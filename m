From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v2 2/2] mmc: tegra: Add Tegra186 support
Date: Thu, 23 Feb 2017 17:23:42 +0100
Message-ID: <20170223162342.15911-2-thierry.reding@gmail.com>
References: <20170223162342.15911-1-thierry.reding@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36271 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751156AbdBWQYV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Feb 2017 11:24:21 -0500
In-Reply-To: <20170223162342.15911-1-thierry.reding@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jon Hunter <jonathanh@nvidia.com>, Alexandre Courbot <gnurou@gmail.com>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The SDHCI controller found on NVIDIA Tegra186 SoCs is very similar to
the one on prior generations of Tegra and can be supported by the same
driver.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 9ae5895678e8..9ef4afcf312c 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -434,7 +434,23 @@ static const struct sdhci_tegra_soc_data soc_data_tegra210 = {
 	.pdata = &sdhci_tegra210_pdata,
 };
 
+static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
+	.quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
+		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
+		  SDHCI_QUIRK_SINGLE_POWER_WRITE |
+		  SDHCI_QUIRK_NO_HISPD_BIT |
+		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
+		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	.ops  = &tegra114_sdhci_ops,
+};
+
+static const struct sdhci_tegra_soc_data soc_data_tegra186 = {
+	.pdata = &sdhci_tegra186_pdata,
+};
+
 static const struct of_device_id sdhci_tegra_dt_match[] = {
+	{ .compatible = "nvidia,tegra186-sdhci", .data = &soc_data_tegra186 },
 	{ .compatible = "nvidia,tegra210-sdhci", .data = &soc_data_tegra210 },
 	{ .compatible = "nvidia,tegra124-sdhci", .data = &soc_data_tegra124 },
 	{ .compatible = "nvidia,tegra114-sdhci", .data = &soc_data_tegra114 },
-- 
2.11.1

