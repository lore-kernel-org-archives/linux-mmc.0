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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802DEC433E6
	for <linux-mmc@archiver.kernel.org>; Tue, 19 Jan 2021 07:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3260022D73
	for <linux-mmc@archiver.kernel.org>; Tue, 19 Jan 2021 07:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730636AbhASHik (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 Jan 2021 02:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730713AbhASHih (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Jan 2021 02:38:37 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D393C061573;
        Mon, 18 Jan 2021 23:37:57 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 30so12471357pgr.6;
        Mon, 18 Jan 2021 23:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TqdVhjuNY9HRhck/delB4RKqtQGRHkMOXaQGCBlJKgE=;
        b=ebf5V31pP3GbUuALPCdazFeYHfhHD3NE5k0Yp0kgkM4gPNcFuxj3i5h58SLmgX2KXZ
         DzLq7IXr4OK6oXxyh8k5ODpm7w5gsJHToWdkz/duEv5MKoRjx0D1QeQ2CCzDzhlJUJsw
         j3gV3iypE8J85nfSFt+KVdeNmt2fn95eIoe6lZFUce7URyQfN1NSjFH5I7tpBEKU8pWM
         PBOukGWLi0dTcXsztJ34cTH7tkSo+/sdOhSo9Cy91SHdriKKDAz2zWgRqPukQYADj3Uc
         eMXJ+u+2AtV5zYKUSWvHMCPlXmHql4IFlmOOZu/mo4drc2dMu4NAOwdGMDlPgy2LPkAY
         gNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TqdVhjuNY9HRhck/delB4RKqtQGRHkMOXaQGCBlJKgE=;
        b=YaF2dbve5YPHkJAXQkJ5kLHY97NgGZICYQxN+p2/L62RUlL3i3AUi85beXeO7rnaGB
         wqMyHeSgJxWHbVj5KndR6Qb8YXbEejWPWoNLYoecn9EAJha0QjoRneZomWAopY3OH0Gl
         LQnDmdF7/zA3OmdLcbBGNu8DDZGBOXCH7sJzILu2T8oMjBJoWFMpuxUiO79y9JKSv7Oh
         HjGnHyTmL1CA6qFTW4fxJshfyTNZouhr/+FyoXZol6pObmV8hKmjq1xThmnABigoNDeR
         N2nzcqZrIfCt0nhf/quO+lmqcRDhxZLKyM+t40u4lVM+3Y4b1yY8jFlry/nHo/JbJOep
         zseQ==
X-Gm-Message-State: AOAM53384ZvdLWWoZObEGE6ZnhdMw05KlAEXuAakJcsm80cEwva9wh7R
        pM4dKeFzx6Gs3Toj6xhiv0M=
X-Google-Smtp-Source: ABdhPJw+Euyv24yOdnB32PO0aMRWM60iLsWK2dxUAJB0YjBWo0UppR4Rb5ETZ/+fJI5kAGoTBmlSCg==
X-Received: by 2002:a63:ac19:: with SMTP id v25mr3331438pge.258.1611041877042;
        Mon, 18 Jan 2021 23:37:57 -0800 (PST)
Received: from tj.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id t6sm1834159pjg.49.2021.01.18.23.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 23:37:56 -0800 (PST)
From:   Yue Hu <zbestahu@gmail.com>
To:     ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, zbestahu@163.com
Subject: [PATCH] mmc: test: clean up mmc_test_cleanup()
Date:   Tue, 19 Jan 2021 15:37:05 +0800
Message-Id: <20210119073705.375-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.29.2.windows.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

mmc_test_cleanup() has same body as __mmc_test_prepare() with write
except the character to memset().

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 drivers/mmc/core/mmc_test.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
index f999b48..39a4788 100644
--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -624,7 +624,7 @@ static unsigned int mmc_test_capacity(struct mmc_card *card)
  * Fill the first couple of sectors of the card with known data
  * so that bad reads/writes can be detected
  */
-static int __mmc_test_prepare(struct mmc_test_card *test, int write)
+static int __mmc_test_prepare(struct mmc_test_card *test, int write, int val)
 {
 	int ret, i;
 
@@ -633,7 +633,7 @@ static int __mmc_test_prepare(struct mmc_test_card *test, int write)
 		return ret;
 
 	if (write)
-		memset(test->buffer, 0xDF, 512);
+		memset(test->buffer, val, 512);
 	else {
 		for (i = 0; i < 512; i++)
 			test->buffer[i] = i;
@@ -650,31 +650,17 @@ static int __mmc_test_prepare(struct mmc_test_card *test, int write)
 
 static int mmc_test_prepare_write(struct mmc_test_card *test)
 {
-	return __mmc_test_prepare(test, 1);
+	return __mmc_test_prepare(test, 1, 0xDF);
 }
 
 static int mmc_test_prepare_read(struct mmc_test_card *test)
 {
-	return __mmc_test_prepare(test, 0);
+	return __mmc_test_prepare(test, 0, 0);
 }
 
 static int mmc_test_cleanup(struct mmc_test_card *test)
 {
-	int ret, i;
-
-	ret = mmc_test_set_blksize(test, 512);
-	if (ret)
-		return ret;
-
-	memset(test->buffer, 0, 512);
-
-	for (i = 0; i < BUFFER_SIZE / 512; i++) {
-		ret = mmc_test_buffer_transfer(test, test->buffer, i, 512, 1);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
+	return __mmc_test_prepare(test, 1, 0);
 }
 
 /*******************************************************************/
-- 
1.9.1

