From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V3 09/10] mmc: tegra: fix CQE enable and resume sequence
Date: Wed, 13 Mar 2019 14:45:51 -0700
Message-ID: <1552513552-23423-9-git-send-email-skomatineni@nvidia.com>
References: <1552513552-23423-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552513552-23423-1-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, riteshh@codeaurora.org
Cc: skomatineni@nvidia.com, thierry.reding@gmail.com, jonathanh@nvidia.com, anrao@nvidia.com, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Tegra CQHCI/SDHCI design prevents write access to SDHCI block size
register when CQE is enabled and unhalted.

CQHCI driver enables CQE prior to invoking sdhci_cqe_enable which
violates this Tegra specific host requirement.

This patch fixes this by configuring sdhci block registers prior
to CQE unhalt.

This patch also has a fix for retry of unhalt due to known Tegra
specific CQE resume bug where first unhalt might not succeed when
clear all tasks is performed prior to resume and need a second unhalt.

This patch also includes CQE enable fix for CMD CRC errors that
happen with the specific sandisk emmc device when status command
is sent during the transfer of last data block due to marginal timing.

Tested-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 72 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 62 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 2f08b6e480df..eafaaefab4a6 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -1124,6 +1124,43 @@ static void tegra_sdhci_voltage_switch(struct sdhci_host *host)
 		tegra_host->pad_calib_required = true;
 }
 
+static void tegra_cqhci_writel(struct cqhci_host *cq_host, u32 val, int reg)
+{
+	struct mmc_host *mmc = cq_host->mmc;
+	u8 ctrl;
+	ktime_t timeout;
+	bool timed_out;
+
+	/*
+	 * During CQE resume/unhalt, CQHCI driver unhalts CQE prior to
+	 * cqhci_host_ops enable where SDHCI DMA and BLOCK_SIZE registers need
+	 * to be re-configured.
+	 * Tegra CQHCI/SDHCI prevents write access to block size register when
+	 * CQE is unhalted. So handling CQE resume sequence here to configure
+	 * SDHCI block registers prior to exiting CQE halt state.
+	 */
+	if (reg == CQHCI_CTL && !(val & CQHCI_HALT) &&
+	    cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT) {
+		sdhci_cqe_enable(mmc);
+		writel(val, cq_host->mmio + reg);
+		timeout = ktime_add_us(ktime_get(), 50);
+		while (1) {
+			timed_out = ktime_compare(ktime_get(), timeout) > 0;
+			ctrl = cqhci_readl(cq_host, CQHCI_CTL);
+			if (!(ctrl & CQHCI_HALT) || timed_out)
+				break;
+		}
+		/*
+		 * CQE usually resumes very quick, but incase if Tegra CQE
+		 * doesn't resume retry unhalt.
+		 */
+		if (timed_out)
+			writel(val, cq_host->mmio + reg);
+	} else {
+		writel(val, cq_host->mmio + reg);
+	}
+}
+
 static void sdhci_tegra_update_dcmd_desc(struct mmc_host *mmc,
 					 struct mmc_request *mrq, u64 *data)
 {
@@ -1139,20 +1176,34 @@ static void sdhci_tegra_update_dcmd_desc(struct mmc_host *mmc,
 static void sdhci_tegra_cqe_enable(struct mmc_host *mmc)
 {
 	struct cqhci_host *cq_host = mmc->cqe_private;
-	u32 cqcfg = 0;
+	u32 val;
 
 	/*
-	 * Tegra SDMMC Controller design prevents write access to BLOCK_COUNT
-	 * registers when CQE is enabled.
+	 * Tegra CQHCI/SDMMC design prevents write access to sdhci block size
+	 * register when CQE is enabled and unhalted.
+	 * CQHCI driver enables CQE prior to activation, so disable CQE before
+	 * programming block size in sdhci controller and enable it back.
 	 */
-	cqcfg = cqhci_readl(cq_host, CQHCI_CFG);
-	if (cqcfg & CQHCI_ENABLE)
-		cqhci_writel(cq_host, (cqcfg & ~CQHCI_ENABLE), CQHCI_CFG);
-
-	sdhci_cqe_enable(mmc);
+	if (!cq_host->activated) {
+		val = cqhci_readl(cq_host, CQHCI_CFG);
+		if (val & CQHCI_ENABLE)
+			cqhci_writel(cq_host, (val & ~CQHCI_ENABLE),
+				     CQHCI_CFG);
+		sdhci_cqe_enable(mmc);
+		if (val & CQHCI_ENABLE)
+			cqhci_writel(cq_host, val, CQHCI_CFG);
+	}
 
-	if (cqcfg & CQHCI_ENABLE)
-		cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
+	/*
+	 * CMD CRC errors are seen sometimes with some eMMC devices when status
+	 * command is sent during transfer of last data block which is the
+	 * default case as send status command block counter (CBC) is 1.
+	 * Recommended fix to set CBC to 0 allowing send status command only
+	 * when data lines are idle.
+	 */
+	val = cqhci_readl(cq_host, CQHCI_SSC1);
+	val &= ~CQHCI_SSC1_CBC_MASK;
+	cqhci_writel(cq_host, val, CQHCI_SSC1);
 }
 
 static void sdhci_tegra_dumpregs(struct mmc_host *mmc)
@@ -1174,6 +1225,7 @@ static u32 sdhci_tegra_cqhci_irq(struct sdhci_host *host, u32 intmask)
 }
 
 static const struct cqhci_host_ops sdhci_tegra_cqhci_ops = {
+	.write_l    = tegra_cqhci_writel,
 	.enable	= sdhci_tegra_cqe_enable,
 	.disable = sdhci_cqe_disable,
 	.dumpregs = sdhci_tegra_dumpregs,
-- 
2.7.4
