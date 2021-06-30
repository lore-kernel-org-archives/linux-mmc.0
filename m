Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A754C11F65
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Jun 2021 10:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE9A161992
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Jun 2021 10:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbhF3KZU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 30 Jun 2021 06:25:20 -0400
Received: from smtp2.axis.com ([195.60.68.18]:31681 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234209AbhF3KZU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 30 Jun 2021 06:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1625048571;
  x=1656584571;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=r+PAHq9b15OpC5PSuLfcuvp7oa6WZJSPUuMIZDnoA4s=;
  b=Lc+xehf/NLNqdWIsbc6ugCEO1YRv4/E9ALyEptjxugCtAz7b0UXU3T5N
   kYBu1pL93vA9wsLw0Vy2OfSj/ubHNaW2oGg6LwZ3S0jAOEYHIdspEwph2
   fAwSkdcJLxHp0ZDYnCurYwx4XgfJAOy4BIH4MLcpB1V9q6a9vBTpJ4Ykw
   ujneFk2+lzmeKc6p7BVE5+A+qmLFEjme7MN7Qx7f4QVT3HDaQK5vXKbOq
   XYPzdOYAQnBmDw9yRsPk2/9wDy1AJ3PzkgtOGM3q3nyaxktryYCOv+xcl
   ArOBjBt/vuIHNiQpy9Ig8PHYUh5gDgwaETKBJqzTLUEAACWjrtScqo43p
   w==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mmc: dw_mmc: Add data CRC error injection
Date:   Wed, 30 Jun 2021 12:22:43 +0200
Message-ID: <20210630102243.17096-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This driver has issues when handling data CRC errors.  Add fault
injection support so that the handling can be easily triggered and
regression-tested.  A hrtimer is used to indicate a data CRC errors at
various points during the data transfer.

Note that for the recent problem with hangs in the case of some data CRC
errors, a udelay(10) inserted at the start of send_stop_abort() greatly
helped in triggering the error, but I've not included this as part of
the fault injection support since it seemed too specific.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/mmc/host/dw_mmc.c | 71 +++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/dw_mmc.h |  5 +++
 2 files changed, 76 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index d333130d1531..f85271f5c4fa 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -181,6 +181,9 @@ static void dw_mci_init_debugfs(struct dw_mci_slot *slot)
 			   &host->pending_events);
 	debugfs_create_xul("completed_events", S_IRUSR, root,
 			   &host->completed_events);
+#ifdef CONFIG_FAULT_INJECTION
+	fault_create_debugfs_attr("fail_data_crc", root, &host->fail_data_crc);
+#endif
 }
 #endif /* defined(CONFIG_DEBUG_FS) */
 
@@ -1788,6 +1791,68 @@ static const struct mmc_host_ops dw_mci_ops = {
 	.prepare_hs400_tuning	= dw_mci_prepare_hs400_tuning,
 };
 
+#ifdef CONFIG_FAULT_INJECTION
+static enum hrtimer_restart dw_mci_fault_timer(struct hrtimer *t)
+{
+	struct dw_mci *host = container_of(t, struct dw_mci, fault_timer);
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->irq_lock, flags);
+
+	if (!host->data_status)
+		host->data_status = SDMMC_INT_DCRC;
+	set_bit(EVENT_DATA_ERROR, &host->pending_events);
+	tasklet_schedule(&host->tasklet);
+
+	spin_unlock_irqrestore(&host->irq_lock, flags);
+
+	return HRTIMER_NORESTART;
+}
+
+static void dw_mci_start_fault_timer(struct dw_mci *host)
+{
+	struct mmc_data *data = host->data;
+
+	if (!data || data->blocks <= 1)
+		return;
+
+	if (!should_fail(&host->fail_data_crc, 1))
+		return;
+
+	/*
+	 * Try to inject the error at random points during the data transfer.
+	 */
+	hrtimer_start(&host->fault_timer,
+		      ms_to_ktime(prandom_u32() % 25),
+		      HRTIMER_MODE_REL);
+}
+
+static void dw_mci_stop_fault_timer(struct dw_mci *host)
+{
+	hrtimer_cancel(&host->fault_timer);
+}
+
+static void dw_mci_init_fault(struct dw_mci *host)
+{
+	host->fail_data_crc = (struct fault_attr) FAULT_ATTR_INITIALIZER;
+
+	hrtimer_init(&host->fault_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	host->fault_timer.function = dw_mci_fault_timer;
+}
+#else
+static void dw_mci_init_fault(struct dw_mci *host)
+{
+}
+
+static void dw_mci_start_fault_timer(struct dw_mci *host)
+{
+}
+
+static void dw_mci_stop_fault_timer(struct dw_mci *host)
+{
+}
+#endif
+
 static void dw_mci_request_end(struct dw_mci *host, struct mmc_request *mrq)
 	__releases(&host->lock)
 	__acquires(&host->lock)
@@ -2102,6 +2167,7 @@ static void dw_mci_tasklet_func(struct tasklet_struct *t)
 				break;
 			}
 
+			dw_mci_stop_fault_timer(host);
 			host->data = NULL;
 			set_bit(EVENT_DATA_COMPLETE, &host->completed_events);
 			err = dw_mci_data_complete(host, data);
@@ -2151,6 +2217,7 @@ static void dw_mci_tasklet_func(struct tasklet_struct *t)
 			if (mrq->cmd->error && mrq->data)
 				dw_mci_reset(host);
 
+			dw_mci_stop_fault_timer(host);
 			host->cmd = NULL;
 			host->data = NULL;
 
@@ -2600,6 +2667,8 @@ static void dw_mci_cmd_interrupt(struct dw_mci *host, u32 status)
 
 	set_bit(EVENT_CMD_COMPLETE, &host->pending_events);
 	tasklet_schedule(&host->tasklet);
+
+	dw_mci_start_fault_timer(host);
 }
 
 static void dw_mci_handle_cd(struct dw_mci *host)
@@ -3223,6 +3292,8 @@ int dw_mci_probe(struct dw_mci *host)
 	spin_lock_init(&host->irq_lock);
 	INIT_LIST_HEAD(&host->queue);
 
+	dw_mci_init_fault(host);
+
 	/*
 	 * Get the host data width - this assumes that HCON has been set with
 	 * the correct values.
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index da5923a92e60..4eb9c5b6c017 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -230,6 +230,11 @@ struct dw_mci {
 	struct timer_list       cmd11_timer;
 	struct timer_list       cto_timer;
 	struct timer_list       dto_timer;
+
+#ifdef CONFIG_FAULT_INJECTION
+	struct fault_attr	fail_data_crc;
+	struct hrtimer		fault_timer;
+#endif
 };
 
 /* DMA ops for Internal/External DMAC interface */
-- 
2.28.0

