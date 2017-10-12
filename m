From: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH v2 1/5] mmc: dw_mmc: cancel the CTO timer after a voltage
 switch
Date: Thu, 12 Oct 2017 13:11:14 -0700
Message-ID: <20171012201118.23570-2-dianders@chromium.org>
References: <20171012201118.23570-1-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20171012201118.23570-1-dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-sKpHZLTYfq0@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, amstan-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

When running with the commit 03de19212ea3 ("mmc: dw_mmc: introduce
timer for broken command transfer over scheme") I found this message
in the log:
  Unexpected command timeout, state 7

It turns out that we weren't properly cancelling the new CTO timer in
the case that a voltage switch was done.  Let's promote the cancel
into the dw_mci_cmd_interrupt() function to fix this.

Fixes: 03de19212ea3 ("mmc: dw_mmc: introduce timer for broken command transfer over scheme")
Tested-by: Emil Renner Berthing <kernel-sKpHZLTYfq0@public.gmane.org>
Reviewed-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Signed-off-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---

Changes in v2: None

 drivers/mmc/host/dw_mmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 860313bd952a..f5b2bb4b4d98 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2570,6 +2570,8 @@ static void dw_mci_write_data_pio(struct dw_mci *host)
 
 static void dw_mci_cmd_interrupt(struct dw_mci *host, u32 status)
 {
+	del_timer(&host->cto_timer);
+
 	if (!host->cmd_status)
 		host->cmd_status = status;
 
@@ -2662,7 +2664,6 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 		}
 
 		if (pending & SDMMC_INT_CMD_DONE) {
-			del_timer(&host->cto_timer);
 			mci_writel(host, RINTSTS, SDMMC_INT_CMD_DONE);
 			dw_mci_cmd_interrupt(host, pending);
 		}
-- 
2.15.0.rc0.271.g36b669edcc-goog
