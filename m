From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH 07/19] mmc: mmci: add variant property to define dpsm bit
Date: Tue, 12 Jun 2018 15:14:28 +0200
Message-ID: <1528809280-31116-8-git-send-email-ludovic.Barre@st.com>
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

This patch adds datactrl variant property to define
dpsm enable bit. Needed to support the STM32 variant
(STM32 has no dpsm enable bit).

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 15 ++++++++++++---
 drivers/mmc/host/mmci.h |  2 ++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 52562fc..1f44c61 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -57,6 +57,7 @@ static struct variant_data variant_arm = {
 	.cmdreg_srsp		= MCI_CPSM_RESPONSE,
 	.datalength_bits	= 16,
 	.datactrl_blocksz	= 11,
+	.datactrl_dpsm_enable	= MCI_DPSM_ENABLE,
 	.pwrreg_powerup		= MCI_PWR_UP,
 	.f_max			= 100000000,
 	.reversed_irq_handling	= true,
@@ -75,6 +76,7 @@ static struct variant_data variant_arm_extended_fifo = {
 	.cmdreg_srsp		= MCI_CPSM_RESPONSE,
 	.datalength_bits	= 16,
 	.datactrl_blocksz	= 11,
+	.datactrl_dpsm_enable	= MCI_DPSM_ENABLE,
 	.pwrreg_powerup		= MCI_PWR_UP,
 	.f_max			= 100000000,
 	.mmcimask1		= true,
@@ -93,6 +95,7 @@ static struct variant_data variant_arm_extended_fifo_hwfc = {
 	.cmdreg_srsp		= MCI_CPSM_RESPONSE,
 	.datalength_bits	= 16,
 	.datactrl_blocksz	= 11,
+	.datactrl_dpsm_enable	= MCI_DPSM_ENABLE,
 	.pwrreg_powerup		= MCI_PWR_UP,
 	.f_max			= 100000000,
 	.mmcimask1		= true,
@@ -112,6 +115,7 @@ static struct variant_data variant_u300 = {
 	.cmdreg_srsp		= MCI_CPSM_RESPONSE,
 	.datalength_bits	= 16,
 	.datactrl_blocksz	= 11,
+	.datactrl_dpsm_enable	= MCI_DPSM_ENABLE,
 	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
 	.st_sdio			= true,
 	.pwrreg_powerup		= MCI_PWR_ON,
@@ -136,6 +140,7 @@ static struct variant_data variant_nomadik = {
 	.cmdreg_srsp		= MCI_CPSM_RESPONSE,
 	.datalength_bits	= 24,
 	.datactrl_blocksz	= 11,
+	.datactrl_dpsm_enable	= MCI_DPSM_ENABLE,
 	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
 	.st_sdio		= true,
 	.st_clkdiv		= true,
@@ -163,6 +168,7 @@ static struct variant_data variant_ux500 = {
 	.cmdreg_srsp		= MCI_CPSM_RESPONSE,
 	.datalength_bits	= 24,
 	.datactrl_blocksz	= 11,
+	.datactrl_dpsm_enable	= MCI_DPSM_ENABLE,
 	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
 	.st_sdio		= true,
 	.st_clkdiv		= true,
@@ -195,6 +201,7 @@ static struct variant_data variant_ux500v2 = {
 	.datactrl_mask_ddrmode	= MCI_DPSM_ST_DDRMODE,
 	.datalength_bits	= 24,
 	.datactrl_blocksz	= 11,
+	.datactrl_dpsm_enable	= MCI_DPSM_ENABLE,
 	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
 	.st_sdio		= true,
 	.st_clkdiv		= true,
@@ -227,6 +234,7 @@ static struct variant_data variant_stm32 = {
 	.cmdreg_srsp		= MCI_CPSM_RESPONSE,
 	.datalength_bits	= 24,
 	.datactrl_blocksz	= 11,
+	.datactrl_dpsm_enable	= MCI_DPSM_ENABLE,
 	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
 	.st_sdio		= true,
 	.st_clkdiv		= true,
@@ -253,6 +261,7 @@ static struct variant_data variant_qcom = {
 	.blksz_datactrl4	= true,
 	.datalength_bits	= 24,
 	.datactrl_blocksz	= 11,
+	.datactrl_dpsm_enable	= MCI_DPSM_ENABLE,
 	.pwrreg_powerup		= MCI_PWR_UP,
 	.f_max			= 208000000,
 	.explicit_mclk_control	= true,
@@ -564,11 +573,11 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 	BUG_ON(1 << blksz_bits != data->blksz);
 
 	if (variant->blksz_datactrl16)
-		datactrl = MCI_DPSM_ENABLE | (data->blksz << 16);
+		datactrl = variant->datactrl_dpsm_enable | (data->blksz << 16);
 	else if (variant->blksz_datactrl4)
-		datactrl = MCI_DPSM_ENABLE | (data->blksz << 4);
+		datactrl = variant->datactrl_dpsm_enable | (data->blksz << 4);
 	else
-		datactrl = MCI_DPSM_ENABLE | blksz_bits << 4;
+		datactrl = variant->datactrl_dpsm_enable | blksz_bits << 4;
 
 	if (data->flags & MMC_DATA_READ)
 		datactrl |= MCI_DPSM_DIRECTION;
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index e173305..a2bf8bc 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -258,6 +258,7 @@ struct mmci_host;
  *		     register
  * @datactrl_mask_sdio: SDIO enable mask in datactrl register
  * @datactrl_blksz: block size in power of two
+ * @datactrl_dpsm_enable: enable value for DPSM
  * @pwrreg_powerup: power up value for MMCIPOWER register
  * @f_max: maximum clk frequency supported by the controller.
  * @signal_direction: input/out direction of bus signals can be indicated
@@ -297,6 +298,7 @@ struct variant_data {
 	unsigned int		datactrl_mask_ddrmode;
 	unsigned int		datactrl_mask_sdio;
 	unsigned int		datactrl_blocksz;
+	unsigned int		datactrl_dpsm_enable;
 	bool			st_sdio;
 	bool			st_clkdiv;
 	bool			blksz_datactrl16;
-- 
2.7.4
