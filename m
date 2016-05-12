From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: RE: [PATCH/RFC 0/3] UHS-I SDR-104 support for sh_mobile_sdhi
Date: Thu, 12 May 2016 06:30:04 +0000
Message-ID: <SG2PR06MB09190A986DDC6D2220603AA6D8730@SG2PR06MB0919.apcprd06.prod.outlook.com>
References: <1462859524-28522-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1462859524-28522-1-git-send-email-horms+renesas@verge.net.au>
Content-Language: ja-JP
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Ben Hutchings <ben.hutchings@codethink.co.uk>, Ian Molton <ian@mnementh.co.uk>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Simon-san,

> From: Simon Horman
> Sent: Tuesday, May 10, 2016 2:52 PM
> 
> Hi,
> 
> this series is based on work by Ai Kyuse to add UHS-I SDR-104 support for
> sh_mobile_sdhi. It builds on work by Shinobu Uehara, Rob Taylor, William
> Towle and Ian Molton, Ben Hutchings, Wolfram Sang and others to add UHS-I
> SDR-50 support to the same driver.
> 
> This series enables UHS-I SDR-104 on the r8a7790/Lager where
> UHS-I SDR-50 is already enabled.
> 
> It is based on a merge of:
> * The next branch of the mmc tree
> * The renesas-next-20160427v2-v4.6-rc1 tag of the renesas tree
> * The sh-pfc-for-v4.7-tag1 tag of the renesas-drivers tree
> 
> The first two mmc driver patches are targeted at the next branch of the mmc
> tree. The last DT patch is targeted at the devel branch of the renesas tree.
> 
> To aid review this series is provided in the _temporary_ topic/sdr104 branch
> of the renesas tree.

Thank you for the patch set!
I tried to the patch using the topic branch.

> A description of testing performed follows:
> 
> * Environment
> 
>   SoC/Board: r8a7790/Lager
>   SanDisk Card: SanDisk Ultra 64Gb microSDXC UHS-1
>                 Identifier on Packaging: SDSQUNC-064G-GN6MA
>   Samsung Card: Samsung 32Gb microSDHC Card Class 10 UHS-1 U3
>                 ModelCode: MB-MG32EA/FFP

