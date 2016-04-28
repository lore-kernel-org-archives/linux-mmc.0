From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] mmc: sh_mobile_sdhi: remove obsolete include file
Date: Thu, 28 Apr 2016 08:18:11 +0200
Message-ID: <1461824291-2672-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-sh@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>
List-Id: linux-mmc@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

A few SH boards include the file but don't make use of it (no named
interrupts). The SDHI code removed support for this feature as well.
So, drop the references and ultimately remove the unneeded file.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Rich Felker <dalias@libc.org>
Acked-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/boards/board-sh7757lcr.c     |  1 -
 arch/sh/boards/mach-ap325rxa/setup.c |  1 -
 arch/sh/boards/mach-ecovec24/setup.c |  1 -
 arch/sh/boards/mach-kfr2r09/setup.c  |  1 -
 arch/sh/boards/mach-migor/setup.c    |  1 -
 arch/sh/boards/mach-se/7724/setup.c  |  1 -
 include/linux/mmc/sh_mobile_sdhi.h   | 10 ----------
 7 files changed, 16 deletions(-)
 delete mode 100644 include/linux/mmc/sh_mobile_sdhi.h

diff --git a/arch/sh/boards/board-sh7757lcr.c b/arch/sh/boards/board-sh7757lcr.c
index 324599bfad1420..0104c8199c48fe 100644
--- a/arch/sh/boards/board-sh7757lcr.c
+++ b/arch/sh/boards/board-sh7757lcr.c
@@ -20,7 +20,6 @@
 #include <linux/mfd/tmio.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/sh_mmcif.h>
-#include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/sh_eth.h>
 #include <linux/sh_intc.h>
 #include <linux/usb/renesas_usbhs.h>
diff --git a/arch/sh/boards/mach-ap325rxa/setup.c b/arch/sh/boards/mach-ap325rxa/setup.c
index 62c3b81300ed28..de8393cb7313bc 100644
--- a/arch/sh/boards/mach-ap325rxa/setup.c
+++ b/arch/sh/boards/mach-ap325rxa/setup.c
@@ -15,7 +15,6 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/mmc/host.h>
-#include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/mtd/physmap.h>
 #include <linux/mtd/sh_flctl.h>
 #include <linux/mfd/tmio.h>
diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index a9c0c07386fddd..6d612792f6b8ec 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -13,7 +13,6 @@
 #include <linux/platform_device.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/sh_mmcif.h>
-#include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/mtd/physmap.h>
 #include <linux/mfd/tmio.h>
 #include <linux/gpio.h>
diff --git a/arch/sh/boards/mach-kfr2r09/setup.c b/arch/sh/boards/mach-kfr2r09/setup.c
index 6bd9230e64e300..5deb2d82f19f78 100644
--- a/arch/sh/boards/mach-kfr2r09/setup.c
+++ b/arch/sh/boards/mach-kfr2r09/setup.c
@@ -11,7 +11,6 @@
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/mmc/host.h>
-#include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/mfd/tmio.h>
 #include <linux/mtd/physmap.h>
 #include <linux/mtd/onenand.h>
diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
index 7a04da3efce402..5de60a77eaa1ab 100644
--- a/arch/sh/boards/mach-migor/setup.c
+++ b/arch/sh/boards/mach-migor/setup.c
@@ -13,7 +13,6 @@
 #include <linux/input.h>
 #include <linux/input/sh_keysc.h>
 #include <linux/mmc/host.h>
-#include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/mtd/physmap.h>
 #include <linux/mfd/tmio.h>
 #include <linux/mtd/nand.h>
diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
index e0e1df136642cd..f1fecd395679ae 100644
--- a/arch/sh/boards/mach-se/7724/setup.c
+++ b/arch/sh/boards/mach-se/7724/setup.c
@@ -15,7 +15,6 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/mmc/host.h>
-#include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/mfd/tmio.h>
 #include <linux/mtd/physmap.h>
 #include <linux/delay.h>
diff --git a/include/linux/mmc/sh_mobile_sdhi.h b/include/linux/mmc/sh_mobile_sdhi.h
deleted file mode 100644
index 95d6f0314a7ded..00000000000000
--- a/include/linux/mmc/sh_mobile_sdhi.h
+++ /dev/null
@@ -1,10 +0,0 @@
-#ifndef LINUX_MMC_SH_MOBILE_SDHI_H
-#define LINUX_MMC_SH_MOBILE_SDHI_H
-
-#include <linux/types.h>
-
-#define SH_MOBILE_SDHI_IRQ_CARD_DETECT	"card_detect"
-#define SH_MOBILE_SDHI_IRQ_SDCARD	"sdcard"
-#define SH_MOBILE_SDHI_IRQ_SDIO		"sdio"
-
-#endif /* LINUX_MMC_SH_MOBILE_SDHI_H */
-- 
2.7.0
