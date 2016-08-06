From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH 3/6] mmc: dw_mmc: split out dw_mci_set_power
Date: Sat,  6 Aug 2016 13:36:21 +0800
Message-ID: <1470461784-3955-4-git-send-email-shawn.lin@rock-chips.com>
References: <1470461784-3955-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1470461784-3955-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

The dw_mci_set_ios is a little complicated and lengthy,
let's split out the setting of power part. No functionality
change.

Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---

 drivers/mmc/host/dw_mmc.c | 87 ++++++++++++++++++++++++++---------------------
 1 file changed, 49 insertions(+), 38 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 59a5e9c..0e5ed23 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1276,54 +1276,19 @@ static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	spin_unlock_bh(&host->lock);
 }
 
-static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+static int dw_mci_set_power(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct dw_mci_slot *slot = mmc_priv(mmc);
-	const struct dw_mci_drv_data *drv_data = slot->host->drv_data;
 	u32 regs;
 
-	switch (ios->bus_width) {
-	case MMC_BUS_WIDTH_4:
-		slot->ctype = SDMMC_CTYPE_4BIT;
-		break;
-	case MMC_BUS_WIDTH_8:
-		slot->ctype = SDMMC_CTYPE_8BIT;
-		break;
-	default:
-		/* set default 1 bit mode */
-		slot->ctype = SDMMC_CTYPE_1BIT;
-	}
-
-	regs = mci_readl(slot->host, UHS_REG);
-
-	/* DDR mode set */
-	if (ios->timing == MMC_TIMING_MMC_DDR52 ||
-	    ios->timing == MMC_TIMING_UHS_DDR50 ||
-	    ios->timing == MMC_TIMING_MMC_HS400)
-		regs |= ((0x1 << slot->id) << 16);
-	else
-		regs &= ~((0x1 << slot->id) << 16);
-
-	mci_writel(slot->host, UHS_REG, regs);
-	slot->host->timing = ios->timing;
-
-	/*
-	 * Use mirror of ios->clock to prevent race with mmc
-	 * core ios update when finding the minimum.
-	 */
-	slot->clock = ios->clock;
-
-	if (drv_data && drv_data->set_ios)
-		drv_data->set_ios(slot->host, ios);
-
 	switch (ios->power_mode) {
 	case MMC_POWER_UP:
 		if (!IS_ERR(mmc->supply.vmmc) &&
 		    mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd)) {
 			dev_err(slot->host->dev,
 				"failed to enable vmmc regulator\n");
-			/*return, if failed turn on vmmc*/
-			return;
+
+			return -EINVAL;
 		}
 		set_bit(DW_MMC_CARD_NEED_INIT, &slot->flags);
 		regs = mci_readl(slot->host, PWREN);
@@ -1369,6 +1334,52 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		break;
 	}
 
+	return 0;
+}
+
+static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct dw_mci_slot *slot = mmc_priv(mmc);
+	const struct dw_mci_drv_data *drv_data = slot->host->drv_data;
+	u32 regs;
+
+	switch (ios->bus_width) {
+	case MMC_BUS_WIDTH_4:
+		slot->ctype = SDMMC_CTYPE_4BIT;
+		break;
+	case MMC_BUS_WIDTH_8:
+		slot->ctype = SDMMC_CTYPE_8BIT;
+		break;
+	default:
+		/* set default 1 bit mode */
+		slot->ctype = SDMMC_CTYPE_1BIT;
+	}
+
+	regs = mci_readl(slot->host, UHS_REG);
+
+	/* DDR mode set */
+	if (ios->timing == MMC_TIMING_MMC_DDR52 ||
+	    ios->timing == MMC_TIMING_UHS_DDR50 ||
+	    ios->timing == MMC_TIMING_MMC_HS400)
+		regs |= ((0x1 << slot->id) << 16);
+	else
+		regs &= ~((0x1 << slot->id) << 16);
+
+	mci_writel(slot->host, UHS_REG, regs);
+	slot->host->timing = ios->timing;
+
+	/*
+	 * Use mirror of ios->clock to prevent race with mmc
+	 * core ios update when finding the minimum.
+	 */
+	slot->clock = ios->clock;
+
+	if (drv_data && drv_data->set_ios)
+		drv_data->set_ios(slot->host, ios);
+
+	if (dw_mci_set_power(mmc, ios))
+		return;
+
 	if (slot->host->state == STATE_WAITING_CMD11_DONE && ios->clock != 0)
 		slot->host->state = STATE_IDLE;
 }
-- 
2.3.7
