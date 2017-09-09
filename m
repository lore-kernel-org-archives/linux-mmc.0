From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Problems after recent changes to meson-gx-mmc driver
Date: Sat, 9 Sep 2017 15:14:35 +0200
Message-ID: <e2171288-84ef-82db-2efc-300935e6c062@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:44921 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753485AbdIINOp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 9 Sep 2017 09:14:45 -0400
Received: by mail-wm0-f41.google.com with SMTP id 137so11713703wmj.1
        for <linux-mmc@vger.kernel.org>; Sat, 09 Sep 2017 06:14:44 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Hi Jerome,

the recent changes, most likely one of the changes affecting the clock phase setting
or tuning, break mmc on my system (Odroid C2 + Hardkernel 128GB eMMC card).
"Next" kernel from Aug 25th works fine here. Hadn't time yet to bisect the issue.

As additional info, that's what the eMMC DT config looks like here.
The issue remains when switching to HS200.

/* eMMC */
&sd_emmc_c {
        status = "okay";
        pinctrl-0 = <&emmc_pins>;
        pinctrl-names = "default";

        bus-width = <8>;
        cap-sd-highspeed;
        max-frequency = <200000000>;
        non-removable;
        disable-wp;
        cap-mmc-highspeed;
        mmc-ddr-1_8v;
        mmc-hs400-1_8v;

        mmc-pwrseq = <&emmc_pwrseq>;
        vmmc-supply = <&vcc3v3>;
        vqmmc-supply = <&vcc1v8>;
};

Kind regards,
Heiner


[    0.784729] mmcblk0: mmc0:0001 DJNB4R 116 GiB
[    0.790226] mmcblk0boot0: mmc0:0001 DJNB4R partition 1 4.00 MiB
[    0.794860] mmcblk0boot1: mmc0:0001 DJNB4R partition 2 4.00 MiB
[    0.800723] mmcblk0rpmb: mmc0:0001 DJNB4R partition 3 4.00 MiB
[    0.807012]  mmcblk0: p1
[    0.815910] mmcblk0: response CRC error sending r/w cmd command, card status 0xd00
[    0.818973] mmcblk0: response CRC error sending r/w cmd command, card status 0xd00
[    0.826699] mmcblk0: response CRC error sending r/w cmd command, card status 0xd00
[    0.836784] mmcblk0: error -110 sending stop command
[    0.916784] mmcblk0: response CRC error sending r/w cmd command, card status 0xd00
[    0.920069] mmcblk0: response CRC error sending r/w cmd command, card status 0xd00
[    0.930234] mmcblk0: response CRC error sending r/w cmd command, card status 0xd00
[    0.933718] print_req_error: I/O error, dev mmcblk0, sector 2048
[    0.939669] Buffer I/O error on dev mmcblk0p1, logical block 0, lost sync page write
[    0.949190] EXT4-fs (mmcblk0p1): mounted filesystem with ordered data mode. Opts: (null)
[    0.955397] VFS: Mounted root (ext4 filesystem) on device 179:1.
[    0.963359] devtmpfs: mounted
[    0.964411] Freeing unused kernel memory: 320K
[    0.983379] mmcblk0: response CRC error sending SET_BLOCK_COUNT command, card status 0x900
[    0.989571] mmcblk0: response CRC error sending r/w cmd command, card status 0x900
[    1.093957] systemd[1]: System time before build time, advancing clock.
[    1.159148] mmcblk0: response CRC error sending SET_BLOCK_COUNT command, card status 0x900
[    1.193201] NET: Registered protocol family 10
[    1.193750] Segment Routing with IPv6
[    1.205032] systemd[1]: systemd 234 running in system mode. (+PAM -AUDIT -SELINUX -IMA -APPARMOR +SMACK -SYSVINIT +UTMP +LIBCRYP                                                                                                                                            TSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN default-hierarchy=hybrid)
[    1.220390] systemd[1]: Detected architecture arm64.
[    1.244200] systemd[1]: Set hostname to <odroidc2>.
[    1.370901] mmcblk0: response CRC error sending SET_BLOCK_COUNT command, card status 0x900
[    1.378114] mmcblk0: response CRC error sending SET_BLOCK_COUNT command, card status 0x900
[    1.397501] systemd[1]: Created slice User and Session Slice.
[    1.415651] systemd[1]: Reached target Remote File Systems.
[    1.432905] systemd[1]: Created slice System Slice.
[    1.451645] systemd[1]: Reached target Slices.
[    1.468022] systemd[1]: Created slice system-serial\x2dgetty.slice.
[    1.483793] systemd[1]: Listening on udev Control Socket.
[    1.502607] systemd[1]: Mounting Kernel Debug File System...
[    1.830855] EXT4-fs (mmcblk0p1): re-mounted. Opts: data=ordered,discard
[    2.077375] systemd-journald[644]: Received request to flush runtime journal from PID 1
[    2.085030] systemd-journald[644]: File /var/log/journal/5d03187c26854bbe9eab8ea99e9291cb/system.journal corrupted or uncleanly                                                                                                                                             shut down, renaming and replacing.
[    2.096502] mmcblk0: response CRC error sending r/w cmd command, card status 0xd00
[    2.102475] mmcblk0: response CRC error sending r/w cmd command, card status 0xd00
[    2.110107] mmcblk0: response CRC error sending r/w cmd command, card status 0xd00
[    2.117608] mmcblk0: response CRC error sending r/w cmd command, card status 0xd00
[    2.125121] mmcblk0: response CRC error sending r/w cmd command, card status 0xd00
[    2.132627] mmcblk0: response CRC error sending r/w cmd command, card status 0xd00
[    2.140032] mmcblk0: response CRC error sending r/w cmd command, card status 0xd00
[    2.147511] mmcblk0: response CRC error sending r/w cmd command, card status 0xd00
[    2.155040] mmcblk0: response CRC error sending r/w cmd command, card status 0xd00
[    2.161860] print_req_error: I/O error, dev mmcblk0, sector 76224512
[    2.168147] EXT4-fs warning (device mmcblk0p1): ext4_end_bio:322: I/O error 10 writing to inode 2359327 (offset 0 size 4096 star                                                                                                                                            ting block 9528065)
[    2.181256] Buffer I/O error on device mmcblk0p1, logical block 9527808
[    2.190050] mmcblk0: response CRC error sending r/w cmd command, card status 0xd00
[    2.196320] mmcblk0: response CRC error sending r/w cmd command, card status 0xd00
[    2.203573] mmcblk0: response CRC error sending r/w cmd command, card status 0xd00
[    2.211149] mmcblk0: response CRC error sending r/w cmd command, card status 0xd00
[    2.218616] mmcblk0: response CRC error sending r/w cmd command, card status 0xd00
[    2.226114] mmcblk0: response CRC error sending r/w cmd command, card status 0xd00
[    2.233593] mmcblk0: response CRC error sending r/w cmd command, card status 0xd00
[    2.241013] mmcblk0: response CRC error sending r/w cmd command, card status 0xd00
[    2.248513] mmcblk0: response CRC error sending r/w cmd command, card status 0xd00
[    2.255350] print_req_error: I/O error, dev mmcblk0, sector 121899008

