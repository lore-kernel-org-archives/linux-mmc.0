Return-Path: <SRS0=92ZL=3Y=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12ACCC2D0B1
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Feb 2020 08:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8BF72087E
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Feb 2020 08:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ha6oLgAs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgBDIzS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 4 Feb 2020 03:55:18 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40658 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgBDIzS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Feb 2020 03:55:18 -0500
Received: by mail-lj1-f195.google.com with SMTP id n18so17662327ljo.7
        for <linux-mmc@vger.kernel.org>; Tue, 04 Feb 2020 00:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EK9v+jTcdBM1CQqLn/KDsjlxwnI1HlWWrKAGRPO/Vyc=;
        b=ha6oLgAsulQR18W68tnvXp5MLS5yfM9h3Q19tvLAUsoBRkcJHx/JJ/yGhc1wY8PpU8
         wrclzY/BzdTJoWoxXBASOKu4XftVufVPzvBuS1cxTlTytBnhXjcigZ+fx+Z0quSQuAZh
         eNHj6mVVsDRenvF4OL9qvYPxr/yOVynAHJLi5pecRrVSFHepZfCraVjC84CATuohZHeu
         jpj6GfiPP5OfT9n45RaGsGyBoUd20EQ5DfwG52nLPRzQTfUXZftlulNHE8sEHIyXFsIx
         v9lUrPMa9TsWWRVJcBHMNdD+/VHbmgNgEz+8yzvY5DFATcpHsQnggs/lIt4cynhZWXNq
         HHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EK9v+jTcdBM1CQqLn/KDsjlxwnI1HlWWrKAGRPO/Vyc=;
        b=dcEwXWp/QkbLU6OCf9+Zj4MmZr+xKgGZ3svxdpl7JVHGeqIlZJ0jpuHhVgX5L0Oiab
         02EEah6s0DCJHWF038DpdkSNrtFuKwy5VTnD6AY5FtY+rkFwOVDyH1iNmQQFavgdLZeS
         FlSE80VLf3+8PPOZ6rGomGHRNaWxACozpm9gzNAs02I9qbIz2KglWDfwsMxa+ijpzd7q
         ObFBWZr0JqbY8JizapBZo0HzbXXEgOKBwurxnFqCFZZyNnUzBVHSOI2wXaV37A7MN8T0
         9ABpIqfJ3zoo+iuofghnJ3668ZHc8QU1d8iFd+P3DVWFLmWDKgdkRHe4haeM3+WtvTbS
         H3QA==
X-Gm-Message-State: APjAAAXXspRwTUz4vL3CLXeywlyG37/EwwaD3n5+QA1KqZiwRJJQxlIT
        kpqjJ2PppALI3GIFXH56CggtQ6I5p0A=
X-Google-Smtp-Source: APXvYqyMUlhNDDLuQnCnx3vW7zBKi3KAOhXIBQCsZHigT9gEe0pQfFAFeaXBGykKRdwwJxB5h8gsHg==
X-Received: by 2002:a2e:995a:: with SMTP id r26mr17410355ljj.78.1580806516016;
        Tue, 04 Feb 2020 00:55:16 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id n2sm11156283ljj.1.2020.02.04.00.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 00:55:15 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Shawn Lin <shawn.lin@rock-chips.com>, mirq-linux@rere.qmqm.pl
Subject: [PATCH 06/12] mmc: core: Enable re-use of mmc_blk_in_tran_state()
Date:   Tue,  4 Feb 2020 09:54:43 +0100
Message-Id: <20200204085449.32585-7-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200204085449.32585-1-ulf.hansson@linaro.org>
References: <20200204085449.32585-1-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

To allow subsequent changes to re-use the code from the static function
mmc_blk_in_tran_state(), let's move it to a public header. While at it,
let's also rename it to mmc_ready_for_data(), as to try to better describe
its purpose.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/block.c | 24 ++++--------------------
 include/linux/mmc/mmc.h  | 10 ++++++++++
 2 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 663d87924e5e..8ac12e3fff27 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -436,16 +436,6 @@ static int ioctl_do_sanitize(struct mmc_card *card)
 	return err;
 }
 
-static inline bool mmc_blk_in_tran_state(u32 status)
-{
-	/*
-	 * Some cards mishandle the status bits, so make sure to check both the
-	 * busy indication and the card state.
-	 */
-	return status & R1_READY_FOR_DATA &&
-	       (R1_CURRENT_STATE(status) == R1_STATE_TRAN);
-}
-
 static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
 			    u32 *resp_errs)
 {
@@ -477,13 +467,7 @@ static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
 				 __func__, status);
 			return -ETIMEDOUT;
 		}
-
-		/*
-		 * Some cards mishandle the status bits,
-		 * so make sure to check both the busy
-		 * indication and the card state.
-		 */
-	} while (!mmc_blk_in_tran_state(status));
+	} while (!mmc_ready_for_data(status));
 
 	return err;
 }
@@ -1666,7 +1650,7 @@ static void mmc_blk_read_single(struct mmc_queue *mq, struct request *req)
 			goto error_exit;
 
 		if (!mmc_host_is_spi(host) &&
-		    !mmc_blk_in_tran_state(status)) {
+		    !mmc_ready_for_data(status)) {
 			err = mmc_blk_fix_state(card, req);
 			if (err)
 				goto error_exit;
@@ -1726,7 +1710,7 @@ static bool mmc_blk_status_error(struct request *req, u32 status)
 	return brq->cmd.resp[0]  & CMD_ERRORS    ||
 	       brq->stop.resp[0] & stop_err_bits ||
 	       status            & stop_err_bits ||
-	       (rq_data_dir(req) == WRITE && !mmc_blk_in_tran_state(status));
+	       (rq_data_dir(req) == WRITE && !mmc_ready_for_data(status));
 }
 
 static inline bool mmc_blk_cmd_started(struct mmc_blk_request *brq)
@@ -1788,7 +1772,7 @@ static void mmc_blk_mq_rw_recovery(struct mmc_queue *mq, struct request *req)
 
 	/* Try to get back to "tran" state */
 	if (!mmc_host_is_spi(mq->card->host) &&
-	    (err || !mmc_blk_in_tran_state(status)))
+	    (err || !mmc_ready_for_data(status)))
 		err = mmc_blk_fix_state(mq->card, req);
 
 	/*
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 897a87c4c827..4b85ef05a906 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -161,6 +161,16 @@ static inline bool mmc_op_multi(u32 opcode)
 #define R1_STATE_PRG	7
 #define R1_STATE_DIS	8
 
+static inline bool mmc_ready_for_data(u32 status)
+{
+	/*
+	 * Some cards mishandle the status bits, so make sure to check both the
+	 * busy indication and the card state.
+	 */
+	return status & R1_READY_FOR_DATA &&
+	       R1_CURRENT_STATE(status) == R1_STATE_TRAN;
+}
+
 /*
  * MMC/SD in SPI mode reports R1 status always, and R2 for SEND_STATUS
  * R1 is the low order byte; R2 is the next highest byte, when present.
-- 
2.17.1

