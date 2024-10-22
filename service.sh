
until [ "$(resetprop sys.boot_completed)" = "1" -a -d "/data" ]; do
    sleep 5
done

sleep 60

rm -rf /sdcard/Images/*
rm -rf /sdcard/Backups/*
rm -rf /sdcard/Audios/*
rm -rf /sdcard/Videos/Movies/*
mount -o bind "/sdcard/Pictures" "/sdcard/Images"
mount -o bind "/sdcard/Download" "/sdcard/Backups"
mount -o bind "/sdcard/Music" "/sdcard/Audios"
mount -o bind "/sdcard/Movies" "/sdcard/Videos/Movies"

chown shell:shell /data/data/com.twitter.android/files
chmod guo-rwx /data/data/com.twitter.android/files
chown shell:shell /data/data/cmb.pb/files/fontResource
chmod guo-rwx /data/data/cmb.pb/files/fontResource
chown shell:shell /data/data/com.xiaomi.smarthome/files/dynamic_fonts
chmod guo-rwx /data/data/com.xiaomi.smarthome/files/dynamic_fonts

while true
do
    rm -rf /sdcard/Pictures/.gs*
    rm -rf /sdcard/Pictures/.thumb*
    rm -rf /sdcard/Pictures/WeChat
    rm -rf /sdcard/Pictures/WeiXin
    rm -rf /sdcard/Pictures/CloudHub
    rm -rf /sdcard/Pictures/Douban
    rm -rf /sdcard/Pictures/weibo*
    rm -rf /sdcard/Pictures/.stx
    rm -rf /sdcard/Images/jdimage
    rm -rf /sdcard/Images/.stx
    rm -rf /sdcard/Music/.thumb*
    rm -rf /sdcard/DCIM/.tmfs
    rm -rf /sdcard/DCIM/.android
    rm -rf /sdcard/DCIM/.yz
    rm -rf /sdcard/Movies/.thumb*
    rm -rf /sdcard/Movies/weiboIntl_video
    rm -rf /sdcard/Android/media
    rm -rf /sdcard/Android/.vy
    rm -rf /sdcard/Android/obb
    rm -rf /sdcard/Android/obj
    rm -rf /sdcard/Android/.data
    rm -rf /sdcard/Android/data/.nomedia
    rm -rf /sdcard/Documents/.thumb*
    rm -rf /sdcard/Documents/.*.obb
    rm -rf /sdcard/Download/.*
    rm -rf /sdcard/Download/Nearby*
    rm -rf /sdcard/Download/netease*
    rm -rf /sdcard/YZJLog
    rm -rf /sdcard/.yzj_id
    rm -rf /sdcard/.vivo
    rm -rf /sdcard/.gs_fs0
    rm -rf /sdcard/.DataStorage
    rm -rf /sdcard/.UTSystemConfig
    rm -rf /sdcard/msc
    rm -rf /sdcard/tencent
    
    STATE_GMSF() {
        PM="$(command -v pm)"
        GMSF="com.google.android.gms/com.google.android.gms.fonts"
        
        UPS=$(ls -d /data/user/*)
        
        for UP in $UPS; do
            "$PM" "$@" --user "${UP##*/}" "$GMSF.update.UpdateSchedulerService"
            "$PM" "$@" --user "${UP##*/}" "$GMSF.provider.FontsProvider"
        done
    }

    DEL_GMSF() {
        local GMSFD=com.google.android.gms/files/fonts

        [ -d /data/fonts ] && rm -r /data/fonts
            
        find /data \
            -type d \
            -path "*$GMSFD*" \
            -exec test -d {} \; -exec rm -r {} \;
    }

    STATE_GMSF disable >/dev/null 2>&1
    DEL_GMSF

    sleep 60
done
