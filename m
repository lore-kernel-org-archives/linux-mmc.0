Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AF5C43616
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Apr 2021 17:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A569D613C7
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Apr 2021 17:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbhDARpz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 1 Apr 2021 13:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234793AbhDARkN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Apr 2021 13:40:13 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD6DC0610E1;
        Thu,  1 Apr 2021 05:43:56 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id e14so2644438ejz.11;
        Thu, 01 Apr 2021 05:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=buOWgrok9xQ6w8escBaxSF0zvdMNz30efkWYf8lA40s=;
        b=H2F/cOwF+EAGvL/Lwd5xsF2FjGePibzwK3H1SeN6EAkw2FSi7HcuX8EDEy4VFu1dTZ
         XvvqmYn0KCA3Tj4CxK46mJ7CBCLVgYxgvwysUFmcu6hTzqOtM4/IfsVKJauCdTYQ9Bn7
         C6Q84NqIs3Cf5t8MrdbM6WTRVCDSI0p/Q8lN9QeyHigU3JNKOinqUoiQ/S85lc28K7fl
         fHSVqvgbYC48cakqXxtWQ4Ahk/Dh+fKBc08nAgO2olA4IwUxyGv5simkNSmO4+ck9YVJ
         0j3TQ7CVGTi2FzLziv5oK/oHPnaHP3lH3sXcdj5cB7M+OWnSXlSoabZPgi7B9CpsTJwi
         3WAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=buOWgrok9xQ6w8escBaxSF0zvdMNz30efkWYf8lA40s=;
        b=WqxCYzDwxqNsKc3gN275ufH75cBHcMWG3vKlph/cn1Q6Xq9Xcv+b5xUuI7fHI3rfEJ
         I+/R7c+eK/amrULtx/j62hQ/BwYckYvTZYFyq836AvG9gMAldVcw1SK1t8OMnuovj5f+
         PPavhAaxRx6td322vuGWiaNCLI2kRcCkfSfDXTuOJLlcSZZ9LAJe8NDF2lOotRw6nxv4
         oq0+KeZjFdJVxY3tpN3XfOYsKa7FddV+Pf/mjhT9j8zqgifLLKr4YKLRV4YYAGF5uBfT
         tpQSphXVYMUk0oIYnoTyjM5/n+e0+kxx5iQLsyMk560cq6EPretOaCyOp/maTbjf1MuE
         fIFg==
X-Gm-Message-State: AOAM530WPHfgNs4BOE5H5qXLCrPYuwtCB0L9QK+wlN0UPZ2B+ypKUVBU
        tYzQ+ur8hcY10iNmo5eOqnk=
X-Google-Smtp-Source: ABdhPJyc4psJFL+mmCL37/Gm4CTMFihfHukdt4NgnETOOPIEi71kElhm3hTb2OWyumTKhhAFVc7G9A==
X-Received: by 2002:a17:907:3353:: with SMTP id yr19mr9012221ejb.8.1617281034908;
        Thu, 01 Apr 2021 05:43:54 -0700 (PDT)
Received: from localhost.localdomain (ip5f5bec5d.dynamic.kabel-deutschland.de. [95.91.236.93])
        by smtp.gmail.com with ESMTPSA id v8sm3469939edq.76.2021.04.01.05.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 05:43:54 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     ulf.hansson@linaro.org, yoshihiro.shimoda.uh@renesas.com,
        wsa+renesas@sang-engineering.com, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bean Huo <beanhuo@micron.com>
Subject: [PATCH v1 2/2] mmc: core: Let sanitize not retry in case of timeout/failure
Date:   Thu,  1 Apr 2021 14:43:43 +0200
Message-Id: <20210401124343.102915-3-huobean@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210401124343.102915-1-huobean@gmail.com>
References: <20210401124343.102915-1-huobean@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Not any commands need to retry in case of timeout/failure.
Currently, the sanitize command is issued by the IOCTL interface,
and once its timeouts, the user normally decides to retry or not .
Just blindly retry three times sanitize in the driver, it doesn't
help sanitize retry succeed in the end, on the contrary, it only
makes the user feel sanitize timeouts after 12 minutes.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/mmc/core/block.c   | 13 +++++++----
 drivers/mmc/core/mmc.c     | 47 ++++++++++++++++++++++----------------
 drivers/mmc/core/mmc_ops.c | 19 +++++++--------
 drivers/mmc/core/mmc_ops.h |  4 ++--
 4 files changed, 47 insertions(+), 36 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index fe5892d30778..e123be6c6a0f 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -836,7 +836,7 @@ static inline int mmc_blk_part_switch(struct mmc_card *card,
 
 		ret = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 				 EXT_CSD_PART_CONFIG, part_config,
-				 card->ext_csd.part_time);
+				 card->ext_csd.part_time, MMC_CMD_RETRIES);
 		if (ret) {
 			mmc_blk_part_switch_post(card, part_type);
 			return ret;
@@ -1007,7 +1007,7 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
 		ret = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_BOOT_WP,
 				 card->ext_csd.boot_ro_lock |
 				 EXT_CSD_BOOT_WP_B_PWR_WP_EN,
-				 card->ext_csd.part_time);
+				 card->ext_csd.part_time, MMC_CMD_RETRIES);
 		if (ret)
 			pr_err("%s: Locking boot partition ro until next power on failed: %d\n",
 			       md->disk->disk_name, ret);
