Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E44C43462
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Apr 2021 21:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78E9F61177
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Apr 2021 21:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbhDNVXP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 14 Apr 2021 17:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbhDNVXO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Apr 2021 17:23:14 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93320C061760;
        Wed, 14 Apr 2021 14:22:52 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u21so33582740ejo.13;
        Wed, 14 Apr 2021 14:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fbz9pkWGwKhtL9UZysneHUJwTvYhUl7QwaSSSImyqdQ=;
        b=KuIuTCp2GshKdkP1DuEHepZwRwoGeEORQdCBjY8hbtJ2b4zRyAaP1JJT0Cl5w1klKT
         EYzbAItBpnSt/UkG/0PCyinaR/KDOQe+3M8kZXANeHbEvSE+6h0pJgf81k/f/90vfR5i
         W5Iumrxh84UD4/j82X8sznvHDcn9jzm/387VgAkEw4tqNongsHB3xmZF9r4QWKhcc3sm
         voUD8KEs99LiRgYYYLSczxZ629c+5SS1f9H6yvyDPs1/sjep+kth3uYZ/3xwqYXSYxZR
         L/UxuXqkYObx5W8rerD+hdOvoyzTdFXLS4FTocFO9hCKi+m737oHP+JAzWOrVy1WCLaC
         4F6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fbz9pkWGwKhtL9UZysneHUJwTvYhUl7QwaSSSImyqdQ=;
        b=DNHVrNhj/8/+612p5SfD3TN4fzErTfGG9OGkSjpII1ox+UZT5aJy4Zm9czL0Ch8LsS
         7pSN2oJCWPkoG65sGH733naHaLd46EY+T1XbXmLt/hbZg0lkNc4UP4oCMmEbOypeiEDL
         YM7Xrh9dB/9Ga/XUS6gz9Gc6q0XPas2m9O+nOUQYfiRms6qlQchBMUilDvVkXYht7LAI
         1re2g/BxWg1+vbebdpM1JomXbwhcs63yByjGEIzAajVAcmPvCZoA/EWhRaj2dGtUArQp
         VlUmLevkDm749nZNygCA5BJOXHGGqYOp8V2HTIxHyyEHjPn0JZT0DUxZEUX6mzpByQhu
         praQ==
X-Gm-Message-State: AOAM531vCn50GZklJh2C9tjr18E8vnK+N3XXXsyvT9+QpQmYoTJHK3F5
        tetp0IfDgOuFFHnoBk+opQ0=
X-Google-Smtp-Source: ABdhPJygirC2qIk3lHB4pXZL0Y/0+FdkLESskAQVVseUP10uaOjb0QEbNvufh3p8dNFpSbxYsqqdWQ==
X-Received: by 2002:a17:906:6b05:: with SMTP id q5mr92515ejr.460.1618435370806;
        Wed, 14 Apr 2021 14:22:50 -0700 (PDT)
Received: from localhost.localdomain (ip5f5bec5d.dynamic.kabel-deutschland.de. [95.91.236.93])
        by smtp.gmail.com with ESMTPSA id t7sm586187edq.42.2021.04.14.14.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 14:22:50 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     ulf.hansson@linaro.org, wsa+renesas@sang-engineering.com,
        adrian.hunter@intel.com, yoshihiro.shimoda.uh@renesas.com
Cc:     beanhuo@micron.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] mmc: core: Add a retries parameter to __mmc_switch function
Date:   Wed, 14 Apr 2021 23:22:35 +0200
Message-Id: <20210414212236.346813-2-huobean@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210414212236.346813-1-huobean@gmail.com>
References: <20210414212236.346813-1-huobean@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Add command retries parameter to __mmc_switch(), let caller
pass retries according to the caller's condition.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/mmc/core/mmc.c     | 22 +++++++++++-----------
 drivers/mmc/core/mmc_ops.c |  7 ++++---
 drivers/mmc/core/mmc_ops.h |  2 +-
 3 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 8741271d3971..d35231feac68 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1068,7 +1068,7 @@ static int mmc_select_hs(struct mmc_card *card)
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			   EXT_CSD_HS_TIMING, EXT_CSD_TIMING_HS,
 			   card->ext_csd.generic_cmd6_time, MMC_TIMING_MMC_HS,
-			   true, true);
+			   true, true, MMC_CMD_RETRIES);
 	if (err)
 		pr_warn("%s: switch to high-speed failed, err:%d\n",
 			mmc_hostname(card->host), err);
@@ -1100,7 +1100,7 @@ static int mmc_select_hs_ddr(struct mmc_card *card)
 			   ext_csd_bits,
 			   card->ext_csd.generic_cmd6_time,
 			   MMC_TIMING_MMC_DDR52,
