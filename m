From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v2 3/4] mmc: sdhci: Don't try to switch to unsupported voltage
Date: Fri, 23 Sep 2016 08:03:10 +0800
Message-ID: <1474588991-10344-3-git-send-email-shawn.lin@rock-chips.com>
References: <1474588991-10344-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1474588991-10344-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

From: Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

Sdhci shouldn't switch to the unsupported voltage if claiming
that it can not support the requested voltage. Let's fix it.

Signed-off-by: Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---

Changes in v2: None

 drivers/mmc/host/sdhci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 4805566..b1f1edd 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1845,7 +1845,8 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 
 	switch (ios->signal_voltage) {
 	case MMC_SIGNAL_VOLTAGE_330:
-		if (!(host->flags & SDHCI_SIGNALING_330))
+		if (!(host->flags & SDHCI_SIGNALING_330) ||
+		    !(host->caps & SDHCI_CAN_VDD_330))
 			return -EINVAL;
 		/* Set 1.8V Signal Enable in the Host Control2 register to 0 */
 		ctrl &= ~SDHCI_CTRL_VDD_180;
@@ -1872,7 +1873,8 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 
 		return -EAGAIN;
 	case MMC_SIGNAL_VOLTAGE_180:
-		if (!(host->flags & SDHCI_SIGNALING_180))
+		if (!(host->flags & SDHCI_SIGNALING_180) ||
+		    !(host->caps & SDHCI_CAN_VDD_180))
 			return -EINVAL;
 		if (!IS_ERR(mmc->supply.vqmmc)) {
 			ret = mmc_regulator_set_vqmmc(mmc, ios);
-- 
2.3.7
