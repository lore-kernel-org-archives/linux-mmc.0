Return-Path: <SRS0=aPfc=5B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114FDC0044D
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Mar 2020 15:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B198220663
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Mar 2020 15:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IRrtw7HB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbgCPPWN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Mar 2020 11:22:13 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39410 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729541AbgCPPWM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Mar 2020 11:22:12 -0400
Received: by mail-lf1-f66.google.com with SMTP id j15so14443004lfk.6
        for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2020 08:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=My6xvZz/fhkgy/uaLj1NERSiZJmHKnsEWA1q0ELN7mk=;
        b=IRrtw7HBsj/l1UDoFCV247/O60PLsKVHlEL0I4OQudDcqNvosHJVeKqo2DghtPGRVF
         tUmTuT3pHhb0al/NWy3VgTV58U6JgB6aA29XXtLZIZ5vCQ44VUND0VlqIgclJ7raOL59
         ac9fTynI1OJeBGt4r8j1bqPDeURMgdDgE9LYIcaOk/7f86ax56CLndBsIlA4yCE1dPpI
         3sVkmS4x2erg5Q6GSoU0DkppRezBIeRHZt4OA6cjLZLF+25DnfxF6nWUrBq3wGDDBb1n
         pPWV3604ucJWN8vYFTexpW0KQJm8PWU4MQDa7Tlds4rwO4S7yvt8+Nb6OvL2WW9R2uSV
         2pgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=My6xvZz/fhkgy/uaLj1NERSiZJmHKnsEWA1q0ELN7mk=;
        b=a+7HBfasFJsgechwp+aSKQODrkjQ7dLu8J2Y/hlijanDj+u/HvO9mhWwWIMrxlZ60Z
         ZnNXSJ1Buxbm3gG7TWNn65vkOBNjsMjUgY7xOF73Db2rCODVz8JlL4+FbtjKFusN2J6f
         hxqJMuHJ9G44Oczi3493KOQHcZqsolYmH3EkzgPZAbl37ZX0+nNO70PMXG51QjpTWpuw
         /HIqFxef5PnfXzWpKex/2Zs3iyfJgyD3WfMSNB77F7kiCzULyPJlu4nXvsmPkkbFsjhR
         mEc6dJTg6i09e7DGRvqz6MvsdCv8kNZwJgUnzalof4FpcLg+hQhiVEf1SZpXvjeFDGHA
         H8AA==
X-Gm-Message-State: ANhLgQ1ABiQV03ocxX1BfVlhZHfC8IDb/9Q+hDjJN+CV2lk/lkwXrU+4
        JceWJ36E2CIfSzCWDYvDUR5Lgx5jr9g=
X-Google-Smtp-Source: ADFU+vsflTiKdroVx9dnVwEs6VQT1Y6X2K2lGJPXhuSD0OtAi/q7ozXCJVUeYVXi2wGv9OKQ8G69sA==
X-Received: by 2002:a19:8ac1:: with SMTP id m184mr8228342lfd.181.1584372128667;
        Mon, 16 Mar 2020 08:22:08 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id w3sm173008lfe.9.2020.03.16.08.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 08:22:07 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Bitan Biswas <bbiswas@nvidia.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH] mmc: core: Re-work the code for eMMC sanitize
Date:   Mon, 16 Mar 2020 16:21:52 +0100
Message-Id: <20200316152152.15122-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The error path for sanitize operations that completes with -ETIMEDOUT, is
tightly coupled with the internal request handling code of the core. More
precisely, mmc_wait_for_req_done() checks for specific sanitize errors.
This is not only inefficient as it affects all types of requests, but also
hackish.

Therefore, let's improve the behaviour by moving the error path out of the
mmc core. To do that, retuning needs to be held while running the sanitize
operation.

Moreover, to avoid exporting unnecessary symbols to the mmc block module,
let's move the code into the mmc_ops.c file. While updating the actual
code, let's also take the opportunity to clean up some of the mess around
it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/block.c   | 40 ++------------------------------------
 drivers/mmc/core/core.c    | 18 -----------------
 drivers/mmc/core/mmc_ops.c | 38 +++++++++++++++++++++++++++++++++---
 drivers/mmc/core/mmc_ops.h |  2 +-
 include/linux/mmc/core.h   |  3 ---
 5 files changed, 38 insertions(+), 63 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 7634894df853..8499b56a15a8 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -70,7 +70,6 @@ MODULE_ALIAS("mmc:block");
  * ample.
  */
 #define MMC_BLK_TIMEOUT_MS  (10 * 1000)
-#define MMC_SANITIZE_REQ_TIMEOUT 240000
 #define MMC_EXTRACT_INDEX_FROM_ARG(x) ((x & 0x00FF0000) >> 16)
 #define MMC_EXTRACT_VALUE_FROM_ARG(x) ((x & 0x0000FF00) >> 8)
 
@@ -413,34 +412,6 @@ static int mmc_blk_ioctl_copy_to_user(struct mmc_ioc_cmd __user *ic_ptr,
 	return 0;
 }
 
