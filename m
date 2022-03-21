Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741D9C433FE
	for <linux-mmc@archiver.kernel.org>; Mon, 21 Mar 2022 11:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346936AbiCULxR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 21 Mar 2022 07:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346926AbiCULwu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Mar 2022 07:52:50 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FB6158564
        for <linux-mmc@vger.kernel.org>; Mon, 21 Mar 2022 04:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=yXa+PC2KmL1IZD
        J2XME9ff+HOtr6XglrIc3LVEsRp0Q=; b=1fkXXOo7cufzqodsI99ct7VYaxGoKP
        YJE3uQyyTP2bD0yLLjSmqgfj/YYoZbWum0ff+InpsqReZvam+WS6Evt52eXKgy2y
        cRAeM9CJLt0m9FEZuQojWDQfNmsvKOw3CrITOYFXzi2NfrX0XUpKT9Ho8vA3qUKF
        yZB7tplc5/ZJY=
Received: (qmail 860402 invoked from network); 21 Mar 2022 12:51:09 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 21 Mar 2022 12:51:09 +0100
X-UD-Smtp-Session: l3s3148p1@Lw29HLnaDKcgAQnoAFxnAN8BywfgXJ9V
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [RFC PATCH 06/10] mmc: core: remove fallback for mmc_hw_reset()
Date:   Mon, 21 Mar 2022 12:50:52 +0100
Message-Id: <20220321115059.21803-7-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220321115059.21803-1-wsa+renesas@sang-engineering.com>
References: <20220321115059.21803-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

All users have been converted, the fallback can go now.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/core/core.c  | 6 ------
 include/linux/mmc/core.h | 1 -
 2 files changed, 7 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 71e75196bc53..7a2985dde0e6 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2018,12 +2018,6 @@ int mmc_card_hw_reset(struct mmc_card *card)
 }
 EXPORT_SYMBOL(mmc_card_hw_reset);
 
-int mmc_hw_reset(struct mmc_host *host)
-{
-	return mmc_card_hw_reset(host->card);
-}
-EXPORT_SYMBOL(mmc_hw_reset);
-
 int mmc_sw_reset(struct mmc_host *host)
 {
 	int ret;
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 25a7cf69d919..7759502c8c67 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -175,7 +175,6 @@ void mmc_wait_for_req(struct mmc_host *host, struct mmc_request *mrq);
 int mmc_wait_for_cmd(struct mmc_host *host, struct mmc_command *cmd,
 		int retries);
 
-int mmc_hw_reset(struct mmc_host *host);
 int mmc_card_hw_reset(struct mmc_card *card);
 int mmc_sw_reset(struct mmc_host *host);
 void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card);
-- 
2.30.2