I used r8a7790/Lager and the following card:

   SanDisk Card: SanDisk Extreme Pro 32Gb microSDHC U3
   (Sorry I don't have the packaging because I borrowed it from my colleague.)

< Result >
- It seems worked correctly.
- I tried 3 Lager boards:
 - One of board (No.701 / ES2.0) sometimes works correctly.
  - " mmc1: tuning execution failed: -110" appeared.
 - Other 2 boards (No.465 / ES2.0 and No.322 / ES3.0) always works correctly.

Perhaps the issue is related to hardware problem.

< Detail >
If SDR104 works:
[   19.348032] mmc1: new ultra high speed SDR104 SDHC card at address aaaa
[   19.355352] mmcblk1: mmc1:aaaa SP32G 29.7 GiB 
[   19.370433]  mmcblk1: p1

root@192:~# dd bs=1M count=512 iflag=direct if=/dev/mmcblk1 of=/dev/null
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 11.1761 s, 48.0 MB/s

If I remove sdr104 property and worked as SDR50:
[   15.050218] mmc1: new ultra high speed SDR50 SDHC card at address 
aaaa                                                                            
[   15.057282] mmcblk1: mmc1:aaaa SP32G 29.7 GiB                                
[   15.071917]  mmcblk1: p1

root@192:~# dd bs=1M count=512 iflag=direct if=/dev/mmcblk1 of=/dev/null        
512+0 records in                                                                
512+0 records out                                                               
536870912 bytes (537 MB) copied, 15.514 s, 34.6 MB/s

< log of the issue (tuning failed) >
The following message appeared when I connected the card and about 5 seconds later.
[   21.962403] mmc1: tuning execution failed: -110
[   21.967002] mmc1: error -110 whilst initialising SD card
[   21.973813] sh_mobile_sdhi ee100000.sd: timeout waiting for SD bus idle
[   21.981875] sh_mobile_sdhi ee100000.sd: timeout waiting for SD bus idle
[   21.989978] sh_mobile_sdhi ee100000.sd: timeout waiting for SD bus idle
[   21.998036] sh_mobile_sdhi ee100000.sd: timeout waiting for SD bus idle
[   22.006114] sh_mobile_sdhi ee100000.sd: timeout waiting for SD bus idle
[   27.013768] sh_mobile_sdhi ee100000.sd: timeout waiting for SD bus idle
[   27.035294] sh_mobile_sdhi ee100000.sd: timeout waiting for SD bus idle
[   27.053749] sh_mobile_sdhi ee100000.sd: timeout waiting for SD bus idle
[   27.074091] sh_mobile_sdhi ee100000.sd: timeout waiting for SD bus idle
[   27.082471] sh_mobile_sdhi ee100000.sd: timeout waiting for SD bus idle
[   27.090824] sh_mobile_sdhi ee100000.sd: timeout waiting for SD bus idle
[   27.114029] sh_mobile_sdhi ee100000.sd: timeout waiting for SD bus idle
[   27.134033] sh_mobile_sdhi ee100000.sd: timeout waiting for SD bus idle
[   27.142345] sh_mobile_sdhi ee100000.sd: timeout waiting for SD bus idle
[   32.152388] sh_mobile_sdhi ee100000.sd: timeout waiting for hardware interrupt (CMD52)
[   37.202394] sh_mobile_sdhi ee100000.sd: timeout waiting for hardware interrupt (CMD52)

Did you see such a message on your board?

Best regards,
Yoshihiro Shimoda

> * Wit these patches (topic/sdr104 branch)
> 
>   # mount -t debugfs none /sys/kernel/debug
>   # cat /sys/kernel/debug/mmc1/ios
> 
>   clock:          195000000 Hz
>   vdd:            21 (3.3 ~ 3.4 V)
>   bus mode:       2 (push-pull)
>   chip select:    0 (don't care)
>   power mode:     2 (on)
>   bus width:      2 (4 bits)
>   timing spec:    6 (sd uhs SDR104)
>   signal voltage: 1 (1.80 V)
>   driver type:    0 (driver type B)
> 
>   SanDisk Card:
>   # dd bs=1M count=512 iflag=direct if=/dev/mmcblk1 of=/dev/null
>   536870912 bytes (537 MB) copied, 13.6713 s, 39.3 MB/s
> 
>   Samsung Card:
>   # dd bs=1M count=512 iflag=direct if=/dev/mmcblk1 of=/dev/null
>   536870912 bytes (537 MB) copied, 16.4952 s, 32.5 MB/s
> 
> 
> * Without these patches (base of topic/sdr104 branch)
> 
>   # mount -t debugfs none /sys/kernel/debug
>   # cat /sys/kernel/debug/mmc1/ios
> 
>   clock:          100000000 Hz
>   vdd:            21 (3.3 ~ 3.4 V)
>   bus mode:       2 (push-pull)
>   chip select:    0 (don't care)
>   power mode:     2 (on)
>   bus width:      2 (4 bits)
>   timing spec:    5 (sd uhs SDR50)
>   signal voltage: 1 (1.80 V)
>   driver type:    0 (driver type B)
> 
>   SanDisk Card:
>   # dd bs=1M count=512 iflag=direct if=/dev/mmcblk1 of=/dev/null
>   536870912 bytes (537 MB) copied, 17.7253 s, 30.3 MB/s
> 
>   Samsung Card:
>   # dd bs=1M count=512 iflag=direct if=/dev/mmcblk1 of=/dev/null
>   536870912 bytes (537 MB) copied, 20.7866 s, 25.8 MB/s
> 
> 
> 
> Ai Kyuse (2):
>   mmc: tmio: Add tuning support
>   mmc: sh_mobile_sdhi: Add tuning support
> 
> Simon Horman (1):
>   ARM: dts: r8a7790: lager: Enable UHS-I SDR-104
> 
>  arch/arm/boot/dts/r8a7790-lager.dts |   1 +
>  drivers/mmc/host/sh_mobile_sdhi.c   | 264 +++++++++++++++++++++++++++++++++++-
>  drivers/mmc/host/tmio_mmc.h         |  10 ++
>  drivers/mmc/host/tmio_mmc_pio.c     | 249 ++++++++++++++++++++++++++++++++--
>  include/linux/mfd/tmio.h            |   3 +
>  5 files changed, 518 insertions(+), 9 deletions(-)
> 
> --
> 2.1.4
