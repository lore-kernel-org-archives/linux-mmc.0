From: <patrice.chotard@st.com>
Subject: [PATCH v3 01/14] mmc: mmci: Don't pretend all variants to have MMCIMASK1 register
Date: Thu, 18 Jan 2018 15:34:17 +0100
Message-ID: <1516286070-24927-2-git-send-email-patrice.chotard@st.com>
References: <1516286070-24927-1-git-send-email-patrice.chotard@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1516286070-24927-1-git-send-email-patrice.chotard@st.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Russell King <linux@armlinux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexandre Torgue <alexandre.torgue@st.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, Patrice Chotard <patrice.chotard@st.com>, Andrea Merello <andrea.merello@gmail.com>
List-Id: linux-mmc@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

Two mask registers are used in order to select which events have to
actually generate an interrupt on each IRQ line.

It seems that in the single-IRQ case it's assumed that the IRQs lines
are simply OR-ed, while the two mask registers are still present. The
driver still programs the two mask registers separately.

However the STM32 variant has only one IRQ, and also has only one mask
register.

This patch prepares for STM32 variant support by making the driver using
only one mask register.

This patch also optimize the MMCIMASK1 mask usage by caching it into
host->mask1_reg which avoid to read it into mmci_irq().

Tested only on STM32 variant. RFT for variants other than STM32

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
v3: _ none

v2: _ Add Reviewed-by

 drivers/mmc/host/mmci.c | 28 ++++++++++++++++++++++++----
 drivers/mmc/host/mmci.h |  1 +
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 97da0fc..3125dc0 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -82,6 +82,7 @@
  * @qcom_fifo: enables qcom specific fifo pio read logic.
  * @qcom_dml: enables qcom specific dma glue for dma transfers.
  * @reversed_irq_handling: handle data irq before cmd irq.
+ * @mmcimask1: true if variant have a MMCIMASK1 register.
  */
 struct variant_data {
 	unsigned int		clkreg;
@@ -111,6 +112,7 @@ struct variant_data {
 	bool			qcom_fifo;
 	bool			qcom_dml;
 	bool			reversed_irq_handling;
+	bool			mmcimask1;
 };
 
 static struct variant_data variant_arm = {
@@ -120,6 +122,7 @@ struct variant_data {
 	.pwrreg_powerup		= MCI_PWR_UP,
 	.f_max			= 100000000,
 	.reversed_irq_handling	= true,
+	.mmcimask1		= true,
 };
 
 static struct variant_data variant_arm_extended_fifo = {
@@ -128,6 +131,7 @@ struct variant_data {
 	.datalength_bits	= 16,
 	.pwrreg_powerup		= MCI_PWR_UP,
 	.f_max			= 100000000,
+	.mmcimask1		= true,
 };
 
 static struct variant_data variant_arm_extended_fifo_hwfc = {
@@ -137,6 +141,7 @@ struct variant_data {
 	.datalength_bits	= 16,
 	.pwrreg_powerup		= MCI_PWR_UP,
 	.f_max			= 100000000,
+	.mmcimask1		= true,
 };
 
 static struct variant_data variant_u300 = {
@@ -152,6 +157,7 @@ struct variant_data {
 	.signal_direction	= true,
 	.pwrreg_clkgate		= true,
 	.pwrreg_nopower		= true,
+	.mmcimask1		= true,
 };
 
 static struct variant_data variant_nomadik = {
@@ -168,6 +174,7 @@ struct variant_data {
 	.signal_direction	= true,
 	.pwrreg_clkgate		= true,
 	.pwrreg_nopower		= true,
+	.mmcimask1		= true,
 };
 
 static struct variant_data variant_ux500 = {
@@ -190,6 +197,7 @@ struct variant_data {
 	.busy_detect_flag	= MCI_ST_CARDBUSY,
 	.busy_detect_mask	= MCI_ST_BUSYENDMASK,
 	.pwrreg_nopower		= true,
+	.mmcimask1		= true,
 };
 
 static struct variant_data variant_ux500v2 = {
@@ -214,6 +222,7 @@ struct variant_data {
 	.busy_detect_flag	= MCI_ST_CARDBUSY,
 	.busy_detect_mask	= MCI_ST_BUSYENDMASK,
 	.pwrreg_nopower		= true,
+	.mmcimask1		= true,
 };
 
 static struct variant_data variant_qcom = {
@@ -232,6 +241,7 @@ struct variant_data {
 	.explicit_mclk_control	= true,
 	.qcom_fifo		= true,
 	.qcom_dml		= true,
+	.mmcimask1		= true,
 };
 
 /* Busy detection for the ST Micro variant */
@@ -396,6 +406,7 @@ static void mmci_set_clkreg(struct mmci_host *host, unsigned int desired)
 static void mmci_set_mask1(struct mmci_host *host, unsigned int mask)
 {
 	void __iomem *base = host->base;
+	struct variant_data *variant = host->variant;
 
 	if (host->singleirq) {
 		unsigned int mask0 = readl(base + MMCIMASK0);
@@ -406,7 +417,10 @@ static void mmci_set_mask1(struct mmci_host *host, unsigned int mask)
 		writel(mask0, base + MMCIMASK0);
 	}
 
-	writel(mask, base + MMCIMASK1);
+	if (variant->mmcimask1)
+		writel(mask, base + MMCIMASK1);
+
+	host->mask1_reg = mask;
 }
 
 static void mmci_stop_data(struct mmci_host *host)
@@ -1286,7 +1300,7 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
 		status = readl(host->base + MMCISTATUS);
 
 		if (host->singleirq) {
-			if (status & readl(host->base + MMCIMASK1))
+			if (status & host->mask1_reg)
 				mmci_pio_irq(irq, dev_id);
 
 			status &= ~MCI_IRQ1MASK;
@@ -1729,7 +1743,10 @@ static int mmci_probe(struct amba_device *dev,
 	spin_lock_init(&host->lock);
 
 	writel(0, host->base + MMCIMASK0);
-	writel(0, host->base + MMCIMASK1);
+
+	if (variant->mmcimask1)
+		writel(0, host->base + MMCIMASK1);
+
 	writel(0xfff, host->base + MMCICLEAR);
 
 	/*
@@ -1809,6 +1826,7 @@ static int mmci_remove(struct amba_device *dev)
 
 	if (mmc) {
 		struct mmci_host *host = mmc_priv(mmc);
+		struct variant_data *variant = host->variant;
 
 		/*
 		 * Undo pm_runtime_put() in probe.  We use the _sync
@@ -1819,7 +1837,9 @@ static int mmci_remove(struct amba_device *dev)
 		mmc_remove_host(mmc);
 
 		writel(0, host->base + MMCIMASK0);
-		writel(0, host->base + MMCIMASK1);
+
+		if (variant->mmcimask1)
+			writel(0, host->base + MMCIMASK1);
 
 		writel(0, host->base + MMCICOMMAND);
 		writel(0, host->base + MMCIDATACTRL);
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 4a8bef1..83160a9 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -223,6 +223,7 @@ struct mmci_host {
 	u32			clk_reg;
 	u32			datactrl_reg;
 	u32			busy_status;
+	u32			mask1_reg;
 	bool			vqmmc_enabled;
 	struct mmci_platform_data *plat;
 	struct variant_data	*variant;
-- 
1.9.1

