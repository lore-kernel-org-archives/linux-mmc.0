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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB89C43470
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Apr 2021 21:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D3FD600D1
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Apr 2021 21:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbhDNVXQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 14 Apr 2021 17:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbhDNVXQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Apr 2021 17:23:16 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF8DC061761;
        Wed, 14 Apr 2021 14:22:52 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id x4so25466630edd.2;
        Wed, 14 Apr 2021 14:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jb2njQFqh1J5ySivjLPwo4s6Cj9FjUtmZEwE7V7CR88=;
        b=a8uCBdhRzHnkjLZ5iCuIGdQ1dD6Zak7cm+An6QzdWX6YKJeHoGyDKqjJZshI/6ezlQ
         V+hFWU7MjzgRajmdmzxa2RhZK0fLmOqwErcVU8RQsVDSFk3rqdacvLMtYH/YWmtD2Pvq
         xwS0t0SmojfCFbzD6T+aVYh4196e2vJlQXAR+Q2I/KAZXPfI1KFTbG0dcyDAYXAqQ+3u
         kGNR7jnASChXRfg8JE53/YbXd8ZhG8XMfZ3oWphKEN3HBj42WRcOrSbwNvE0X+0lMigc
         u7NpL5jhMyd13ac2wPnxBuYViLvJYpYV1LWZvELlY0ZztefDjfZoTm3MrThqAnedH6N8
         B2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jb2njQFqh1J5ySivjLPwo4s6Cj9FjUtmZEwE7V7CR88=;
        b=bqJrM5z1WAR1badyZNala95hK+KnK6CL3MFpSdpxgSTCSHtgOu7W4LEeXlbia7nFXw
         ffXn8ZOB24u2wRybFW9hg+q6U0hQXnccEkmHcXZlwNDhswVqeDD46JA2i/qN9z5sGZUA
         4rICju33o6rqsD5Sws9DNClwH7A9k0XIBaDbCw4NhdFToM+inVQwt+79PVPHAH9TiZlj
         3LATZaHoX3NyrX873ULMgxHoSBCEHDFzMq5QLFrMEcPPsQCqO4dc2aZ9JC8sNg7YSSJf
         d06Qymw1LeaKuXdirRMnJxOLxlwBnAUpKjrSe7KV1tAa4mwQ4jHJOfX542GAfye2CkiQ
         B3Mg==
X-Gm-Message-State: AOAM530ZC1SVvDYVO58P0w08i4bE+N92RSbMun72zF+jmrgExU6GbKO+
        GDX8JsCiM20VqMGqIApGTNQ2flPokw+6hIZ2
X-Google-Smtp-Source: ABdhPJzopybsU5t9L35TApEQhlKL6BV3DHt+PoFmes+lTWIt3hsCmfp+AaX1Dh75q8VbiitKwJ7hWw==
X-Received: by 2002:a05:6402:354b:: with SMTP id f11mr221195edd.361.1618435371392;
        Wed, 14 Apr 2021 14:22:51 -0700 (PDT)
Received: from localhost.localdomain (ip5f5bec5d.dynamic.kabel-deutschland.de. [95.91.236.93])
        by smtp.gmail.com with ESMTPSA id t7sm586187edq.42.2021.04.14.14.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 14:22:51 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     ulf.hansson@linaro.org, wsa+renesas@sang-engineering.com,
        adrian.hunter@intel.com, yoshihiro.shimoda.uh@renesas.com
Cc:     beanhuo@micron.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] mmc: core: Let sanitize not retry in case of timeout/failure
Date:   Wed, 14 Apr 2021 23:22:36 +0200
Message-Id: <20210414212236.346813-3-huobean@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210414212236.346813-1-huobean@gmail.com>
References: <20210414212236.346813-1-huobean@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Not any commands need to retry in case of timeout/failure.
Currently, the sanitize command is issued by the IOCTL interface,
and once its timeouts, the user normally decides to retry or not .
Just blindly retry three times sanitize in the driver, it doesn't
help sanitize retry succeed in the end, on the contrary, it only
makes the user feel sanitize timeouts after 12 minutes.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/mmc/core/mmc_ops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 1ca0c89081be..cdf02d88fe92 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -1028,8 +1028,8 @@ int mmc_sanitize(struct mmc_card *card, unsigned int timeout_ms)
 
 	mmc_retune_hold(host);
 
-	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_SANITIZE_START,
-			 1, timeout_ms);
+	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_SANITIZE_START,
+			   1, timeout_ms, 0, true, false, 0);
 	if (err)
 		pr_err("%s: Sanitize failed err=%d\n", mmc_hostname(host), err);
 
-- 
2.25.1

