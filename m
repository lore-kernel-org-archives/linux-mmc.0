Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11310C433ED
	for <linux-mmc@archiver.kernel.org>; Tue,  4 May 2021 16:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5C23613BA
	for <linux-mmc@archiver.kernel.org>; Tue,  4 May 2021 16:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbhEDQOL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 4 May 2021 12:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbhEDQNs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 May 2021 12:13:48 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE91C0613ED
        for <linux-mmc@vger.kernel.org>; Tue,  4 May 2021 09:12:50 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id h4so6486582lfv.0
        for <linux-mmc@vger.kernel.org>; Tue, 04 May 2021 09:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3YPvSgtMwuWKmsANJZN3wDrqLMspZZxchfU1o9bNBS0=;
        b=mQphSbjpUQsny9Y+iTx74acCw2RC/7Rw66VAAOnWDQUbQN8E9LjjfCVAzjwDg73JYA
         2IIFyaDZjid8qqdoeGQAIR3C515ImGXr120DHipM+PWv/A7IWFOERw4csxR8Xz3MfWLM
         BXA++rt0qv0y7yOl7xPOtANwFhnssW285d9b7MaIeL/719Jnyeb7Fl7m9GuBgfjiVELN
         ofhx+tgSVyM2kJoNjey09xJSfBxoagBzS0jZrS5u5+1y1oM7dYuX66Vx3x778dqu120z
         AIVs+p3XrD8Ngj1UbGm3GJ74xLM090JwCD/Eh0r13hdXrw6GlBAK/t+2pAA/afENElZM
         c5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3YPvSgtMwuWKmsANJZN3wDrqLMspZZxchfU1o9bNBS0=;
        b=p6m+yan9NTjOjv30D2KE3cTlWDrxKH2xp5TDgeTewPwILO0OUX+jldDp+ROhI4SePJ
         COGKEp8qHT/FeCmzCqGVlw4C/vWL7H+bQCK8LUAaYzkL8bsW746ajk9JOCL3nlGmP+gq
         KyPUQGmWUNEJs1N+UovX91jiF7jbh5hIYC6u3SEj4csyZULKCE/pGZ4c0pnCoMsy6C/k
         8tsuCCsibYwVNsDSwHPtdT7L7iU0yO+pU8d6b2eswA8kCb1VdBkatyDDrqfZVosN7MSI
         2I3TPPfgBitQBVe2x6jbpbofXmQylDt68JJrE0nIX3dfcmb6gEb1lBv+Ie/q0mf/YTW4
         w+IQ==
X-Gm-Message-State: AOAM532Do+9tNzxck90aWKTa7lWGdhj39C0KFB7Rb3O6SwIftCp2KGqJ
        0nLxm+FR5agbGa+N9x9Pu/GcRUWeowJCMz4l
X-Google-Smtp-Source: ABdhPJzEg4JyZbtiP7/8bkCcH2v8n2BiNms886QzrgiideGRN2RshaK0sMxOvd1N+Ux3WM8cYYi4Ig==
X-Received: by 2002:a05:6512:c0a:: with SMTP id z10mr17587062lfu.467.1620144768925;
        Tue, 04 May 2021 09:12:48 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-180-197.NA.cust.bahnhof.se. [98.128.180.197])
        by smtp.gmail.com with ESMTPSA id s20sm164193ljs.116.2021.05.04.09.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 09:12:48 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] mmc: core: Parse the SD SCR register for support of CMD48/49 and CMD58/59
Date:   Tue,  4 May 2021 18:12:19 +0200
Message-Id: <20210504161222.101536-9-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210504161222.101536-1-ulf.hansson@linaro.org>
References: <20210504161222.101536-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

In SD spec v4.x the support for CMD48/49 and CMD58/59 were introduced as
optional features. To let the card announce whether it supports the
commands, the SCR register has been extended with corresponding support
bits. Let's parse and store this information for later use.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sd.c    | 4 +++-
 include/linux/mmc/card.h | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 2c48d6504101..de7b5f8df550 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -222,7 +222,9 @@ static int mmc_decode_scr(struct mmc_card *card)
 	else
 		card->erased_byte = 0x0;
 
-	if (scr->sda_spec3)
+	if (scr->sda_spec4)
+		scr->cmds = UNSTUFF_BITS(resp, 32, 4);
+	else if (scr->sda_spec3)
 		scr->cmds = UNSTUFF_BITS(resp, 32, 2);
 
 	/* SD Spec says: any SD Card shall set at least bits 0 and 2 */
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index f9ad35dd6012..858fc4d11240 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -139,6 +139,8 @@ struct sd_scr {
 	unsigned char		cmds;
 #define SD_SCR_CMD20_SUPPORT   (1<<0)
 #define SD_SCR_CMD23_SUPPORT   (1<<1)
+#define SD_SCR_CMD48_SUPPORT   (1<<2)
+#define SD_SCR_CMD58_SUPPORT   (1<<3)
 };
 
 struct sd_ssr {
-- 
2.25.1

