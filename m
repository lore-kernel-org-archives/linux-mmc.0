Return-Path: <SRS0=92ZL=3Y=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64BFC3524D
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Feb 2020 08:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FDEF2087E
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Feb 2020 08:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HmBIPL1I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgBDIzW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 4 Feb 2020 03:55:22 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36959 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgBDIzV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Feb 2020 03:55:21 -0500
Received: by mail-lf1-f67.google.com with SMTP id b15so11651327lfc.4
        for <linux-mmc@vger.kernel.org>; Tue, 04 Feb 2020 00:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dhFxxDwJUKLwoCX90rahTvLMvFdyoyjOAB1gpaNjDR0=;
        b=HmBIPL1IiIS5Iy0IF/WVJ03hd1Mp1oBR7RlgZmVxd0DgNnwrMFGPsqqhnSIYMthEtb
         D8RkrugqbII51Zmble1Ef0hjj7mUKMm9Q/SBZeN+7atMFQlYSbruhK5r+DGsaqpRraMu
         f8aAlDXX2u04LhGFDz9Mjk/v0vgGNgZmMY5gUFV1QVGV8aXmxTLW4/YJL+8un1cWKFjl
         nYDXKuKqU+IGIxHTh2zfXzxlsKUzFIUIyTC8LiKv5Pyh2NMOE0DSC0ETQpITgt+eMrcf
         KK7c0fpGEKO5GLSE8qdnSS+ns7DriHOBvENTxC1qlY8d4exm9KMHEO/iNMiMSpfRPGMq
         Grvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dhFxxDwJUKLwoCX90rahTvLMvFdyoyjOAB1gpaNjDR0=;
        b=qu9ZxLrTIqwaaCAKYkMnOnwHxqJ/Oh8dVwmr9JO5llzHdWMaM2KyRgCdnZztSlqsWE
         DMNK1k3Zk81O/bheAlXNrPMfcXe0sGL1OMXKADobhiBreFlgYC7Xqtq1YWJBwClET3kq
         swo6y9zZP3O1DDCKs5Xr9ycYpMtymecpptdkZ17bTr21SQHD2SCN8fGrKHApXLAEm5I9
         YyDT+5EMrSd7WmMTJvEzlBTEbELb66oqNhxm2jLw5AycNZgKOaVghxA7JGnSW/b4XJMi
         j3dkcVUmSPlsw31O5MGfqyPC2SNmvNgA4Pje3IfSrEgMBkukV/w7nnedF71Pz/zsOgnz
         +J+w==
X-Gm-Message-State: APjAAAWYSSt6I4jCadG80BpKwLErNxz2nTbQiCfH3UG+Rn67CxhoM2tN
        FdH9y5dQKK0rO8o5FS9wNrq6fUC72vU=
X-Google-Smtp-Source: APXvYqxhxo3lUSX7fVwBs4DYVvPjzYUCpEfzxo0MqI0b0yuM7qaAfZm/BIeDe1tW5Sb6Pyco0IQdLg==
X-Received: by 2002:ac2:5f59:: with SMTP id 25mr14334983lfz.193.1580806519186;
        Tue, 04 Feb 2020 00:55:19 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id n2sm11156283ljj.1.2020.02.04.00.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 00:55:18 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Shawn Lin <shawn.lin@rock-chips.com>, mirq-linux@rere.qmqm.pl
Subject: [PATCH 08/12] mmc: core: Convert to mmc_poll_for_busy() for erase/trim/discard
Date:   Tue,  4 Feb 2020 09:54:45 +0100
Message-Id: <20200204085449.32585-9-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200204085449.32585-1-ulf.hansson@linaro.org>
References: <20200204085449.32585-1-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Rather than open coding the polling loop in mmc_do_erase(), let's convert
to use mmc_poll_for_busy().

To allow a slightly different error parsing during polling, compared to the
__mmc_switch() case, a new in-parameter to mmc_poll_for_busy() is needed,
but other than that the conversion is straight forward.

Besides addressing the open coding issue, moving to mmc_poll_for_busy() for
erase/trim/discard improves the behaviour according to below.

- Adds support for polling via the optional ->card_busy() host ops.
- Returns zero to indicate success when the final polling attempt finds the
  card non-busy, even if the timeout expired.
- Exits the polling loop when state moves to R1_STATE_TRAN, rather than
  when leaving R1_STATE_PRG.
- Decreases the starting range for throttling to 32-64us.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c    | 36 ++----------------------------------
 drivers/mmc/core/mmc_ops.c | 30 ++++++++++++++++++++++++------
 drivers/mmc/core/mmc_ops.h |  7 +++++++
 3 files changed, 33 insertions(+), 40 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index aa54d359dab7..6b38c194d74f 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1658,8 +1658,6 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
 	struct mmc_command cmd = {};
 	unsigned int qty = 0, busy_timeout = 0;
 	bool use_r1b_resp = false;
-	unsigned long timeout;
-	int loop_udelay=64, udelay_max=32768;
 	int err;
 
 	mmc_retune_hold(card->host);
