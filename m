From: Kevin Hao <haokexin@gmail.com>
Subject: [PATCH 11/15] mmc: kconfig: replace PPC_OF with PPC
Date: Sat, 31 Jan 2015 21:47:41 +0800
Message-ID: <1422712065-9403-12-git-send-email-haokexin@gmail.com>
References: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f176.google.com ([209.85.160.176]:55647 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbbAaNsv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 31 Jan 2015 08:48:51 -0500
Received: by mail-yk0-f176.google.com with SMTP id q200so19117778ykb.7
        for <linux-mmc@vger.kernel.org>; Sat, 31 Jan 2015 05:48:50 -0800 (PST)
In-Reply-To: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org, linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Michael Ellerman <mpe@ellerman.id.au>, Kevin Hao <haokexin@gmail.com>

The PPC_OF is a ppc specific option which is used to mean that the
firmware device tree access functions are available. Since all the
ppc platforms have a device tree, it is aways set to 'y' for ppc.
So it makes no sense to keep a such option in the current kernel.
Replace it with PPC.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/mmc/host/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index f145f1558353..a18dde1078ea 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -132,7 +132,7 @@ config MMC_SDHCI_OF_ARASAN
 config MMC_SDHCI_OF_ESDHC
 	tristate "SDHCI OF support for the Freescale eSDHC controller"
 	depends on MMC_SDHCI_PLTFM
-	depends on PPC_OF
+	depends on PPC
 	select MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
 	help
 	  This selects the Freescale eSDHC controller support.
@@ -144,7 +144,7 @@ config MMC_SDHCI_OF_ESDHC
 config MMC_SDHCI_OF_HLWD
 	tristate "SDHCI OF support for the Nintendo Wii SDHCI controllers"
 	depends on MMC_SDHCI_PLTFM
-	depends on PPC_OF
+	depends on PPC
 	select MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
-- 
1.9.3

