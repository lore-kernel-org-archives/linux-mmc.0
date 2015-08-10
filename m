From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: [PATCH v6] mmc: dw_mmc: add quirk for broken data transfer over scheme
Date: Mon, 10 Aug 2015 13:12:18 +0200
Message-ID: <6399035.ITCGpzeoRA@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:34681 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933062AbbHJLM0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 10 Aug 2015 07:12:26 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-rockchip@lists.infradead.org, dianders@chromium.org, Addy Ke <addy.ke@rock-chips.com>

From: Addy Ke <addy.ke@rock-chips.com>

This patch add a new quirk to add a s/w timer to notify the driver
to terminate current transfer and report a data timeout to the core,
if DTO interrupt does NOT come within the given time.

dw_mmc call mmc_request_done func to finish transfer depends on
DTO interrupt. If DTO interrupt does not come in sending data state,
the current transfer will be blocked.

We got the reply from synopsys:
There are two counters but both use the same value of [31:8] bits.
Data timeout counter doesn't wait for stop clock and you should get
DRTO even when the clock is not stopped.
Host Starvation timeout counter is triggered with stop clock condition.

This means that host should get DRTO and DTO interrupt.

But this case really exists, when driver reads tuning data from
card on RK3288-pink2 board. I measured waveforms by oscilloscope
and found that card clock was always on and data lines were always
holded high level in sending data state.

There are two possibility that data over interrupt doesn't come in
reading data state on RK3X SoCs:
- get command done interrupt, but doesn't get any data-related interrupt.
- get data error interrupt, but doesn't get data over interrupt.

Signed-off-by: Addy Ke <addy.ke@rock-chips.com>

Address review comments from Jaehoon Chung.
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
Changes in v2:
- fix some typo.
- remove extra timeout value (250ms).
- remove dw_mci_dto_start_monitor func.
- use "broken-dto" for new quirk and change Subject for it.

Changes in v3:
- Remove dts for broken-dto, just add this quirk in dw_mci_rockchip_init

Changes in v4:
- fix bug that may cause 32 bit overflow by (drto_clks * 1000).
- doesn't call mod_timer in writing data state, becase TMOUT register only
  for reading data.

Changes in v5:
- fix some typo.
- add a buffer for drto_ms.
- move drto_ms related code to a helper function.

Changes in v6:
- better spare time comment
- let dw_mci_set_drto start the timer itself

 drivers/mmc/host/dw_mmc-rockchip.c |  3 ++
 drivers/mmc/host/dw_mmc.c          | 64 
++++++++++++++++++++++++++++++++++++--
 include/linux/mmc/dw_mmc.h         |  4 +++
 3 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-
rockchip.c
index de15121..bc76aa2 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -73,6 +73,9 @@ static int dw_mci_rockchip_init(struct dw_mci *host)
 	/* It is slot 8 on Rockchip SoCs */
 	host->sdio_id0 = 8;
 
+	/* It needs this quirk on all Rockchip SoCs */
+	host->pdata->quirks |= DW_MCI_QUIRK_BROKEN_DTO;
+
 	return 0;
 }
 
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 4e95ca9..459e68b 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1528,6 +1528,20 @@ static int dw_mci_data_complete(struct dw_mci *host, 
struct mmc_data *data)
 	return data->error;
 }
 
+static void dw_mci_set_drto(struct dw_mci *host)
+{
+	unsigned int drto_clks;
+	unsigned int drto_ms;
+
+	drto_clks = mci_readl(host, TMOUT) >> 8;
+	drto_ms = DIV_ROUND_UP(drto_clks, host->bus_hz / 1000);
+
+	/* add a bit spare time */
+	drto_ms += 10;
+
+	mod_timer(&host->dto_timer, jiffies + msecs_to_jiffies(drto_ms));
+}
+
 static void dw_mci_tasklet_func(unsigned long priv)
 {
 	struct dw_mci *host = (struct dw_mci *)priv;
@@ -1605,8 +1619,16 @@ static void dw_mci_tasklet_func(unsigned long priv)
 			}
 
 			if (!test_and_clear_bit(EVENT_XFER_COMPLETE,
-						&host->pending_events))
+						&host->pending_events)) {
+				/*
+				 * If all data-related interrupts don't come
+				 * within the given time in reading data state.
+				 */
+				if ((host->quirks & DW_MCI_QUIRK_BROKEN_DTO) &&
+				    (host->dir_status == DW_MCI_RECV_STATUS))
+					dw_mci_set_drto(host);
 				break;
+			}
 
 			set_bit(EVENT_XFER_COMPLETE, &host->completed_events);
 