-static int ioctl_do_sanitize(struct mmc_card *card)
-{
-	int err;
-
-	if (!mmc_can_sanitize(card)) {
-			pr_warn("%s: %s - SANITIZE is not supported\n",
-				mmc_hostname(card->host), __func__);
-			err = -EOPNOTSUPP;
-			goto out;
-	}
-
-	pr_debug("%s: %s - SANITIZE IN PROGRESS...\n",
-		mmc_hostname(card->host), __func__);
-
-	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-					EXT_CSD_SANITIZE_START, 1,
-					MMC_SANITIZE_REQ_TIMEOUT);
-
-	if (err)
-		pr_err("%s: %s - EXT_CSD_SANITIZE_START failed. err=%d\n",
-		       mmc_hostname(card->host), __func__, err);
-
-	pr_debug("%s: %s - SANITIZE COMPLETED\n", mmc_hostname(card->host),
-					     __func__);
-out:
-	return err;
-}
-
 static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
 			    u32 *resp_errs)
 {
@@ -569,15 +540,8 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 	}
 
 	if ((MMC_EXTRACT_INDEX_FROM_ARG(cmd.arg) == EXT_CSD_SANITIZE_START) &&
-	    (cmd.opcode == MMC_SWITCH)) {
-		err = ioctl_do_sanitize(card);
-
-		if (err)
-			pr_err("%s: ioctl_do_sanitize() failed. err = %d",
-			       __func__, err);
-
-		return err;
-	}
+	    (cmd.opcode == MMC_SWITCH))
+		return mmc_sanitize(card);
 
 	mmc_wait_for_req(card->host, &mrq);
 
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 3f7a31456eb4..4c5de6d37ac7 100644
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
@@ -1925,7 +1908,6 @@ int mmc_can_sanitize(struct mmc_card *card)
 		return 1;
 	return 0;
 }
-EXPORT_SYMBOL(mmc_can_sanitize);
 
 int mmc_can_secure_erase_trim(struct mmc_card *card)
 {
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index c75c00b5890d..5bd0ab8b236a 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -21,6 +21,7 @@
 
 #define MMC_BKOPS_TIMEOUT_MS		(120 * 1000) /* 120s */
 #define MMC_CACHE_FLUSH_TIMEOUT_MS	(30 * 1000) /* 30s */
+#define MMC_SANITIZE_TIMEOUT_MS		(240 * 1000) /* 240s */
 
 static const u8 tuning_blk_pattern_4bit[] = {
 	0xff, 0x0f, 0xff, 0x00, 0xff, 0xcc, 0xc3, 0xcc,
@@ -597,9 +598,6 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		cmd.flags |= MMC_RSP_SPI_R1 | MMC_RSP_R1;
 	}
 
-	if (index == EXT_CSD_SANITIZE_START)
-		cmd.sanitize_busy = true;
-
 	err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
 	if (err)
 		goto out;
@@ -1032,3 +1030,37 @@ int mmc_cmdq_disable(struct mmc_card *card)
 	return mmc_cmdq_switch(card, false);
 }
 EXPORT_SYMBOL_GPL(mmc_cmdq_disable);
+
+int mmc_sanitize(struct mmc_card *card)
+{
+	struct mmc_host *host = card->host;
+	int err;
+
+	if (!mmc_can_sanitize(card)) {
+		pr_warn("%s: Sanitize not supported\n", mmc_hostname(host));
+		return -EOPNOTSUPP;
+	}
+
+	pr_debug("%s: Sanitize in progress...\n", mmc_hostname(host));
+
+	mmc_retune_hold(host);
+
+	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_SANITIZE_START,
+			 1, MMC_SANITIZE_TIMEOUT_MS);
+	if (err)
+		pr_err("%s: Sanitize failed err=%d\n", mmc_hostname(host), err);
+
+	/*
+	 * If the sanitize operation timed out, the card is probably still busy
+	 * in the R1_STATE_PRG. Rather than continue to wait, let's try to abort
+	 * it with a HPI command to get back into R1_STATE_TRAN.
+	 */
+	if (err == -ETIMEDOUT && !mmc_interrupt_hpi(card))
+		pr_warn("%s: Sanitize aborted\n", mmc_hostname(host));
+
+	mmc_retune_release(host);
+
+	pr_debug("%s: Sanitize completed\n", mmc_hostname(host));
+	return err;
+}
+EXPORT_SYMBOL_GPL(mmc_sanitize);
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 38dcfeeaf6d5..632009260e51 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -32,7 +32,6 @@ int mmc_send_cid(struct mmc_host *host, u32 *cid);
 int mmc_spi_read_ocr(struct mmc_host *host, int highcap, u32 *ocrp);
 int mmc_spi_set_crc(struct mmc_host *host, int use_crc);
 int mmc_bus_test(struct mmc_card *card, u8 bus_width);
-int mmc_interrupt_hpi(struct mmc_card *card);
 int mmc_can_ext_csd(struct mmc_card *card);
 int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
 int mmc_switch_status(struct mmc_card *card, bool crc_err_fatal);
@@ -47,6 +46,7 @@ void mmc_run_bkops(struct mmc_card *card);
 int mmc_flush_cache(struct mmc_card *card);
 int mmc_cmdq_enable(struct mmc_card *card);
 int mmc_cmdq_disable(struct mmc_card *card);
+int mmc_sanitize(struct mmc_card *card);
 
 #endif
 
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
2.20.1