@@ -1058,7 +1058,8 @@ static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
 					 card->erase_arg == MMC_TRIM_ARG ?
 					 INAND_CMD38_ARG_TRIM :
 					 INAND_CMD38_ARG_ERASE,
-					 card->ext_csd.generic_cmd6_time);
+					 card->ext_csd.generic_cmd6_time,
+					 MMC_CMD_RETRIES);
 		}
 		if (!err)
 			err = mmc_erase(card, from, nr, card->erase_arg);
@@ -1100,7 +1101,8 @@ static void mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
 				 arg == MMC_SECURE_TRIM1_ARG ?
 				 INAND_CMD38_ARG_SECTRIM1 :
 				 INAND_CMD38_ARG_SECERASE,
-				 card->ext_csd.generic_cmd6_time);
+				 card->ext_csd.generic_cmd6_time,
+				 MMC_CMD_RETRIES);
 		if (err)
 			goto out_retry;
 	}
@@ -1118,7 +1120,8 @@ static void mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
 			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 					 INAND_CMD38_ARG_EXT_CSD,
 					 INAND_CMD38_ARG_SECTRIM2,
-					 card->ext_csd.generic_cmd6_time);
+					 card->ext_csd.generic_cmd6_time,
+					 MMC_CMD_RETRIES);
 			if (err)
 				goto out_retry;
 		}
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 4e4b3592d3d6..eefb48191e6c 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -964,7 +964,8 @@ static int __mmc_select_powerclass(struct mmc_card *card,
 		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 				 EXT_CSD_POWER_CLASS,
 				 pwrclass_val,
-				 card->ext_csd.generic_cmd6_time);
+				 card->ext_csd.generic_cmd6_time,
+				 MMC_CMD_RETRIES);
 	}
 
 	return err;
@@ -1061,7 +1062,8 @@ static int mmc_select_bus_width(struct mmc_card *card)
 		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 				 EXT_CSD_BUS_WIDTH,
 				 ext_csd_bits[idx],
-				 card->ext_csd.generic_cmd6_time);
+				 card->ext_csd.generic_cmd6_time,
+				 MMC_CMD_RETRIES);
 		if (err)
 			continue;
 
@@ -1100,7 +1102,7 @@ static int mmc_select_hs(struct mmc_card *card)
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			   EXT_CSD_HS_TIMING, EXT_CSD_TIMING_HS,
 			   card->ext_csd.generic_cmd6_time, MMC_TIMING_MMC_HS,
-			   true, true);
+			   true, true, MMC_CMD_RETRIES);
 	if (err)
 		pr_warn("%s: switch to high-speed failed, err:%d\n",
 			mmc_hostname(card->host), err);
@@ -1132,7 +1134,7 @@ static int mmc_select_hs_ddr(struct mmc_card *card)
 			   ext_csd_bits,
 			   card->ext_csd.generic_cmd6_time,
 			   MMC_TIMING_MMC_DDR52,
-			   true, true);
+			   true, true, MMC_CMD_RETRIES);
 	if (err) {
 		pr_err("%s: switch to bus width %d ddr failed\n",
 			mmc_hostname(host), 1 << bus_width);
@@ -1200,7 +1202,7 @@ static int mmc_select_hs400(struct mmc_card *card)
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			   EXT_CSD_HS_TIMING, val,
 			   card->ext_csd.generic_cmd6_time, 0,
-			   false, true);
+			   false, true, MMC_CMD_RETRIES);
 	if (err) {
 		pr_err("%s: switch to high-speed from hs200 failed, err:%d\n",
 			mmc_hostname(host), err);
@@ -1229,7 +1231,8 @@ static int mmc_select_hs400(struct mmc_card *card)
 	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			 EXT_CSD_BUS_WIDTH,
 			 EXT_CSD_DDR_BUS_WIDTH_8,
-			 card->ext_csd.generic_cmd6_time);
+			 card->ext_csd.generic_cmd6_time,
+			 MMC_CMD_RETRIES);
 	if (err) {
 		pr_err("%s: switch to bus width for hs400 failed, err:%d\n",
 			mmc_hostname(host), err);
@@ -1242,7 +1245,7 @@ static int mmc_select_hs400(struct mmc_card *card)
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			   EXT_CSD_HS_TIMING, val,
 			   card->ext_csd.generic_cmd6_time, 0,
-			   false, true);
+			   false, true, MMC_CMD_RETRIES);
 	if (err) {
 		pr_err("%s: switch to hs400 failed, err:%d\n",
 			 mmc_hostname(host), err);
@@ -1288,7 +1291,7 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
 	val = EXT_CSD_TIMING_HS;
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
 			   val, card->ext_csd.generic_cmd6_time, 0,
-			   false, true);
+			   false, true, MMC_CMD_RETRIES);
 	if (err)
 		goto out_err;
 
