From: Kevin Hao <haokexin@gmail.com>
Subject: [PATCH v2 09/11] mmc: kconfig: replace PPC_OF with PPC
Date: Thu, 26 Feb 2015 20:08:21 +0800
Message-ID: <1424952503-8247-10-git-send-email-haokexin@gmail.com>
References: <1424952503-8247-1-git-send-email-haokexin@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f170.google.com ([209.85.160.170]:35027 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753184AbbBZMJv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Feb 2015 07:09:51 -0500
Received: by ykbq200 with SMTP id q200so3840015ykb.2
        for <linux-mmc@vger.kernel.org>; Thu, 26 Feb 2015 04:09:51 -0800 (PST)
In-Reply-To: <1424952503-8247-1-git-send-email-haokexin@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org

The PPC_OF is a ppc specific option which is used to mean that the
firmware device tree access functions are available. Since all the
ppc platforms have a device tree, it is aways set to 'y' for ppc.
So it makes no sense to keep a such option in the current kernel.
Replace it with PPC.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
v2: No change.

 drivers/mmc/host/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 61ac63a3776a..7858d7a52818 100644
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

