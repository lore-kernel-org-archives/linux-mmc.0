From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [RESEND PATCH 4/6] mmc: dw_mmc: split out dw_mci_set_power_reg
Date: Sat,  6 Aug 2016 15:46:06 +0800
Message-ID: <1470469566-5841-1-git-send-email-shawn.lin@rock-chips.com>
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

Splite out dw_mci_set_power_reg to set PWREN register
in case that we need more complicated power control.

Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---

 drivers/mmc/host/dw_mmc.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 0e5ed23..c35a26a 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1276,10 +1276,25 @@ static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	spin_unlock_bh(&host->lock);
 }
 
+static inline void dw_mci_set_power_reg(struct dw_mci_slot *slot,
+					bool enable)
+{
+	u32 regs;
+
+	if (enable) {
+		regs = mci_readl(slot->host, PWREN);
+		regs |= (1 << slot->id);
+		mci_writel(slot->host, PWREN, regs);
+	} else {
+		regs = mci_readl(slot->host, PWREN);
+		regs &= ~(1 << slot->id);
+		mci_writel(slot->host, PWREN, regs);
+	}
+}
+
 static int dw_mci_set_power(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct dw_mci_slot *slot = mmc_priv(mmc);
-	u32 regs;
 
 	switch (ios->power_mode) {
 	case MMC_POWER_UP:
@@ -1291,9 +1306,7 @@ static int dw_mci_set_power(struct mmc_host *mmc, struct mmc_ios *ios)
 			return -EINVAL;
 		}
 		set_bit(DW_MMC_CARD_NEED_INIT, &slot->flags);
-		regs = mci_readl(slot->host, PWREN);
-		regs |= (1 << slot->id);
-		mci_writel(slot->host, PWREN, regs);
+		dw_mci_set_power_reg(slot, true);
 		break;
 	case MMC_POWER_ON:
 		if (!slot->host->vqmmc_enabled) {
@@ -1325,10 +1338,7 @@ static int dw_mci_set_power(struct mmc_host *mmc, struct mmc_ios *ios)
 		if (!IS_ERR(mmc->supply.vqmmc) && slot->host->vqmmc_enabled)
 			regulator_disable(mmc->supply.vqmmc);
 		slot->host->vqmmc_enabled = false;
-
-		regs = mci_readl(slot->host, PWREN);
-		regs &= ~(1 << slot->id);
-		mci_writel(slot->host, PWREN, regs);
+		dw_mci_set_power_reg(slot, false);
 		break;
 	default:
 		break;
-- 
2.3.7