@@ -1760,38 +1758,8 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
 	if ((card->host->caps & MMC_CAP_WAIT_WHILE_BUSY) && use_r1b_resp)
 		goto out;
 
-	timeout = jiffies + msecs_to_jiffies(busy_timeout);
-	do {
-		memset(&cmd, 0, sizeof(struct mmc_command));
-		cmd.opcode = MMC_SEND_STATUS;
-		cmd.arg = card->rca << 16;
-		cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
-		/* Do not retry else we can't see errors */
-		err = mmc_wait_for_cmd(card->host, &cmd, 0);
-		if (err || R1_STATUS(cmd.resp[0])) {
-			pr_err("error %d requesting status %#x\n",
-				err, cmd.resp[0]);
-			err = -EIO;
-			goto out;
-		}
-
-		/* Timeout if the device never becomes ready for data and
-		 * never leaves the program state.
-		 */
-		if (time_after(jiffies, timeout)) {
-			pr_err("%s: Card stuck in programming state! %s\n",
-				mmc_hostname(card->host), __func__);
-			err =  -EIO;
-			goto out;
-		}
-		if ((cmd.resp[0] & R1_READY_FOR_DATA) &&
-		    R1_CURRENT_STATE(cmd.resp[0]) != R1_STATE_PRG)
-			break;
-
-		usleep_range(loop_udelay, loop_udelay*2);
-		if (loop_udelay < udelay_max)
-			loop_udelay *= 2;
-	} while (1);
+	/* Let's poll to find out when the erase operation completes. */
+	err = mmc_poll_for_busy(card, busy_timeout, MMC_BUSY_ERASE);
 
 out:
 	mmc_retune_release(card->host);
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index c14e24570b4e..5643277a4eeb 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -445,7 +445,7 @@ int mmc_switch_status(struct mmc_card *card, bool crc_err_fatal)
 }
 
 static int mmc_busy_status(struct mmc_card *card, bool retry_crc_err,
-			   bool *busy)
+			   enum mmc_busy_cmd busy_cmd, bool *busy)
 {
 	struct mmc_host *host = card->host;
 	u32 status = 0;
@@ -464,7 +464,17 @@ static int mmc_busy_status(struct mmc_card *card, bool retry_crc_err,
 	if (err)
 		return err;
 
-	err = mmc_switch_status_error(card->host, status);
+	switch (busy_cmd) {
+	case MMC_BUSY_CMD6:
+		err = mmc_switch_status_error(card->host, status);
+		break;
+	case MMC_BUSY_ERASE:
+		err = R1_STATUS(status) ? -EIO : 0;
+		break;
+	default:
+		err = -EINVAL;
+	}
+
 	if (err)
 		return err;
 
@@ -472,8 +482,9 @@ static int mmc_busy_status(struct mmc_card *card, bool retry_crc_err,
 	return 0;
 }
 
-static int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
-			bool send_status, bool retry_crc_err)
+static int __mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
+			       bool send_status, bool retry_crc_err,
+			       enum mmc_busy_cmd busy_cmd)
 {
 	struct mmc_host *host = card->host;
 	int err;
@@ -500,7 +511,7 @@ static int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
 		 */
 		expired = time_after(jiffies, timeout);
 
-		err = mmc_busy_status(card, retry_crc_err, &busy);
+		err = mmc_busy_status(card, retry_crc_err, busy_cmd, &busy);
 		if (err)
 			return err;
 
@@ -522,6 +533,12 @@ static int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
 	return 0;
 }
 
+int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
+		      enum mmc_busy_cmd busy_cmd)
+{
+	return __mmc_poll_for_busy(card, timeout_ms, true, false, busy_cmd);
+}
+
 /**
  *	__mmc_switch - modify EXT_CSD register
  *	@card: the MMC card associated with the data transfer
@@ -589,7 +606,8 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		goto out_tim;
 
 	/* Let's try to poll to find out when the command is completed. */
-	err = mmc_poll_for_busy(card, timeout_ms, send_status, retry_crc_err);
+	err = __mmc_poll_for_busy(card, timeout_ms, send_status, retry_crc_err,
+				  MMC_BUSY_CMD6);
 	if (err)
 		goto out;
 
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index de0c509a3a38..8cd05fb583da 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -10,6 +10,11 @@
 
 #include <linux/types.h>
 
+enum mmc_busy_cmd {
+	MMC_BUSY_CMD6,
+	MMC_BUSY_ERASE,
+};
+
 struct mmc_host;
 struct mmc_card;
 
@@ -30,6 +35,8 @@ int mmc_interrupt_hpi(struct mmc_card *card);
 int mmc_can_ext_csd(struct mmc_card *card);
 int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
 int mmc_switch_status(struct mmc_card *card, bool crc_err_fatal);
+int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
+		      enum mmc_busy_cmd busy_cmd);
 int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		unsigned int timeout_ms, unsigned char timing,
 		bool send_status, bool retry_crc_err);
-- 
2.17.1

