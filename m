From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH 2/2] mmc: mmci: add quirk property to add stm32 transfer mode
Date: Thu, 21 Feb 2019 11:10:51 +0100
Message-ID: <1550743851-13588-3-git-send-email-ludovic.Barre@st.com>
References: <1550743851-13588-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1550743851-13588-1-git-send-email-ludovic.Barre@st.com>
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
Cc: devicetree@vger.kernel.org, Alexandre Torgue <alexandre.torgue@st.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org, Ludovic Barre <ludovic.barre@st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds a quirk bit to define specific stm32 transfer
modes. sdmmc data transfer mode selection could be:
-Block data transfer ending on block count.
-SDIO multibyte data transfer.
-MMC Stream data transfer (not used).
-Block data transfer ending with STOP_TRANSMISSION command.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 11 +++++++++++
 drivers/mmc/host/mmci.h |  7 +++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 387ff14..44c721a 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -284,6 +284,7 @@ static struct variant_data variant_stm32_sdmmc = {
 	.datactrl_blocksz	= 14,
 	.stm32_idmabsize_mask	= GENMASK(12, 5),
 	.init			= sdmmc_variant_init,
+	.quirks			= MMCI_QUIRK_STM32_DTMODE,
 };
 
 static struct variant_data variant_qcom = {
@@ -1028,6 +1029,16 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 	else
 		datactrl = variant->datactrl_dpsm_enable | blksz_bits << 4;
 
+	if (variant->quirks & MMCI_QUIRK_STM32_DTMODE) {
+		if (host->mmc->card && mmc_card_sdio(host->mmc->card) &&
+		    data->blocks == 1)
+			datactrl |= MCI_DPSM_STM32_MODE_SDIO;
+		else if (data->stop && !host->mrq->sbc)
+			datactrl |= MCI_DPSM_STM32_MODE_BLOCK_STOP;
+		else
+			datactrl |= MCI_DPSM_STM32_MODE_BLOCK;
+	}
+
 	if (data->flags & MMC_DATA_READ)
 		datactrl |= MCI_DPSM_DIRECTION;
 
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 474f4fa..9fbd0a4 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -131,6 +131,11 @@
 /* Control register extensions in the Qualcomm versions */
 #define MCI_DPSM_QCOM_DATA_PEND	BIT(17)
 #define MCI_DPSM_QCOM_RX_DATA_PEND BIT(20)
+/* Control register extensions in STM32 versions */
+#define MCI_DPSM_STM32_MODE_BLOCK	(0 << 2)
+#define MCI_DPSM_STM32_MODE_SDIO	(1 << 2)
+#define MCI_DPSM_STM32_MODE_STREAM	(2 << 2)
+#define MCI_DPSM_STM32_MODE_BLOCK_STOP	(3 << 2)
 
 #define MMCIDATACNT		0x030
 #define MMCISTATUS		0x034
@@ -357,6 +362,8 @@ struct variant_data {
 	void (*init)(struct mmci_host *host);
 };
 
+#define MMCI_QUIRK_STM32_DTMODE	BIT(0)
+
 /* mmci variant callbacks */
 struct mmci_host_ops {
 	int (*validate_data)(struct mmci_host *host, struct mmc_data *data);
-- 
2.7.4
