From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 1/2] mmc: dw_mmc: add hw_reset support
Date: Thu, 22 Oct 2015 14:19:45 +0800
Message-ID: <1445494785-16864-1-git-send-email-shawn.lin@rock-chips.com>
References: <1445494740-16778-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445494740-16778-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

This patch implement hw_reset function for DesignWare
MMC controller. By adding this feature, mmc blk can
do some basic recovery if emmc device cannot work any
more for unknown reasons.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

 drivers/mmc/host/dw_mmc.c | 29 +++++++++++++++++++++++++++++
 drivers/mmc/host/dw_mmc.h |  4 ++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 6e600e8..8a0f2995 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1478,6 +1478,34 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
 	return present;
 }
 
+static void dw_mci_hw_reset(struct mmc_host *mmc)
+{
+	struct dw_mci_slot *slot = mmc_priv(mmc);
+	struct dw_mci *host = slot->host;
+
+	if (host->use_dma == TRANS_MODE_IDMAC)
+		dw_mci_idmac_reset(host);
+
+	if (!dw_mci_ctrl_reset(host, SDMMC_CTRL_DMA_RESET) ||
+	    (!dw_mci_ctrl_reset(host, SDMMC_CTRL_FIFO_RESET)))
+		return;
+
+	/* CARD_RESET
+	 * According to eMMC spec
+	 * tRstW >= 1us:   RST_n pulse width
+	 * tRSCA >= 200us: RST_n to Command time
+	 * tRSTH >= 1us:   RST_n high period
+	 * Note: add some margin to make rst timing not too
+	 * "spec" for some bad qulity eMMC devices.
+	 */
+	 mci_writel(slot->host, RST_N, SDMMC_RST_HWRESET);
+	 wmb(); /* drain writebuffer */
+	 usleep_range(5, 10);
+	 mci_writel(slot->host, RST_N, SDMMC_RST_HWACTIVE);
+	 wmb(); /* drain writebuffer */
+	 usleep_range(500, 1000);
+}
+
 static void dw_mci_init_card(struct mmc_host *mmc, struct mmc_card *card)
 {
 	struct dw_mci_slot *slot = mmc_priv(mmc);
@@ -1564,6 +1592,7 @@ static const struct mmc_host_ops dw_mci_ops = {
 	.set_ios		= dw_mci_set_ios,
 	.get_ro			= dw_mci_get_ro,
 	.get_cd			= dw_mci_get_cd,
+	.hw_reset               = dw_mci_hw_reset,
 	.enable_sdio_irq	= dw_mci_enable_sdio_irq,
 	.execute_tuning		= dw_mci_execute_tuning,
 	.card_busy		= dw_mci_card_busy,
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index f2a88d4..9df18c1 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -46,6 +46,7 @@
 #define SDMMC_VERID		0x06c
 #define SDMMC_HCON		0x070
 #define SDMMC_UHS_REG		0x074
+#define SDMMC_RST_N		0x078
 #define SDMMC_BMOD		0x080
 #define SDMMC_PLDMND		0x084
 #define SDMMC_DBADDR		0x088
@@ -169,6 +170,9 @@
 #define SDMMC_IDMAC_ENABLE		BIT(7)
 #define SDMMC_IDMAC_FB			BIT(1)
 #define SDMMC_IDMAC_SWRESET		BIT(0)
+/* H/W reset*/
+#define SDMMC_RST_HWACTIVE		0x1
+#define SDMMC_RST_HWRESET		0x0
 /* Version ID register define */
 #define SDMMC_GET_VERID(x)		((x) & 0xFFFF)
 /* Card read threshold */
-- 
2.3.7
