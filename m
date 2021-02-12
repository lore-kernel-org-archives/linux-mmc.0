Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B45EC433E0
	for <linux-mmc@archiver.kernel.org>; Fri, 12 Feb 2021 13:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3429564E57
	for <linux-mmc@archiver.kernel.org>; Fri, 12 Feb 2021 13:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhBLNZA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 12 Feb 2021 08:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbhBLNY4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 12 Feb 2021 08:24:56 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E945C061574
        for <linux-mmc@vger.kernel.org>; Fri, 12 Feb 2021 05:24:15 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id g21so4969035ljl.3
        for <linux-mmc@vger.kernel.org>; Fri, 12 Feb 2021 05:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D+0z0pzX8kl0CvjEUK/fo0H55/SuussxmmPAWLGiwDw=;
        b=r7WJqKh0tyKnQCCU0xOleun34zA/iXM7vbphK2jvF9MSkqXMuv6UkoiU9MRBuvqYPL
         f4HH9WWsNdg180GfHFnYOiPrZc+L/6UWH1gZanEGKFKslh8BFsTZF8HbvWoVpcGUkdS7
         WWA3ZCes9czVliI95qDo06DZxf4RpK/ZKwoayLEVyvYSnGW4IAsoB6SFcW44N7MnJGXn
         Jp26kswzj2KJEuVRWkzA8QorVa7JZz450IKrYYBpXqqG9aHMDzJgEhpnn99k5ChNSgbV
         awj5O6pD5Yr1G4lqRVufYZ4GHLQ/QISgoVObq5qvG1q4J63CYY1rrjahbCi+tXuPQR0V
         OIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D+0z0pzX8kl0CvjEUK/fo0H55/SuussxmmPAWLGiwDw=;
        b=foXGtp/PZoOt1w9Wt4gZ83kXMCUqJk4CcWzwbbgitofa+2cAcqgcT0eTA4lc5pMYU0
         ILg7YT3LY3cIKI82UrWj+OLEoZwD8P0NB8GIU6kmh+xOalWB3lKNGRNqumX+8eUrSP1f
         NT4Mfcq6A9MU5/nZj15jpOqlk+4pBPYShesoO1w8HoY8TL/7KqiqJKILwNkuXB1lFL+0
         d3FG2tjHX74yKBzXchn3RtHqeJw862WVt1Oke1sgNaq001RnLUdVvVIGiuCJQEf/B3PB
         r5s55QabHTazuLZ7hMNMk6wGDfGuyW04+FKN5hXbl/UmUFKCYRBI7p8o2KKgaqitOxlE
         OSrw==
X-Gm-Message-State: AOAM530UCw6kZV8qQsllfEHqZsBkeouieVBPc9u/BVUKZtpMK8SRQZyP
        bIFoSZnfUhhT/qgIs3768cBEXEmvdfbecZhd
X-Google-Smtp-Source: ABdhPJzzypHjHwgX4odQHgqFTCno50p2mx8gkBj0hQfs2OxAb9pVEZMch/6242DPdp7Ne0JCBXjHjQ==
X-Received: by 2002:a05:651c:509:: with SMTP id o9mr1687221ljp.369.1613136252949;
        Fri, 12 Feb 2021 05:24:12 -0800 (PST)
Received: from localhost.localdomain (h-98-128-181-28.NA.cust.bahnhof.se. [98.128.181.28])
        by smtp.gmail.com with ESMTPSA id i18sm979205lfe.177.2021.02.12.05.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 05:24:11 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: dw_mmc: Drop redundant call to ->card_event callback
Date:   Fri, 12 Feb 2021 14:24:06 +0100
Message-Id: <20210212132406.237270-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The ->card_event callback isn't being used by any of the dw_mmc variants.
It's likely a leftover from an earlier change, hence let's just drop the
redundant call to it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/dw_mmc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index a5244435556b..df327c89cec5 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2606,8 +2606,6 @@ static void dw_mci_handle_cd(struct dw_mci *host)
 {
 	struct dw_mci_slot *slot = host->slot;
 
-	if (slot->mmc->ops->card_event)
-		slot->mmc->ops->card_event(slot->mmc);
 	mmc_detect_change(slot->mmc,
 		msecs_to_jiffies(host->pdata->detect_delay_ms));
 }
-- 
2.25.1

