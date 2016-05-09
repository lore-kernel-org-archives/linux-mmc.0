From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] mmc: tegra: Disable UHS-I modes for tegra30
Date: Mon, 9 May 2016 16:15:03 +0100
Message-ID: <1462806903-13860-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:4937 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061AbcEIPPK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 May 2016 11:15:10 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>

Support for SD cards is not working on the Tegra30 Beaver board and on
boot the following error message is seen if an SD card is present:

 mmc0: error -110 whilst initialising SD card

In addition to this, Tegra30 is also randomly hanging during system
suspend when entering and is caused by the Tegra SDHCI driver. Similar
issues have been seen on the Tegra124 Jetson TK1 and are linked to the
UHS-I tuning sequence. Disabling the UHS-I modes for Tegra30 fixes SD
card support and prevents any hangs from occurring when entering system
suspend. Therefore, disable the UHS-I modes for Tegra30 for now until
we can correct the tuning sequence for Tegra.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index bcc0de47fe7e..24c33aee8e7c 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -347,10 +347,6 @@ static const struct sdhci_pltfm_data sdhci_tegra30_pdata = {
 
 static const struct sdhci_tegra_soc_data soc_data_tegra30 = {
 	.pdata = &sdhci_tegra30_pdata,
-	.nvquirks = NVQUIRK_ENABLE_SDHCI_SPEC_300 |
-		    NVQUIRK_ENABLE_SDR50 |
-		    NVQUIRK_ENABLE_SDR104 |
-		    NVQUIRK_HAS_PADCALIB,
 };
 
 static const struct sdhci_ops tegra114_sdhci_ops = {
-- 
2.1.4

