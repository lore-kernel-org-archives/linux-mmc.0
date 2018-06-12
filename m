From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH 18/19] mmc: mmci: add specific clk/pwr procedure for stm32 sdmmc
Date: Tue, 12 Jun 2018 15:14:39 +0200
Message-ID: <1528809280-31116-19-git-send-email-ludovic.Barre@st.com>
References: <1528809280-31116-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528809280-31116-1-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Gerald Baeza <gerald.baeza@st.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, Ludovic Barre <ludovic.barre@st.com>
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds specific clock and power ios for stm32 sdmmc variant.
power ios: stm32 dedicated procedure must be done to perform power
off/on procedures. To power off, the sdmmc must be reset and set
to power cycle state before to disabling vqmmc. This drives low
SDMMC_D[7:0], SDMMC_CMD and SDMMC_CK to prevent the Card from
being supplied through the signal lines.
To power on, set the SDMMC in power-off SDMMC_D[7:0], SDMMC_CMD
and SDMMC_CK are driven high. Then we can set the SDMMC to
Power-on state.

clock ios: specific bits behavior:
-clock divider card_clk = mclk / (2 * clkdiv)
-ddr activation
-wide bus 1/4/8bits
-bus speed
-receive clock selection (in_ck/ck_in/fb_ck)

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 112 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 86aef4f..af27a0a 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -50,6 +50,10 @@
 
 static unsigned int fmax = 515633;
 
+static void mmci_sdmmc_set_pwrreg(struct mmci_host *host,
+				  unsigned char power_mode, unsigned int pwr);
+static void mmci_sdmmc_set_clkreg(struct mmci_host *host, unsigned int desired);
+
 static struct variant_data variant_arm = {
 	.fifosize		= 16 * 4,
 	.fifohalfsize		= 8 * 4,
@@ -490,6 +494,114 @@ static void mmci_set_pwrreg(struct mmci_host *host, unsigned char power_mode,
 	mmci_write_pwrreg(host, pwr);
 }
 
+static void mmci_sdmmc_set_clkreg(struct mmci_host *host, unsigned int desired)
+{
+	unsigned int clk = 0, ddr = 0;
+
+	if (host->mmc->ios.timing == MMC_TIMING_MMC_DDR52 ||
+	    host->mmc->ios.timing == MMC_TIMING_UHS_DDR50)
+		ddr = MCI_STM32_CLK_DDR;
+
+	/*
+	 * cclk = mclk / (2 * clkdiv)
+	 * clkdiv 0 => bypass
+	 * in ddr mode bypass is not possible
+	 */
+	if (desired) {
+		if (desired >= host->mclk && !ddr) {
+			host->cclk = host->mclk;
+		} else {
+			clk = DIV_ROUND_UP(host->mclk, 2 * desired);
+			if (clk > MCI_STM32_CLK_CLKDIV_MSK)
+				clk = MCI_STM32_CLK_CLKDIV_MSK;
+			host->cclk = host->mclk / (2 * clk);
+		}
+	}
+
+	if (host->mmc->ios.bus_width == MMC_BUS_WIDTH_4)
+		clk |= MCI_STM32_CLK_WIDEBUS_4;
+	if (host->mmc->ios.bus_width == MMC_BUS_WIDTH_8)
+		clk |= MCI_STM32_CLK_WIDEBUS_8;
+
+	clk |= MCI_STM32_CLK_HWFCEN;
+	clk |= host->clk_reg_add;
+	clk |= ddr;
+
+	/*
+	 * SDMMC_FBCK is selected when an external Delay Block is needed
+	 * with SDR104.
+	 */
+	if (host->mmc->ios.timing >= MMC_TIMING_UHS_SDR50) {
+		clk |= MCI_STM32_CLK_BUSSPEED;
+		if (host->mmc->ios.timing == MMC_TIMING_UHS_SDR104) {
+			clk &= ~MCI_STM32_CLK_SEL_MSK;
+			clk |= MCI_STM32_CLK_SELFBCK;
+		}
+	}
+
+	mmci_write_clkreg(host, clk);
+}
+
+static void mmci_sdmmc_set_pwrreg(struct mmci_host *host,
+				  unsigned char power_mode, unsigned int pwr)
+{
+	struct mmc_host *mmc = host->mmc;
+
+	pwr |= host->pwr_reg_add;
+
+	switch (power_mode) {
+	case MMC_POWER_OFF:
+		if (!IS_ERR(mmc->supply.vmmc))
+			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
+
+		/* Only a reset could disable sdmmc */
+		reset_control_assert(host->rst);
+		udelay(2);
+		reset_control_deassert(host->rst);
+
+		/* default mask (probe) must be activated */
+		writel(MCI_IRQENABLE | host->variant->start_err,
+		       host->base + MMCIMASK0);
+
+		/*
+		 * Set the SDMMC in Power-cycle state before to disabling vqmmc.
+		 * This will make that the SDMMC_D[7:0], SDMMC_CMD and SDMMC_CK
+		 * are driven low, to prevent the Card from being supplied
+		 * through the signal lines.
+		 */
+		mmci_write_pwrreg(host, MCI_STM32_PWR_CYC | pwr);
+
+		if (!IS_ERR(host->mmc->supply.vqmmc) && host->vqmmc_enabled) {
+			regulator_disable(host->mmc->supply.vqmmc);
+			host->vqmmc_enabled = false;
+		}
+		break;
+	case MMC_POWER_UP:
+		if (!IS_ERR(mmc->supply.vmmc))
+			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc,
+					      mmc->ios.vdd);
+		break;
+	case MMC_POWER_ON:
+		if (!IS_ERR(host->mmc->supply.vqmmc) && !host->vqmmc_enabled) {
+			if (regulator_enable(host->mmc->supply.vqmmc) < 0)
+				dev_err(mmc_dev(host->mmc),
+					"failed to enable vqmmc regulator\n");
+			else
+				host->vqmmc_enabled = true;
+		}
+
+		/*
+		 * After a power-cycle state, we must set the SDMMC in
+		 * Power-off. The SDMMC_D[7:0], SDMMC_CMD and SDMMC_CK are
+		 * driven high. Then we can set the SDMMC to Power-on state
+		 */
+		mmci_write_pwrreg(host, MCI_PWR_OFF | pwr);
+		mdelay(1);
+		mmci_write_pwrreg(host, MCI_PWR_ON | pwr);
+		break;
+	}
+}
+
 static void
 mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
 {
-- 
2.7.4
