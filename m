From: Mario <nutrinfnon@gmx.com>
Subject: Re: mmc0: error -84 whilst initialising SD card
Date: Sat, 30 May 2015 07:24:19 +0000 (UTC)
Message-ID: <loom.20150530T073858-128@post.gmane.org>
References: <54D1B037.6010909@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:43145 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751038AbbE3IAH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 30 May 2015 04:00:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1Yybga-0000YR-K0
	for linux-mmc@vger.kernel.org; Sat, 30 May 2015 10:00:04 +0200
Received: from 94.160.79.49 ([94.160.79.49])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Sat, 30 May 2015 10:00:04 +0200
Received: from nutrinfnon by 94.160.79.49 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Sat, 30 May 2015 10:00:04 +0200
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Mario <nutrinfnon <at> gmx.com> writes:

> 
> Hi,
> 
>   I wrote to Intel support without success. They answer me that I must 
> ask to tablet manufacturer, but I know it is impossible.
> 
> I try to ask here, with short question:
> 
> Object:
> TABLET CHUWI VX8 3G Atom Z3735G
> 
> Description:
> POWER OFF
> -> SWITCH ON
>   -> BOOT Linux-3.19.0-rc6
>    -> ERROR "mmc0: error -84 whilst initialising SD card"
>     -> no sd device
> 
> POWER OFF
> -> SWITCH ON
>   -> BOOT Linux-3.10.20_from_original_android_installation
>    -> mmc initialized successfully
>     -> sd device works fine
>      -> REBOOT without switch off tablet
>       -> BOOT Linux-3.19.0-rc6 (ABOVE GOES IN ERROR)
>        -> mmc initialized successfully
>         -> sd device works fine with 3.19.0-rc6 too
> 
> Thanks.
> 
> I think it is possible ssh login to tablet trough IPv6 if it is necessary.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

Good morning,

I tested linux-4.1.0-rc5 on my tablet the issue is still present.

I add following logs, I don't know if issue is linked to specific hardware:

>first test 
start linux-4.1.0-rc5 from power-off
mounting SD-4GB and then SD-8GB works fine, dd data transfer ok
[  273.698217] mmc2: new high speed SDHC card at address b368
[  273.714685] mmcblk1: mmc2:b368 NCard 3.70 GiB
[  273.728593]  mmcblk1: p1
[  273.733426] byt-rt5640 byt-rt5640: ASoC: CPU DAI baytrail-pcm-audio not
registered
[  286.450821] mmc2: card b368 removed
[  299.757777] mmc2: new high speed SDHC card at address b368
[  299.771745] mmcblk1: mmc2:b368 NCard 7.41 GiB
[  299.780833]  mmcblk1: p1
[  299.786920] byt-rt5640 byt-rt5640: ASoC: CPU DAI baytrail-pcm-audio not
registered
[  303.597891] mmc2: card b368 removed


>second test
mounting SD-32GB fails initialization, no device mmc... in /dev/
[  134.024070] mmc2: new ultra high speed DDR50 SDHC card at address 0007
[  134.029309] mmcblk1: mmc2:0007 SD32G 29.0 GiB 
[  134.031953]  mmcblk1: p1
[  134.084302] mmcblk1: error -123 sending status command, retrying
[  134.087337] mmcblk1: error -123 sending status command, retrying
[  134.090362] mmcblk1: error -123 sending status command, aborting
[  134.280470] mmc2: card 0007 removed
[  135.292593] mmc2: error -84 whilst initialising SD card

>tirdh test
dismount and remount SD-32GB from slot
[  269.160748] mmc2: error -84 whilst initialising SD card


>fourth test
shutdown -r now and restart with same kernel 4.1.0-rc5
now works but alot of errors
[   48.238649] mmc2: new ultra high speed DDR50 SDHC card at address 0007
[   48.239869] mmcblk1: mmc2:0007 SD32G 29.0 GiB 
[   48.242323]  mmcblk1: p1

