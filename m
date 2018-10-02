From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH V4 13/25] mmc: mmci: add datactrl block size variant property
Date: Tue, 2 Oct 2018 14:09:15 +0200
Message-ID: <1538482167-13819-14-git-send-email-ludovic.Barre@st.com>
References: <1538482167-13819-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1538482167-13819-1-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, benjamin.gaignard@linaro.org, Gerald Baeza <gerald.baeza@st.com>, Loic Pallardy <loic.pallardy@st.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, Ludovic Barre <ludovic.barre@st.com>
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch allows to define a datactrl block size
by variant, requested by STM32 sdmmc variant.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 13 +++++++++++--
 drivers/mmc/host/mmci.h |  2 ++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index c221955..59a2188 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -51,6 +51,7 @@ static struct variant_data variant_arm = {
 	.fifosize		= 16 * 4,
 	.fifohalfsize		= 8 * 4,
 	.datalength_bits	= 16,
+	.datactrl_blocksz	= 11,
 	.pwrreg_powerup		= MCI_PWR_UP,
 	.f_max			= 100000000,
 	.reversed_irq_handling	= true,
@@ -64,6 +65,7 @@ static struct variant_data variant_arm_extended_fifo = {
 	.fifosize		= 128 * 4,
 	.fifohalfsize		= 64 * 4,
 	.datalength_bits	= 16,
+	.datactrl_blocksz	= 11,
 	.pwrreg_powerup		= MCI_PWR_UP,
 	.f_max			= 100000000,
 	.mmcimask1		= true,
@@ -77,6 +79,7 @@ static struct variant_data variant_arm_extended_fifo_hwfc = {
 	.fifohalfsize		= 64 * 4,
 	.clkreg_enable		= MCI_ARM_HWFCEN,
 	.datalength_bits	= 16,
+	.datactrl_blocksz	= 11,
 	.pwrreg_powerup		= MCI_PWR_UP,
 	.f_max			= 100000000,
 	.mmcimask1		= true,
@@ -91,6 +94,7 @@ static struct variant_data variant_u300 = {
 	.clkreg_enable		= MCI_ST_U300_HWFCEN,
 	.clkreg_8bit_bus_enable = MCI_ST_8BIT_BUS,
 	.datalength_bits	= 16,
+	.datactrl_blocksz	= 11,
 	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
 	.st_sdio			= true,
 	.pwrreg_powerup		= MCI_PWR_ON,
@@ -110,6 +114,7 @@ static struct variant_data variant_nomadik = {
 	.clkreg			= MCI_CLK_ENABLE,
 	.clkreg_8bit_bus_enable = MCI_ST_8BIT_BUS,
 	.datalength_bits	= 24,
+	.datactrl_blocksz	= 11,
 	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
 	.st_sdio		= true,
 	.st_clkdiv		= true,
@@ -132,6 +137,7 @@ static struct variant_data variant_ux500 = {
 	.clkreg_8bit_bus_enable = MCI_ST_8BIT_BUS,
 	.clkreg_neg_edge_enable	= MCI_ST_UX500_NEG_EDGE,
 	.datalength_bits	= 24,
+	.datactrl_blocksz	= 11,
 	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
 	.st_sdio		= true,
 	.st_clkdiv		= true,
@@ -159,6 +165,7 @@ static struct variant_data variant_ux500v2 = {
 	.clkreg_neg_edge_enable	= MCI_ST_UX500_NEG_EDGE,
 	.datactrl_mask_ddrmode	= MCI_DPSM_ST_DDRMODE,
 	.datalength_bits	= 24,
+	.datactrl_blocksz	= 11,
 	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
 	.st_sdio		= true,
 	.st_clkdiv		= true,
@@ -186,6 +193,7 @@ static struct variant_data variant_stm32 = {
 	.clkreg_8bit_bus_enable = MCI_ST_8BIT_BUS,
 	.clkreg_neg_edge_enable	= MCI_ST_UX500_NEG_EDGE,
 	.datalength_bits	= 24,
+	.datactrl_blocksz	= 11,
 	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
 	.st_sdio		= true,
 	.st_clkdiv		= true,
@@ -207,6 +215,7 @@ static struct variant_data variant_qcom = {
 	.data_cmd_enable	= MCI_CPSM_QCOM_DATCMD,
 	.blksz_datactrl4	= true,
 	.datalength_bits	= 24,
+	.datactrl_blocksz	= 11,
 	.pwrreg_powerup		= MCI_PWR_UP,
 	.f_max			= 208000000,
 	.explicit_mclk_control	= true,
@@ -1856,13 +1865,13 @@ static int mmci_probe(struct amba_device *dev,
 	/*
 	 * Block size can be up to 2048 bytes, but must be a power of two.
 	 */
-	mmc->max_blk_size = 1 << 11;
+	mmc->max_blk_size = 1 << variant->datactrl_blocksz;
 
 	/*
 	 * Limit the number of blocks transferred so that we don't overflow
 	 * the maximum request size.
 	 */
-	mmc->max_blk_count = mmc->max_req_size >> 11;
+	mmc->max_blk_count = mmc->max_req_size >> variant->datactrl_blocksz;
 
 	spin_lock_init(&host->lock);
 
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 78fa281..042cbef 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -217,6 +217,7 @@ struct mmci_host;
  * @blksz_datactrl4: true if Block size is at b4..b16 position in datactrl
  *		     register
  * @datactrl_mask_sdio: SDIO enable mask in datactrl register
+ * @datactrl_blksz: block size in power of two
  * @pwrreg_powerup: power up value for MMCIPOWER register
  * @f_max: maximum clk frequency supported by the controller.
  * @signal_direction: input/out direction of bus signals can be indicated
@@ -248,6 +249,7 @@ struct variant_data {
 	unsigned int		data_cmd_enable;
 	unsigned int		datactrl_mask_ddrmode;
 	unsigned int		datactrl_mask_sdio;
+	unsigned int		datactrl_blocksz;
 	u8			st_sdio:1;
 	u8			st_clkdiv:1;
 	u8			blksz_datactrl16:1;
-- 
2.7.4
