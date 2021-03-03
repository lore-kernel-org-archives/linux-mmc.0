Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBF9C433E6
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 00:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCF8664F69
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 00:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237612AbhCDAAU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377168AbhCCMWe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Mar 2021 07:22:34 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C43C061797
        for <linux-mmc@vger.kernel.org>; Wed,  3 Mar 2021 04:20:57 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id z11so36696707lfb.9
        for <linux-mmc@vger.kernel.org>; Wed, 03 Mar 2021 04:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=soyM9wPlLASUiUbmRQQtsdUjbF417QlwKml+91jIMqs=;
        b=H8fTVYBkdNNsM4NQ2zrh58J24JrxnUp/sbzJz+tslBM2fXthmdZg8PunTTxX5PeqZS
         wYB0hPGkc8fGLG2e26Y2ceHPXGShqZJ3egDGkhZUZ/fb72ew+VImxGywy/Jb7PiTCliF
         pW+kFtx3NpztdYl7ku0T3Q0A+CqiXg5nQJ0DIofQX1XrBw82M4XifHsHgHtqZVIF1tFh
         96lG5SdY/uKjKkP+p7vcTIpNCU00AWHHGaSNr/9RlrczOeG2/ftzIfZRBarbCI1KI2Vs
         Zu6roEFOCAYzwiYyRpMY58cJ+d5uzvVprYR7BFzeOsJTBJnANQkM+jZJEMgbix0QKwvx
         MyOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=soyM9wPlLASUiUbmRQQtsdUjbF417QlwKml+91jIMqs=;
        b=PV4eG+U6v7RWx9sTcVU8cPCGWzmp4Nxxe3TamfXvWgpCnJAlRS+ukOCcoepJRfaaa8
         wubh7hxYub71HpEwq9anQN0T2ayJGrDrgZrEYY4sR8EJYbcV6YgNPwm7cZqaxwSY3OH5
         ebRfUWU+krSp4TxPvkzZhSlPI3ZaQ727QD4LxNmxwfksIeroKnxEHuNXmeOVYiQ58d/r
         1sk/5/PJuClTQ3y/OB1JkxxaeStcZeSOMHknbqlEEPyW9/7Bt2zMfAeiz49QRCSbo+30
         v2Ag75vuXGY/yatP1LH3tyA/yP/L78g4jLA7hOBVHKs9YiOmg6ipdC2/WJCTwXvyh953
         C9FA==
X-Gm-Message-State: AOAM530UK/9Fzdelulnv5qAY53V2cWqfXNxNi/2XZ/YDPgiy/Rd0jv1E
        v22Zh8lNfcWr1umSO8Fr/NwEJpS8klB4Kg==
X-Google-Smtp-Source: ABdhPJxhQ8IEPAejaPoXzG/IU+//OTOpt03Evjcamw7wzwgLwru5/CGFu9Rsa774rOsyYUKUJqMmIA==
X-Received: by 2002:ac2:5e21:: with SMTP id o1mr14773513lfg.435.1614774055042;
        Wed, 03 Mar 2021 04:20:55 -0800 (PST)
Received: from localhost.localdomain (h-155-4-129-234.NA.cust.bahnhof.se. [155.4.129.234])
        by smtp.gmail.com with ESMTPSA id d3sm811519lfq.249.2021.03.03.04.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 04:20:54 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] mmc: block: Drop use of unlikely() in mmc_blk_probe()
Date:   Wed,  3 Mar 2021 13:20:47 +0100
Message-Id: <20210303122049.151986-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210303122049.151986-1-ulf.hansson@linaro.org>
References: <20210303122049.151986-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

mmc_blk_probe() isn't a hotpath, which makes it's questionable to use
unlikely(). Therefore let's simply drop it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 8e6a623b35de..dc6b2e8f4f95 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2888,7 +2888,7 @@ static int mmc_blk_probe(struct mmc_card *card)
 
 	card->complete_wq = alloc_workqueue("mmc_complete",
 					WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
-	if (unlikely(!card->complete_wq)) {
+	if (!card->complete_wq) {
 		pr_err("Failed to create mmc completion workqueue");
 		return -ENOMEM;
 	}
-- 
2.25.1

