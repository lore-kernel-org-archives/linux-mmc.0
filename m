Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C489CC11F68
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Jul 2021 13:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEE1561432
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Jul 2021 13:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbhGBNpZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 2 Jul 2021 09:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbhGBNpX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Jul 2021 09:45:23 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEEDC061764
        for <linux-mmc@vger.kernel.org>; Fri,  2 Jul 2021 06:42:51 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id f13so13335888ljp.10
        for <linux-mmc@vger.kernel.org>; Fri, 02 Jul 2021 06:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u3UbKE7Xbmdhqfi5jFjBOgqg0YH0MVXVTmeGRno/rGo=;
        b=nonR9oDGaUwZHLxPGUO7VPq0gAx71iFtzBCyEZsdo3PrQtXmxWmG9N4RTL1CD/cBas
         24G0m29y4NqNUazzcpH2laPVeSh1Sq/NfSb9wwCiGipk7ks2T1AuuGWWlU3dY6m1yXS9
         blwO9jElKTaFJ9SrBpB128eH4DdDxvbWeiDDROczpYjD786sVmpf0siLwxKqe81ev6H4
         0hsT5q0aUPoHvt8LZrl/S37S2UtZEW3wGgDG4nprj4yAbuClr6rxaQDbWglOjOwT1tKe
         Lp+RfozgL8cenqU8kt01Njmgv0k9yLj4R4kESzx/8LCs3O0XHjsAznhODDHyKQpLM+yn
         tfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u3UbKE7Xbmdhqfi5jFjBOgqg0YH0MVXVTmeGRno/rGo=;
        b=WIocF4VCq6bhVp9ai5WuGnUdS6Tuza3GNNCM5BOBqEtf3HG3Dj6xl+RO9CR0hFeNtO
         IkpW/QXcho/5cY1WPXqznb05lGrYfU8ogaBOvscZesFcZt6cZvjC2sDsp3+Qc4ATCGes
         Z8a3/+4tZkirlcKAE/9K+4wtRHlQ+FNEeUVevUaSPuvFLhIBnQLNT/I7dzoIrHSMZQuT
         VD8hYWZsE8D9fSVEeoiegy/oSK7symW1csijkNyyuXN1Pt0RnGC0cLLYbe+rEbpn7TWZ
         CLlwqH9j7lWbcOav7G+EHo4OWP9Xy5K5aZsGtKoKToI0iRcuFI27AOsislnDQutfQP0Y
         NOeQ==
X-Gm-Message-State: AOAM532IxSI3+mKQX8wD7sBaxzb8TTCSH3QWbZTKZpXhu1M0RA+imXpL
        jEr2DDFl7J4U6LK3Dh5L8VJolrNNPJmXpiXj
X-Google-Smtp-Source: ABdhPJyQXgCSbpp5kouEiFuJMVySK7ItUJ3kUJyLaC/nXtWIYudghZPPUp+yZp0lFiEVA6bd8/4ePg==
X-Received: by 2002:a2e:a4ae:: with SMTP id g14mr4057839ljm.354.1625233368740;
        Fri, 02 Jul 2021 06:42:48 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id u5sm277486lfg.268.2021.07.02.06.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 06:42:47 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Christian Lohle <CLoehle@hyperstone.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] mmc: core: Avoid hogging the CPU while polling for busy after I/O writes
Date:   Fri,  2 Jul 2021 15:42:29 +0200
Message-Id: <20210702134229.357717-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210702134229.357717-1-ulf.hansson@linaro.org>
References: <20210702134229.357717-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

When mmc_blk_card_busy() calls card_busy_detect() to poll for the card's
state with CMD13, this is done without any delays in between the commands
being sent.

Rather than fixing card_busy_detect() in this regards, let's instead
convert into using the common __mmc_poll_for_busy(), which also helps us to
avoid open-coding.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/block.c   | 69 ++++++++++++++++----------------------
 drivers/mmc/core/mmc_ops.c |  1 +
 2 files changed, 30 insertions(+), 40 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 0f9044cf3aab..c692f2af77f2 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -97,6 +97,11 @@ static int max_devices;
 static DEFINE_IDA(mmc_blk_ida);
 static DEFINE_IDA(mmc_rpmb_ida);
 
