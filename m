From: Richard Zhu <r65037@freescale.com>
Subject: [PATCH 4/4] esdhc-4 mx51: enable fsl esdhc driver
Date: Fri, 24 Sep 2010 11:54:27 +0800
Message-ID: <1285300467-5158-5-git-send-email-r65037@freescale.com>
References: <1285300467-5158-1-git-send-email-r65037@freescale.com>
 <1285300467-5158-2-git-send-email-r65037@freescale.com>
 <1285300467-5158-3-git-send-email-r65037@freescale.com>
 <1285300467-5158-4-git-send-email-r65037@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:57901
	"EHLO VA3EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755454Ab0IXDuy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Sep 2010 23:50:54 -0400
Received: from mail170-va3 (localhost.localdomain [127.0.0.1])	by
 mail170-va3-R.bigfish.com (Postfix) with ESMTP id BB74AEE02A3	for
 <linux-mmc@vger.kernel.org>; Fri, 24 Sep 2010 03:50:51 +0000 (UTC)
Received: from VA3EHSMHS026.bigfish.com (unknown [10.7.14.250])	by
 mail170-va3.bigfish.com (Postfix) with ESMTP id 685611A6004F	for
 <linux-mmc@vger.kernel.org>; Fri, 24 Sep 2010 03:50:50 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
 [10.64.34.200])	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
 o8O3okRj026927	for <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2010 20:50:46
 -0700 (MST)
Received: from shlinux1.ap.freescale.net ([10.192.225.216])	by
 az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id o8O3oqJT015861	for
 <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2010 22:50:52 -0500 (CDT)
In-Reply-To: <1285300467-5158-4-git-send-email-r65037@freescale.com>
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


