From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] mmc: dw_mmc: introduce timer for broken command transfer over scheme
Date: Tue, 11 Jul 2017 17:38:37 +0800
Message-ID: <1499765917-228806-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:46532 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751124AbdGKJjf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Jul 2017 05:39:35 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Ziyuan Xu <xzy.xu@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Addy Ke <addy.ke@rock-chips.com>, Shawn Lin <shawn.lin@rock-chips.com>

From: Addy Ke <addy.ke@rock-chips.com>

Per the databook of designware mmc controller 2.70a, table 3-2, cmd
done interrupt should be fired as soon as the the cmd is sent via
cmd line. And the response timeout interrupt should be generated
unconditioinally as well if the controller doesn't receive the resp.
However that doesn't seem to meet the fact of rockchip specified Soc
platforms using dwmmc. We have continuously found the the cmd done or
response timeout interrupt missed somehow which took us a long time to
understand what was happening. Finally we narrow down the root to
the reconstruction of sample circuit for dwmmc IP introduced by
rockchip and the buggy design sweeps over all the existing rockchip
Socs using dwmmc disastrously.

It seems no way to work around this bug without the proper break-out
mechanism so that we seek for a parallel pair the same as the handling
for missing data response timeout, namely dto timer. Adding this cto
timer seems easily to handle this bug but it's hard to restrict the code
under the rockchip specified context. So after merging this patch, it
sets up the cto timer for all the platforms using dwmmc IP which isn't
ideal but at least we don't advertise new quirk here. Fortunately, no
obvious performance regression was found by test and the pre-existing
similar catch-all timer for sdhci has proved it's an acceptant way to
make the code as robust as possible.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=196321
Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
Signed-off-by: Ziyuan Xu <xzy.xu@rock-chips.com>
[shawn.lin: rewrite the code and the commit msg throughout]
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

 drivers/mmc/host/dw_mmc.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/dw_mmc.h |  2 ++
 2 files changed, 50 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index a9dfb26..2f6121e 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -398,6 +398,21 @@ static u32 dw_mci_prep_stop_abort(struct dw_mci *host, struct mmc_command *cmd)
 	return cmdr;
 }
 
+static inline void dw_mci_set_cto(struct dw_mci *host)
+{
+	unsigned int cto_clks;
+	unsigned int cto_ms;
+
+	cto_clks = mci_readl(host, TMOUT) & 0xff;
+	cto_ms = DIV_ROUND_UP(cto_clks, host->bus_hz / 1000);
+
+	/* add a bit spare time */
+	cto_ms += 10;
+
+	mod_timer(&host->cto_timer,
+		  jiffies + msecs_to_jiffies(cto_ms) + 1);
+}
+
 static void dw_mci_start_command(struct dw_mci *host,
 				 struct mmc_command *cmd, u32 cmd_flags)
 {
@@ -410,6 +425,10 @@ static void dw_mci_start_command(struct dw_mci *host,
 	wmb(); /* drain writebuffer */
 	dw_mci_wait_while_busy(host, cmd_flags);
 
+	/* response expected command only */
+	if (cmd_flags & SDMMC_CMD_RESP_EXP)
+		dw_mci_set_cto(host);
+
 	mci_writel(host, CMD, cmd_flags | SDMMC_CMD_START);
 }
 
@@ -2599,6 +2618,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 		}
 
 		if (pending & DW_MCI_CMD_ERROR_FLAGS) {
+			del_timer(&host->cto_timer);
 			mci_writel(host, RINTSTS, DW_MCI_CMD_ERROR_FLAGS);
 			host->cmd_status = pending;
 			smp_wmb(); /* drain writebuffer */
@@ -2642,6 +2662,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 		}
 
 		if (pending & SDMMC_INT_CMD_DONE) {
+			del_timer(&host->cto_timer);
 			mci_writel(host, RINTSTS, SDMMC_INT_CMD_DONE);
 			dw_mci_cmd_interrupt(host, pending);
 		}
@@ -2914,6 +2935,30 @@ static void dw_mci_cmd11_timer(unsigned long arg)
 	tasklet_schedule(&host->tasklet);
 }
 
+static void dw_mci_cto_timer(unsigned long arg)
+{
+	struct dw_mci *host = (struct dw_mci *)arg;
+
+	switch (host->state) {
+	case STATE_SENDING_CMD11:
+	case STATE_SENDING_CMD:
+	case STATE_SENDING_STOP:
+		/*
+		 * If CMD_DONE interrupt does NOT come in sending command
+		 * state, we should notify the driver to terminate current
+		 * transfer and report a command timeout to the core.
+		 */
+		host->cmd_status = SDMMC_INT_RTO;
+		set_bit(EVENT_CMD_COMPLETE, &host->pending_events);
+		tasklet_schedule(&host->tasklet);
+		break;
+	default:
+		dev_warn(host->dev, "Unexpected command timeout, state %d\n",
+			 host->state);
+		break;
+	}
+}
+
 static void dw_mci_dto_timer(unsigned long arg)
 {
 	struct dw_mci *host = (struct dw_mci *)arg;
@@ -3085,6 +3130,9 @@ int dw_mci_probe(struct dw_mci *host)
 	setup_timer(&host->cmd11_timer,
 		    dw_mci_cmd11_timer, (unsigned long)host);
 
+	setup_timer(&host->cto_timer,
+		    dw_mci_cto_timer, (unsigned long)host);
+
 	setup_timer(&host->dto_timer,
 		    dw_mci_dto_timer, (unsigned long)host);
 
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 75da375..4210927 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -126,6 +126,7 @@ struct dw_mci_dma_slave {
  * @irq: The irq value to be passed to request_irq.
  * @sdio_id0: Number of slot0 in the SDIO interrupt registers.
  * @cmd11_timer: Timer for SD3.0 voltage switch over scheme.
+ * @cto_timer: Timer for broken command transfer over scheme.
  * @dto_timer: Timer for broken data transfer over scheme.
  *
  * Locking
@@ -232,6 +233,7 @@ struct dw_mci {
 	int			sdio_id0;
 
 	struct timer_list       cmd11_timer;
+	struct timer_list       cto_timer;
 	struct timer_list       dto_timer;
 };
 
-- 
1.9.1


