From: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH v2 5/5] mmc: dw_mmc: Cleanup the DTO timer like the CTO one
Date: Thu, 12 Oct 2017 13:11:18 -0700
Message-ID: <20171012201118.23570-6-dianders@chromium.org>
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

The recent CTO timer introduced in commit 03de19212ea3 ("mmc: dw_mmc:
introduce timer for broken command transfer over scheme") was causing
observable problems due to race conditions.  Previous patches have
fixed those race conditions.

It can be observed that these same race conditions ought to be
theoretically possible with the DTO timer too though they are
massively less likely to happen because the data timeout is always set
to 0xffffff right now.  That means even at a 200 MHz card clock we
were arming the DTO timer for 94 ms:
  >>> (0xffffff * 1000. / 200000000) + 10
  93.886075

We always also were setting the DTO timer _after_ starting the
transfer, unlike how the old code was seting the CTO timer.

In any case, even though the DTO timer is much less likely to have
races, it still makes sense to add code to handle it _just in case_.

Signed-off-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---

Changes in v2:
- Cleanup the DTO timer new for v2

 drivers/mmc/host/dw_mmc.c | 54 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 51 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 6bc87b1385a9..bc0808615431 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1950,7 +1950,11 @@ static void dw_mci_set_drto(struct dw_mci *host)
 	/* add a bit spare time */
 	drto_ms += 10;
 
-	mod_timer(&host->dto_timer, jiffies + msecs_to_jiffies(drto_ms));
+	spin_lock_irqsave(&host->irq_lock, irqflags);
+	if (!test_bit(EVENT_DATA_COMPLETE, &host->pending_events))
+		mod_timer(&host->dto_timer,
+			  jiffies + msecs_to_jiffies(drto_ms));
+	spin_unlock_irqrestore(&host->irq_lock, irqflags);
 }
 
 static bool dw_mci_clear_pending_cmd_complete(struct dw_mci *host)
@@ -1971,6 +1975,18 @@ static bool dw_mci_clear_pending_cmd_complete(struct dw_mci *host)
 	return true;
 }
 
+static bool dw_mci_clear_pending_data_complete(struct dw_mci *host)
+{
+	if (!test_bit(EVENT_DATA_COMPLETE, &host->pending_events))
+		return false;
+
+	/* Extra paranoia just like dw_mci_clear_pending_cmd_complete() */
+	WARN_ON(del_timer_sync(&host->dto_timer));
+	clear_bit(EVENT_DATA_COMPLETE, &host->pending_events);
+
+	return true;
+}
+
 static void dw_mci_tasklet_func(unsigned long priv)
 {
 	struct dw_mci *host = (struct dw_mci *)priv;
@@ -2112,8 +2128,7 @@ static void dw_mci_tasklet_func(unsigned long priv)
 			/* fall through */
 
 		case STATE_DATA_BUSY:
-			if (!test_and_clear_bit(EVENT_DATA_COMPLETE,
-						&host->pending_events)) {
+			if (!dw_mci_clear_pending_data_complete(host)) {
 				/*
 				 * If data error interrupt comes but data over
 				 * interrupt doesn't come within the given time.
@@ -2683,6 +2698,8 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 		}
 
 		if (pending & SDMMC_INT_DATA_OVER) {
+			spin_lock_irqsave(&host->irq_lock, irqflags);
+
 			del_timer(&host->dto_timer);
 
 			mci_writel(host, RINTSTS, SDMMC_INT_DATA_OVER);
@@ -2695,6 +2712,8 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 			}
 			set_bit(EVENT_DATA_COMPLETE, &host->pending_events);
 			tasklet_schedule(&host->tasklet);
+
+			spin_unlock_irqrestore(&host->irq_lock, irqflags);
 		}
 
 		if (pending & SDMMC_INT_RXDR) {
@@ -3044,7 +3063,31 @@ static void dw_mci_cto_timer(unsigned long arg)
 static void dw_mci_dto_timer(unsigned long arg)
 {
 	struct dw_mci *host = (struct dw_mci *)arg;
+	unsigned long irqflags;
+	u32 pending;
+
+	spin_lock_irqsave(&host->irq_lock, irqflags);
 
+	/*
+	 * The DTO timer is much longer than the CTO timer, so it's even less
+	 * likely that we'll these cases, but it pays to be paranoid.
+	 */
+	pending = mci_readl(host, MINTSTS); /* read-only mask reg */
+	if (pending & SDMMC_INT_DATA_OVER) {
+		/* The interrupt should fire; no need to act but we can warn */
+		dev_warn(host->dev, "Unexpected data interrupt latency\n");
+		goto exit;
+	}
+	if (test_bit(EVENT_DATA_COMPLETE, &host->pending_events)) {
+		/* Presumably interrupt handler couldn't delete the timer */
+		dev_warn(host->dev, "DTO timeout when already completed\n");
+		goto exit;
+	}
+
+	/*
+	 * Continued paranoia to make sure we're in the state we expect.
+	 * This paranoia isn't really justified but it seems good to be safe.
+	 */
 	switch (host->state) {
 	case STATE_SENDING_DATA:
 	case STATE_DATA_BUSY:
@@ -3059,8 +3102,13 @@ static void dw_mci_dto_timer(unsigned long arg)
 		tasklet_schedule(&host->tasklet);
 		break;
 	default:
+		dev_warn(host->dev, "Unexpected data timeout, state %d\n",
+			 host->state);
 		break;
 	}
+
+exit:
+	spin_unlock_irqrestore(&host->irq_lock, irqflags);
 }
 
 #ifdef CONFIG_OF
-- 
2.15.0.rc0.271.g36b669edcc-goog