@@ -1304,7 +1307,7 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
 	/* Switch HS DDR to HS */
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_BUS_WIDTH,
 			   EXT_CSD_BUS_WIDTH_8, card->ext_csd.generic_cmd6_time,
-			   0, false, true);
+			   0, false, true, MMC_CMD_RETRIES);
 	if (err)
 		goto out_err;
 
@@ -1319,7 +1322,7 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
 	      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
 			   val, card->ext_csd.generic_cmd6_time, 0,
-			   false, true);
+			   false, true, MMC_CMD_RETRIES);
 	if (err)
 		goto out_err;
 
@@ -1403,7 +1406,7 @@ static int mmc_select_hs400es(struct mmc_card *card)
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			   EXT_CSD_HS_TIMING, EXT_CSD_TIMING_HS,
 			   card->ext_csd.generic_cmd6_time, 0,
-			   false, true);
+			   false, true, MMC_CMD_RETRIES);
 	if (err) {
 		pr_err("%s: switch to hs for hs400es failed, err:%d\n",
 			mmc_hostname(host), err);
@@ -1422,7 +1425,7 @@ static int mmc_select_hs400es(struct mmc_card *card)
 	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			 EXT_CSD_BUS_WIDTH,
 			 val,
-			 card->ext_csd.generic_cmd6_time);
+			 card->ext_csd.generic_cmd6_time, MMC_CMD_RETRIES);
 	if (err) {
 		pr_err("%s: switch to bus width for hs400es failed, err:%d\n",
 			mmc_hostname(host), err);
@@ -1437,7 +1440,7 @@ static int mmc_select_hs400es(struct mmc_card *card)
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			   EXT_CSD_HS_TIMING, val,
 			   card->ext_csd.generic_cmd6_time, 0,
-			   false, true);
+			   false, true, MMC_CMD_RETRIES);
 	if (err) {
 		pr_err("%s: switch to hs400es failed, err:%d\n",
 			mmc_hostname(host), err);
@@ -1502,7 +1505,7 @@ static int mmc_select_hs200(struct mmc_card *card)
 		err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 				   EXT_CSD_HS_TIMING, val,
 				   card->ext_csd.generic_cmd6_time, 0,
-				   false, true);
+				   false, true, MMC_CMD_RETRIES);
 		if (err)
 			goto err;
 		old_timing = host->ios.timing;
@@ -1731,7 +1734,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	if (card->ext_csd.rev >= 3) {
 		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 				 EXT_CSD_ERASE_GROUP_DEF, 1,
-				 card->ext_csd.generic_cmd6_time);
+				 card->ext_csd.generic_cmd6_time,
+				 MMC_CMD_RETRIES);
 
 		if (err && err != -EBADMSG)
 			goto free_card;
@@ -1762,7 +1766,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 		card->ext_csd.part_config &= ~EXT_CSD_PART_CONFIG_ACC_MASK;
 		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_PART_CONFIG,
 				 card->ext_csd.part_config,
-				 card->ext_csd.part_time);
+				 card->ext_csd.part_time, MMC_CMD_RETRIES);
 		if (err && err != -EBADMSG)
 			goto free_card;
 	}
@@ -1774,7 +1778,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 				 EXT_CSD_POWER_OFF_NOTIFICATION,
 				 EXT_CSD_POWER_ON,
-				 card->ext_csd.generic_cmd6_time);
+				 card->ext_csd.generic_cmd6_time,
+				 MMC_CMD_RETRIES);
 		if (err && err != -EBADMSG)
 			goto free_card;
 
@@ -1834,7 +1839,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	if (card->ext_csd.hpi) {
 		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 				EXT_CSD_HPI_MGMT, 1,
-				card->ext_csd.generic_cmd6_time);
+				card->ext_csd.generic_cmd6_time,
+				MMC_CMD_RETRIES);
 		if (err && err != -EBADMSG)
 			goto free_card;
 		if (err) {
@@ -1858,7 +1864,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 
 		timeout_ms = max(card->ext_csd.generic_cmd6_time, timeout_ms);
 		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-				EXT_CSD_CACHE_CTRL, 1, timeout_ms);
