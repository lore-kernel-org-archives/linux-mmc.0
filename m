Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE9CC432BE
	for <linux-mmc@archiver.kernel.org>; Fri, 27 Aug 2021 08:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6629A60FDA
	for <linux-mmc@archiver.kernel.org>; Fri, 27 Aug 2021 08:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244604AbhH0I5k (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 27 Aug 2021 04:57:40 -0400
Received: from smtp1.axis.com ([195.60.68.17]:22599 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244601AbhH0I5k (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 27 Aug 2021 04:57:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1630054612;
  x=1661590612;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wVWL1w1t4PoKqWdPakWlOklY52sCjhhBMT6cuVIypEw=;
  b=qA6m14npdYFdxj+kjlPluLVVZuhaNAKkx/lIWI+EfPlxltAGZFwErlxZ
   ylqGXecFIozEwfbzEDB/lCXOp0PZr43bI2qfJ9knPIC/7AEog7+1d6/u5
   8PTkVB98Uhm8KpYRC7FugGVbizwEqUCMFZ+hkeO0BdCIHNhkWpjyTQ2bs
   tyYz673ZtXc06kcg4j0RJW6vlAdnbG+M1r3G1e06aQUJOj7RGi9lTDQRq
   9T82O2FPIlFJpVLTSyX/RNSaHFjuPYTQhxG0ix1+xsSxLK8nD263lRXsW
   qpXxoGbEURn7uEjsh9Ic6R93tfLHvXKatbL04KGbl9WMGSHkvtspqgYQg
   Q==;
From:   =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
To:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     <kernel@axis.com>, <linux-mmc@vger.kernel.org>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
Subject: [PATCH] mmc: dw_mmc: Support more time for data read timeouts
Date:   Fri, 27 Aug 2021 10:56:34 +0200
Message-ID: <20210827085634.21225-1-marten.lindahl@axis.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

For data read transfers a data transfer over timer (dto_timer) is
started to make sure the data command can be completed in cases the Data
Transfer Over (DTO) interrupt does not come. This timer was originally
introduced as a quirk in commit 57e104864bc48 ("mmc: dw_mmc: add quirk
for broken data transfer over scheme"), but is since a while back part
of the running code.

The dto timer picks the DATA_TIMEOUT value in the TMOUT register for its
timeout, which will give a max timeout of approximately 84 + (10 spare)
milliseconds on a 200MHz clock. But this register is not intended to be
used like that, since it is a counter for data read timeouts (DRTO) and
response timeouts (RTO), which will result in error interrupts in case
of data read and response delays.

The TMOUT register is always set with a full value for every transfer,
which according to the manual (and with 200MHz clock) will give a full
DRTO of:
((TMOUT[10:8] -1) * 0xFFFFFF + TMOUT[31:11] * 8) / 200000000 => ~587 ms

But as the same register is used for the dto_timer, the dto_timer will
always have a fixed timeout.

Instead of always setting a fixed value in TMOUT register, we can use
data->timeout_ns for the DRTO interrupts that actually matches what was
provided per requested command. Likewise we can also use timeout_ns for
the dto_timer, which will allow a max timeout of 587 ms, instead of the
fixed 94 ms. Furthermore, if a data error interrupt comes, it shouldn't
be necessary to wait for the dto_timer before we finish the command, but
instead we can handle it in the interrupt handler.

Lets fix this. In most cases data->timeout_ns values are given, but in
case it is not given, the maximum (default) timeout for the dto_timer,
and the DRTO, is set to approximately 587 ms.

Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
---
 drivers/mmc/host/dw_mmc.c | 108 ++++++++++++++++++++++----------------
 1 file changed, 63 insertions(+), 45 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index c3229d8c7041..0762d95293d4 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -52,6 +52,7 @@
 
 #define DW_MCI_FREQ_MAX	200000000	/* unit: HZ */
 #define DW_MCI_FREQ_MIN	100000		/* unit: HZ */
+#define DW_MCI_DATA_TMOUT_NS_MAX	587202490
 
 #define IDMAC_INT_CLR		(SDMMC_IDMAC_INT_AI | SDMMC_IDMAC_INT_NI | \
 				 SDMMC_IDMAC_INT_CES | SDMMC_IDMAC_INT_DU | \
@@ -390,6 +391,23 @@ static inline void dw_mci_set_cto(struct dw_mci *host)
 	spin_unlock_irqrestore(&host->irq_lock, irqflags);
 }
 
+static void dw_mci_set_dto(struct dw_mci *host, u32 timeout_ns)
+{
+	unsigned int dto_ns;
+	unsigned long irqflags;
+
+	if (!timeout_ns || timeout_ns > DW_MCI_DATA_TMOUT_NS_MAX)
+		dto_ns = DW_MCI_DATA_TMOUT_NS_MAX;
+	else
+		dto_ns = timeout_ns;
+
+	spin_lock_irqsave(&host->irq_lock, irqflags);
+	if (!test_bit(EVENT_DATA_COMPLETE, &host->pending_events))
+		mod_timer(&host->dto_timer,
+			  jiffies + nsecs_to_jiffies(dto_ns));
+	spin_unlock_irqrestore(&host->irq_lock, irqflags);
+}
+
 static void dw_mci_start_command(struct dw_mci *host,
 				 struct mmc_command *cmd, u32 cmd_flags)
 {
@@ -1144,9 +1162,10 @@ static void dw_mci_submit_data(struct dw_mci *host, struct mmc_data *data)
 	host->sg = NULL;
 	host->data = data;
 
-	if (data->flags & MMC_DATA_READ)
+	if (data->flags & MMC_DATA_READ) {
 		host->dir_status = DW_MCI_RECV_STATUS;
-	else
+		dw_mci_set_dto(host, data->timeout_ns);
+	} else
 		host->dir_status = DW_MCI_SEND_STATUS;
 
 	dw_mci_ctrl_thld(host, data);
@@ -1277,6 +1296,36 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 	mci_writel(host, CTYPE, (slot->ctype << slot->id));
 }
 
+static void dw_mci_set_data_timeout(struct dw_mci *host, u32 timeout_ns)
+{
+	u32 timeout, freq_mhz, tmp, tmout;
+
+	if (!timeout_ns || timeout_ns > DW_MCI_DATA_TMOUT_NS_MAX) {
+		/* Timeout (maximum) */
+		mci_writel(host, TMOUT, 0xFFFFFFFF);
+		return;
+	}
+
+	timeout = timeout_ns / NSEC_PER_USEC;
+	freq_mhz = host->bus_hz / NSEC_PER_MSEC;
+
+	/* TMOUT[7:0] (RESPONSE_TIMEOUT) */
+	tmout = 0xFF;
+
+	/* TMOUT[10:8] (DATA_TIMEOUT) */
+	tmp = ((timeout * freq_mhz) / 0xFFFFFF) + 1;
+	tmout |= (tmp & 0x7) << 8;
+
+	/* TMOUT[31:11] (DATA_TIMEOUT) */
+	tmp = ((tmp - 1) * 0xFFFFFF) / freq_mhz;
+	tmp = (timeout - tmp) * freq_mhz / 8;
+	tmout |= (tmp & 0x1FFFFF) << 11;
+
+	mci_writel(host, TMOUT, tmout);
+	dev_dbg(host->dev, "timeout_ns: %u => TMOUT[31:8]: 0x%08x",
+		timeout_ns, tmout);
+}
+
 static void __dw_mci_start_request(struct dw_mci *host,
 				   struct dw_mci_slot *slot,
 				   struct mmc_command *cmd)
@@ -1297,7 +1346,7 @@ static void __dw_mci_start_request(struct dw_mci *host,
 
 	data = cmd->data;
 	if (data) {
-		mci_writel(host, TMOUT, 0xFFFFFFFF);
+		dw_mci_set_data_timeout(host, data->timeout_ns);
 		mci_writel(host, BYTCNT, data->blksz*data->blocks);
 		mci_writel(host, BLKSIZ, data->blksz);
 	}
@@ -1897,31 +1946,6 @@ static int dw_mci_data_complete(struct dw_mci *host, struct mmc_data *data)
 	return data->error;
 }
 
-static void dw_mci_set_drto(struct dw_mci *host)
-{
-	unsigned int drto_clks;
-	unsigned int drto_div;
-	unsigned int drto_ms;
-	unsigned long irqflags;
-
-	drto_clks = mci_readl(host, TMOUT) >> 8;
-	drto_div = (mci_readl(host, CLKDIV) & 0xff) * 2;
-	if (drto_div == 0)
-		drto_div = 1;
-
-	drto_ms = DIV_ROUND_UP_ULL((u64)MSEC_PER_SEC * drto_clks * drto_div,
-				   host->bus_hz);
-
-	/* add a bit spare time */
-	drto_ms += 10;
-
-	spin_lock_irqsave(&host->irq_lock, irqflags);
-	if (!test_bit(EVENT_DATA_COMPLETE, &host->pending_events))
-		mod_timer(&host->dto_timer,
-			  jiffies + msecs_to_jiffies(drto_ms));
-	spin_unlock_irqrestore(&host->irq_lock, irqflags);
-}
-
 static bool dw_mci_clear_pending_cmd_complete(struct dw_mci *host)
 {
 	if (!test_bit(EVENT_CMD_COMPLETE, &host->pending_events))
@@ -2052,15 +2076,8 @@ static void dw_mci_tasklet_func(struct tasklet_struct *t)
 			}
 
 			if (!test_and_clear_bit(EVENT_XFER_COMPLETE,
-						&host->pending_events)) {
-				/*
-				 * If all data-related interrupts don't come
-				 * within the given time in reading data state.
-				 */
-				if (host->dir_status == DW_MCI_RECV_STATUS)
-					dw_mci_set_drto(host);
+						&host->pending_events))
 				break;
-			}
 
 			set_bit(EVENT_XFER_COMPLETE, &host->completed_events);
 
@@ -2091,16 +2108,8 @@ static void dw_mci_tasklet_func(struct tasklet_struct *t)
 			fallthrough;
 
 		case STATE_DATA_BUSY:
-			if (!dw_mci_clear_pending_data_complete(host)) {
-				/*
-				 * If data error interrupt comes but data over
-				 * interrupt doesn't come within the given time.
-				 * in reading data state.
-				 */
-				if (host->dir_status == DW_MCI_RECV_STATUS)
-					dw_mci_set_drto(host);
+			if (!dw_mci_clear_pending_data_complete(host))
 				break;
-			}
 
 			host->data = NULL;
 			set_bit(EVENT_DATA_COMPLETE, &host->completed_events);
@@ -2649,12 +2658,21 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 		}
 
 		if (pending & DW_MCI_DATA_ERROR_FLAGS) {
+			spin_lock(&host->irq_lock);
+
+			del_timer(&host->dto_timer);
+
 			/* if there is an error report DATA_ERROR */
 			mci_writel(host, RINTSTS, DW_MCI_DATA_ERROR_FLAGS);
 			host->data_status = pending;
 			smp_wmb(); /* drain writebuffer */
 			set_bit(EVENT_DATA_ERROR, &host->pending_events);
+
+			/* In case of error, we cannot expect a DTO */
+			set_bit(EVENT_DATA_COMPLETE, &host->pending_events);
 			tasklet_schedule(&host->tasklet);
+
+			spin_unlock(&host->irq_lock);
 		}
 
 		if (pending & SDMMC_INT_DATA_OVER) {
-- 
2.20.1

