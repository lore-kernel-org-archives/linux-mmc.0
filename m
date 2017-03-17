From: Helmut Klein <hgkr.klein@gmail.com>
Subject: Re: meson-gx-mmc: 2nd patch set
Date: Fri, 17 Mar 2017 19:00:02 +0100
Message-ID: <2a6d59e0-28db-b65a-835d-512a7e68443e@gmail.com>
References: <d1f4c34c-799c-c76c-4ad8-5c0060f9c71f@gmail.com>
 <b5e36943-ba83-e73e-7df7-d6967aff5886@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37716 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751117AbdCQSAK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Mar 2017 14:00:10 -0400
Received: by mail-wm0-f50.google.com with SMTP id n11so21996556wma.0
        for <linux-mmc@vger.kernel.org>; Fri, 17 Mar 2017 11:00:08 -0700 (PDT)
In-Reply-To: <b5e36943-ba83-e73e-7df7-d6967aff5886@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

On 17.03.2017 07:44, Heiner Kallweit wrote:
> Am 16.03.2017 um 22:12 schrieb Helmut Klein:
>> Hallo Heiner,
>>
>> i applied your 2nd patch sets to linux-amlogic. (and of course the older set v5 1...10).
>>
>> The performance of the sd-card and the mmc-chip of my minimx is much better now.
>>
>> sd-card: from 6.5 to 22.5 MBytes/s
>> mmc: from 14.5 to 28.5 MBytes/s (hs200 compatible device)
>>
>> But:
>> the wifi-adapter is no longer operational. The problem starts with patch 3 and gets worse with patch 5.
>>
>> the adapter (ap6330) is attached to the sdio port of the the s905. (=mmc1)
>>
> Thanks for testing and sharing the feedback. Much appreciated.
> The board I test on supports block devices only.
>
> Could you please share few more details:
> - Drivers involved
> - All syslog messages related to the device / driver
>
> And please set the relevant mailing lists on cc when providing test feedback.
> Others might find your feedback helpful too.
>
> Thanks, Heiner
>
>> so i think it is important to test your patch set asap on an officially supported board with a wifi adapter).
>>
>> regards
>> Helmut
>>
>
>

The driver for the wifi adapter is brcmfmac. It is compiled as a module 
and loaded via /etc/modules.
the driver depends on the modules brcmutil and cfg80211, which are auto 
loaded.

my user space is debian unstable. The kernel is cross compiled on my 
x86-64 laptop with gcc 5.4.1

i use my own kernel configuration without an initial ramdisk. mmc, usb & 
ext4 drivers are compiled into the kernel

kernel & dtb are loaded by u-boot from mmcblk2p1 (sd-card)

the drive for the kernel is sda2 (sd-card inside of a usb card reader).


here is the filtered (mmc|brcmfmac) syslog output when only patches 1 & 
2 are applied

[    1.685012] meson-gx-mmc d0074000.mmc: allocated mmc-pwrseq
[    1.873010] mmc0: new DDR MMC card at address 0001
[    1.873258] mmcblk0: mmc0:0001 NCard  14.5 GiB
[    1.876731] mmcblk0boot0: mmc0:0001 NCard  partition 1 4.00 MiB
[    1.882597] mmcblk0boot1: mmc0:0001 NCard  partition 2 4.00 MiB
[    2.004399] meson-gx-mmc d0070000.mmc: allocated mmc-pwrseq
[    2.048160] meson-gx-mmc d0072000.mmc: Got CD GPIO
[    2.066962] mmc1: queuing unknown CIS tuple 0x80 (2 bytes)
[    2.068985] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    2.074242] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    2.081275] mmc1: queuing unknown CIS tuple 0x80 (7 bytes)
[    2.124761] mmc2: Skipping voltage switch
[    2.153763] mmc1: new high speed SDIO card at address 0001
[    2.158567] mmc2: new high speed SDHC card at address 59b4
[    2.159219] mmcblk2: mmc2:59b4 USD00 29.5 GiB
[    2.164206]  mmcblk2: p1 p2
[    6.664118] brcmfmac: brcmf_c_preinit_dcmds: Firmware version = wl0: 
Jan  6 2014 15:11:29 version 5.90.195.89.13 FWID 01-72f124c5
[    6.736239] brcmfmac: brcmf_cfg80211_reg_notifier: not a ISO3166 code 
(0x30 0x30)
[    6.928045] brcmfmac: brcmf_construct_chaninfo: Ignoring unexpected 
firmware channel 184
[    6.930475] brcmfmac: brcmf_construct_chaninfo: Ignoring unexpected 
firmware channel 188
[    6.938524] brcmfmac: brcmf_construct_chaninfo: Ignoring unexpected 
firmware channel 192
[    6.946543] brcmfmac: brcmf_construct_chaninfo: Ignoring unexpected 
firmware channel 196
[    6.954566] brcmfmac: brcmf_construct_chaninfo: Ignoring unexpected 
firmware channel 200
[    6.954663] brcmfmac: brcmf_cfg80211_reg_notifier: not a ISO3166 code 
(0x30 0x30)
[    6.969995] brcmfmac: brcmf_construct_chaninfo: Ignoring unexpected 
firmware channel 204
[    6.978023] brcmfmac: brcmf_construct_chaninfo: Ignoring unexpected 
firmware channel 208

