From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V2 07/10] mmc: tegra: add Tegra186 WAR for CQE
Date: Mon, 11 Mar 2019 11:02:36 -0700
Message-ID: <1552327359-8036-7-git-send-email-skomatineni@nvidia.com>
References: <1552327359-8036-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552327359-8036-1-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, riteshh@codeaurora.org
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, anrao@nvidia.com, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Tegra186 CQHCI host has a known bug where CQHCI controller selects
DATA_PRESENT_SELECT bit to 1 for DCMDs with R1B response type and
since DCMD does not trigger any data transfer, DCMD task complete
happens leaving the DATA FSM of host controller in wait state for
the data.

This effects the data transfer tasks issued after the DCMDs with
R1b response type resulting in timeout.

SW WAR is to set CMD_TIMING to 1 in DCMD task descriptor. This bug
and SW WAR is applicable only for Tegra186 and not for Tegra194.

This patch implements this WAR thru NVQUIRK_CQHCI_DCMD_R1B_CMD_TIMING
for Tegra186 and also implements get_dcmd_cmd_timing cqhci_host_ops
interface to specify the CMD_TIMING bit depending on the NVQUIRK.

Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index f1aa0591112a..1ac0ca37ce95 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -106,6 +106,7 @@
 #define NVQUIRK_HAS_PADCALIB				BIT(6)
 #define NVQUIRK_NEEDS_PAD_CONTROL			BIT(7)
 #define NVQUIRK_DIS_CARD_CLK_CONFIG_TAP			BIT(8)
+#define NVQUIRK_CQHCI_DCMD_R1B_CMD_TIMING		BIT(9)
 
 /* SDMMC CQE Base Address for Tegra Host Ver 4.1 and Higher */
 #define SDHCI_TEGRA_CQE_BASE_ADDR			0xF000
@@ -1123,6 +1124,21 @@ static void tegra_sdhci_voltage_switch(struct sdhci_host *host)
 		tegra_host->pad_calib_required = true;
 }
 
+static u8 sdhci_tegra_cqe_dcmd_cmd_timing(struct mmc_host *mmc,
+					  struct mmc_request *mrq)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(mmc_priv(mmc));
+	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
+	const struct sdhci_tegra_soc_data *soc_data = tegra_host->soc_data;
+
+	if (soc_data->nvquirks & NVQUIRK_CQHCI_DCMD_R1B_CMD_TIMING)
+		return 1;
+	else if (mrq->cmd->flags & MMC_RSP_R1B)
+		return 0;
+	else
+		return 1;
+}
+
 static void sdhci_tegra_cqe_enable(struct mmc_host *mmc)
 {
 	struct cqhci_host *cq_host = mmc->cqe_private;
@@ -1164,6 +1180,7 @@ static const struct cqhci_host_ops sdhci_tegra_cqhci_ops = {
 	.enable	= sdhci_tegra_cqe_enable,
 	.disable = sdhci_cqe_disable,
 	.dumpregs = sdhci_tegra_dumpregs,
+	.get_dcmd_cmd_timing = sdhci_tegra_cqe_dcmd_cmd_timing,
 };
 
 static const struct sdhci_ops tegra_sdhci_ops = {
@@ -1345,7 +1362,8 @@ static const struct sdhci_tegra_soc_data soc_data_tegra186 = {
 		    NVQUIRK_HAS_PADCALIB |
 		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP |
 		    NVQUIRK_ENABLE_SDR50 |
-		    NVQUIRK_ENABLE_SDR104,
+		    NVQUIRK_ENABLE_SDR104 |
+		    NVQUIRK_CQHCI_DCMD_R1B_CMD_TIMING,
 	.min_tap_delay = 84,
 	.max_tap_delay = 136,
 };
-- 
2.7.4
