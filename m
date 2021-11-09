Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42358C433F5
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Nov 2021 19:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B50161207
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Nov 2021 19:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243190AbhKIT3C (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 9 Nov 2021 14:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243162AbhKIT3B (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Nov 2021 14:29:01 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8043BC061766
        for <linux-mmc@vger.kernel.org>; Tue,  9 Nov 2021 11:26:15 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id bu18so181137lfb.0
        for <linux-mmc@vger.kernel.org>; Tue, 09 Nov 2021 11:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9U1fcZswaVveyNe1fznYM+D+TPyYVuPdJculmvVq/ks=;
        b=WnLDcW0Fg0r4DQNLTHhwsf9sb6bRjMerXAEkruLL3RitqhgJTmHfIu+eId72nJURnt
         aZW1NW+dWuRun2G65OjX5DQCOqqdN6Nqyf315yGXa66jdC5gm1OSn2Uyz0oy4DnTwng8
         0nsrekf24rf5PFhq17WrzpOSfX6mwAlrOsRzMUUQlXHFXcp+56wADP9R6hsqdR1m1bQA
         wDvi2/6mjXqtTZLV5VOWITJmI7D82vVHSzIs7uKrIu25seiYyiUrzYJBThcvxrhsJZIR
         Eac2EJI/gK3R/LJsCS+pHBBkNzhP4j9AUXWYUHmHvYPIxX3nwHLGDAp9wRZaLLscspAq
         SaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9U1fcZswaVveyNe1fznYM+D+TPyYVuPdJculmvVq/ks=;
        b=dzlPKWiOc1JzhpZe6d/AMD9Vx/onFqtCmJVvL4xkwpXH95xiXwTNg7Tk7+tyKhOsk+
         wu40DTm6WGkLduwYngCXDF4As2ySL0jiaBhQsLnODgJ0Ikb6iVob9WcMLXL4aMK3u+Df
         Owdw5a5zuFovPYJWVAvjS1Id9MHCNkchZno4oF/Sw+aKuIcaEUL4afDOytL27/Z7V8WI
         Nc51BZl8533oZPo6FZWoKv0tQGoPbLYh9kdTMVO7gA4ad8u+1p9UGMZYFUAdkxq8+keR
         I6uNpJtZdczeTM+1+BgFT6bB1FElg1rAxld8LoW4E8Xida3Zdf26HtjMuhJeppzUXuYp
         TiKQ==
X-Gm-Message-State: AOAM533M1+kLqfbBNQeydthR3n2k+2vmBcaweosLRsyzNoyPCkx7g0lr
        EXasHyMo9j7bM0UG4MYO7EOPlSHvApbqaQ==
X-Google-Smtp-Source: ABdhPJzD/gdSPZISI19GHFxGQ8gJGvNKlkDBRo4hr+K2cT3JQ9erdTVniPXm8mWNFEaQKiFTbXLXLg==
X-Received: by 2002:ac2:4e02:: with SMTP id e2mr9257911lfr.264.1636485973441;
        Tue, 09 Nov 2021 11:26:13 -0800 (PST)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id d24sm125134lfb.139.2021.11.09.11.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 11:26:12 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "H . Nikolaus Schaller" <hns@goldelico.com>,
        Jerome Pouiller <jerome.pouiller@silabs.com>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: core: Fixup storing of OCR for MMC_QUIRK_NONSTD_SDIO
Date:   Tue,  9 Nov 2021 20:25:47 +0100
Message-Id: <20211109192547.28679-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The mmc core takes a specific path to support initializing of a
non-standard SDIO card. This is triggered by looking for the card-quirk,
MMC_QUIRK_NONSTD_SDIO.

In mmc_sdio_init_card() this gets rather messy, as it causes the code to
bail out earlier, compared to the usual path. This leads to that the OCR
doesn't get saved properly in card->ocr. Fortunately, only omap_hsmmc has
been using the MMC_QUIRK_NONSTD_SDIO and is dealing with the issue, by
assigning a hardcoded value (0x80) to card->ocr from an ->init_card() ops.

To make the behaviour consistent, let's instead rely on the core to save
the OCR in card->ocr during initialization.

Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sdio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 68edf7a615be..5447c47157aa 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -708,6 +708,8 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	if (host->ops->init_card)
 		host->ops->init_card(host, card);
 
+	card->ocr = ocr_card;
+
 	/*
 	 * If the host and card support UHS-I mode request the card
 	 * to switch to 1.8V signaling level.  No 1.8v signalling if
@@ -820,7 +822,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 			goto mismatch;
 		}
 	}
-	card->ocr = ocr_card;
+
 	mmc_fixup_device(card, sdio_fixup_methods);
 
 	if (card->type == MMC_TYPE_SD_COMBO) {
-- 
2.25.1

