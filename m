From: Christian Daudt <bcm@fixthebug.org>
Subject: [PATCH v2 3/4] rename ARCH_BCM to ARCH_BCM_MOBILE (mmc)
Date: Mon, 23 Sep 2013 10:20:35 -0700
Message-ID: <1379956836-5866-4-git-send-email-bcm@fixthebug.org>
References: <1379956836-5866-1-git-send-email-bcm@fixthebug.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36254 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691Ab3IWRVH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Sep 2013 13:21:07 -0400
Received: by mail-pa0-f49.google.com with SMTP id ld10so3813776pab.8
        for <linux-mmc@vger.kernel.org>; Mon, 23 Sep 2013 10:21:07 -0700 (PDT)
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

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 7fc5099..7e89650 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -251,7 +251,7 @@ config MMC_SDHCI_S3C_DMA
 
 config MMC_SDHCI_BCM_KONA
 	tristate "SDHCI support on Broadcom KONA platform"
-	depends on ARCH_BCM
+	depends on ARCH_BCM_MOBILE
 	select MMC_SDHCI_PLTFM
 	help
 	  This selects the Broadcom Kona Secure Digital Host Controller
-- 
1.7.10.4