+				EXT_CSD_CACHE_CTRL, 1, timeout_ms,
+				MMC_CMD_RETRIES);
 		if (err && err != -EBADMSG)
 			goto free_card;
 
@@ -2008,7 +2015,7 @@ static int mmc_poweroff_notify(struct mmc_card *card, unsigned int notify_type)
 
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			EXT_CSD_POWER_OFF_NOTIFICATION,
-			notify_type, timeout, 0, false, false);
+			notify_type, timeout, 0, false, false, MMC_CMD_RETRIES);
 	if (err)
 		pr_err("%s: Power Off Notification timed out, %u\n",
 		       mmc_hostname(card->host), timeout);
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 40a4f9e22d30..857f5b48ecdc 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -531,12 +531,13 @@ int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
  *	@timing: new timing to change to
  *	@send_status: send status cmd to poll for busy
  *	@retry_crc_err: retry when CRC errors when polling with CMD13 for busy
+ *	@retries: number of retries
  *
  *	Modifies the EXT_CSD register for selected card.
  */
 int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		unsigned int timeout_ms, unsigned char timing,
-		bool send_status, bool retry_crc_err)
+		bool send_status, bool retry_crc_err, unsigned int retries)
 {
 	struct mmc_host *host = card->host;
 	int err;
@@ -562,7 +563,6 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 	if (!(host->caps & MMC_CAP_NEED_RSP_BUSY) && host->max_busy_timeout &&
 	    (timeout_ms > host->max_busy_timeout))
 		use_r1b_resp = false;
-
 	cmd.opcode = MMC_SWITCH;
 	cmd.arg = (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
 		  (index << 16) |
@@ -576,7 +576,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		cmd.flags |= MMC_RSP_SPI_R1 | MMC_RSP_R1;
 	}
 
-	err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
+	err = mmc_wait_for_cmd(host, &cmd, retries);
 	if (err)
 		goto out;
 
@@ -608,10 +608,10 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 }
 
 int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
-		unsigned int timeout_ms)
+		unsigned int timeout_ms, unsigned int retries)
 {
 	return __mmc_switch(card, set, index, value, timeout_ms, 0,
-			    true, false);
+			    true, false, retries);
 }
 EXPORT_SYMBOL_GPL(mmc_switch);
 
@@ -950,7 +950,8 @@ void mmc_run_bkops(struct mmc_card *card)
 	 * urgent levels by using an asynchronous background task, when idle.
 	 */
 	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-			 EXT_CSD_BKOPS_START, 1, MMC_BKOPS_TIMEOUT_MS);
+			 EXT_CSD_BKOPS_START, 1, MMC_BKOPS_TIMEOUT_MS,
+			 MMC_CMD_RETRIES);
 	if (err)
 		pr_warn("%s: Error %d starting bkops\n",
 			mmc_hostname(card->host), err);
@@ -971,7 +972,7 @@ int mmc_flush_cache(struct mmc_card *card)
 			(card->ext_csd.cache_ctrl & 1)) {
 		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 				 EXT_CSD_FLUSH_CACHE, 1,
-				 MMC_CACHE_FLUSH_TIMEOUT_MS);
+				 MMC_CACHE_FLUSH_TIMEOUT_MS, MMC_CMD_RETRIES);
 		if (err)
 			pr_err("%s: cache flush error %d\n",
 					mmc_hostname(card->host), err);
@@ -990,7 +991,7 @@ static int mmc_cmdq_switch(struct mmc_card *card, bool enable)
 		return -EOPNOTSUPP;
 
 	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_CMDQ_MODE_EN,
-			 val, card->ext_csd.generic_cmd6_time);
+			 val, card->ext_csd.generic_cmd6_time, MMC_CMD_RETRIES);
 	if (!err)
 		card->ext_csd.cmdq_en = enable;
 
@@ -1024,7 +1025,7 @@ int mmc_sanitize(struct mmc_card *card)
 	mmc_retune_hold(host);
 
 	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_SANITIZE_START,
-			 1, card->sanitize_timeout_ms);
+			 1, card->sanitize_timeout_ms, 0);
 	if (err)
 		pr_err("%s: Sanitize failed err=%d\n", mmc_hostname(host), err);
 
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 632009260e51..ccf9ea70c8f3 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -39,9 +39,9 @@ int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
 		      enum mmc_busy_cmd busy_cmd);
 int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		unsigned int timeout_ms, unsigned char timing,
-		bool send_status, bool retry_crc_err);
+		bool send_status, bool retry_crc_err, unsigned int retries);
 int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
-		unsigned int timeout_ms);
+		unsigned int timeout_ms, unsigned int retries);
 void mmc_run_bkops(struct mmc_card *card);
 int mmc_flush_cache(struct mmc_card *card);
 int mmc_cmdq_enable(struct mmc_card *card);
-- 
2.25.1

