From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH 06/19] mmc: mmci: add variant properties to define cpsm &
 cmdresp bits
Date: Tue, 12 Jun 2018 15:14:27 +0200
Message-ID: <1528809280-31116-7-git-send-email-ludovic.Barre@st.com>
References: <1528809280-31116-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1528809280-31116-1-git-send-email-ludovic.Barre@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, Alexandre Torgue <alexandre.torgue@st.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ludovic Barre <ludovic.barre@st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Gerald Baeza <gerald.baeza@st.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds command variant properties to define
cpsm enable bit and responses.
Needed to support the STM32 variant (shift of cpsm bit,
specific definition of commands response).

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 47 +++++++++++++++++++++++++++++++++++++++++++----
 drivers/mmc/host/mmci.h |  8 ++++++++
 2 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 801c86b..52562fc 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -51,6 +51,10 @@ static unsigned int fmax = 515633;
 static struct variant_data variant_arm = {
 	.fifosize		= 16 * 4,
 	.fifohalfsize		= 8 * 4,
+	.cmdreg_cpsm_enable	= MCI_CPSM_ENABLE,
+	.cmdreg_lrsp_crc	= MCI_CPSM_RESPONSE | MCI_CPSM_LONGRSP,
+	.cmdreg_srsp_crc	= MCI_CPSM_RESPONSE,
+	.cmdreg_srsp		= MCI_CPSM_RESPONSE,
 	.datalength_bits	= 16,
 	.datactrl_blocksz	= 11,
 	.pwrreg_powerup		= MCI_PWR_UP,
@@ -65,6 +69,10 @@ static struct variant_data variant_arm = {
 static struct variant_data variant_arm_extended_fifo = {
 	.fifosize		= 128 * 4,
 	.fifohalfsize		= 64 * 4,
+	.cmdreg_cpsm_enable	= MCI_CPSM_ENABLE,
+	.cmdreg_lrsp_crc	= MCI_CPSM_RESPONSE | MCI_CPSM_LONGRSP,
+	.cmdreg_srsp_crc	= MCI_CPSM_RESPONSE,
+	.cmdreg_srsp		= MCI_CPSM_RESPONSE,
 	.datalength_bits	= 16,
 	.datactrl_blocksz	= 11,
 	.pwrreg_powerup		= MCI_PWR_UP,
@@ -79,6 +87,10 @@ static struct variant_data variant_arm_extended_fifo_hwfc = {
 	.fifosize		= 128 * 4,
 	.fifohalfsize		= 64 * 4,
 	.clkreg_enable		= MCI_ARM_HWFCEN,
+	.cmdreg_cpsm_enable	= MCI_CPSM_ENABLE,
+	.cmdreg_lrsp_crc	= MCI_CPSM_RESPONSE | MCI_CPSM_LONGRSP,
+	.cmdreg_srsp_crc	= MCI_CPSM_RESPONSE,
+	.cmdreg_srsp		= MCI_CPSM_RESPONSE,
 	.datalength_bits	= 16,
 	.datactrl_blocksz	= 11,
 	.pwrreg_powerup		= MCI_PWR_UP,
@@ -94,6 +106,10 @@ static struct variant_data variant_u300 = {
 	.fifohalfsize		= 8 * 4,
 	.clkreg_enable		= MCI_ST_U300_HWFCEN,
 	.clkreg_8bit_bus_enable = MCI_ST_8BIT_BUS,
+	.cmdreg_cpsm_enable	= MCI_CPSM_ENABLE,
+	.cmdreg_lrsp_crc	= MCI_CPSM_RESPONSE | MCI_CPSM_LONGRSP,
+	.cmdreg_srsp_crc	= MCI_CPSM_RESPONSE,
+	.cmdreg_srsp		= MCI_CPSM_RESPONSE,
 	.datalength_bits	= 16,
 	.datactrl_blocksz	= 11,
 	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
@@ -114,6 +130,10 @@ static struct variant_data variant_nomadik = {
 	.fifohalfsize		= 8 * 4,
 	.clkreg			= MCI_CLK_ENABLE,
 	.clkreg_8bit_bus_enable = MCI_ST_8BIT_BUS,
+	.cmdreg_cpsm_enable	= MCI_CPSM_ENABLE,
+	.cmdreg_lrsp_crc	= MCI_CPSM_RESPONSE | MCI_CPSM_LONGRSP,
+	.cmdreg_srsp_crc	= MCI_CPSM_RESPONSE,
+	.cmdreg_srsp		= MCI_CPSM_RESPONSE,
 	.datalength_bits	= 24,
 	.datactrl_blocksz	= 11,
 	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
@@ -137,6 +157,10 @@ static struct variant_data variant_ux500 = {
 	.clkreg_enable		= MCI_ST_UX500_HWFCEN,
 	.clkreg_8bit_bus_enable = MCI_ST_8BIT_BUS,
 	.clkreg_neg_edge_enable	= MCI_ST_UX500_NEG_EDGE,
+	.cmdreg_cpsm_enable	= MCI_CPSM_ENABLE,
+	.cmdreg_lrsp_crc	= MCI_CPSM_RESPONSE | MCI_CPSM_LONGRSP,
+	.cmdreg_srsp_crc	= MCI_CPSM_RESPONSE,
+	.cmdreg_srsp		= MCI_CPSM_RESPONSE,
 	.datalength_bits	= 24,
 	.datactrl_blocksz	= 11,
 	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
@@ -164,6 +188,10 @@ static struct variant_data variant_ux500v2 = {
 	.clkreg_enable		= MCI_ST_UX500_HWFCEN,
 	.clkreg_8bit_bus_enable = MCI_ST_8BIT_BUS,
 	.clkreg_neg_edge_enable	= MCI_ST_UX500_NEG_EDGE,
+	.cmdreg_cpsm_enable	= MCI_CPSM_ENABLE,
+	.cmdreg_lrsp_crc	= MCI_CPSM_RESPONSE | MCI_CPSM_LONGRSP,
+	.cmdreg_srsp_crc	= MCI_CPSM_RESPONSE,
+	.cmdreg_srsp		= MCI_CPSM_RESPONSE,
 	.datactrl_mask_ddrmode	= MCI_DPSM_ST_DDRMODE,
 	.datalength_bits	= 24,
 	.datactrl_blocksz	= 11,
@@ -193,6 +221,10 @@ static struct variant_data variant_stm32 = {
 	.clkreg_enable		= MCI_ST_UX500_HWFCEN,
 	.clkreg_8bit_bus_enable = MCI_ST_8BIT_BUS,
 	.clkreg_neg_edge_enable	= MCI_ST_UX500_NEG_EDGE,
+	.cmdreg_cpsm_enable	= MCI_CPSM_ENABLE,
+	.cmdreg_lrsp_crc	= MCI_CPSM_RESPONSE | MCI_CPSM_LONGRSP,
+	.cmdreg_srsp_crc	= MCI_CPSM_RESPONSE,
+	.cmdreg_srsp		= MCI_CPSM_RESPONSE,
 	.datalength_bits	= 24,
 	.datactrl_blocksz	= 11,
 	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
@@ -213,6 +245,10 @@ static struct variant_data variant_qcom = {
 				  MCI_QCOM_CLK_SELECT_IN_FBCLK,
 	.clkreg_8bit_bus_enable = MCI_QCOM_CLK_WIDEBUS_8,
 	.datactrl_mask_ddrmode	= MCI_QCOM_CLK_SELECT_IN_DDR_MODE,
+	.cmdreg_cpsm_enable	= MCI_CPSM_ENABLE,
+	.cmdreg_lrsp_crc	= MCI_CPSM_RESPONSE | MCI_CPSM_LONGRSP,
+	.cmdreg_srsp_crc	= MCI_CPSM_RESPONSE,
+	.cmdreg_srsp		= MCI_CPSM_RESPONSE,
 	.data_cmd_enable	= MCI_CPSM_QCOM_DATCMD,
 	.blksz_datactrl4	= true,
 	.datalength_bits	= 24,
@@ -603,16 +639,19 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
 	dev_dbg(mmc_dev(host->mmc), "op %02x arg %08x flags %08x\n",
 	    cmd->opcode, cmd->arg, cmd->flags);
 
-	if (readl(base + MMCICOMMAND) & MCI_CPSM_ENABLE) {
+	if (readl(base + MMCICOMMAND) & host->variant->cmdreg_cpsm_enable) {
 		writel(0, base + MMCICOMMAND);
 		mmci_reg_delay(host);
 	}
 
-	c |= cmd->opcode | MCI_CPSM_ENABLE;
+	c |= cmd->opcode | host->variant->cmdreg_cpsm_enable;
 	if (cmd->flags & MMC_RSP_PRESENT) {
 		if (cmd->flags & MMC_RSP_136)
-			c |= MCI_CPSM_LONGRSP;
-		c |= MCI_CPSM_RESPONSE;
+			c |= host->variant->cmdreg_lrsp_crc;
+		else if (cmd->flags & MMC_RSP_CRC)
+			c |= host->variant->cmdreg_srsp_crc;
+		else
+			c |= host->variant->cmdreg_srsp;
 	}
 	if (/*interrupt*/0)
 		c |= MCI_CPSM_INTERRUPT;
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 7265ca6..e173305 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -239,6 +239,10 @@ struct mmci_host;
  * @clkreg_enable: enable value for MMCICLOCK register
  * @clkreg_8bit_bus_enable: enable value for 8 bit bus
  * @clkreg_neg_edge_enable: enable value for inverted data/cmd output
+ * @cmdreg_cpsm_enable: enable value for CPSM
+ * @cmdreg_lrsp_crc: enable value for long response with crc
+ * @cmdreg_srsp_crc: enable value for short response with crc
+ * @cmdreg_srsp: enable value for short response without crc
  * @datalength_bits: number of bits in the MMCIDATALENGTH register
  * @fifosize: number of bytes that can be written when MMCI_TXFIFOEMPTY
  *	      is asserted (likewise for RX)
@@ -282,6 +286,10 @@ struct variant_data {
 	unsigned int		clkreg_enable;
 	unsigned int		clkreg_8bit_bus_enable;
 	unsigned int		clkreg_neg_edge_enable;
+	unsigned int		cmdreg_cpsm_enable;
+	unsigned int		cmdreg_lrsp_crc;
+	unsigned int		cmdreg_srsp_crc;
+	unsigned int		cmdreg_srsp;
 	unsigned int		datalength_bits;
 	unsigned int		fifosize;
 	unsigned int		fifohalfsize;
-- 
2.7.4
