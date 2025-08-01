#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Scripts for refreshing ags, waybar, rofi, swaync, wallust

SCRIPTSDIR=$HOME/.config/hypr/scripts
UserScripts=$HOME/.config/hypr/UserScripts

# Define file_exists function
file_exists() {
  [[ -f "$1" ]]
}

# قائمة البرامج اللي نتأكد أنها شغالة، وإذا ما شغلت نشغلها بدون قتل
_ps=(waybar rofi swaync ags swaybg)

for _prs in "${_ps[@]}"; do
    if ! pidof "${_prs}" >/dev/null; then
        echo "Starting $_prs ..."
        # تشغيل البرنامج المناسب
        case $_prs in
            waybar)
                waybar &
                ;;
            rofi)
                rofi -show run &
                ;;
            swaync)
                swaync > /dev/null 2>&1 &
                swaync-client --reload-config
                ;;
            ags)
                ags &
                ;;
            swaybg)
                swaybg &
                ;;
        esac
    else
        echo "$_prs is already running"
    fi
done

# إرسال إشارة لتحديث waybar فقط (بدون قتل وإعادة تشغيل)
killall -SIGUSR2 waybar

exit 0
