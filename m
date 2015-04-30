From: Xuebing Wang <xbing6@gmail.com>
Subject: /dev/mmcblk0 (or /dev/mmcblk0p1) does not exist on Freescale
 iMX6SL board
Date: Thu, 30 Apr 2015 17:20:12 +0800
Message-ID: <5541F3CC.4090000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:33840 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710AbbD3JUR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Apr 2015 05:20:17 -0400
Received: by qgfi89 with SMTP id i89so22338096qgf.1
        for <linux-mmc@vger.kernel.org>; Thu, 30 Apr 2015 02:20:16 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, fabio.estavam@freescale.com, Ulf Hansson <ulf.hansson@linaro.org>, balbi@ti.com, niranjan Patil <Niranjan.Patil@infocus.com>, richard Jiang <Richard.Jiang@infocus.com>

Hi linux-mmc community,

I am working on a board which is very similar to Freescale iMX6SL EVK 
(evaluation board), but /dev/mmcblk0 does not exist for kernel v4.0.1

A bit of background information. I was working on kernel 3.10.17, all 
eMMC works fine, except that USB Mass Storage performance is low when 
connecting USB to Windows 7 host. Its peformance is ok when connecting 
to MacOS or Linux host. linux-usb community suggests me to give a try of 
the latest kernel.

Here is how I build uImage and device tree blob:
make ARCH=arm imx_v6_v7_defconfig
make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi- LOADADDR=0x80008000 
uImage -j8
make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi- LOADADDR=0x80008000 
imx6sl-evk.dtb

My u-boot resides on eMMC, and I am using tftp (to load uImage and dtb) 
and nfs-rootfs.

---------------------------------
# uname -r
4.0.1

# dmesg | grep mmc
[    1.282872] Driver 'mmcblk' needs updating - please use bus_type methods
[    1.309598] sdhci-esdhc-imx 2190000.usdhc: No vmmc regulator found
[    1.315809] sdhci-esdhc-imx 2190000.usdhc: No vqmmc regulator found
[    1.367511] mmc0: SDHCI controller on 2190000.usdhc [2190000.usdhc] 
using ADMA
[    1.378980] sdhci-esdhc-imx 2194000.usdhc: No vmmc regulator found
[    1.385191] sdhci-esdhc-imx 2194000.usdhc: No vqmmc regulator found
[    1.437440] mmc1: SDHCI controller on 2194000.usdhc [2194000.usdhc] 
using ADMA
[    1.449272] sdhci-esdhc-imx 2198000.usdhc: No vmmc regulator found
[    1.455479] sdhci-esdhc-imx 2198000.usdhc: No vqmmc regulator found
[    1.507338] mmc2: SDHCI controller on 2198000.usdhc [2198000.usdhc] 
using ADMA

$ arm-none-linux-gnueabi-gcc --version
arm-none-linux-gnueabi-gcc (Sourcery CodeBench Lite 2013.05-24) 4.7.3
Copyright (C) 2012 Free Software Foundation, Inc.
---------------------------------

Any suggestions?

-- 
Xuebing
