From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH 08/19] mmc: mmci: add variant property to define irq pio mask
Date: Tue, 12 Jun 2018 15:14:29 +0200
Message-ID: <1528809280-31116-9-git-send-email-ludovic.Barre@st.com>
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

This patch allows to define specific pio mask for variants.
Needed to support the STM32 sdmmc variant which has some bits
with different meaning (bits: 21,20,13,12,9)

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 13 +++++++++++--
 drivers/mmc/host/mmci.h |  5 ++++-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 1f44c61..5fd3ffb6 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -62,6 +62,7 @@ static struct variant_data variant_arm = {
 	.f_max			= 100000000,
 	.reversed_irq_handling	= true,
 	.mmcimask1		= true,
+	.irq_pio_mask		= MCI_IRQ_PIO_MASK,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_ROD,
 	.mmci_dma		= &dmaengine,
@@ -80,6 +81,7 @@ static struct variant_data variant_arm_extended_fifo = {
 	.pwrreg_powerup		= MCI_PWR_UP,
 	.f_max			= 100000000,
 	.mmcimask1		= true,
+	.irq_pio_mask		= MCI_IRQ_PIO_MASK,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_ROD,
 	.mmci_dma		= &dmaengine,
@@ -99,6 +101,7 @@ static struct variant_data variant_arm_extended_fifo_hwfc = {
 	.pwrreg_powerup		= MCI_PWR_UP,
 	.f_max			= 100000000,
 	.mmcimask1		= true,
+	.irq_pio_mask		= MCI_IRQ_PIO_MASK,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_ROD,
 	.mmci_dma		= &dmaengine,
@@ -124,6 +127,7 @@ static struct variant_data variant_u300 = {
 	.pwrreg_clkgate		= true,
 	.pwrreg_nopower		= true,
 	.mmcimask1		= true,
+	.irq_pio_mask		= MCI_IRQ_PIO_MASK,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_OD,
 	.mmci_dma		= &dmaengine,
@@ -150,6 +154,7 @@ static struct variant_data variant_nomadik = {
 	.pwrreg_clkgate		= true,
 	.pwrreg_nopower		= true,
 	.mmcimask1		= true,
+	.irq_pio_mask		= MCI_IRQ_PIO_MASK,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_OD,
 	.mmci_dma		= &dmaengine,
@@ -182,6 +187,7 @@ static struct variant_data variant_ux500 = {
 	.busy_detect_mask	= MCI_ST_BUSYENDMASK,
 	.pwrreg_nopower		= true,
 	.mmcimask1		= true,
+	.irq_pio_mask		= MCI_IRQ_PIO_MASK,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_OD,
 	.mmci_dma		= &dmaengine,
@@ -216,6 +222,7 @@ static struct variant_data variant_ux500v2 = {
 	.busy_detect_mask	= MCI_ST_BUSYENDMASK,
 	.pwrreg_nopower		= true,
 	.mmcimask1		= true,
+	.irq_pio_mask		= MCI_IRQ_PIO_MASK,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_OD,
 	.mmci_dma		= &dmaengine,
@@ -232,6 +239,7 @@ static struct variant_data variant_stm32 = {
 	.cmdreg_lrsp_crc	= MCI_CPSM_RESPONSE | MCI_CPSM_LONGRSP,
 	.cmdreg_srsp_crc	= MCI_CPSM_RESPONSE,
 	.cmdreg_srsp		= MCI_CPSM_RESPONSE,
+	.irq_pio_mask		= MCI_IRQ_PIO_MASK,
 	.datalength_bits	= 24,
 	.datactrl_blocksz	= 11,
 	.datactrl_dpsm_enable	= MCI_DPSM_ENABLE,
@@ -268,6 +276,7 @@ static struct variant_data variant_qcom = {
 	.qcom_fifo		= true,
 	.qcom_dml		= true,
 	.mmcimask1		= true,
+	.irq_pio_mask		= MCI_IRQ_PIO_MASK,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_ROD,
 	.mmci_dma		= &dmaengine,
@@ -486,7 +495,7 @@ static void mmci_set_mask1(struct mmci_host *host, unsigned int mask)
 	if (host->singleirq) {
 		unsigned int mask0 = readl(base + MMCIMASK0);
 
-		mask0 &= ~MCI_IRQ1MASK;
+		mask0 &= ~variant->irq_pio_mask;
 		mask0 |= mask;
 
 		writel(mask0, base + MMCIMASK0);
@@ -1046,7 +1055,7 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
 			if (status & host->mask1_reg)
 				mmci_pio_irq(irq, dev_id);
 
-			status &= ~MCI_IRQ1MASK;
+			status &= ~host->variant->irq_pio_mask;
 		}
 
 		/*
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index a2bf8bc..b91b130 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -186,7 +186,7 @@
 	MCI_CMDRESPENDMASK | MCI_CMDSENTMASK)
 
 /* These interrupts are directed to IRQ1 when two IRQ lines are available */
-#define MCI_IRQ1MASK \
+#define MCI_IRQ_PIO_MASK \
 	(MCI_RXFIFOHALFFULLMASK | MCI_RXDATAAVLBLMASK | \
 	 MCI_TXFIFOHALFEMPTYMASK)
 
@@ -275,6 +275,8 @@ struct mmci_host;
  * @qcom_dml: enables qcom specific dma glue for dma transfers.
  * @reversed_irq_handling: handle data irq before cmd irq.
  * @mmcimask1: true if variant have a MMCIMASK1 register.
+ * @irq_pio_mask: bitmask used to manage interrupt pio transfert in mmcimask
+ *		  register
  * @start_err: bitmask identifying the STARTBITERR bit inside MMCISTATUS
  *	       register.
  * @opendrain: bitmask identifying the OPENDRAIN bit inside MMCIPOWER register
@@ -317,6 +319,7 @@ struct variant_data {
 	bool			qcom_dml;
 	bool			reversed_irq_handling;
 	bool			mmcimask1;
+	unsigned int		irq_pio_mask;
 	u32			start_err;
 	u32			opendrain;
 	struct mmci_dma_ops	*mmci_dma;
-- 
2.7.4
