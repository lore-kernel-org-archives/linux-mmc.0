From: Doug Anderson <dianders@chromium.org>
Subject: [PATCH] mmc: dw_mmc: Add a timeout for sending CMD11
Date: Mon,  9 Mar 2015 16:18:21 -0700
Message-ID: <1425943101-11976-1-git-send-email-dianders@chromium.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:38466 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117AbbCIXSj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Mar 2015 19:18:39 -0400
Received: by igbhl2 with SMTP id hl2so25671912igb.3
        for <linux-mmc@vger.kernel.org>; Mon, 09 Mar 2015 16:18:38 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Addy Ke <addy.ke@rock-chips.com>, Alexandru Stan <amstan@chromium.org>, javier.martinez@collabora.co.uk, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Doug Anderson <dianders@chromium.org>, chris@printf.net, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

In the Designware databook's description of the "Voltage Switch Normal
Scenario" it instructs us to set a timer and fail the voltage change
if we don't see the voltage change interrupt within 2ms.  Let's
implement that.  Without implementing this I have often been able to
reproduce a hang while trying to send CMD11 on an rk3288-based board
while constantly ejecting and inserting UHS cards.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 drivers/mmc/host/dw_mmc.c  | 26 ++++++++++++++++++++++++++
 include/linux/mmc/dw_mmc.h |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 47dfd0e..d259662 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1020,6 +1020,15 @@ static void __dw_mci_start_request(struct dw_mci *host,
 
 	dw_mci_start_command(host, cmd, cmdflags);
 
+	if (cmd->opcode == SD_SWITCH_VOLTAGE) {
+		/*
+		 * Databook says to fail after 2ms w/ no response; give an
+		 * extra jiffy just in case we're about to roll over.
+		 */
+		mod_timer(&host->cmd11_timer,
+			  jiffies + msecs_to_jiffies(2) + 1);
+	}
+
 	if (mrq->stop)
 		host->stop_cmdr = dw_mci_prepare_command(slot->mmc, mrq->stop);
 	else
@@ -2158,6 +2167,8 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 		/* Check volt switch first, since it can look like an error */
 		if ((host->state == STATE_SENDING_CMD11) &&
 		    (pending & SDMMC_INT_VOLT_SWITCH)) {
+			del_timer(&host->cmd11_timer);
+
 			mci_writel(host, RINTSTS, SDMMC_INT_VOLT_SWITCH);
 			pending &= ~SDMMC_INT_VOLT_SWITCH;
 			dw_mci_cmd_interrupt(host, pending);
@@ -2571,6 +2582,18 @@ ciu_out:
 	return ret;
 }
 
+static void dw_mci_cmd11_timer(unsigned long arg)
+{
+	struct dw_mci *host = (struct dw_mci *)arg;
+
+	if (host->state != STATE_SENDING_CMD11)
+		dev_info(host->dev, "Unexpected CMD11 timeout\n");
+
+	host->cmd_status = SDMMC_INT_RTO;
+	set_bit(EVENT_CMD_COMPLETE, &host->pending_events);
+	tasklet_schedule(&host->tasklet);
+}
+
 #ifdef CONFIG_OF
 static struct dw_mci_of_quirks {
 	char *quirk;
@@ -2745,6 +2768,9 @@ int dw_mci_probe(struct dw_mci *host)
 		}
 	}
 
+	setup_timer(&host->cmd11_timer,
+		    dw_mci_cmd11_timer, (unsigned long)host);
+
 	host->quirks = host->pdata->quirks;
 
 	spin_lock_init(&host->lock);
diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index 471fb31..9efc567 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -202,6 +202,8 @@ struct dw_mci {
 	int			irq;
 
 	int			sdio_id0;
+
+	struct timer_list       cmd11_timer;
 };
 
 /* DMA ops for Internal/External DMAC interface */
-- 
2.2.0.rc0.207.ga3a616c

