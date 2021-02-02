Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D106C433E0
	for <linux-mmc@archiver.kernel.org>; Tue,  2 Feb 2021 10:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1D5564F2C
	for <linux-mmc@archiver.kernel.org>; Tue,  2 Feb 2021 10:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhBBKRR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 2 Feb 2021 05:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhBBKRQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Feb 2021 05:17:16 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EB4C061573
        for <linux-mmc@vger.kernel.org>; Tue,  2 Feb 2021 02:16:35 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id q12so27111646lfo.12
        for <linux-mmc@vger.kernel.org>; Tue, 02 Feb 2021 02:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ekx47d27Ls5WQSFPSkQR0rp/GmQo/q7sleajQGZOu+g=;
        b=X/1h2eCrVQF3IAcwLVLrbOY+c/gwmSzjKYh7YP+i/1ZmadXNpRB8t+gA0pHihwcStb
         MXlzPThwaOlCSYXqwarliVCto9c74rkArEpoPpAvf8WOvMBIruRIcIIB8fyKM1gOnh9H
         hHPw1/HPeA71DsPf/Ny3yzyNIatLXRZbaKBFMDfbYMKxsu28sOpOO0g08q9XoIA8utLz
         CF+DdSKKKUj9aovZvCnKYp9JnWKHQHlQ2fhLbzhOZLI2RnVpWq79rxay4+zpsvtw8ZGu
         d0cfvxIlaub55yvkLarDb1XG8h6sXHGTY/k4RAwtrTFnb34Y0FhJdPEVl9DYerzwOQEo
         Llmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ekx47d27Ls5WQSFPSkQR0rp/GmQo/q7sleajQGZOu+g=;
        b=jzti72o6RRbKlpI7NrVafgtEk51g9RJdHYnLqplYvaSeWdPOmi7PuU9gctDQ6dV/+U
         Y07zz3DsfMixAl6sSO7GTRUBIeXB2vL+Au9ENe0auMQEx7AHFjhsDOmOI/snmsfV7r5o
         z28OMeTybUiiPwElON/MlWcvo+j0/0WB5vhbRtyvKrTWjMZ7T4/mYYuaWA7gVtfOXhIe
         dv1LMW7K0KtoEQ8e1VeWIRA/e9mYR878RL9t8JpHB+BcBRd0RQtmTLulw3kICMBFaKOy
         75pqTdEdIDP5MSYFTgNe+fzxWZ5s8UIqvSE6YwmyscvpmPaiR/MHfSDQXog22FZwOADJ
         E0fg==
X-Gm-Message-State: AOAM532ew9O/jwOylt/IX4NlgmGoEkeKSutuTXFmyhu3GhAebqGj8UQT
        pptN2mwTVqxbnSqyTH14xSoT+zzkDb3Hq3yJ
X-Google-Smtp-Source: ABdhPJwV0B301+ZbwWpgSQsJi9Ans8tqOXAIME/s9Dq2VXqI4ltaIArlXDfJn2xm5NL+a0F0vacHQw==
X-Received: by 2002:a05:6512:902:: with SMTP id e2mr10571882lft.492.1612260993569;
        Tue, 02 Feb 2021 02:16:33 -0800 (PST)
Received: from localhost.localdomain (h-98-128-180-179.NA.cust.bahnhof.se. [98.128.180.179])
        by smtp.gmail.com with ESMTPSA id y3sm3241409lfg.208.2021.02.02.02.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 02:16:32 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: core: Drop redundant bouncesz from struct mmc_card
Date:   Tue,  2 Feb 2021 11:16:26 +0100
Message-Id: <20210202101626.64503-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The commit de3ee99b097d ("mmc: Delete bounce buffer handling") removed the
bounce buffer handling from the mmc core, but forgot to remove the bouncesz
member from the struct mmc_card, let's fix it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/linux/mmc/card.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 42df06c6b19c..f9ad35dd6012 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -311,7 +311,6 @@ struct mmc_card {
 	struct mmc_part	part[MMC_NUM_PHY_PARTITION]; /* physical partitions */
 	unsigned int    nr_parts;
 
-	unsigned int		bouncesz;	/* Bounce buffer size */
 	struct workqueue_struct *complete_wq;	/* Private workqueue */
 };
 
-- 
2.25.1

