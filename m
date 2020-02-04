Return-Path: <SRS0=92ZL=3Y=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D06EC2D0B1
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Feb 2020 08:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1ECC21775
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Feb 2020 08:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AUuH5mHb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgBDIzQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 4 Feb 2020 03:55:16 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41689 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgBDIzQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Feb 2020 03:55:16 -0500
Received: by mail-lf1-f67.google.com with SMTP id m30so11616115lfp.8
        for <linux-mmc@vger.kernel.org>; Tue, 04 Feb 2020 00:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oo1kARjEhP98lYPlpiOSceeqz5RhRUO7sBl5qQa8iZI=;
        b=AUuH5mHbfdO0ptVloZto0bqI1nhiIzw/tiAZA6uR9t4iYf9c+gCCZ1bw5YEmJUAjeY
         eq49ZKn2fPLB2LeRXMB+9oR/o2qhxwtA7x2jQYKc7kOK5fh/sZglW1zy+yiifPGRXOGn
         /vXxNwIsFb30FQMPKBRlbtHHIQTmpDdm6aNSFn5KmPPHlOCkCyWgRe9TZFNjOqT4vvwk
         rvfm9laQtncLlFR4vSbrF9I/bBqGGZOk+10+a72KpvuYLf729usIhFiRlhUVPiGHcjWG
         C20Lsg9NcpJkz3qjP8EFZnrSi+maJPgnpcXX5D6674UCu/w6agCIAckq+Oxg7bNGYaUC
         DRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oo1kARjEhP98lYPlpiOSceeqz5RhRUO7sBl5qQa8iZI=;
        b=B+CM8H6ZTBF2KKtaOav3srPJvlvoIa2HdEgfGhRSvRazbimKEyrTabaWUhuBDn4HR3
         H+p0X8Nm+0yT0/PKkGJwc8GAe51Cl8Wzhxw/bNe6h/McpmYM6iXP+/P0PPByguQTezha
         872zSxIUeh73E3TRYFa/TUW5f24AcgmKCki8SKjOp3px4mYUScWPSP/08MN3Pcpzl10f
         EIfxttLQh2LfUtBJtQT6EB/O9BWXy9/Q0uHlTpe5lAFfWcpTGFCqXuzn9EP6+k//LLbv
         psavOGIqO8Zm4gdRU9CPWNPql1YdxP1Uma5ZUum60YMaNx0ni9V/7zXeKIK+TWslqMIA
         vpfw==
X-Gm-Message-State: APjAAAXS8aTf+y3NJmZhh6e+g8cej6+pASKkNi3QCbDdhivpNE2lRLoW
        kOZmetNG+p1Fb8txkQXrS7JW/9bDyrc=
X-Google-Smtp-Source: APXvYqzuAkLU0jn7W/55jifg0tyovaiaOysa+fQtbTBeeb3vRL2rGVgA4VBAsbln4wFuNCaC1UM4TA==
X-Received: by 2002:a19:c014:: with SMTP id q20mr14613516lff.209.1580806512657;
        Tue, 04 Feb 2020 00:55:12 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id n2sm11156283ljj.1.2020.02.04.00.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 00:55:12 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Shawn Lin <shawn.lin@rock-chips.com>, mirq-linux@rere.qmqm.pl
Subject: [PATCH 04/12] mmc: core: Drop redundant in-parameter to __mmc_switch()
Date:   Tue,  4 Feb 2020 09:54:41 +0100
Message-Id: <20200204085449.32585-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200204085449.32585-1-ulf.hansson@linaro.org>
References: <20200204085449.32585-1-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The use_busy_signal in-parameter is set true by all callers of
__mmc_switch(), hence it's redundant so drop it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc.c     | 22 +++++++++++-----------
 drivers/mmc/core/mmc_ops.c | 11 +++--------
 drivers/mmc/core/mmc_ops.h |  2 +-
 3 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 8a1f64065a47..648c1c79282f 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1055,7 +1055,7 @@ static int mmc_select_hs(struct mmc_card *card)
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			   EXT_CSD_HS_TIMING, EXT_CSD_TIMING_HS,
 			   card->ext_csd.generic_cmd6_time, MMC_TIMING_MMC_HS,
-			   true, true, true);
+			   true, true);
 	if (err)
 		pr_warn("%s: switch to high-speed failed, err:%d\n",
 			mmc_hostname(card->host), err);
@@ -1087,7 +1087,7 @@ static int mmc_select_hs_ddr(struct mmc_card *card)
 			   ext_csd_bits,
 			   card->ext_csd.generic_cmd6_time,
 			   MMC_TIMING_MMC_DDR52,
