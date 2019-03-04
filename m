From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH  5/5] mmc: mmci: replace blksz_datactrlXX by get_datactrl_cfg callback
Date: Mon, 4 Mar 2019 11:17:05 +0100
Message-ID: <1551694625-6414-6-git-send-email-ludovic.Barre@st.com>
References: <1551694625-6414-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551694625-6414-1-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: srinivas.kandagatla@linaro.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, Ludovic Barre <ludovic.barre@st.com>
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch allows to get datactrl configuration specific
at variant. This introduce more flexibility on datactlr
value.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 13 +------------
 drivers/mmc/host/mmci.h |  5 -----
 2 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index e1d3f42..fe424ae 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -221,7 +221,6 @@ static struct variant_data variant_ux500v2 = {
 	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
 	.st_sdio		= true,
 	.st_clkdiv		= true,
-	.blksz_datactrl16	= true,
 	.pwrreg_powerup		= MCI_PWR_ON,
 	.f_max			= 100000000,
 	.signal_direction	= true,
@@ -296,7 +295,6 @@ static struct variant_data variant_qcom = {
 	.cmdreg_srsp_crc	= MCI_CPSM_RESPONSE,
 	.cmdreg_srsp		= MCI_CPSM_RESPONSE,
 	.data_cmd_enable	= MCI_CPSM_QCOM_DATCMD,
-	.blksz_datactrl4	= true,
 	.datalength_bits	= 24,
 	.datactrl_blocksz	= 11,
 	.datactrl_dpsm_enable	= MCI_DPSM_ENABLE,
@@ -1026,7 +1024,6 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 	unsigned int datactrl, timeout, irqmask;
 	unsigned long long clks;
 	void __iomem *base;
-	int blksz_bits;
 
 	dev_dbg(mmc_dev(host->mmc), "blksz %04x blks %04x flags %08x\n",
 		data->blksz, data->blocks, data->flags);
@@ -1044,15 +1041,7 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 	writel(timeout, base + MMCIDATATIMER);
 	writel(host->size, base + MMCIDATALENGTH);
 
-	blksz_bits = ffs(data->blksz) - 1;
-	BUG_ON(1 << blksz_bits != data->blksz);
-
-	if (variant->blksz_datactrl16)
-		datactrl = variant->datactrl_dpsm_enable | (data->blksz << 16);
-	else if (variant->blksz_datactrl4)
-		datactrl = variant->datactrl_dpsm_enable | (data->blksz << 4);
-	else
-		datactrl = variant->datactrl_dpsm_enable | blksz_bits << 4;
+	datactrl = host->ops->get_datactrl_cfg(host);
 
 	if (data->flags & MMC_DATA_READ)
 		datactrl |= MCI_DPSM_DIRECTION;
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index eb5d99af..fb5a83f 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -280,9 +280,6 @@ struct mmci_host;
  * @st_clkdiv: true if using a ST-specific clock divider algorithm
  * @stm32_clkdiv: true if using a STM32-specific clock divider algorithm
  * @datactrl_mask_ddrmode: ddr mode mask in datactrl register.
- * @blksz_datactrl16: true if Block size is at b16..b30 position in datactrl register
- * @blksz_datactrl4: true if Block size is at b4..b16 position in datactrl
- *		     register
  * @datactrl_mask_sdio: SDIO enable mask in datactrl register
  * @datactrl_blksz: block size in power of two
  * @datactrl_dpsm_enable: enable value for DPSM
@@ -336,8 +333,6 @@ struct variant_data {
 	u8			st_sdio:1;
 	u8			st_clkdiv:1;
 	u8			stm32_clkdiv:1;
-	u8			blksz_datactrl16:1;
-	u8			blksz_datactrl4:1;
 	u32			pwrreg_powerup;
 	u32			f_max;
 	u8			signal_direction:1;
-- 
2.7.4
