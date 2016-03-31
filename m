From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v2 3/3] mmc: dw_mmc: remove setup_clock callback
Date: Thu, 31 Mar 2016 15:34:10 +0800
Message-ID: <1459409650-20429-1-git-send-email-shawn.lin@rock-chips.com>
References: <1459409616-20306-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1459409616-20306-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
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
Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Now, no dw_mmc variant drivers use this callback, let's
remove it.

Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---

Changes in v2: None

 drivers/mmc/host/dw_mmc.c | 9 ---------
 drivers/mmc/host/dw_mmc.h | 2 --
 2 files changed, 11 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 242f9a0..e03cc66 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3003,15 +3003,6 @@ int dw_mci_probe(struct dw_mci *host)
 		}
 	}
 
-	if (drv_data && drv_data->setup_clock) {
-		ret = drv_data->setup_clock(host);
-		if (ret) {
-			dev_err(host->dev,
-				"implementation specific clock setup failed\n");
-			goto err_clk_ciu;
-		}
-	}
-
 	setup_timer(&host->cmd11_timer,
 		    dw_mci_cmd11_timer, (unsigned long)host);
 
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 68d5da2..1e8d838 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -277,7 +277,6 @@ struct dw_mci_slot {
  * dw_mci driver data - dw-mshc implementation specific driver data.
  * @caps: mmc subsystem specified capabilities of the controller(s).
  * @init: early implementation specific initialization.
- * @setup_clock: implementation specific clock configuration.
  * @set_ios: handle bus specific extensions.
  * @parse_dt: parse implementation specific device tree properties.
  * @execute_tuning: implementation specific tuning procedure.
@@ -289,7 +288,6 @@ struct dw_mci_slot {
 struct dw_mci_drv_data {
 	unsigned long	*caps;
 	int		(*init)(struct dw_mci *host);
-	int		(*setup_clock)(struct dw_mci *host);
 	void		(*set_ios)(struct dw_mci *host, struct mmc_ios *ios);
 	int		(*parse_dt)(struct dw_mci *host);
 	int		(*execute_tuning)(struct dw_mci_slot *slot, u32 opcode);
-- 
2.3.7
