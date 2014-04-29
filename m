From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] mmc: rtsx: usb backend needs LED support
Date: Tue, 29 Apr 2014 11:45:59 +0200
Message-ID: <7208467.nZIXMIfPji@wuerfel>
References: <cover.1398735435.git.micky_ching@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:63650 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753225AbaD2JqN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Apr 2014 05:46:13 -0400
In-Reply-To: <cover.1398735435.git.micky_ching@realsil.com.cn>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: micky_ching@realsil.com.cn
Cc: chris@printf.net, ulf.hansson@linaro.org, lee.jones@linaro.org, sameo@linux.intel.com, gregkh@linuxfoundation.org, dan.carpenter@oracle.com, devel@linuxdriverproject.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, rogerable@realtek.com, wei_wang@realsil.com.cn

[hijacking the thread since it has the right Cc list already, sorry]

I stumbled over this doing randconfig builds on linux-next

8<----------

>From c11f54f1e5ea0557e076867ca31c90bcb20e3e0c Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 29 Apr 2014 11:41:40 +0200
Subject: [PATCH] mmc: rtsx: usb backend needs LED support

Building the rtsx USB driver requires the LED classdev base
support, otherwise we get this build error:

drivers/built-in.o: In function `rtsx_usb_sdmmc_drv_remove':
:(.text+0x806480): undefined reference to `led_classdev_unregister'
drivers/built-in.o: In function `rtsx_usb_sdmmc_drv_probe':
:(.text+0x806708): undefined reference to `led_classdev_register'

This adds an explicit dependency in Kconfig

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 92d91fe..66aedf3 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -696,6 +696,7 @@ config MMC_REALTEK_PCI
 config MMC_REALTEK_USB
 	tristate "Realtek USB SD/MMC Card Interface Driver"
 	depends on MFD_RTSX_USB
+	depends on LEDS_CLASS
 	help
 	  Say Y here to include driver code to support SD/MMC card interface
 	  of Realtek RTS5129/39 series card reader