-			   true, true);
+			   true, true, MMC_CMD_RETRIES);
 	if (err) {
 		pr_err("%s: switch to bus width %d ddr failed\n",
 			mmc_hostname(host), 1 << bus_width);
@@ -1168,7 +1168,7 @@ static int mmc_select_hs400(struct mmc_card *card)
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			   EXT_CSD_HS_TIMING, val,
 			   card->ext_csd.generic_cmd6_time, 0,
-			   false, true);
+			   false, true, MMC_CMD_RETRIES);
 	if (err) {
 		pr_err("%s: switch to high-speed from hs200 failed, err:%d\n",
 			mmc_hostname(host), err);
@@ -1210,7 +1210,7 @@ static int mmc_select_hs400(struct mmc_card *card)
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			   EXT_CSD_HS_TIMING, val,
 			   card->ext_csd.generic_cmd6_time, 0,
-			   false, true);
+			   false, true, MMC_CMD_RETRIES);
 	if (err) {
 		pr_err("%s: switch to hs400 failed, err:%d\n",
 			 mmc_hostname(host), err);
@@ -1256,7 +1256,7 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
 	val = EXT_CSD_TIMING_HS;
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
 			   val, card->ext_csd.generic_cmd6_time, 0,
-			   false, true);
+			   false, true, MMC_CMD_RETRIES);
 	if (err)
 		goto out_err;
 
@@ -1272,7 +1272,7 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
 	/* Switch HS DDR to HS */
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_BUS_WIDTH,
 			   EXT_CSD_BUS_WIDTH_8, card->ext_csd.generic_cmd6_time,
-			   0, false, true);
+			   0, false, true, MMC_CMD_RETRIES);
 	if (err)
 		goto out_err;
 
@@ -1287,7 +1287,7 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
 	      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
 			   val, card->ext_csd.generic_cmd6_time, 0,
-			   false, true);
+			   false, true, MMC_CMD_RETRIES);
 	if (err)
 		goto out_err;
 
@@ -1371,7 +1371,7 @@ static int mmc_select_hs400es(struct mmc_card *card)
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			   EXT_CSD_HS_TIMING, EXT_CSD_TIMING_HS,
 			   card->ext_csd.generic_cmd6_time, 0,
-			   false, true);
+			   false, true, MMC_CMD_RETRIES);
 	if (err) {
 		pr_err("%s: switch to hs for hs400es failed, err:%d\n",
 			mmc_hostname(host), err);
@@ -1405,7 +1405,7 @@ static int mmc_select_hs400es(struct mmc_card *card)
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			   EXT_CSD_HS_TIMING, val,
 			   card->ext_csd.generic_cmd6_time, 0,
-			   false, true);
+			   false, true, MMC_CMD_RETRIES);
 	if (err) {
 		pr_err("%s: switch to hs400es failed, err:%d\n",
 			mmc_hostname(host), err);
@@ -1470,7 +1470,7 @@ static int mmc_select_hs200(struct mmc_card *card)
 		err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 				   EXT_CSD_HS_TIMING, val,
 				   card->ext_csd.generic_cmd6_time, 0,
-				   false, true);
+				   false, true, MMC_CMD_RETRIES);
 		if (err)
 			goto err;
 		old_timing = host->ios.timing;
@@ -1975,7 +1975,7 @@ static int mmc_poweroff_notify(struct mmc_card *card, unsigned int notify_type)
 
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			EXT_CSD_POWER_OFF_NOTIFICATION,
-			notify_type, timeout, 0, false, false);
+			notify_type, timeout, 0, false, false, MMC_CMD_RETRIES);
 	if (err)
 		pr_err("%s: Power Off Notification timed out, %u\n",
 		       mmc_hostname(card->host), timeout);
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index ccca067db993..1ca0c89081be 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -532,12 +532,13 @@ int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
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
@@ -577,7 +578,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		cmd.flags |= MMC_RSP_SPI_R1 | MMC_RSP_R1;
 	}
 
-	err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
+	err = mmc_wait_for_cmd(host, &cmd, retries);
 	if (err)
 		goto out;
 
@@ -612,7 +613,7 @@ int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		unsigned int timeout_ms)
 {
 	return __mmc_switch(card, set, index, value, timeout_ms, 0,
-			    true, false);
+			    true, false, MMC_CMD_RETRIES);
 }
 EXPORT_SYMBOL_GPL(mmc_switch);
 
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 1ed0d0375780..7bc1cfb0654c 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -39,7 +39,7 @@ int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
 		      enum mmc_busy_cmd busy_cmd);
 int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		unsigned int timeout_ms, unsigned char timing,
-		bool send_status, bool retry_crc_err);
+		bool send_status, bool retry_crc_err, unsigned int retries);
 int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		unsigned int timeout_ms);
 void mmc_run_bkops(struct mmc_card *card);
-- 
2.25.1

