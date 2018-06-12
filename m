From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH 19/19] mmc: mmci: add stm32 sdmmc variant
Date: Tue, 12 Jun 2018 15:14:40 +0200
Message-ID: <1528809280-31116-20-git-send-email-ludovic.Barre@st.com>
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

This patch adds a stm32 sdmmc variant, rev 1.1.
Introduces a new Manufacturer id "0x53, ascii 'S' to define
new stm32 sdmmc familly with clean range of amba
revision/configurations bits (corresponding to sdmmc_ver
register with major/minor fields).

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index af27a0a..bed671d 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -267,6 +267,29 @@ static struct variant_data variant_stm32 = {
 	.mmci_dma		= &dmaengine,
 };
 
+static struct variant_data variant_stm32_sdmmc = {
+	.fifosize		= 16 * 4,
+	.fifohalfsize		= 8 * 4,
+	.f_max			= 208000000,
+	.stm32_clkdiv		= true,
+	.reset			= true,
+	.cmdreg_cpsm_enable	= MCI_CPSM_STM32_ENABLE,
+	.cmdreg_lrsp_crc	= MCI_CPSM_STM32_LRSP_CRC,
+	.cmdreg_srsp_crc	= MCI_CPSM_STM32_SRSP_CRC,
+	.cmdreg_srsp		= MCI_CPSM_STM32_SRSP,
+	.cmdreg_stop		= MCI_CPSM_STM32_CMDSTOP,
+	.data_cmd_enable	= MCI_CPSM_STM32_CMDTRANS,
+	.irq_pio_mask		= MCI_IRQ_PIO_STM32_MASK,
+	.datactrl_first		= true,
+	.datalength_bits	= 25,
+	.datactrl_blocksz	= 14,
+	.mmci_dma		= &sdmmc_idma,
+	.stm32_idmabsize_mask	= GENMASK(12, 5),
+	.validate_data		= sdmmc_idma_validate_data,
+	.set_clkreg		= mmci_sdmmc_set_clkreg,
+	.set_pwrreg		= mmci_sdmmc_set_pwrreg,
+};
+
 static struct variant_data variant_qcom = {
 	.fifosize		= 16 * 4,
 	.fifohalfsize		= 8 * 4,
@@ -1907,6 +1930,11 @@ static const struct amba_id mmci_ids[] = {
 		.mask   = 0x00ffffff,
 		.data	= &variant_stm32,
 	},
+	{
+		.id     = 0x10153180,
+		.mask	= 0xf0ffffff,
+		.data	= &variant_stm32_sdmmc,
+	},
 	/* Qualcomm variants */
 	{
 		.id     = 0x00051180,
-- 
2.7.4
