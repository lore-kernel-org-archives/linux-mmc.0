From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: irq flood with mmc boot partitions on s3c2416 with 3.0rc1
Date: Fri, 3 Jun 2011 08:48:05 +0900
Message-ID: <BANLkTi=xVzdLDq5wbzLtQFu+nz=8G9SbKQ@mail.gmail.com>
References: <201106022149.47936.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:65178 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752578Ab1FBXsL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Jun 2011 19:48:11 -0400
Received: by vxi39 with SMTP id 39so1035340vxi.19
        for <linux-mmc@vger.kernel.org>; Thu, 02 Jun 2011 16:48:10 -0700 (PDT)
In-Reply-To: <201106022149.47936.heiko@sntech.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, andreiw@motorola.com

Hi,

Interesting, I also use the latest kernel and boot well.
As I don't have the s3c2416 user manaul, I'm not sure it's support
AUTO CMD12 or not. but at least it's support at s3c6410 and later.

[    1.355000] sdhci: Secure Digital Host Controller Interface driver
[    1.360000] sdhci: Copyright(c) Pierre Ossman
[    1.365000] s3c-sdhci s3c-sdhci.0: clock source 2: sclk_mmc (5000000=
0 Hz)
[    1.375000] mmc0: SDHCI controller on samsung-hsmmc [s3c-sdhci.0] us=
ing ADMA
[    1.380000] s3c-sdhci s3c-sdhci.2: clock source 2: sclk_mmc (5000000=
0 Hz)
[    1.385000] mmc1: no vmmc regulator found
[    1.390000] mmc1: SDHCI controller on samsung-hsmmc [s3c-sdhci.2] us=
ing ADMA
[    1.400000] s3c-sdhci s3c-sdhci.3: clock source 2: sclk_mmc (5000000=
0 Hz)
[    1.405000] mmc2: no vmmc regulator found
[    1.410000] mmc2: SDHCI controller on samsung-hsmmc [s3c-sdhci.3] us=
ing ADMA
=2E..
[    1.435000] Waiting for root device /dev/mmcblk0p3...
[    1.650000] mmc0: new high speed MMC card at address 0001
[    1.655000] mmcblk0: mmc0:0001 SEM08G 7.39 GiB
[    1.660000] mmcblk0boot0: mmc0:0001 SEM08G partition 1 1.00 MiB
[    1.665000] mmcblk0boot1: mmc0:0001 SEM08G partition 2 1.00 MiB
[    1.675000]  mmcblk0: p1 p2 p3 p4 < p5 p6 >
[    1.680000]  mmcblk0boot1: unknown partition table
[    1.685000]  mmcblk0boot0: unknown partition table

I also check the external SD card.

Thank you,
Kyungmin Park


On Fri, Jun 3, 2011 at 4:49 AM, Heiko St=FCbner <heiko@sntech.de> wrote=
:
> Hi,
>
> after upgrading my development kernel from 2.6.38 to 3.0rc1 I get flo=
oded (i.e.
> it never stops) by messages of the form:
>
> mmc1: Got data interrupt 0x00100000 even though no data operation was=
 in
> progress.
> =A0sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D REGISTER DUMP (mmc1)=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =A0sdhci: Sys addr: 0x37b1b000 | Version: =A00x00000401
> =A0sdhci: Blk size: 0x00007200 | Blk cnt: =A00x00000000
> =A0sdhci: Argument: 0x00010000 | Trn mode: 0x00000033
> =A0sdhci: Present: =A00x01e70002 | Host ctl: 0x00000012
> =A0sdhci: Power: =A0 =A00x0000000a | Blk gap: =A00x00000000
> =A0sdhci: Wake-up: =A00x00000000 | Clock: =A0 =A00x0000020f
> =A0sdhci: Timeout: =A00x0000000e | Int stat: 0x00108000
> =A0sdhci: Int enab: 0x02ff000b | Sig enab: 0x02ff000b
> =A0sdhci: AC12 err: 0x00000000 | Slot int: 0x00000001
> =A0sdhci: Caps: =A0 =A0 0x05e80080 | Caps_1: =A0 0x00000000
> =A0sdhci: Cmd: =A0 =A0 =A00x00000d1a | Max curr: 0x00000000
> =A0sdhci: Host ctl2: 0x00000000
> =A0sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x37846808
> =A0sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
> hardware: S3C2416 based board, mmc0 is an external micro-SD and mmc1 =
is a
> =A0mmc1: new high speed MMC card at address 0001
> =A0mmcblk1: mmc1:0001 HYNIX =A01.88 GiB
> =A0mmcblk1boot0: mmc1:0001 HYNIX =A0partition 1 256 KiB
> =A0mmcblk1boot1: mmc1:0001 HYNIX =A0partition 2 256 KiB
> =A0 mmcblk1: p1 p2 p3
> =A0 mmcblk1boot1: unknown partition table
> =A0 mmcblk1boot0: unknown partition table
>
> it uses therefore the sdhci-s3c driver.
>
>
> I did some prodding in the code and found the following peculiarities=
:
>
> - When I remove Kyungmins AUTO_CMD12-quirk in sdhci-s3c it seems I ge=
t one
> functional boot and have only the following messages in the kernel lo=
g
>
> =A0mmcblk1boot0: retrying using single block read
> =A0mmc1: ADMA error
> =A0mmcblk1boot0: error -5 transferring data, sector 448, nr 32, card =
status
> 0x900
> =A0end_request: I/O error, dev mmcblk1boot0, sector 448
> =A0Buffer I/O error on device mmcblk1boot0, logical block 56
> =A0mmcblk1boot1: retrying using single block read
> =A0mmc1: ADMA error
> =A0mmcblk1boot1: error -5 transferring data, sector 448, nr 32, card =
status
> 0x900
> =A0end_request: I/O error, dev mmcblk1boot1, sector 448
>
> But after a soft reset the irq message flood seems to return.
>
> - When I completely remove the boot partition registration in
> mmc_blk_alloc_parts() in card/block.c it seems that everything return=
 to
> normal, i.e. no strange messages at all
>
>
> I'm not sure if this is a problem of only my board or if it happens o=
n more
> hardware.
>
>
> Heiko
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
