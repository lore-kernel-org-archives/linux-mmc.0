From: Christian Daudt <bcm@fixthebug.org>
Subject: [PATCH v2 4/4] rename ARCH_BCM to ARCH_BCM_MOBILE (dt)
Date: Mon, 23 Sep 2013 10:20:36 -0700
Message-ID: <1379956836-5866-5-git-send-email-bcm@fixthebug.org>
References: <1379956836-5866-1-git-send-email-bcm@fixthebug.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:60239 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635Ab3IWRV1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Sep 2013 13:21:27 -0400
Received: by mail-pd0-f175.google.com with SMTP id q10so3466506pdj.6
        for <linux-mmc@vger.kernel.org>; Mon, 23 Sep 2013 10:21:27 -0700 (PDT)
In-Reply-To: <1379956836-5866-1-git-send-email-bcm@fixthebug.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@wwwdotorg.org>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Chris Ball <cjb@laptop.org>
Cc: Domenico Andreoli <cavokz@gmail.com>, Christian Daudt <csd@broadcom.com>, Hauke Mehrtens <hauke@hauke-m.de>, Matt Porter <matt.porter@linaro.org>, Alex Elder <alex.elder@linaro.org>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Christian Daudt <bcm@fixthebug.org>

Currently ARCH_BCM has been used for Broadcom
Mobile V7 based SoCs. In order to allow other Broadcom
SoCs to also use mach-bcm directory and files, this patch
renames the original ARCH_BCM to ARCH_BCM_MOBILE, and
uses ARCH_BCM to define any Broadcom chip residing
in mach-bcm directory.

Signed-off-by: Christian Daudt <bcm@fixthebug.org>
Acked-by: Olof Johansson <olof@lixom.net>

Changes from v1:
 - fix alpha ordering in dts/Makefile
 - break into 4 patches for separate subsys

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index cc0f1fb..2b07eb8 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -41,9 +41,9 @@ dtb-$(CONFIG_ARCH_AT91)	+= sama5d33ek.dtb
 dtb-$(CONFIG_ARCH_AT91)	+= sama5d34ek.dtb
 dtb-$(CONFIG_ARCH_AT91)	+= sama5d35ek.dtb
 
-dtb-$(CONFIG_ARCH_BCM2835) += bcm2835-rpi-b.dtb
-dtb-$(CONFIG_ARCH_BCM) += bcm11351-brt.dtb \
+dtb-$(CONFIG_ARCH_BCM_MOBILE) += bcm11351-brt.dtb \
 	bcm28155-ap.dtb
+dtb-$(CONFIG_ARCH_BCM2835) += bcm2835-rpi-b.dtb
 dtb-$(CONFIG_ARCH_DAVINCI) += da850-enbw-cmc.dtb \
 	da850-evm.dtb
 dtb-$(CONFIG_ARCH_DOVE) += dove-cm-a510.dtb \
-- 
1.7.10.4