-			   true, true, true);
+			   true, true);
 	if (err) {
 		pr_err("%s: switch to bus width %d ddr failed\n",
 			mmc_hostname(host), 1 << bus_width);
@@ -1155,7 +1155,7 @@ static int mmc_select_hs400(struct mmc_card *card)
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			   EXT_CSD_HS_TIMING, val,
 			   card->ext_csd.generic_cmd6_time, 0,
-			   true, false, true);
+			   false, true);
 	if (err) {
 		pr_err("%s: switch to high-speed from hs200 failed, err:%d\n",
 			mmc_hostname(host), err);
@@ -1197,7 +1197,7 @@ static int mmc_select_hs400(struct mmc_card *card)
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			   EXT_CSD_HS_TIMING, val,
 			   card->ext_csd.generic_cmd6_time, 0,
-			   true, false, true);
+			   false, true);
 	if (err) {
 		pr_err("%s: switch to hs400 failed, err:%d\n",
 			 mmc_hostname(host), err);
@@ -1243,7 +1243,7 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
 	val = EXT_CSD_TIMING_HS;
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
 			   val, card->ext_csd.generic_cmd6_time, 0,
-			   true, false, true);
+			   false, true);
 	if (err)
 		goto out_err;
 
@@ -1256,7 +1256,7 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
 	/* Switch HS DDR to HS */
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_BUS_WIDTH,
 			   EXT_CSD_BUS_WIDTH_8, card->ext_csd.generic_cmd6_time,
-			   0, true, false, true);
+			   0, false, true);
 	if (err)
 		goto out_err;
 
@@ -1274,7 +1274,7 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
 	      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
 			   val, card->ext_csd.generic_cmd6_time, 0,
-			   true, false, true);
+			   false, true);
 	if (err)
 		goto out_err;
 
@@ -1358,7 +1358,7 @@ static int mmc_select_hs400es(struct mmc_card *card)
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			   EXT_CSD_HS_TIMING, EXT_CSD_TIMING_HS,
 			   card->ext_csd.generic_cmd6_time, 0,
-			   true, false, true);
+			   false, true);
 	if (err) {
 		pr_err("%s: switch to hs for hs400es failed, err:%d\n",
 			mmc_hostname(host), err);
@@ -1392,7 +1392,7 @@ static int mmc_select_hs400es(struct mmc_card *card)
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			   EXT_CSD_HS_TIMING, val,
 			   card->ext_csd.generic_cmd6_time, 0,
-			   true, false, true);
+			   false, true);
 	if (err) {
 		pr_err("%s: switch to hs400es failed, err:%d\n",
 			mmc_hostname(host), err);
@@ -1457,7 +1457,7 @@ static int mmc_select_hs200(struct mmc_card *card)
 		err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 				   EXT_CSD_HS_TIMING, val,
 				   card->ext_csd.generic_cmd6_time, 0,
-				   true, false, true);
+				   false, true);
 		if (err)
 			goto err;
 		old_timing = host->ios.timing;
@@ -1955,7 +1955,7 @@ static int mmc_poweroff_notify(struct mmc_card *card, unsigned int notify_type)
 
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			EXT_CSD_POWER_OFF_NOTIFICATION,
-			notify_type, timeout, 0, true, false, false);
+			notify_type, timeout, 0, false, false);
 	if (err)
 		pr_err("%s: Power Off Notification timed out, %u\n",
 		       mmc_hostname(card->host), timeout);
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index d2371612d536..1c5b23d99b77 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -516,7 +516,6 @@ static int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
  *	@timeout_ms: timeout (ms) for operation performed by register write,
  *                   timeout of zero implies maximum possible timeout
  *	@timing: new timing to change to
- *	@use_busy_signal: use the busy signal as response type
  *	@send_status: send status cmd to poll for busy
  *	@retry_crc_err: retry when CRC errors when polling with CMD13 for busy
  *
@@ -524,12 +523,12 @@ static int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
  */
 int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		unsigned int timeout_ms, unsigned char timing,
-		bool use_busy_signal, bool send_status,	bool retry_crc_err)
+		bool send_status, bool retry_crc_err)
 {
 	struct mmc_host *host = card->host;
 	int err;
 	struct mmc_command cmd = {};
-	bool use_r1b_resp = use_busy_signal;
+	bool use_r1b_resp = true;
 	unsigned char old_timing = host->ios.timing;
 
 	mmc_retune_hold(host);
@@ -569,10 +568,6 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 	if (err)
 		goto out;
 
-	/* No need to check card status in case of unblocking command */
-	if (!use_busy_signal)
-		goto out;
-
 	/*If SPI or used HW busy detection above, then we don't need to poll. */
 	if (((host->caps & MMC_CAP_WAIT_WHILE_BUSY) && use_r1b_resp) ||
 		mmc_host_is_spi(host))
@@ -603,7 +598,7 @@ int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		unsigned int timeout_ms)
 {
 	return __mmc_switch(card, set, index, value, timeout_ms, 0,
-			true, true, false);
+			    true, false);
 }
 EXPORT_SYMBOL_GPL(mmc_switch);
 
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 09dee8a466a0..de0c509a3a38 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -32,7 +32,7 @@ int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
 int mmc_switch_status(struct mmc_card *card, bool crc_err_fatal);
 int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		unsigned int timeout_ms, unsigned char timing,
-		bool use_busy_signal, bool send_status,	bool retry_crc_err);
+		bool send_status, bool retry_crc_err);
 int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		unsigned int timeout_ms);
 void mmc_run_bkops(struct mmc_card *card);
-- 
2.17.1

