From: Richard Zhu <r65037@freescale.com>
Subject: [PATCH 4/4] esdhc-4 mx51: enable fsl esdhc driver
Date: Fri, 24 Sep 2010 11:43:08 +0800
Message-ID: <1285299788-32209-5-git-send-email-r65037@freescale.com>
References: <1285299788-32209-1-git-send-email-r65037@freescale.com>
 <1285299788-32209-2-git-send-email-r65037@freescale.com>
 <1285299788-32209-3-git-send-email-r65037@freescale.com>
 <1285299788-32209-4-git-send-email-r65037@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe004.messaging.microsoft.com ([216.32.180.14]:6585 "EHLO
	VA3EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753741Ab0IXDjd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Sep 2010 23:39:33 -0400
Received: from mail151-va3 (localhost.localdomain [127.0.0.1])	by
 mail151-va3-R.bigfish.com (Postfix) with ESMTP id 6470AE203BF	for
 <linux-mmc@vger.kernel.org>; Fri, 24 Sep 2010 03:39:32 +0000 (UTC)
Received: from VA3EHSMHS018.bigfish.com (unknown [10.7.14.239])	by
 mail151-va3.bigfish.com (Postfix) with ESMTP id EBE7722804E	for
 <linux-mmc@vger.kernel.org>; Fri, 24 Sep 2010 03:39:30 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP id o8O3dSE6002059	for
 <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2010 20:39:28 -0700 (MST)
Received: from shlinux1.ap.freescale.net ([10.192.225.216])	by
 de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id o8O3svmm023588	for
 <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2010 22:54:57 -0500 (CDT)
In-Reply-To: <1285299788-32209-4-git-send-email-r65037@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: w.sang@pengutronix.de, u.kleine-koenig@pengutronix.de, linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Richard Zhu <r65037@freescale.com>

Enable the fsl esdhc driver on mx51 platforms

Signed-off-by: Richard Zhu <r65037@freescale.com>
---
 arch/arm/configs/mx51_defconfig |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/mx51_defconfig b/arch/arm/configs/mx51_defconfig
index a665ecb..4f3067b 100644
--- a/arch/arm/configs/mx51_defconfig
+++ b/arch/arm/configs/mx51_defconfig
@@ -106,8 +106,13 @@ CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_MXC=y
 CONFIG_MMC=y
-CONFIG_MMC_BLOCK=m
-CONFIG_MMC_SDHCI=m
+CONFIG_MMC_BLOCK=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_IO_ACCESSORS=y
+CONFIG_MMC_SDHCI_PLTFM=y
+CONFIG_MMC_SDHCI_IMX=y
+# CONFIG_MMC_MXC is not set
+# CONFIG_MEMSTICK is not set
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=m
 CONFIG_RTC_CLASS=y
-- 
1.7.0


