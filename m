Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3560CC11F68
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Jul 2021 13:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 216CE6142C
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Jul 2021 13:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbhGBNpT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 2 Jul 2021 09:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbhGBNpS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Jul 2021 09:45:18 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E59C061764
        for <linux-mmc@vger.kernel.org>; Fri,  2 Jul 2021 06:42:46 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id x20so13392976ljc.5
        for <linux-mmc@vger.kernel.org>; Fri, 02 Jul 2021 06:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3pL4MvxeWog2IfLGYd7eKX1l2HS5OPUQFZV3aIXsKoU=;
        b=nv08IjPcm+Hty4Sfpv6VlE2MwUc+YQ6djusyBTlemq2QO4zTYkE5Wliw8U9hmoCNH6
         +8OoyCP2c0aigcm2jF8FsL2zPS6ew+KDiNDtTKLepR8Mf9f5x1m+ldINo5Qeqkk/M0Z+
         k1b7E6CH4JqzukdAFcOHdOT0YmNi7+rCpogKoz0HLPCbHL4wlBTXrl/5wVPUAn3zI41s
         DHchW5QY943HsLRExewAcTc9iLyElLN7nVViRLAqyttIbanU973GIDlQtTfxcxfJrqbN
         S9/9gk9+8T8iCxwVIOSsgXbxWT3YK1xkIhDzUbKDjMOfqvaioD2TYsuOQ8Nin85Wyr4o
         Psdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3pL4MvxeWog2IfLGYd7eKX1l2HS5OPUQFZV3aIXsKoU=;
        b=g4G9RL+TSWnC1MyGoZ3cLmBi6OX2/lvmMG359k0U40WMLz7J8Tw0HkwKPHJUUrxuod
         NhyfsdJsZ2Z8iwU26mXJf+d6KMnprDfLtHiZu4J51FuBXawn6zRW0CEkD4swplgvUsps
         okKCj7yasNQx99t5gCPkoE6IV/+ldULeMV/2A/uQq3tibyYBOfHGpmEJnsYqrJBbofBC
         Sv2byzOuT61vzH5BmTajYOhQoGq9bCcvdOfogDYqs8CQqc4U26ajY9jbzREsFtPJxjvv
         6CYbTdeS0j+TwSWbNpGDW1aMsjjMKe1xudX78A0fDb0t6r91gyKNE680apnu31FR9H5i
         XTSA==
X-Gm-Message-State: AOAM532Uj4r4loKtZ851HHLsHLwe8pKGo2tTJ1HhnEzlq3XMJ1TwKzvR
        1pykmruOiOpJGwSIdpy86JSfPvt3zH8eUPVL
X-Google-Smtp-Source: ABdhPJwD0eRwhqZIHnQ52EyyAN9A8UlJ0xC8X2hYvZ5HvnpXibYcI5DKr+pTGJkxqY2tl1jB1dynPA==
X-Received: by 2002:a2e:804d:: with SMTP id p13mr3936926ljg.324.1625233364409;
        Fri, 02 Jul 2021 06:42:44 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id u5sm277486lfg.268.2021.07.02.06.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 06:42:43 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Christian Lohle <CLoehle@hyperstone.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] mmc: core: Avoid hogging the CPU while polling for busy in the I/O err path
Date:   Fri,  2 Jul 2021 15:42:27 +0200
Message-Id: <20210702134229.357717-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210702134229.357717-1-ulf.hansson@linaro.org>
References: <20210702134229.357717-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

When mmc_blk_fix_state() sends a CMD12 to try to move the card into the
transfer state, it calls card_busy_detect() to poll for the card's state
with CMD13. This is done without any delays in between the commands being
sent.

Rather than fixing card_busy_detect() in this regards, let's instead
convert into using the common mmc_poll_for_busy(), which also helps us to
avoid open-coding.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/block.c   | 2 +-
 drivers/mmc/core/mmc_ops.c | 4 +++-
 drivers/mmc/core/mmc_ops.h | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 88f4c215caa6..1b5576048cdb 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1630,7 +1630,7 @@ static int mmc_blk_fix_state(struct mmc_card *card, struct request *req)
 
 	mmc_blk_send_stop(card, timeout);
 
-	err = card_busy_detect(card, timeout, NULL);
+	err = mmc_poll_for_busy(card, timeout, false, MMC_BUSY_IO);
 
 	mmc_retune_release(card->host);
 
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 973756ed4016..e2c431c0ce5d 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -435,7 +435,7 @@ static int mmc_busy_cb(void *cb_data, bool *busy)
 	u32 status = 0;
 	int err;
 
-	if (host->ops->card_busy) {
+	if (data->busy_cmd != MMC_BUSY_IO && host->ops->card_busy) {
 		*busy = host->ops->card_busy(host);
 		return 0;
 	}
@@ -457,6 +457,7 @@ static int mmc_busy_cb(void *cb_data, bool *busy)
 		break;
 	case MMC_BUSY_HPI:
 	case MMC_BUSY_EXTR_SINGLE:
+	case MMC_BUSY_IO:
 		break;
 	default:
 		err = -EINVAL;
@@ -521,6 +522,7 @@ int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
 
 	return __mmc_poll_for_busy(card, timeout_ms, &mmc_busy_cb, &cb_data);
 }
+EXPORT_SYMBOL_GPL(mmc_poll_for_busy);
 
 bool mmc_prepare_busy_cmd(struct mmc_host *host, struct mmc_command *cmd,
 			  unsigned int timeout_ms)
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 41ab4f573a31..ae25ffc2e870 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -15,6 +15,7 @@ enum mmc_busy_cmd {
 	MMC_BUSY_ERASE,
 	MMC_BUSY_HPI,
 	MMC_BUSY_EXTR_SINGLE,
+	MMC_BUSY_IO,
 };
 
 struct mmc_host;
-- 
2.25.1

