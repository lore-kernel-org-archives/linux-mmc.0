From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH 2/3] mmc: dw_mmc: Add hardware unbusy interrupt support
Date: Wed, 27 Feb 2019 11:36:42 +0800
Message-ID: <1551238603-82412-3-git-send-email-shawn.lin@rock-chips.com>
References: <1551238603-82412-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1551238603-82412-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
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
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

So that we don't need to busy checking the busy state,
but relinguish the CPU and rely on the hareware interrupt
if available.

Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---

 drivers/mmc/host/dw_mmc.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/dw_mmc.h |  6 ++++++
 2 files changed, 61 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 703dedf..b8f0ed9 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -107,6 +107,8 @@ struct idmac_desc {
 /* Each descriptor can transfer up to 4KB of data in chained mode */
 #define DW_MCI_DESC_DATA_LENGTH	0x1000
 
+DECLARE_WAIT_QUEUE_HEAD(unbusy_waiter);
+
 #if defined(CONFIG_DEBUG_FS)
 static int dw_mci_req_show(struct seq_file *s, void *v)
 {
@@ -231,9 +233,36 @@ static bool dw_mci_ctrl_reset(struct dw_mci *host, u32 reset)
 	return true;
 }
 
+static inline int dw_mci_wait_hw_unbusy(struct dw_mci *host,
+					 unsigned long timeout)
+{
+	unsigned long irqflags;
+	int err;
+
+	set_bit(EVENT_UNBUSY_COMPLETE, &host->pending_events);
+	err = host->drv_data->prepare_hw_unbusy(host, true);
+	if (err)
+		return err;
+
+	wait_event_interruptible_timeout(unbusy_waiter,
+					 !test_bit(EVENT_UNBUSY_COMPLETE,
+						   &host->pending_events),
+					 timeout);
+
+	spin_lock_irqsave(&host->irq_lock, irqflags);
+	if (test_and_clear_bit(EVENT_UNBUSY_COMPLETE,
+			       &host->pending_events)) {
+		dev_err(host->dev, "Busy; trying anyway\n");
+		host->drv_data->prepare_hw_unbusy(host, false);
+	}
+	spin_unlock_irqrestore(&host->irq_lock, irqflags);
+	return 0;
+}
+
 static void dw_mci_wait_while_busy(struct dw_mci *host, u32 cmd_flags)
 {
 	u32 status;
+	int err;
 
 	/*
 	 * Databook says that before issuing a new data transfer command
@@ -245,6 +274,15 @@ static void dw_mci_wait_while_busy(struct dw_mci *host, u32 cmd_flags)
 	 */
 	if ((cmd_flags & SDMMC_CMD_PRV_DAT_WAIT) &&
 	    !(cmd_flags & SDMMC_CMD_VOLT_SWITCH)) {
+		/* Resort to hw unbusy interrupt first */
+		if (host->drv_data->prepare_hw_unbusy) {
+			err = dw_mci_wait_hw_unbusy(host,
+					jiffies + msecs_to_jiffies(500));
+			if (!err)
+				return;
+			/* Otherwise we fallback to busy checking */
+		}
+
 		if (readl_poll_timeout_atomic(host->regs + SDMMC_STATUS,
 					      status,
 					      !(status & SDMMC_STATUS_BUSY),
@@ -2734,6 +2772,16 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 			dw_mci_handle_cd(host);
 		}
 
+		/* Check hardware unbusy interrupt */
+		if (host->hw_unbusy_int != -EINVAL &&
+		    pending & BIT(host->hw_unbusy_int)) {
+			mci_writel(host, RINTSTS, BIT(host->hw_unbusy_int));
+			spin_lock_irqsave(&host->irq_lock, irqflags);
+			clear_bit(EVENT_UNBUSY_COMPLETE, &host->pending_events);
+			spin_unlock_irqrestore(&host->irq_lock, irqflags);
+			wake_up_interruptible(&unbusy_waiter);
+		}
+
 		if (pending & SDMMC_INT_SDIO(slot->sdio_id)) {
 			mci_writel(host, RINTSTS,
 				   SDMMC_INT_SDIO(slot->sdio_id));
@@ -3249,6 +3297,8 @@ int dw_mci_probe(struct dw_mci *host)
 		reset_control_deassert(host->pdata->rstc);
 	}
 
+	host->hw_unbusy_int = -EINVAL;
+
 	if (drv_data && drv_data->init) {
 		ret = drv_data->init(host);
 		if (ret) {
@@ -3360,6 +3410,11 @@ int dw_mci_probe(struct dw_mci *host)
 	mci_writel(host, INTMASK, SDMMC_INT_CMD_DONE | SDMMC_INT_DATA_OVER |
 		   SDMMC_INT_TXDR | SDMMC_INT_RXDR |
 		   DW_MCI_ERROR_FLAGS);
+
+	if (host->hw_unbusy_int != -EINVAL)
+		mci_writel(host, INTMASK,
+			   mci_readl(host, INTMASK) | BIT(host->hw_unbusy_int));
+
 	/* Enable mci interrupt */
 	mci_writel(host, CTRL, SDMMC_CTRL_INT_ENABLE);
 
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 46e9f8e..fb4c173 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -33,6 +33,7 @@ enum dw_mci_state {
 
 enum {
 	EVENT_CMD_COMPLETE = 0,
+	EVENT_UNBUSY_COMPLETE,
 	EVENT_XFER_COMPLETE,
 	EVENT_DATA_COMPLETE,
 	EVENT_DATA_ERROR,
@@ -124,6 +125,7 @@ struct dw_mci_dma_slave {
  * @irq_flags: The flags to be passed to request_irq.
  * @irq: The irq value to be passed to request_irq.
  * @sdio_id0: Number of slot0 in the SDIO interrupt registers.
+ * @hw_unbusy_int: Number of unbusy interrupt in the interrupt registers.
  * @cmd11_timer: Timer for SD3.0 voltage switch over scheme.
  * @cto_timer: Timer for broken command transfer over scheme.
  * @dto_timer: Timer for broken data transfer over scheme.
@@ -230,6 +232,7 @@ struct dw_mci {
 	int			irq;
 
 	int			sdio_id0;
+	int                     hw_unbusy_int;
 
 	struct timer_list       cmd11_timer;
 	struct timer_list       cto_timer;
@@ -551,6 +554,8 @@ struct dw_mci_slot {
  * @set_ios: handle bus specific extensions.
  * @parse_dt: parse implementation specific device tree properties.
  * @execute_tuning: implementation specific tuning procedure.
+ * @prepare_hw_unbusy: implementation specific procedure for
+ *                    controlling hw unbusy interrupt.
  *
  * Provide controller implementation specific extensions. The usage of this
  * data structure is fully optional and usage of each member in this structure
@@ -565,6 +570,7 @@ struct dw_mci_drv_data {
 	int		(*execute_tuning)(struct dw_mci_slot *slot, u32 opcode);
 	int		(*prepare_hs400_tuning)(struct dw_mci *host,
 						struct mmc_ios *ios);
+	int             (*prepare_hw_unbusy)(struct dw_mci *host, bool enable);
 	int		(*switch_voltage)(struct mmc_host *mmc,
 					  struct mmc_ios *ios);
 };
-- 
1.9.1
