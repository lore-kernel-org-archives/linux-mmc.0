Return-Path: <SRS0=9I0v=2H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60AE5C43603
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Dec 2019 02:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31CE224655
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Dec 2019 02:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="hJRykcJ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfLQCwy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Dec 2019 21:52:54 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:61772 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727106AbfLQCwt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Dec 2019 21:52:49 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576551169; h=References: In-Reply-To: References:
 In-Reply-To: Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=5VMsqS8lIHVcSH7kLp2T46tPeWOdiEfYDpNCPsaN/uQ=; b=hJRykcJ3TKa7pljl+eU6X/X57WD+EsNgMDfyE3iDZceb7sg6yIRydMHyE8i8jlCbYDeW8bq6
 BK7wjkGCbWYh1iEd+WmhRtWmLtOTOVdMyjSqmwNuMNOmB5P2B+CjrcC5DOc88/Fjx5CkOK7T
 4ff4TXkOmo9s8CY6gx9HvRnv2oc=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyJiYTcxMiIsICJsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5df842ff.7f896be25030-smtp-out-n03;
 Tue, 17 Dec 2019 02:52:47 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B71D2C447A0; Tue, 17 Dec 2019 02:52:47 +0000 (UTC)
Received: from pacamara-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: nguyenb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 773F6C4479C;
        Tue, 17 Dec 2019 02:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 773F6C4479C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=nguyenb@codeaurora.org
From:   "Bao D. Nguyen" <nguyenb@codeaurora.org>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        asutoshd@codeaurora.org, cang@codeaurora.org,
        "Bao D. Nguyen" <nguyenb@quicinc.com>,
        "Bao D. Nguyen" <nguyenb@codeaurora.org>
Subject: [<PATCH v1> 9/9] mmc: sd: Fix trivial SD card issues
Date:   Mon, 16 Dec 2019 18:50:42 -0800
Message-Id: <25f3b41fb4950cad5cf075b245d0ac4010cd1aac.1576540908.git.nguyenb@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1576540906.git.nguyenb@codeaurora.org>
References: <cover.1576540906.git.nguyenb@codeaurora.org>
In-Reply-To: <cover.1576540906.git.nguyenb@codeaurora.org>
References: <cover.1576540906.git.nguyenb@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: "Bao D. Nguyen" <nguyenb@quicinc.com>

Fix various trivial SD card issues.

Signed-off-by: Bao D. Nguyen <nguyenb@codeaurora.org>
---
 drivers/mmc/core/block.c |  4 ++--
 drivers/mmc/core/bus.c   | 13 +++++++++++++
 drivers/mmc/core/core.c  | 13 ++++++++-----
 drivers/mmc/core/sd.c    |  9 ++++++---
 4 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 95b41c0..200882d 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -653,13 +653,13 @@ static int mmc_blk_ioctl_cmd(struct mmc_blk_data *md,
 	struct request *req;
 
 	idata = mmc_blk_ioctl_copy_from_user(ic_ptr);
-	if (IS_ERR(idata))
+	if (IS_ERR_OR_NULL(idata))
 		return PTR_ERR(idata);
 	/* This will be NULL on non-RPMB ioctl():s */
 	idata->rpmb = rpmb;
 
 	card = md->queue.card;
-	if (IS_ERR(card)) {
+	if (IS_ERR_OR_NULL(card)) {
 		err = PTR_ERR(card);
 		goto cmd_done;
 	}
diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 74de3f2..fb17d21 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -131,6 +131,16 @@ static void mmc_bus_shutdown(struct device *dev)
 	struct mmc_host *host = card->host;
 	int ret;
 
+	if (!drv) {
+		pr_debug("%s: %s: drv is NULL\n", dev_name(dev), __func__);
+		return;
+	}
+
+	if (!card) {
+		pr_debug("%s: %s: card is NULL\n", dev_name(dev), __func__);
+		return;
+	}
+
 	if (dev->driver && drv->shutdown)
 		drv->shutdown(card);
 
@@ -247,12 +257,15 @@ void mmc_unregister_driver(struct mmc_driver *drv)
 static void mmc_release_card(struct device *dev)
 {
 	struct mmc_card *card = mmc_dev_to_card(dev);
+	struct mmc_host *host = card->host;
 
 	sdio_free_common_cis(card);
 
 	kfree(card->info);
 
 	kfree(card);
+	if (host)
+		host->card = NULL;
 }
 
 /*
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 38b0cec..13d496e 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -399,7 +399,7 @@ void mmc_wait_for_req_done(struct mmc_host *host, struct mmc_request *mrq)
 	struct mmc_command *cmd;
 
 	while (1) {
-		wait_for_completion(&mrq->completion);
+		wait_for_completion_io(&mrq->completion);
 
 		cmd = mrq->cmd;
 
@@ -666,6 +666,10 @@ void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card)
 {
 	unsigned int mult;
 
+	if (!card) {
+		WARN_ON(1);
+		return;
+	}
 	/*
 	 * SDIO cards only define an upper 1 s limit on access.
 	 */
@@ -2341,17 +2345,16 @@ void mmc_rescan(struct work_struct *work)
 
 void mmc_start_host(struct mmc_host *host)
 {
+	mmc_claim_host(host);
 	host->f_init = max(freqs[0], host->f_min);
 	host->rescan_disable = 0;
 	host->ios.power_mode = MMC_POWER_UNDEFINED;
 
-	if (!(host->caps2 & MMC_CAP2_NO_PRESCAN_POWERUP)) {
-		mmc_claim_host(host);
+	if (!(host->caps2 & MMC_CAP2_NO_PRESCAN_POWERUP))
 		mmc_power_up(host, host->ocr_avail);
-		mmc_release_host(host);
-	}
 
 	mmc_gpiod_request_cd_irq(host);
+	mmc_release_host(host);
 	_mmc_detect_change(host, 0, false);
 }
 
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 5938caf..e163f0e 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -989,6 +989,7 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 		err = mmc_send_relative_addr(host, &card->rca);
 		if (err)
 			goto free_card;
+		host->card = card;
 	}
 
 	if (!oldcard) {
@@ -1090,13 +1091,13 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 		goto free_card;
 	}
 done:
-	host->card = card;
 	return 0;
 
 free_card:
-	if (!oldcard)
+	if (!oldcard) {
+		host->card = NULL;
 		mmc_remove_card(card);
-
+	}
 	return err;
 }
 
@@ -1106,7 +1107,9 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 static void mmc_sd_remove(struct mmc_host *host)
 {
 	mmc_remove_card(host->card);
+	mmc_claim_host(host);
 	host->card = NULL;
+	mmc_release_host(host);
 }
 
 /*
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