+struct mmc_blk_busy_data {
+	struct mmc_card *card;
+	u32 status;
+};
+
 /*
  * There is one mmc_blk_data per slot.
  */
@@ -411,42 +416,6 @@ static int mmc_blk_ioctl_copy_to_user(struct mmc_ioc_cmd __user *ic_ptr,
 	return 0;
 }
 
-static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
-			    u32 *resp_errs)
-{
-	unsigned long timeout = jiffies + msecs_to_jiffies(timeout_ms);
-	int err = 0;
-	u32 status;
-
-	do {
-		bool done = time_after(jiffies, timeout);
-
-		err = __mmc_send_status(card, &status, 5);
-		if (err) {
-			dev_err(mmc_dev(card->host),
-				"error %d requesting status\n", err);
-			return err;
-		}
-
-		/* Accumulate any response error bits seen */
-		if (resp_errs)
-			*resp_errs |= status;
-
-		/*
-		 * Timeout if the device never becomes ready for data and never
-		 * leaves the program state.
-		 */
-		if (done) {
-			dev_err(mmc_dev(card->host),
-				"Card stuck in wrong state! %s status: %#x\n",
-				 __func__, status);
-			return -ETIMEDOUT;
-		}
-	} while (!mmc_ready_for_data(status));
-
-	return err;
-}
-
 static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 			       struct mmc_blk_ioc_data *idata)
 {
@@ -1846,28 +1815,48 @@ static inline bool mmc_blk_rq_error(struct mmc_blk_request *brq)
 	       brq->data.error || brq->cmd.resp[0] & CMD_ERRORS;
 }
 
+static int mmc_blk_busy_cb(void *cb_data, bool *busy)
+{
+	struct mmc_blk_busy_data *data = cb_data;
+	u32 status = 0;
+	int err;
+
+	err = mmc_send_status(data->card, &status);
+	if (err)
+		return err;
+
+	/* Accumulate response error bits. */
+	data->status |= status;
+
+	*busy = !mmc_ready_for_data(status);
+	return 0;
+}
+
 static int mmc_blk_card_busy(struct mmc_card *card, struct request *req)
 {
 	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
-	u32 status = 0;
+	struct mmc_blk_busy_data cb_data;
 	int err;
 
 	if (mmc_host_is_spi(card->host) || rq_data_dir(req) == READ)
 		return 0;
 
-	err = card_busy_detect(card, MMC_BLK_TIMEOUT_MS, &status);
+	cb_data.card = card;
+	cb_data.status = 0;
+	err = __mmc_poll_for_busy(card, MMC_BLK_TIMEOUT_MS, &mmc_blk_busy_cb,
+				  &cb_data);
 
 	/*
 	 * Do not assume data transferred correctly if there are any error bits
 	 * set.
 	 */
-	if (status & mmc_blk_stop_err_bits(&mqrq->brq)) {
+	if (cb_data.status & mmc_blk_stop_err_bits(&mqrq->brq)) {
 		mqrq->brq.data.bytes_xfered = 0;
 		err = err ? err : -EIO;
 	}
 
 	/* Copy the exception bit so it will be seen later on */
-	if (mmc_card_mmc(card) && status & R1_EXCEPTION_EVENT)
+	if (mmc_card_mmc(card) && cb_data.status & R1_EXCEPTION_EVENT)
 		mqrq->brq.cmd.resp[0] |= R1_EXCEPTION_EVENT;
 
 	return err;
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index e2c431c0ce5d..90d213a2203f 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -510,6 +510,7 @@ int __mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(__mmc_poll_for_busy);
 
 int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
 		      bool retry_crc_err, enum mmc_busy_cmd busy_cmd)
-- 
2.25.1

