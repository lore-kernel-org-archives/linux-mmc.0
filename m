Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5FBC433E0
	for <linux-mmc@archiver.kernel.org>; Mon, 18 Jan 2021 08:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FBE6229C6
	for <linux-mmc@archiver.kernel.org>; Mon, 18 Jan 2021 08:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387740AbhARIhE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 18 Jan 2021 03:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387720AbhARIhC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Jan 2021 03:37:02 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58779C061573;
        Mon, 18 Jan 2021 00:36:22 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id e9so4089518plh.3;
        Mon, 18 Jan 2021 00:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QCCyHU2zDMLrImBBL+/S28Nlgaq/M9LMxN1voLK5Ag8=;
        b=Ii48X1Br+3Xd3OjdEn1IO2Ko2V6sKOYzCTUMxqYjIb7CS0M5vfjx8rsGlA1PbnHOiB
         I102wbgyMfVIub9wLwcn8L9sXhBwNIkn5daeDlRTr2IljmwNHv6UeB2mj0Km4wnoK3Ba
         k205DXWeuNj5kNfwl5pi185Y+FxYjRXNCf59nmFgRSsLqVZiDgIzpEmlsPPKIWutX1e3
         TDZKGMll11ZrqxjZWlh4ftn6coP3LlfxzJtD8NVFzoPPMdkdGWr48tUbCVOHDD0l9+8/
         dPKiesz3wr6/wY9NLVgAfvbXm31xS6e8V9r8lGmwXHT6HyZhLzTFT7FuHdBePh+R7c6Z
         rlMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QCCyHU2zDMLrImBBL+/S28Nlgaq/M9LMxN1voLK5Ag8=;
        b=drmOwCVY3Vh08ivb+Fg5xKFSUJJ/MJrAPJ9+mb3GtbqtRQjmAjxGtU4y7GzmowCLyw
         ZWeoDzd7qaD1BRwyZGgpuHp0utNPlMf5RrxohEDi+3tZKbDkrdXRsOqj8mQFA6G1tqCo
         ATbFi39CIzEGUG7FQmN1VECmHK1yIwsRJQNDBLRtVVvHifZbhLok0NTWjutRCsRMgCMb
         E7jGSxOrV7OppRe8MPlRKMwBc67kRfr5QRqr76Q8bHaM8fLPsJScq2jbzn2kpe8sEhcd
         JSt/vZFOo5qOc8pHq9de5b0gsypoMjVHemkoO9mp8zaGVMLke8DtO3ry9rtIIRnkBEK7
         4I2A==
X-Gm-Message-State: AOAM5302ikBccFs9GqatBwTmdfaRVViBknOgGFmNUNiQasmG9FxkXfGq
        j8z48kaB8sf/kx/lIJjNlvs=
X-Google-Smtp-Source: ABdhPJzhnyfKfDpYekqRJ/gBZVac6GjK0/7PaBkqfjwCQmdhSagVa6namIAasOUBHZ/l2YryzriWtg==
X-Received: by 2002:a17:90a:2947:: with SMTP id x7mr543656pjf.157.1610958982037;
        Mon, 18 Jan 2021 00:36:22 -0800 (PST)
Received: from tj.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id e21sm15170528pgv.74.2021.01.18.00.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 00:36:21 -0800 (PST)
From:   Yue Hu <zbestahu@gmail.com>
To:     ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        pali@kernel.org, huyue2@yulong.com, zhangwen@yulong.com,
        zbestahu@163.com
Subject: [PATCH] mmc: core: remove unused host parameter of mmc_sd_get_csd()
Date:   Mon, 18 Jan 2021 16:35:39 +0800
Message-Id: <20210118083539.183-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.29.2.windows.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

The host parameter host is not used in the body of mmc_sd_get_csd(),
so let's remove it. Also update related code.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 drivers/mmc/core/sd.c   | 4 ++--
 drivers/mmc/core/sd.h   | 2 +-
 drivers/mmc/core/sdio.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 6f054c4..6fa51a6 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -860,7 +860,7 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr)
 	return err;
 }
 
-int mmc_sd_get_csd(struct mmc_host *host, struct mmc_card *card)
+int mmc_sd_get_csd(struct mmc_card *card)
 {
 	int err;
 
@@ -1046,7 +1046,7 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 	}
 
 	if (!oldcard) {
-		err = mmc_sd_get_csd(host, card);
+		err = mmc_sd_get_csd(card);
 		if (err)
 			goto free_card;
 
diff --git a/drivers/mmc/core/sd.h b/drivers/mmc/core/sd.h
index 497c026..1af5a03 100644
--- a/drivers/mmc/core/sd.h
+++ b/drivers/mmc/core/sd.h
@@ -10,7 +10,7 @@
 struct mmc_card;
 
 int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr);
-int mmc_sd_get_csd(struct mmc_host *host, struct mmc_card *card);
+int mmc_sd_get_csd(struct mmc_card *card);
 void mmc_decode_cid(struct mmc_card *card);
 int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card,
 	bool reinit);
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 694a212..0fda778 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -751,7 +751,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	 * Read CSD, before selecting the card
 	 */
 	if (!oldcard && card->type == MMC_TYPE_SD_COMBO) {
-		err = mmc_sd_get_csd(host, card);
+		err = mmc_sd_get_csd(card);
 		if (err)
 			goto remove;
 
-- 
1.9.1

