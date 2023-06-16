Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B96EB64DB
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Jun 2023 20:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjFPUmg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 16 Jun 2023 16:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbjFPUmf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Jun 2023 16:42:35 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A5030EF
        for <linux-mmc@vger.kernel.org>; Fri, 16 Jun 2023 13:42:34 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so1677081e87.3
        for <linux-mmc@vger.kernel.org>; Fri, 16 Jun 2023 13:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686948153; x=1689540153;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z9MD7T6l8zvLVJ/fOvCH77GltOs80Rm4EnRGEKnGhEE=;
        b=bW16p5BgLLEVTQ/p00oo7zlTthVUlwfeRCnDG8XjhAq2/wjpG44WqM9Pqrjit2b7oe
         p+7kFWQf6kOGc6ZpikV/59oD5d0L5zRHAQl9q/QcxK1rNLWeh9L3/pvu40EGt+WxrZYX
         On3aV3NpbxGl0v+YMGuF5MJzezhMoa9mgVNOdA+8P8DoE+Y7z/SkWxn94Jw+A4CcdhDz
         RS1xBKURqdGF2cBbHIkd0ztmWwLkYAevv1ZYCI3GcVodHbMiuuAdHUG3fvOfJ7ebnkIC
         Wce3MLcMuTCfBoV/vgb9oYo5dZ/fla6jBjNgjdbf8gFp8PgUKEK4JnP3LqYgPetxp7MP
         VtrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686948153; x=1689540153;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z9MD7T6l8zvLVJ/fOvCH77GltOs80Rm4EnRGEKnGhEE=;
        b=gs7SwDmxfpHy4CQyMEWtvKqwsz9vH4R47vPWTbkWaq6FynAbtL9NeaFejXbDmy/M28
         DLnfYneF29MiDMWX94GL89vRLBfW7Q8dM0MmBmI6n/K1trjjk6QLdc/TQEYor+2VO9OS
         9KTREgXzMcw/yceVB7p/jhpkbx1QDWyGQ7FVeOPFr6eyWw3WYDW/JGjfrEkjhRW+fNiY
         uL4FQhYiLwUPDbfQoJSqMhnLEgjiKTr9D8fU2e2CXGRG/63k1079086j4kfu3US92Bha
         u+ZzCRK3nRo7Hwk+VIg2xqOuEkAcM3rzdvLvSx7qM1AVQHHIBaJGqWNcwVzsw1TCS/Rg
         2EIQ==
X-Gm-Message-State: AC+VfDyXvTODRu7Gg97xSGsVu+Jdf4UgQIY4HyaEm4QcOaaCsboZt+el
        xGRuRbHai210raaBfaL2OQ79LA==
X-Google-Smtp-Source: ACHHUZ5yX9jck7OGuqSI51rJNYwjPqBvEoCmQq3iZfXK2/VJV4HDNiIlCxvrEBDQrJnQJroZoa+MfQ==
X-Received: by 2002:ac2:5f98:0:b0:4f2:34f1:cf24 with SMTP id r24-20020ac25f98000000b004f234f1cf24mr2449109lfe.22.1686948153271;
        Fri, 16 Jun 2023 13:42:33 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id d22-20020ac244d6000000b004f845907454sm770981lfm.232.2023.06.16.13.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 13:42:32 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 16 Jun 2023 22:42:21 +0200
Subject: [PATCH v7 3/9] mmc: mmci: Stash status while waiting for busy
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-pl180-busydetect-fix-v7-3-69a7164f2a61@linaro.org>
References: <20230405-pl180-busydetect-fix-v7-0-69a7164f2a61@linaro.org>
In-Reply-To: <20230405-pl180-busydetect-fix-v7-0-69a7164f2a61@linaro.org>
To:     Stefan Hansson <newbyte@disroot.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.2
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Some interesting flags can arrive while we are waiting for
the first busy detect IRQ so OR then onto the stashed
flags so they are not missed.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v6->v7:
- No changes.
ChangeLog v4->v6:
- No changes.
ChangeLog v3->v4:
- No changes.
ChangeLog v2->v3:
- Rebased.
ChangeLog v1->v2:
- No changes
---
 drivers/mmc/host/mmci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index b2c7c2d39767..417dc3b1c744 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -713,6 +713,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 	 */
 	if (host->busy_status &&
 	    (status & host->variant->busy_detect_flag)) {
+		host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
 		writel(host->variant->busy_detect_mask, base + MMCICLEAR);
 		return false;
 	}

-- 
2.40.1

