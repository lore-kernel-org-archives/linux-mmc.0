Return-Path: <SRS0=yZYV=3L=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E97C2D0DB
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Jan 2020 14:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A7C4217F4
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Jan 2020 14:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vCzxjkQf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgAVO2B (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 22 Jan 2020 09:28:01 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40231 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgAVO2B (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Jan 2020 09:28:01 -0500
Received: by mail-lj1-f193.google.com with SMTP id n18so2082111ljo.7
        for <linux-mmc@vger.kernel.org>; Wed, 22 Jan 2020 06:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iKMQyjxDBSc+wBx/1iQ6rTe3TF9m2VraA2r1zuub9Cs=;
        b=vCzxjkQf0eK5+n0Yvb5KS7tvQbyS0L/N38j8D0PSCIDPwdO86O32qKyP4tUM4P9pnZ
         +aOVG9nuZ/6L7VtsQZy+tmm2Lox8pRDM/dDSAC2E5Ec8ZFmWv6qRPl4qSmCNwxsSexx9
         bHOT8t2IGpONPwgQA7O5HKltTsCQqwWfiXxEbxtnFyIDtMyb5jo9R2l3Or9XRxJ0tT7f
         PqwQwKDdfHILGdqZCKCPXB3M4OZw8/6N4eSSChyUYb5/WxKgqtiGgkJ5FXzS3b5yVXrq
         PvCFra1M2SvO0fXcov+J26WVwDJ0XOBd+xS941oR8CbAgixDFB1zRHh0fQw+OkTYsO9e
         WSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iKMQyjxDBSc+wBx/1iQ6rTe3TF9m2VraA2r1zuub9Cs=;
        b=cVTDl7PTIt26+Am1mfIZ/ZiCpGM8ZQPMFg61ul0YLniugVyc8DGJad0ov+HHEfpm3T
         geQktsg6Sk9kJtWg2u4wKjobjf+RQFI9ZoVEWbHCuGFpmHWSXvhFF3X6wIvrZi+t8Mwu
         0HcFhNfS0JPUrWVcwJzR9yMGpuX3w3s78mnyQU04enmbWqZeU/VzfLTH8N4/hsRmucPC
         /QlGc3dDy4rmqO56OTPBDcnwmO/4rn6VAri6GAafza/g40bHTRWT9k/WxCk/ZOyV9c1A
         MMBjj6lamp2yMxnknxZn+4RFUjsc9NeYHdPhsk1cnYJqFnPKFFjDJHbwxwpiA5hmQ/b2
         akoQ==
X-Gm-Message-State: APjAAAXTAQHPSEjoUZ9pnpUixPYvBKDcFwmVrje/O9F06Jqjp8FmAzt7
        /PBziMKa1MCRxwroxvC1FG02LYbxSuM=
X-Google-Smtp-Source: APXvYqzJCmDh7AiySbGBM04U1xsULqeJFagf/nw765013LXaioofEr0/Si6wGBu+aBJy0uaZxItlUg==
X-Received: by 2002:a05:651c:1110:: with SMTP id d16mr19627966ljo.86.1579703278423;
        Wed, 22 Jan 2020 06:27:58 -0800 (PST)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id u17sm20369548ljk.62.2020.01.22.06.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 06:27:57 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Shawn Lin <shawn.lin@rock-chips.com>, mirq-linux@rere.qmqm.pl
Subject: [PATCH 3/3] mmc: core: Default to generic_cmd6_time as timeout in __mmc_switch()
Date:   Wed, 22 Jan 2020 15:27:47 +0100
Message-Id: <20200122142747.5690-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200122142747.5690-1-ulf.hansson@linaro.org>
References: <20200122142747.5690-1-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

All callers of __mmc_switch() should now be specifying a valid timeout for
the CMD6 command. However, to sure let's print a warning and default to use
the generic_cmd6_time in case the provided timeout_ms argument is zero.

In this context, let's also simplify some of corresponding code and clarify
some related comments.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc_ops.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 1966abcbc7c0..da425ee2d9bf 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -460,10 +460,6 @@ static int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
 	bool expired = false;
 	bool busy = false;
 
-	/* We have an unspecified cmd timeout, use the fallback value. */
-	if (!timeout_ms)
-		timeout_ms = MMC_OPS_TIMEOUT_MS;
-
 	/*
 	 * In cases when not allowed to poll by using CMD13 or because we aren't
 	 * capable of polling by using ->card_busy(), then rely on waiting the
@@ -536,14 +532,19 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 
 	mmc_retune_hold(host);
 
+	if (!timeout_ms) {
+		pr_warn("%s: unspecified timeout for CMD6 - use generic\n",
+			mmc_hostname(host));
+		timeout_ms = card->ext_csd.generic_cmd6_time;
+	}
+
 	/*
-	 * If the cmd timeout and the max_busy_timeout of the host are both
-	 * specified, let's validate them. A failure means we need to prevent
-	 * the host from doing hw busy detection, which is done by converting
-	 * to a R1 response instead of a R1B.
+	 * If the max_busy_timeout of the host is specified, make sure it's
+	 * enough to fit the used timeout_ms. In case it's not, let's instruct
+	 * the host to avoid HW busy detection, by converting to a R1 response
+	 * instead of a R1B.
 	 */
-	if (timeout_ms && host->max_busy_timeout &&
-		(timeout_ms > host->max_busy_timeout))
+	if (host->max_busy_timeout && (timeout_ms > host->max_busy_timeout))
 		use_r1b_resp = false;
 
 	cmd.opcode = MMC_SWITCH;
@@ -554,10 +555,6 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 	cmd.flags = MMC_CMD_AC;
 	if (use_r1b_resp) {
 		cmd.flags |= MMC_RSP_SPI_R1B | MMC_RSP_R1B;
-		/*
-		 * A busy_timeout of zero means the host can decide to use
-		 * whatever value it finds suitable.
-		 */
 		cmd.busy_timeout = timeout_ms;
 	} else {
 		cmd.flags |= MMC_RSP_SPI_R1 | MMC_RSP_R1;
-- 
2.17.1

