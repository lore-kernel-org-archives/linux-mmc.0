From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [RESEND PATCH 2/6] mmc: dw_mmc: cleanup power setting of set_ios
 callback
Date: Sat,  6 Aug 2016 15:45:44 +0800
Message-ID: <1470469544-5759-1-git-send-email-shawn.lin@rock-chips.com>
References: <1470469503-5676-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1470469503-5676-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
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

Remove the ret variable and combine the condition check
to simplify the code.

Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---

 drivers/mmc/host/dw_mmc.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 32380d5..59a5e9c 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1281,7 +1281,6 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	struct dw_mci_slot *slot = mmc_priv(mmc);
 	const struct dw_mci_drv_data *drv_data = slot->host->drv_data;
 	u32 regs;
-	int ret;
 
 	switch (ios->bus_width) {
 	case MMC_BUS_WIDTH_4:
@@ -1319,15 +1318,12 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	switch (ios->power_mode) {
 	case MMC_POWER_UP:
-		if (!IS_ERR(mmc->supply.vmmc)) {
-			ret = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc,
-					ios->vdd);
-			if (ret) {
-				dev_err(slot->host->dev,
-					"failed to enable vmmc regulator\n");
-				/*return, if failed turn on vmmc*/
-				return;
-			}
+		if (!IS_ERR(mmc->supply.vmmc) &&
+		    mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd)) {
+			dev_err(slot->host->dev,
+				"failed to enable vmmc regulator\n");
+			/*return, if failed turn on vmmc*/
+			return;
 		}
 		set_bit(DW_MMC_CARD_NEED_INIT, &slot->flags);
 		regs = mci_readl(slot->host, PWREN);
@@ -1336,14 +1332,10 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		break;
 	case MMC_POWER_ON:
 		if (!slot->host->vqmmc_enabled) {
-			if (!IS_ERR(mmc->supply.vqmmc)) {
-				ret = regulator_enable(mmc->supply.vqmmc);
-				if (ret < 0)
-					dev_err(slot->host->dev,
-						"failed to enable vqmmc\n");
-				else
-					slot->host->vqmmc_enabled = true;
-
+			if (!IS_ERR(mmc->supply.vqmmc) &&
+			    regulator_enable(mmc->supply.vqmmc)) {
+				dev_err(slot->host->dev,
+					"failed to enable vqmmc\n");
 			} else {
 				/* Keep track so we don't reset again */
 				slot->host->vqmmc_enabled = true;
-- 
2.3.7