@@ -1639,8 +1661,17 @@ static void dw_mci_tasklet_func(unsigned long priv)
 
 		case STATE_DATA_BUSY:
 			if (!test_and_clear_bit(EVENT_DATA_COMPLETE,
-						&host->pending_events))
+						&host->pending_events)) {
+				/*
+				 * If data error interrupt comes but data over
+				 * interrupt doesn't come within the given time.
+				 * in reading data state.
+				 */
+				if ((host->quirks & DW_MCI_QUIRK_BROKEN_DTO) &&
+				    (host->dir_status == DW_MCI_RECV_STATUS))
+					dw_mci_set_drto(host);
 				break;
+			}
 
 			host->data = NULL;
 			set_bit(EVENT_DATA_COMPLETE, &host->completed_events);
@@ -2201,6 +2232,9 @@ static irqreturn_t dw_mci_interrupt(int irq, void 
*dev_id)
 		}
 
 		if (pending & SDMMC_INT_DATA_OVER) {
+			if (host->quirks & DW_MCI_QUIRK_BROKEN_DTO)
+				del_timer(&host->dto_timer);
+
 			mci_writel(host, RINTSTS, SDMMC_INT_DATA_OVER);
 			if (!host->data_status)
 				host->data_status = pending;
@@ -2593,6 +2627,28 @@ static void dw_mci_cmd11_timer(unsigned long arg)
 	tasklet_schedule(&host->tasklet);
 }
 
+static void dw_mci_dto_timer(unsigned long arg)
+{
+	struct dw_mci *host = (struct dw_mci *)arg;
+
+	switch (host->state) {
+	case STATE_SENDING_DATA:
+	case STATE_DATA_BUSY:
+		/*
+		 * If DTO interrupt does NOT come in sending data state,
+		 * we should notify the driver to terminate current transfer
+		 * and report a data timeout to the core.
+		 */
+		host->data_status = SDMMC_INT_DRTO;
+		set_bit(EVENT_DATA_ERROR, &host->pending_events);
+		set_bit(EVENT_DATA_COMPLETE, &host->pending_events);
+		tasklet_schedule(&host->tasklet);
+		break;
+	default:
+		break;
+	}
+}
+
 #ifdef CONFIG_OF
 static struct dw_mci_of_quirks {
 	char *quirk;
@@ -2769,6 +2825,10 @@ int dw_mci_probe(struct dw_mci *host)
 
 	host->quirks = host->pdata->quirks;
 
+	if (host->quirks & DW_MCI_QUIRK_BROKEN_DTO)
+		setup_timer(&host->dto_timer,
+			    dw_mci_dto_timer, (unsigned long)host);
+
 	spin_lock_init(&host->lock);
 	spin_lock_init(&host->irq_lock);
 	INIT_LIST_HEAD(&host->queue);
diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index 5be9767..1c47ce3 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -98,6 +98,7 @@ struct mmc_data;
  * @irq_flags: The flags to be passed to request_irq.
  * @irq: The irq value to be passed to request_irq.
  * @sdio_id0: Number of slot0 in the SDIO interrupt registers.
+ * @dto_timer: Timer for broken data transfer over scheme.
  *
  * Locking
  * =======
@@ -204,6 +205,7 @@ struct dw_mci {
 	int			sdio_id0;
 
 	struct timer_list       cmd11_timer;
+	struct timer_list       dto_timer;
 };
 
 /* DMA ops for Internal/External DMAC interface */
@@ -226,6 +228,8 @@ struct dw_mci_dma_ops {
 #define DW_MCI_QUIRK_HIGHSPEED			BIT(2)
 /* Unreliable card detection */
 #define DW_MCI_QUIRK_BROKEN_CARD_DETECTION	BIT(3)
+/* Timer for broken data transfer over scheme */
+#define DW_MCI_QUIRK_BROKEN_DTO			BIT(4)
 
 struct dma_pdata;
 
-- 
2.1.4

