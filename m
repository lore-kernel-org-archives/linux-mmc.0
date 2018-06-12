From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH 05/19] mmc: mmci: allow to overwrite clock/power procedure to specific variant
Date: Tue, 12 Jun 2018 15:14:26 +0200
Message-ID: <1528809280-31116-6-git-send-email-ludovic.Barre@st.com>
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

A specific variant could have different power or clock procedures.
This patch allows to overwrite the default mmci_set_clkreg and
mmci_set_pwrreg for a specific variant.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 96 +++++++++++++++++++++++++++++--------------------
 drivers/mmc/host/mmci.h |  7 ++++
 2 files changed, 64 insertions(+), 39 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index ede95b7..801c86b 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -374,6 +374,52 @@ static void mmci_set_clkreg(struct mmci_host *host, unsigned int desired)
 	mmci_write_clkreg(host, clk);
 }
 
+static void mmci_set_pwrreg(struct mmci_host *host, unsigned char power_mode,
+			    unsigned int pwr)
+{
+	struct variant_data *variant = host->variant;
+	struct mmc_host *mmc = host->mmc;
+
+	switch (power_mode) {
+	case MMC_POWER_OFF:
+		if (!IS_ERR(mmc->supply.vmmc))
+			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
+
+		if (!IS_ERR(mmc->supply.vqmmc) && host->vqmmc_enabled) {
+			regulator_disable(mmc->supply.vqmmc);
+			host->vqmmc_enabled = false;
+		}
+
+		break;
+	case MMC_POWER_UP:
+		if (!IS_ERR(mmc->supply.vmmc))
+			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc,
+					      mmc->ios.vdd);
+
+		/*
+		 * The ST Micro variant doesn't have the PL180s MCI_PWR_UP
+		 * and instead uses MCI_PWR_ON so apply whatever value is
+		 * configured in the variant data.
+		 */
+		pwr |= variant->pwrreg_powerup;
+
+		break;
+	case MMC_POWER_ON:
+		if (!IS_ERR(mmc->supply.vqmmc) && !host->vqmmc_enabled) {
+			if (regulator_enable(mmc->supply.vqmmc) < 0)
+				dev_err(mmc_dev(mmc),
+					"failed to enable vqmmc regulator\n");
+			else
+				host->vqmmc_enabled = true;
+		}
+
+		pwr |= MCI_PWR_ON;
+		break;
+	}
+
+	mmci_write_pwrreg(host, pwr);
+}
+
 static void
 mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
 {
@@ -1031,7 +1077,7 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct mmci_host *host = mmc_priv(mmc);
 	struct variant_data *variant = host->variant;
-	u32 pwr = 0;
+	unsigned int pwr = 0;
 	unsigned long flags;
 	int ret;
 
@@ -1039,42 +1085,6 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		host->plat->ios_handler(mmc_dev(mmc), ios))
 			dev_err(mmc_dev(mmc), "platform ios_handler failed\n");
 
-	switch (ios->power_mode) {
-	case MMC_POWER_OFF:
-		if (!IS_ERR(mmc->supply.vmmc))
-			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
-
-		if (!IS_ERR(mmc->supply.vqmmc) && host->vqmmc_enabled) {
-			regulator_disable(mmc->supply.vqmmc);
-			host->vqmmc_enabled = false;
-		}
-
-		break;
-	case MMC_POWER_UP:
-		if (!IS_ERR(mmc->supply.vmmc))
-			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd);
-
-		/*
-		 * The ST Micro variant doesn't have the PL180s MCI_PWR_UP
-		 * and instead uses MCI_PWR_ON so apply whatever value is
-		 * configured in the variant data.
-		 */
-		pwr |= variant->pwrreg_powerup;
-
-		break;
-	case MMC_POWER_ON:
-		if (!IS_ERR(mmc->supply.vqmmc) && !host->vqmmc_enabled) {
-			ret = regulator_enable(mmc->supply.vqmmc);
-			if (ret < 0)
-				dev_err(mmc_dev(mmc),
-					"failed to enable vqmmc regulator\n");
-			else
-				host->vqmmc_enabled = true;
-		}
-
-		pwr |= MCI_PWR_ON;
-		break;
-	}
 
 	if (variant->signal_direction && ios->power_mode != MMC_POWER_OFF) {
 		/*
@@ -1126,8 +1136,16 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	spin_lock_irqsave(&host->lock, flags);
 
-	mmci_set_clkreg(host, ios->clock);
-	mmci_write_pwrreg(host, pwr);
+	if (variant->set_clkreg)
+		variant->set_clkreg(host, ios->clock);
+	else
+		mmci_set_clkreg(host, ios->clock);
+
+	if (variant->set_pwrreg)
+		variant->set_pwrreg(host, ios->power_mode, pwr);
+	else
+		mmci_set_pwrreg(host, ios->power_mode, pwr);
+
 	mmci_reg_delay(host);
 
 	spin_unlock_irqrestore(&host->lock, flags);
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 2ba9640..7265ca6 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -231,6 +231,7 @@
 
 struct clk;
 struct dma_chan;
+struct mmci_host;
 
 /**
  * struct variant_data - MMCI variant-specific quirks
@@ -273,6 +274,8 @@ struct dma_chan;
  *	       register.
  * @opendrain: bitmask identifying the OPENDRAIN bit inside MMCIPOWER register
  * @mmci_dma: Pointer to platform-specific DMA callbacks.
+ * @set_clk_ios: if clock procedure of variant is specific
+ * @set_pwr_ios: if power procedure of variant is specific
  */
 struct variant_data {
 	unsigned int		clkreg;
@@ -307,6 +310,9 @@ struct variant_data {
 	u32			start_err;
 	u32			opendrain;
 	struct mmci_dma_ops	*mmci_dma;
+	void (*set_clkreg)(struct mmci_host *host, unsigned int desired);
+	void (*set_pwrreg)(struct mmci_host *host, unsigned char power_mode,
+			   unsigned int pwr);
 };
 
 struct mmci_host {
@@ -328,6 +334,7 @@ struct mmci_host {
 	u32			pwr_reg;
 	u32			pwr_reg_add;
 	u32			clk_reg;
+	u32			clk_reg_add;
 	u32			datactrl_reg;
 	u32			busy_status;
 	u32			mask1_reg;
-- 
2.7.4
