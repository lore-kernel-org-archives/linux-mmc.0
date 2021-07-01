Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A22C11F64
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Jul 2021 08:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46B456148E
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Jul 2021 08:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbhGAIIJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 1 Jul 2021 04:08:09 -0400
Received: from smtp1.axis.com ([195.60.68.17]:37090 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234833AbhGAIIJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 1 Jul 2021 04:08:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1625126739;
  x=1656662739;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=b6eCm58koRg2hleF5/VCtCv9ol4aOKs+jQNpqEcbUro=;
  b=nllmc62HzJuZfl2rPt0+SArbeY+FLIEIpMbrj3nEihtYfLuDa/D14E7t
   n2khWFzFwY7JbcDEYdYOAb55r16QYdo6Kha28EKnleGrSRnzTJN7YdKWi
   xyt/niXvJHf1ZD6Y2LfkDPeXg81sWTX8fKta77DdhjOrCVNO0EaeNVihz
   9DdZDuPiRBkpj2XRR19kWLdfVhplvkKtAna4Wn/rzMB8q08gm8oBz6Y7H
   ukXXXAkOaqAkruy/tyywi/1zAbbyddu8HQkFo0ZcgD0LlhkB3bQBvhtli
   c8DqNKauUyuxKIthJvaMItJ2LRDKOFfLMsMD4WpPcZiXHE2nHxrQggweC
   A==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] mmc: dw_mmc: Add data CRC error injection
Date:   Thu, 1 Jul 2021 10:05:34 +0200
Message-ID: <20210701080534.23138-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This driver has had problems when handling data errors.  Add fault
injection support so that the abort handling can be easily triggered and
regression-tested.  A hrtimer is used to indicate a data CRC error at
various points during the data transfer.

Note that for the recent problem with hangs in the case of some data CRC
errors, a udelay(10) inserted at the start of send_stop_abort() greatly
helped in triggering the error, but I've not included this as part of
the fault injection support since it seemed too specific.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---

Notes:
    v2: Add missing includes.

 drivers/mmc/host/dw_mmc.c | 73 +++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/dw_mmc.h |  7 ++++
 2 files changed, 80 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index d333130d1531..dbbb94e6ff4b 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -17,9 +17,11 @@
 #include <linux/interrupt.h>
 #include <linux/iopoll.h>
 #include <linux/ioport.h>
+#include <linux/ktime.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/prandom.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/stat.h>
@@ -181,6 +183,9 @@ static void dw_mci_init_debugfs(struct dw_mci_slot *slot)
 			   &host->pending_events);
 	debugfs_create_xul("completed_events", S_IRUSR, root,
 			   &host->completed_events);
+#ifdef CONFIG_FAULT_INJECTION
+	fault_create_debugfs_attr("fail_data_crc", root, &host->fail_data_crc);
+#endif
 }
 #endif /* defined(CONFIG_DEBUG_FS) */
 
@@ -1788,6 +1793,68 @@ static const struct mmc_host_ops dw_mci_ops = {
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
@@ -2102,6 +2169,7 @@ static void dw_mci_tasklet_func(struct tasklet_struct *t)
 				break;
 			}
 
+			dw_mci_stop_fault_timer(host);
 			host->data = NULL;
 			set_bit(EVENT_DATA_COMPLETE, &host->completed_events);
 			err = dw_mci_data_complete(host, data);
@@ -2151,6 +2219,7 @@ static void dw_mci_tasklet_func(struct tasklet_struct *t)
 			if (mrq->cmd->error && mrq->data)
 				dw_mci_reset(host);
 
+			dw_mci_stop_fault_timer(host);
 			host->cmd = NULL;
 			host->data = NULL;
 
@@ -2600,6 +2669,8 @@ static void dw_mci_cmd_interrupt(struct dw_mci *host, u32 status)
 
 	set_bit(EVENT_CMD_COMPLETE, &host->pending_events);
 	tasklet_schedule(&host->tasklet);
+
+	dw_mci_start_fault_timer(host);
 }
 
 static void dw_mci_handle_cd(struct dw_mci *host)
@@ -3223,6 +3294,8 @@ int dw_mci_probe(struct dw_mci *host)
 	spin_lock_init(&host->irq_lock);
 	INIT_LIST_HEAD(&host->queue);
 
+	dw_mci_init_fault(host);
+
 	/*
 	 * Get the host data width - this assumes that HCON has been set with
 	 * the correct values.
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index da5923a92e60..ce05d81477d9 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -14,6 +14,8 @@
 #include <linux/mmc/core.h>
 #include <linux/dmaengine.h>
 #include <linux/reset.h>
+#include <linux/fault-inject.h>
+#include <linux/hrtimer.h>
 #include <linux/interrupt.h>
 
 enum dw_mci_state {
@@ -230,6 +232,11 @@ struct dw_mci {
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

