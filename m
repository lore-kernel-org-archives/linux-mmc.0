Return-Path: <SRS0=92ZL=3Y=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CBDC2D0B1
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Feb 2020 08:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D83E21775
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Feb 2020 08:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r5GdvLAX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgBDIz2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 4 Feb 2020 03:55:28 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43913 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgBDIz2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Feb 2020 03:55:28 -0500
Received: by mail-lj1-f196.google.com with SMTP id a13so17650965ljm.10
        for <linux-mmc@vger.kernel.org>; Tue, 04 Feb 2020 00:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KLjqRxjOu37hotK4LZ6sgid1xsi6x3z1IsXdytiYo/0=;
        b=r5GdvLAXN9EdLzVKnNrEIQlTqye2BCI+enOv/sqW+eNnO41xvphgSQ+xKMnCMSRJDM
         /3J0K6p27Ll3Eu3aUjPPf/VMbNgmDsNx9ZNL05Yajs/wGE8i0ITNJnBLrwhrCdq55h1e
         5ScBvEc3pZo1MDGiTa7LYf95U6otdEDxAe8J18l5p0OsB/zfjIsDRVXKO/4/gKHY0ukK
         huGNt/yAFmwIlpf0oCvd++l1p5gWVolqk8ZprpzwKsyw2ptX0AOg77tlMCKpUYQLFrB0
         JgbC7wJW7tkDses99Pig4geGlbqndqEFdmbo4iZQI4j/jS/BJ9G2flz09MNX00lUJIrb
         af4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KLjqRxjOu37hotK4LZ6sgid1xsi6x3z1IsXdytiYo/0=;
        b=j1puiG3YNNADIt/G1ERUv6zUisz4YO0zWiO530U873P0mWJBvh3a3QGDSxvUfzju/t
         4KVUVzNixFpZDvnFEyVqyrpWJu7WgN0xifq1nfBzIKu7b5FCd8A450VXZI/m6C1uhYAy
         J8Tk1o9dORoQ7v9QIZ2BX2Nv1lVZkF3eTkM1Tbyo/AbquoyzbazDLR5AdiKv9OfkWd65
         sAenefjtA/avpe9F+Lypxk3rAHYzKDM+JyhnQIrF0h5Y3kp1uYu9iT/5QOjkUDDyJMQp
         KOAgJTH2XWM8rq1MdH1pqEfi1hFRhJfZTFUCoV7GhdEvIyaKbp7CWTd40tCjz551YHH3
         by5Q==
X-Gm-Message-State: APjAAAXExmcdd9RBUzFkJPr5qkiJHk1NtPy7NQ+hXTRLPIuumPVBpWoN
        GBj0An7QO6bKJcfyiYvDqkwlXNOP62A=
X-Google-Smtp-Source: APXvYqzyE9gMGXnT5ZFghzMWHqfr+J/2GenIi3CD0MpPlBQcqyhts9H7Vi4hlfbeXiaqRqMRpIq2DQ==
X-Received: by 2002:a2e:808a:: with SMTP id i10mr16669196ljg.151.1580806525240;
        Tue, 04 Feb 2020 00:55:25 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id n2sm11156283ljj.1.2020.02.04.00.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 00:55:24 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Shawn Lin <shawn.lin@rock-chips.com>, mirq-linux@rere.qmqm.pl
Subject: [PATCH 12/12] mmc: core: Re-work the error path for the eMMC sanitize command
Date:   Tue,  4 Feb 2020 09:54:49 +0100
Message-Id: <20200204085449.32585-13-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200204085449.32585-1-ulf.hansson@linaro.org>
References: <20200204085449.32585-1-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The error path for sanitize operations that returns with a -ETIMEDOUT error
code, is for some reason very tightly coupled with the internal request
handling code of the mmc core. For example, mmc_wait_for_req_done() runs
code at completion of requests, to check specific sanitize errors. This is
inefficient, as at it affects all types of requests.

To improve the behaviour, let's move the error management for sanitize
requests into ioctl_do_sanitize(), as it's really there it belongs. Moving
the error handling requires retuning to be held, so let's do that.

