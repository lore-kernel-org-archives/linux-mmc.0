From: Matt Porter <mporter@linaro.org>
Subject: [PATCH] ARM: bcm_defconfig: re-enable BCM Kona SDHCI driver
Date: Mon, 16 Jun 2014 13:56:16 -0400
Message-ID: <1402941376-29594-1-git-send-email-mporter@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:41725 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755487AbaFPR42 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jun 2014 13:56:28 -0400
Received: by mail-ig0-f176.google.com with SMTP id a13so3221453igq.9
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jun 2014 10:56:27 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: arm@kernel.org
Cc: Linux MMC List <linux-mmc@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

Since 5d01b7684b7e "mmc: simplify SDHCI Kconfig dependencies",
MMC_SDHCI_PLTFM is no longer selected by the BCM Kona SDHCI
driver which is enabled in this defconfig. This results in the
SDHCI driver not being built and a boot failure. Explictly
enable MMC_SDHCI_PLTFM in bcm_defconfig so the BCM Kona SDHCI
driver is built.

Fixes: 5d01b7684b7e ("mmc: simplify SDHCI Kconfig dependencies")
Signed-off-by: Matt Porter <mporter@linaro.org>
---
 arch/arm/configs/bcm_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/bcm_defconfig b/arch/arm/configs/bcm_defconfig
index 9d13dae..dcfc559 100644
--- a/arch/arm/configs/bcm_defconfig
+++ b/arch/arm/configs/bcm_defconfig
@@ -98,6 +98,7 @@ CONFIG_MMC_UNSAFE_RESUME=y
 CONFIG_MMC_BLOCK_MINORS=32
 CONFIG_MMC_TEST=y
 CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_BCM_KONA=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
-- 
1.8.4