this is the output after adding patch 3

[    1.684982] meson-gx-mmc d0074000.mmc: allocated mmc-pwrseq
[    1.873041] mmc0: new DDR MMC card at address 0001
[    1.873273] mmcblk0: mmc0:0001 NCard  14.5 GiB
[    1.876765] mmcblk0boot0: mmc0:0001 NCard  partition 1 4.00 MiB
[    1.882621] mmcblk0boot1: mmc0:0001 NCard  partition 2 4.00 MiB
[    2.004408] meson-gx-mmc d0070000.mmc: allocated mmc-pwrseq
[    2.048189] meson-gx-mmc d0072000.mmc: Got CD GPIO
[    2.066978] mmc1: queuing unknown CIS tuple 0x80 (2 bytes)
[    2.069001] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    2.074253] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    2.081285] mmc1: queuing unknown CIS tuple 0x80 (7 bytes)
[    2.124874] mmc2: Skipping voltage switch
[    2.153475] mmc1: new high speed SDIO card at address 0001
[    2.158610] mmc2: new high speed SDHC card at address 59b4
[    2.158935] mmcblk2: mmc2:59b4 USD00 29.5 GiB
[    2.163910]  mmcblk2: p1 p2
[    6.586318] brcmfmac: brcmf_sdiod_ramrw: membytes transfer failed 
<<<=====
[    6.586810] brcmfmac: brcmf_sdio_download_code_file: error -84 on 
writing 239507 membytes at 0x00000000
[    6.596373] brcmfmac: brcmf_sdio_download_firmware: dongle image file 
download failed

and this is the output after adding patches 4 & 5

[    1.684941] meson-gx-mmc d0074000.mmc: allocated mmc-pwrseq
[    1.868910] mmc0: new DDR MMC card at address 0001
[    1.869159] mmcblk0: mmc0:0001 NCard  14.5 GiB
[    1.872639] mmcblk0boot0: mmc0:0001 NCard  partition 1 4.00 MiB
[    1.878497] mmcblk0boot1: mmc0:0001 NCard  partition 2 4.00 MiB
[    1.884356] mmcblk0rpmb: mmc0:0001 NCard  partition 3 128 KiB 
<<<=====
[    2.000339] meson-gx-mmc d0070000.mmc: allocated mmc-pwrseq
[    2.044090] meson-gx-mmc d0072000.mmc: Got CD GPIO
[    2.062850] mmc1: queuing unknown CIS tuple 0x80 (2 bytes)
[    2.064869] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    2.070129] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    2.077161] mmc1: queuing unknown CIS tuple 0x80 (7 bytes)
[    2.120693] mmc2: Skipping voltage switch
[    2.148795] mmc1: new high speed SDIO card at address 0001
[    2.154443] mmc2: new high speed SDHC card at address 59b4
[    2.154660] mmcblk2: mmc2:59b4 USD00 29.5 GiB
[    2.159402]  mmcblk2: p1 p2
[    6.550881] brcmfmac: brcmf_chip_recognition: SB chip is not 
supported     <<<=====
[    6.556606] brcmfmac: brcmf_sdio_probe_attach: brcmf_chip_attach failed!
[    6.563260] brcmfmac: brcmf_sdio_probe: brcmf_sdio_probe_attach failed
[    6.569796] brcmfmac: brcmf_ops_sdio_probe: F2 error, probe failed -19...

regards
Helmut
