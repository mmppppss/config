#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════════
#  Kbhelp — super+h · listado completo de keybinds (una vista)
#  Aparece al instante, buscable; Enter ejecuta, Esc cancela.
#  Parser inline (awk) sobre ~/.config/sxhkd/sxhkdrc
# ═══════════════════════════════════════════════════════════════

SXHKDRC="$HOME/.config/sxhkd/sxhkdrc"
THEME="$HOME/.config/rofi/whickey.rasi"
[ -f "$THEME" ] || THEME="$HOME/.config/rofi/gruvbox-minimal.rasi"
[ -f "$SXHKDRC" ] || exit 1

DATA="$(awk -F '\t' '
function glab(g){ # orden → etiqueta de grupo
    if(g==1) return "super";
    if(g==2) return "super + shift";
    if(g==3) return "super + ctrl";
    if(g==4) return "super + alt";
    if(g==5) return "media (XF86)";
    return "otras (Print)";
}
function groupof(k){ return index(k,"super + shift")==1?2:(index(k,"super + ctrl")==1?3:(index(k,"super + alt")==1?4:(index(k,"super")==1?1:(index(k,"XF86")==1?5:6)))); }
function firstn(s,   b,seg,l,c,i){
    b=index(s,"{");
    if(b==0) return 1;
    seg=substr(s,b+1); l=index(seg,"}"); seg=substr(seg,1,l-1);
    c=1; for(i=1;i<=length(seg);i++) if(substr(seg,i,1)==",") c++;
    return c;
}
function picks(s,j,   n,arr,i,k,seg,cnt,el,res){
    n=split(s,arr,"}");
    res="";
    for(i=1;i<=n;i++){
        k=index(arr[i],"{");
        if(k>0){
            seg=substr(arr[i],k+1);
            cnt=split(seg,el,",");
            res=res substr(arr[i],1,k-1) el[(j%cnt)+1];
        } else {
            res=res arr[i];
            if(i<n) res=res "}";
        }
    }
    return res;
}
function cmdd(c,   o){
    o=c;
    gsub(/[ \t]*\\\n/," ",o);
    gsub(/\n/," ",o);
    gsub(/[ \t]+/," ",o);
    return o;
}
function trimpref(h,ord,   k){
    if(ord==5||ord==6) return h;
    if(ord==1) k="super + ";
    else if(ord==2) k="super + shift + ";
    else if(ord==3) k="super + ctrl + ";
    else if(ord==4) k="super + alt + ";
    if(index(h,k)==1) return substr(h,length(k)+1);
    return h;
}
function flushout(   ord,n,j,key,run,disp,rn){
    if(cur=="") return;
    r=cmd_raw;
    if(length(r)>0 && substr(r,length(r),1)=="\n") r=substr(r,1,length(r)-1);
    ord=groupof(cur);
    n=firstn(cur);
    if(n>1){
        for(j=0;j<n;j++){
            key=picks(cur,j);
            run=r; if(index(r,"{")>0) run=picks(r,j);
            disp=cmdd(run);
            rn=run; gsub(/\n/,"\\n",rn);
            print ord "\t" glab(ord) "\t" trimpref(key,ord) "\t" disp "\t" rn;
        }
    } else {
        run=r; disp=cmdd(run);
        rn=run; gsub(/\n/,"\\n",rn);
        print ord "\t" glab(ord) "\t" trimpref(cur,ord) "\t" disp "\t" rn;
    }
    cur=""; cmd_raw="";
}
BEGIN{ cur=""; cmd_raw=""; }
/^[ \t]*#/ { next }
/^[ \t]*$/ { next }
/^[ \t]/   { if(cur!=""){ s=$0; sub(/^[ \t]+/,"",s); cmd_raw=cmd_raw s "\n"; } next }
{ flushout(); cur=$0; }
END{ flushout(); }
' "$SXHKDRC" 2>/dev/null)"

[ -n "$DATA" ] || exit 1

# ── Lista única: grupo + tecla + comando ─────────────────────
l=()
runs=()
declare -A runsmap
n=0
while IFS=$'\t' read -r ord grp key disp run; do
    [ -n "$ord" ] || continue
    grpesc="${grp//&/&amp;}"
    kesc="${key//&/&amp;}"
    descesc="${disp//&/&amp;}"
    visible="<span foreground=\"#a89984\">$grpesc</span>  <span foreground=\"#fe8019\">$kesc</span>  <span foreground=\"#ebdbb2\">$descesc</span>"
    l[$n]="$visible"
    runs[$n]="$run"
    runsmap["$(sed 's/<[^>]*>//g' <<< "$visible")"]="$run"
    n=$((n+1))
done <<< "$DATA"
[ "$n" -gt 0 ] || exit 1

sel="$(printf '%s\n' "${l[@]}" | rofi -dmenu -i -no-custom -markup-rows -mesg "keybinds · Enter ejecuta · Esc cierra" -theme "$THEME" | head -1)"
[ -n "$sel" ] || exit 0

cmd=""
if [[ "$sel" =~ ^[0-9]+$ ]] && [ "$sel" -lt "$n" ]; then
    cmd="${runs[$sel]}"
else
    cmd="${runsmap[$(sed 's/<[^>]*>//g' <<< "$sel")]}"
fi
[ -n "$cmd" ] || exit 0

bash -c "${cmd//\\n/$'\n'}"