From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH] ARM: multi_v7_defconfig: re-enable SDHCI drivers
Date: Mon, 16 Jun 2014 10:50:42 -0600
Message-ID: <1402937442-7623-1-git-send-email-swarren@wwwdotorg.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:45757 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932068AbaFPQut (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jun 2014 12:50:49 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Stephen Warren <swarren@nvidia.com>

From: Stephen Warren <swarren@nvidia.com>

Following 5d01b7684b7e "mmc: simplify SDHCI Kconfig dependencies",
SDHCI drivers that use MMC_SDHCI_PLTFM no longer select it, but
instead depend on it. This means that multi_v7_defconfig no longer
selects it, and hence many SDHCI drivers are no longer enabled.
Explicitly enable MMC_SDHCI_PLTFM to solve this.

Fixes: 5d01b7684b7e ("mmc: simplify SDHCI Kconfig dependencies")
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
This is a fix for 3.16, and based directly on v3.16-rc1.

 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index e2d62048e198..17d9462b9fb9 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -300,6 +300,7 @@ CONFIG_MMC=y
 CONFIG_MMC_BLOCK_MINORS=16
 CONFIG_MMC_ARMMMCI=y
 CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_OF_ARASAN=y
 CONFIG_MMC_SDHCI_ESDHC_IMX=y
 CONFIG_MMC_SDHCI_DOVE=y
-- 
1.8.1.5

