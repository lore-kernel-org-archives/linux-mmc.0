From: Doug Anderson <dianders@chromium.org>
Subject: [PATCH 3/3] mmc: dw_mmc: Add locking around cmd11 timer
Date: Fri,  3 Apr 2015 11:13:07 -0700
Message-ID: <1428084787-8710-3-git-send-email-dianders@chromium.org>
References: <1428084787-8710-1-git-send-email-dianders@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428084787-8710-1-git-send-email-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Addy Ke <addy.ke@rock-chips.com>, Alexandru Stan <amstan@chromium.org>, javier.martinez@collabora.co.uk, linux-rockchip@lists.infradead.org, Doug Anderson <dianders@chromium.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

It is possible for the cmd11 interrupt to fire and delete the
cmd11_timer before the cmd11_timer was actually setup.  Let's fix this
race by adding a few spinlocks.  Note that the race wasn't seen in
practice without adding some printk statements, but it still seems
wise to fix.

Fixes: 5c935165da79 ("mmc: dw_mmc: Add a timeout for sending CMD11")
Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 drivers/mmc/host/dw_mmc.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 357ef04..105a602 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1022,14 +1022,23 @@ static void __dw_mci_start_request(struct dw_mci *host,
 	dw_mci_start_command(host, cmd, cmdflags);
 
 	if (cmd->opcode == SD_SWITCH_VOLTAGE) {
+		unsigned long irqflags;
+
 		/*
 		 * Databook says to fail after 2ms w/ no response, but evidence
 		 * shows that sometimes the cmd11 interrupt takes over 130ms.
 		 * We'll set to 500ms, plus an extra jiffy just in case jiffies
 		 * is just about to roll over.
+		 *
+		 * We do this whole thing under spinlock and only if the
+		 * command hasn't already completed (indicating the the irq
+		 * already ran so we don't want the timeout).
 		 */
-		mod_timer(&host->cmd11_timer,
-			  jiffies + msecs_to_jiffies(500) + 1);
+		spin_lock_irqsave(&host->irq_lock, irqflags);
+		if (!test_bit(EVENT_CMD_COMPLETE, &host->pending_events))
+			mod_timer(&host->cmd11_timer,
+				jiffies + msecs_to_jiffies(500) + 1);
+		spin_unlock_irqrestore(&host->irq_lock, irqflags);
 	}
 
 	if (mrq->stop)
@@ -2170,11 +2179,20 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 		/* Check volt switch first, since it can look like an error */
 		if ((host->state == STATE_SENDING_CMD11) &&
 		    (pending & SDMMC_INT_VOLT_SWITCH)) {
-			del_timer(&host->cmd11_timer);
+			unsigned long irqflags;
 
 			mci_writel(host, RINTSTS, SDMMC_INT_VOLT_SWITCH);
 			pending &= ~SDMMC_INT_VOLT_SWITCH;
+
+			/*
+			 * Hold the lock; we know cmd11_timer can't be kicked
+			 * off after the lock is released, so safe to delete.
+			 */
+			spin_lock_irqsave(&host->irq_lock, irqflags);
 			dw_mci_cmd_interrupt(host, pending);
+			spin_unlock_irqrestore(&host->irq_lock, irqflags);
+
+			del_timer(&host->cmd11_timer);
 		}
 
 		if (pending & DW_MCI_CMD_ERROR_FLAGS) {
-- 
2.2.0.rc0.207.ga3a616c