While updating this code, let's also take the opportunity to clean it up a
bit.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/block.c   | 33 +++++++++++++++++++--------------
 drivers/mmc/core/core.c    | 17 -----------------
 drivers/mmc/core/mmc_ops.c |  3 ---
 include/linux/mmc/core.h   |  3 ---
 4 files changed, 19 insertions(+), 37 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 8ac12e3fff27..db59c51052df 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -410,29 +410,34 @@ static int mmc_blk_ioctl_copy_to_user(struct mmc_ioc_cmd __user *ic_ptr,
 
 static int ioctl_do_sanitize(struct mmc_card *card)
 {
+	struct mmc_host *host = card->host;
 	int err;
 
 	if (!mmc_can_sanitize(card)) {
-			pr_warn("%s: %s - SANITIZE is not supported\n",
-				mmc_hostname(card->host), __func__);
-			err = -EOPNOTSUPP;
-			goto out;
+		pr_warn("%s: SANITIZE is not supported\n", mmc_hostname(host));
+		return -EOPNOTSUPP;
 	}
 
-	pr_debug("%s: %s - SANITIZE IN PROGRESS...\n",
-		mmc_hostname(card->host), __func__);
+	pr_debug("%s: SANITIZE IN PROGRESS...\n", mmc_hostname(host));
 
-	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-					EXT_CSD_SANITIZE_START, 1,
-					MMC_SANITIZE_REQ_TIMEOUT);
+	mmc_retune_hold(host);
 
+	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_SANITIZE_START,
+			 1, MMC_SANITIZE_REQ_TIMEOUT);
 	if (err)
-		pr_err("%s: %s - EXT_CSD_SANITIZE_START failed. err=%d\n",
-		       mmc_hostname(card->host), __func__, err);
+		pr_err("%s: SANITIZE failed err=%d\n", mmc_hostname(host), err);
 
-	pr_debug("%s: %s - SANITIZE COMPLETED\n", mmc_hostname(card->host),
-					     __func__);
-out:
+	/*
+	 * If the santize operation timed out, the card is probably still busy
+	 * in the R1_STATE_PRG. Rather than continue to wait, let's try to abort
+	 * it with a HPI command to get back into R1_STATE_TRAN.
+	 */
+	if (err == -ETIMEDOUT && !mmc_interrupt_hpi(card))
+		pr_warn("%s: Sanitize aborted\n", mmc_hostname(host));
+
+	mmc_retune_release(host);
+
+	pr_debug("%s: SANITIZE COMPLETED\n", mmc_hostname(host));
 	return err;
 }
 
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 6b38c194d74f..95db8ffbdd35 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -403,23 +403,6 @@ void mmc_wait_for_req_done(struct mmc_host *host, struct mmc_request *mrq)
 
 		cmd = mrq->cmd;
 
-		/*
-		 * If host has timed out waiting for the sanitize
-		 * to complete, card might be still in programming state
-		 * so let's try to bring the card out of programming
-		 * state.
-		 */
-		if (cmd->sanitize_busy && cmd->error == -ETIMEDOUT) {
-			if (!mmc_interrupt_hpi(host->card)) {
-				pr_warn("%s: %s: Interrupted sanitize\n",
-					mmc_hostname(host), __func__);
-				cmd->error = 0;
-				break;
-			} else {
-				pr_err("%s: %s: Failed to interrupt sanitize\n",
-				       mmc_hostname(host), __func__);
-			}
-		}
 		if (!cmd->error || !cmd->retries ||
 		    mmc_card_removed(host->card))
 			break;
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index aa0cab190cd8..c08f8b723a3b 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -595,9 +595,6 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		cmd.flags |= MMC_RSP_SPI_R1 | MMC_RSP_R1;
 	}
 
-	if (index == EXT_CSD_SANITIZE_START)
-		cmd.sanitize_busy = true;
-
 	err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
 	if (err)
 		goto out;
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index b7ba8810a3b5..29aa50711626 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -107,9 +107,6 @@ struct mmc_command {
  */
 
 	unsigned int		busy_timeout;	/* busy detect timeout in ms */
-	/* Set this flag only for blocking sanitize request */
-	bool			sanitize_busy;
-
 	struct mmc_data		*data;		/* data segment associated with cmd */
 	struct mmc_request	*mrq;		/* associated request */
 };
-- 
2.17.1