dd if=/dev/mmcblk1 bs=1M of=/dev/null count=10
[  219.632258] mmc2: tried to reset card
[  219.638056] mmcblk1: error -84 sending stop command, original cmd
response 0x900, card status 0x900
[  219.638062] mmcblk1: error -84 transferring data, sector 79872, nr 256,
cmd response 0x900, card status 0x0
[  219.638067] mmcblk1: retrying using single block read
[  237.838814] mmcblk1: error -84 transferring data, sector 3584, nr 256,
cmd response 0x900, card status 0xb00
[  237.910556] mmc2: tried to reset card
[  237.918066] mmcblk1: error -84 transferring data, sector 3584, nr 256,
cmd response 0x900, card status 0xb00
[  237.918086] mmcblk1: retrying using single block read
[  238.040761] mmcblk1: error -84 transferring data, sector 3840, nr 256,
cmd response 0x900, card status 0xb00
[  238.114797] mmc2: tried to reset card
[  238.118827] mmcblk1: error -84 transferring data, sector 3840, nr 256,
cmd response 0x900, card status 0xb00
[  238.118844] mmcblk1: retrying using single block read
[  238.586231] mmcblk1: error -84 transferring data, sector 18432, nr 256,
cmd response 0x900, card status 0xb00
[  238.655674] mmc2: tried to reset card
[  238.663444] mmcblk1: error -84 transferring data, sector 18432, nr 256,
cmd response 0x900, card status 0xb00
[  238.663454] mmcblk1: retrying using single block read
[  238.773924] mmcblk1: error -84 transferring data, sector 18688, nr 256,
cmd response 0x900, card status 0xb00
[  238.846571] mmc2: tried to reset card
[  238.849762] mmcblk1: error -84 transferring data, sector 18688, nr 256,
cmd response 0x900, card status 0xb00
[  238.849782] mmcblk1: retrying using single block read





>fifth test
(no advancement)
rmmod sdhci_acpi
rmmod sdhci
modprobe sdhci debug_quirks2=0x80 (BROKEN DDR50)
modprobe sdhci_acpi
cat /sys/module/sdhci/parameters/debug_quirks2
128
[  509.598938] mmc2: card 0007 removed
[  518.858860] mmc2: new ultra high speed SDR25 SDHC card at address 0007
[  518.860060] mmcblk1: mmc2:0007 SD32G 29.0 GiB 
[  518.862501]  mmcblk1: p1
[  518.863609] byt-rt5640 byt-rt5640: ASoC: CPU DAI baytrail-pcm-audio not
registered

dd if=/dev/mmcblk1 bs=1M of=/dev/null count=10
[  552.622909] mmcblk1: error -84 transferring data, sector 3584, nr 256,
cmd response 0x900, card status 0xb00
[  552.689828] mmc2: tried to reset card
[  552.697856] mmcblk1: error -84 transferring data, sector 3584, nr 256,
cmd response 0x900, card status 0xb00
[  552.697870] mmcblk1: retrying using single block read
[  552.808111] mmcblk1: error -84 transferring data, sector 3840, nr 256,
cmd response 0x900, card status 0xb00
[  552.879781] mmc2: tried to reset card
[  552.882905] mmcblk1: error -84 transferring data, sector 3840, nr 256,
cmd response 0x900, card status 0xb00
[  552.882916] mmcblk1: retrying using single block read
[  553.377844] mmcblk1: error -84 transferring data, sector 18432, nr 256,
cmd response 0x900, card status 0xb00
[  553.452786] mmc2: tried to reset card
[  553.460669] mmcblk1: error -84 transferring data, sector 18432, nr 256,
cmd response 0x900, card status 0xb00
[  553.460685] mmcblk1: retrying using single block read
[  553.603483] mmcblk1: error -84 transferring data, sector 18688, nr 256,
cmd response 0x900, card status 0xb00
[  553.676880] mmc2: tried to reset card
[  553.679914] mmcblk1: error -84 transferring data, sector 18688, nr 256,
cmd response 0x900, card status 0xb00
[  553.679925] mmcblk1: retrying using single block read

>sixth test
shutdown -r now
start android kernel
shutdown -r now
start 4.1.0-rc5 kernel
(all works fine, dd does not generate error, errors=0)
[   55.126886] mmc2: card 0007 removed
[   64.922405] mmc2: new ultra high speed DDR50 SDHC card at address 0007
[   64.923218] mmcblk1: mmc2:0007 SD32G 29.0 GiB 
[   64.925089]  mmcblk1: p1
[   64.925598] byt-rt5640 byt-rt5640: ASoC: CPU DAI baytrail-pcm-audio not
registered

dd if=/dev/mmcblk1 of=/dev/null bs=1M count=10
10+0 records in
10+0 records out
10485760 bytes (10 MB) copied, 0.301079 s, 34.8 MB/s



Thanks


