Return-Path: <SRS0=yZYV=3L=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DC3C2D0DB
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Jan 2020 14:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96545217F4
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Jan 2020 14:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rSQaUcuD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgAVO15 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 22 Jan 2020 09:27:57 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:32843 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgAVO15 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Jan 2020 09:27:57 -0500
Received: by mail-lf1-f65.google.com with SMTP id n25so5508039lfl.0
        for <linux-mmc@vger.kernel.org>; Wed, 22 Jan 2020 06:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u69ihC/ZR+aWt0/0qdjrRugRF6Lbl1PlbpQFAVv2gC4=;
        b=rSQaUcuD9WYbFQDeILVt5uWXtC+pYCIbQTmp8rklMfgzJezqUvAmNBdusbpnMXhL9n
         EWdrbS4rvBkTSapeIsyu6TY4ZmacFWWuGPEWrpaQTwPAKX2Sqe269HU4+Jl70y+3X1hD
         ytum1u2/qb0DM+2gOimtRxoh77QvmIff2kDFsmq40gTjrpTP79wdEsPlgcBm7IJZ/tP/
         pTUtKAygC7lkiDa7E26/4dfUeIyy5qfb9hIScBc1pTyO4yBj24yf/P1Ecre1MjRd080Q
         piTBfKDeS9NIHq5QsbjdBIOYJFOwdn9cZMjUNqznQZBfxOdYBh6jjTsWajrtcjUNlHm1
         3SIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u69ihC/ZR+aWt0/0qdjrRugRF6Lbl1PlbpQFAVv2gC4=;
        b=c7VDGv9AqCQyWbRxVhxrkoU0GthqLf/C/0Xo0VvFt2dk2VTmiei1WA8a776LnXwyrF
         521WS/6byfSmG4ENR4lrCWfzdNlchS8GhSjNZ5agEE7Ms6FA0zNLjd00aNunskaILnpN
         Xh61gZtD28XNJV2IZcjokshTAb6/JS/ByDqB+EUpaZDA9eRFTQeVw1S/oTIXn4NKs1/4
         DcyHIPD110kFfFsQIP7IU1BoPeXwd3kTNA5qXjIrvZmSk6Mh5vWrUTJ7vv4I3/rAnEJo
         YC0aqP8udrZUVvs311ZT7H8ECME9ybCsUFGsdpyCKtf6q7hfqtd4uMFhxUTX031HJe3B
         2+Ig==
X-Gm-Message-State: APjAAAWQY1lW4+9+4BXFmqhkUVnavAAW941WLi9ll3/6GiLQkhWuthuv
        OtOtCrSeUM9r6umOZmLXV3PSXHQPdfE=
X-Google-Smtp-Source: APXvYqz3doFCmwXxXT6oY4So5XrFSZ4pwNSnSrhsOXkF8afaGw1nGLZtjWtykC5JK4h3PWjzgjy1Bg==
X-Received: by 2002:a19:c697:: with SMTP id w145mr1978294lff.54.1579703274214;
        Wed, 22 Jan 2020 06:27:54 -0800 (PST)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id u17sm20369548ljk.62.2020.01.22.06.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 06:27:52 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Shawn Lin <shawn.lin@rock-chips.com>, mirq-linux@rere.qmqm.pl
Subject: [PATCH 1/3] mmc: core: Specify timeouts for BKOPS and CACHE_FLUSH for eMMC
Date:   Wed, 22 Jan 2020 15:27:45 +0100
Message-Id: <20200122142747.5690-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200122142747.5690-1-ulf.hansson@linaro.org>
References: <20200122142747.5690-1-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The timeout values used while waiting for a CMD6 for BKOPS or a CACHE_FLUSH
to complete, are not defined by the eMMC spec. However, a timeout of 10
minutes as is currently being used, is just silly for both of these cases.
Instead, let's specify more reasonable timeouts, 120s for BKOPS and 30s for
CACHE_FLUSH.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc_ops.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 09113b9ad679..1966abcbc7c0 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -19,7 +19,9 @@
 #include "host.h"
 #include "mmc_ops.h"
 
-#define MMC_OPS_TIMEOUT_MS	(10 * 60 * 1000) /* 10 minute timeout */
+#define MMC_OPS_TIMEOUT_MS		(10 * 60 * 1000) /* 10min*/
+#define MMC_BKOPS_TIMEOUT_MS		(120 * 1000) /* 120s */
+#define MMC_CACHE_FLUSH_TIMEOUT_MS	(30 * 1000) /* 30s */
 
 static const u8 tuning_blk_pattern_4bit[] = {
 	0xff, 0x0f, 0xff, 0x00, 0xff, 0xcc, 0xc3, 0xcc,
@@ -941,7 +943,7 @@ void mmc_run_bkops(struct mmc_card *card)
 	 * urgent levels by using an asynchronous background task, when idle.
 	 */
 	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-			EXT_CSD_BKOPS_START, 1, MMC_OPS_TIMEOUT_MS);
+			 EXT_CSD_BKOPS_START, 1, MMC_BKOPS_TIMEOUT_MS);
 	if (err)
 		pr_warn("%s: Error %d starting bkops\n",
 			mmc_hostname(card->host), err);
@@ -961,7 +963,8 @@ int mmc_flush_cache(struct mmc_card *card)
 			(card->ext_csd.cache_size > 0) &&
 			(card->ext_csd.cache_ctrl & 1)) {
 		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-				EXT_CSD_FLUSH_CACHE, 1, 0);
+				 EXT_CSD_FLUSH_CACHE, 1,
+				 MMC_CACHE_FLUSH_TIMEOUT_MS);
 		if (err)
 			pr_err("%s: cache flush error %d\n",
 					mmc_hostname(card->host), err);
-- 
2.17.1

