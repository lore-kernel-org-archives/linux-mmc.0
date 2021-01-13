Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90941C433E0
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 11:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3885B233CE
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 11:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbhAMLfc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Jan 2021 06:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbhAMLfb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jan 2021 06:35:31 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BCBC061794;
        Wed, 13 Jan 2021 03:34:51 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d4so911538plh.5;
        Wed, 13 Jan 2021 03:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EgaeFpmH5E2jmLvTPLmCQgBXGqs2KZHLOzG23waOJU4=;
        b=uTQbEAUnfvGxb/1IfprffX33T4aV+3NmE37L1puZ7W1KZ4cTY0YnFeKcnZTw6jpcMv
         JqDBSzuiZTKgJgnp3QP1C79XzWbh+T1GzsSqApI/x2KpujAdBziS2WuQINfNJOY/0EzG
         NBqh/9iSan8OPU126Hg4Dyy+8ZifhQmkvjjpwimGNGKhl60hpJmoX3VIeU0MgucokB0b
         ThxtTBA5P/8wTE4b5ISOSI+t3WOTucA94Z1N3SXRXpWUKYzdmf0UxiD568g99c1wZi4H
         QMjcsVSFAw6ZrmeyCexUg2fBUTL78F4x38NpaNTsTqrXIHLMVyhJg8a13E4DStM4cGhB
         k5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EgaeFpmH5E2jmLvTPLmCQgBXGqs2KZHLOzG23waOJU4=;
        b=DGRFOPnlmdF8iuP9SujuwfJupPT9KD4TX6sADryTiUdJEZVfbrJrBPxBprKmp3G9Qh
         oVPW8nkch13WATOlvbWiBx8VPyMQZbfJLrvoz2MBYyvnDAgkzEKivjhvhBuFK41U8/Tm
         GDiMQdcncWi/RZK0BXiQ5akbYzhsrTbvG2wq/dOtW3XIfDC4QmSdz7A7OK//Thh13LXb
         JKE4WJ0UGzGBd80P23tKbFkyansqh2aK5Kve3AY/xlciF0Y4kcjydc4lI0kQYfQTLu0/
         Q00FPdFxgd3wh2JE9db8gLJ+a/uO6DDPdKcIwxZhnT/YBsan5C4clNbsUJ3xj74GxO9A
         Omig==
X-Gm-Message-State: AOAM532XRnH5pGkhfog9jobuUoeaMXYQH+jNbJDj8kw5Pv0pvknG9+Wj
        z3CFL/OvSP3FuypNKStf3xQ8vv+VHU8VgXGr
X-Google-Smtp-Source: ABdhPJx8GSudA+pwINqRxgAeqUngPQu1yYkzN/3l1+grPWjmsqIsLW6d5grYc0qrXyvLTwP7CyhB+Q==
X-Received: by 2002:a17:90a:2e83:: with SMTP id r3mr1872252pjd.112.1610537691067;
        Wed, 13 Jan 2021 03:34:51 -0800 (PST)
Received: from tj.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id t23sm2415161pfc.0.2021.01.13.03.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 03:34:50 -0800 (PST)
From:   Yue Hu <zbestahu@gmail.com>
To:     ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, zbestahu@163.com
Subject: [PATCH] mmc: core: remove needless err = 0 in mmc_init_card()
Date:   Wed, 13 Jan 2021 19:34:31 +0800
Message-Id: <20210113113431.522-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.29.2.windows.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

Since they will always being in successful path to return 0 directly,
no need to set err = 0.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 drivers/mmc/core/mmc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index ff3063c..54ab1c7 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1697,7 +1697,6 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 			goto free_card;
 
 		if (err) {
-			err = 0;
 			/*
 			 * Just disable enhanced area off & sz
 			 * will try to enable ERASE_GROUP_DEF
@@ -1802,7 +1801,6 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 			pr_warn("%s: Enabling HPI failed\n",
 				mmc_hostname(card->host));
 			card->ext_csd.hpi_en = 0;
-			err = 0;
 		} else {
 			card->ext_csd.hpi_en = 1;
 		}
@@ -1831,7 +1829,6 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 			pr_warn("%s: Cache is supported, but failed to turn on (%d)\n",
 				mmc_hostname(card->host), err);
 			card->ext_csd.cache_ctrl = 0;
-			err = 0;
 		} else {
 			card->ext_csd.cache_ctrl = 1;
 		}
@@ -1851,7 +1848,6 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 				mmc_hostname(card->host));
 			card->ext_csd.cmdq_support = false;
 			card->ext_csd.cmdq_depth = 0;
-			err = 0;
 		}
 	}
 	/*
-- 
1.9.1

