Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610D3C43460
	for <linux-mmc@archiver.kernel.org>; Tue,  4 May 2021 16:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FBC5610A7
	for <linux-mmc@archiver.kernel.org>; Tue,  4 May 2021 16:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbhEDQNh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 4 May 2021 12:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbhEDQNg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 May 2021 12:13:36 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B2CC0613ED
        for <linux-mmc@vger.kernel.org>; Tue,  4 May 2021 09:12:40 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id n138so14140181lfa.3
        for <linux-mmc@vger.kernel.org>; Tue, 04 May 2021 09:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/ee795yxnzHs29v3TjQa721b4l02PWsrUGNagPQX+uQ=;
        b=dHVCBXheSA/nPVW+TvqCQLGQZ10Py/jY6VqG4/6GNO7B5xKIefq2DXnenApc2gSdUp
         LP0AhRlyrY2mAHLH5pEaY894wET3dw1t3OcPjOeGQBDR3LhjKQfGucKOHTk5Y6pKT93f
         AR6uaY5SgrPu9fbqt4QgOsjNRWz4n997XqkGaqJpv53dnQtL0VZ2Jnwf3OhUjzxLeb9G
         ZgcW+q0mWP3l2y9syoSGF1+Dele0STkqqimV2XS0jpUoKnw5xl1wswtj00ZM5/V0MJ35
         jsTFwUki0BL0LkhtTiIX15Wn3zlmim4qHrxgnSB9MOlGtPwqzjVInl6MCzas7VubLfKO
         Asuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/ee795yxnzHs29v3TjQa721b4l02PWsrUGNagPQX+uQ=;
        b=EEBo19izUSRg9PzYBzEEN6haNB/zMmUW93cNdXFSTgybbajaaHK85wzwQLyF9ayqIh
         tDOvFrXWcfFfGF1HelRCbkq/m3vJzWQRjTyAE+z8ALmw4CdZcws2qzqJlnP4/PwxYqSn
         dY7A97wYDQgmF1KUzlf+oFJTJcP89XoBcCyY5BIg1KVqlyuLxeiPBRa1ttGEPVs0vbNY
         A9yPoeAfZzHzoucoh18p4c1F3+AljSD3956VkW8BZ+GbAmCc51Oxit3R+5P/b+Xuu02x
         pgZTm65FlXZoSsctUmFzE6s3Rj2zEbZltVJYYCPQf38smImEgS44i90zjFoxu6jKzWuF
         OXew==
X-Gm-Message-State: AOAM531w5UGoZRvNTTChst2vonYijVQs45UE3Zs0pgJCp5WI4ln7Jt+x
        elIiTR/z1Pjrt5uYJkLqNJYRjjMd4UJAVe3M
X-Google-Smtp-Source: ABdhPJwaLC553y4EWUnONr50m/PHQiryaxLapFqcwSYnqXkOCKi79+Q6m6D8DiB+LSijTT4KL2vyaw==
X-Received: by 2002:a19:4849:: with SMTP id v70mr17190047lfa.590.1620144758840;
        Tue, 04 May 2021 09:12:38 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-180-197.NA.cust.bahnhof.se. [98.128.180.197])
        by smtp.gmail.com with ESMTPSA id s20sm164193ljs.116.2021.05.04.09.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 09:12:37 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] mmc: core: Re-structure some code in __mmc_poll_for_busy()
Date:   Tue,  4 May 2021 18:12:14 +0200
Message-Id: <20210504161222.101536-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210504161222.101536-1-ulf.hansson@linaro.org>
References: <20210504161222.101536-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

To make the code a bit more understandable, let's move the check about
whether polling is allowed or not, out to the caller instead. In this way,
we can also drop the send_status in-parameter, so let's do that.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc_ops.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 66ae699a410f..ccaee1cb7ff5 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -465,8 +465,7 @@ static int mmc_busy_status(struct mmc_card *card, bool retry_crc_err,
 }
 
 static int __mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
-			       bool send_status, bool retry_crc_err,
-			       enum mmc_busy_cmd busy_cmd)
+			       bool retry_crc_err, enum mmc_busy_cmd busy_cmd)
 {
 	struct mmc_host *host = card->host;
 	int err;
@@ -475,16 +474,6 @@ static int __mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
 	bool expired = false;
 	bool busy = false;
 
-	/*
-	 * In cases when not allowed to poll by using CMD13 or because we aren't
-	 * capable of polling by using ->card_busy(), then rely on waiting the
-	 * stated timeout to be sufficient.
-	 */
-	if (!send_status && !host->ops->card_busy) {
-		mmc_delay(timeout_ms);
-		return 0;
-	}
-
 	timeout = jiffies + msecs_to_jiffies(timeout_ms) + 1;
 	do {
 		/*
@@ -518,7 +507,7 @@ static int __mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
 int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
 		      enum mmc_busy_cmd busy_cmd)
 {
-	return __mmc_poll_for_busy(card, timeout_ms, true, false, busy_cmd);
+	return __mmc_poll_for_busy(card, timeout_ms, false, busy_cmd);
 }
 
 bool mmc_prepare_busy_cmd(struct mmc_host *host, struct mmc_command *cmd,
@@ -591,8 +580,18 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		mmc_host_is_spi(host))
 		goto out_tim;
 
+	/*
+	 * If the host doesn't support HW polling via the ->card_busy() ops and
+	 * when it's not allowed to poll by using CMD13, then we need to rely on
+	 * waiting the stated timeout to be sufficient.
+	 */
+	if (!send_status && !host->ops->card_busy) {
+		mmc_delay(timeout_ms);
+		goto out_tim;
+	}
+
 	/* Let's try to poll to find out when the command is completed. */
-	err = __mmc_poll_for_busy(card, timeout_ms, send_status, retry_crc_err,
+	err = __mmc_poll_for_busy(card, timeout_ms, retry_crc_err,
 				  MMC_BUSY_CMD6);
 	if (err)
 		goto out;
-- 
2.25.1

