From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V1 08/11] mmc: tegra: add Tegra186 WAR for CQE
Date: Fri, 1 Mar 2019 21:20:22 -0800
Message-ID: <1551504025-3541-8-git-send-email-skomatineni@nvidia.com>
References: <1551504025-3541-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551504025-3541-1-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, riteshh@codeaurora.org
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, anrao@nvidia.com, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, Sowjanya Komatineni <skomatineni@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Tegra186 design has a known bug where CQE does not generated task
complete interrupt for data transfer tasks issued after DCMD task
with R1b response type and results in timeout.

SW WAR is to set CMD_TIMING to 1 in task descriptor for DCMDs with
R1b response type. This bug and SW WAR is applicable only for
Tegra186 and not for Tegra194.

This patch adds this WAR to Tegra186.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 2086e0eced88..2b63626dc2fa 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -116,6 +116,7 @@ struct sdhci_tegra_soc_data {
 	u32 nvquirks;
 	u8 min_tap_delay;
 	u8 max_tap_delay;
+	u32 cqequirks;
 };
 
 /* Magic pull up and pull down pad calibration offsets */
@@ -1354,6 +1355,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra186 = {
 		    NVQUIRK_ENABLE_SDR104,
 	.min_tap_delay = 84,
 	.max_tap_delay = 136,
+	.cqequirks = CQHCI_QUIRK_CMD_TIMING_R1B_DCMD,
 };
 
 static const struct sdhci_tegra_soc_data soc_data_tegra194 = {
@@ -1383,6 +1385,7 @@ static int sdhci_tegra_add_host(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
+	const struct sdhci_tegra_soc_data *soc_data = tegra_host->soc_data;
 	struct cqhci_host *cq_host;
 	bool dma64;
 	int ret;
@@ -1407,6 +1410,7 @@ static int sdhci_tegra_add_host(struct sdhci_host *host)
 
 	cq_host->mmio = host->ioaddr + SDHCI_TEGRA_CQE_BASE_ADDR;
 	cq_host->ops = &sdhci_tegra_cqhci_ops;
+	cq_host->quirks = soc_data->cqequirks;
 
 	dma64 = host->flags & SDHCI_USE_64_BIT_DMA;
 	if (dma64)
-- 
2.7.4
