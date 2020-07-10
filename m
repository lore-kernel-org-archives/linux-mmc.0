Return-Path: <SRS0=hS93=AV=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FC2C433DF
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jul 2020 11:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93FD52076A
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jul 2020 11:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWqB2c/2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgGJLH5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 10 Jul 2020 07:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgGJLHz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Jul 2020 07:07:55 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595EBC08C5DC;
        Fri, 10 Jul 2020 04:07:55 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 1so2392694pfn.9;
        Fri, 10 Jul 2020 04:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ti/RasPzpDQfCkU80y2QxpiPoAPRKGJkYJCcdL+0vLs=;
        b=VWqB2c/2mD7N1CybHi64Z60T58eMyCTiWHXE8zz0z9JBKZDY5XwX1tpqaq+i9EYfCP
         1EpnQonma3W/bIwCu1unJEghezBdiUwX3/2UkMfe/++zgyFLq64DKoevEDW6xhqe08D9
         tcvj6bMqcHaAY9M8Vo1q6tSAW9b+xt5y662KQkj8qIWYgtFcuUv5DCtBrkuv4lFJx34r
         nWTiIlsvWNuNJPWhmtZUJy5c1QdPhhtN9vXq1WV9TOwCxUfMAIC6a5EaXjskUUN4XHBL
         71lA/nmBaZKU2VykKgTwOEfifooqU5xxcIKq7YETToMwaYvXiyYpYtmRxq47gEtkV8m0
         kMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ti/RasPzpDQfCkU80y2QxpiPoAPRKGJkYJCcdL+0vLs=;
        b=UOBFXekIGJTQJRhthTJwJJYM3/fEyM29zGtPuaQ+Qyoy+6iF+eWNwcpVpZt8zp+nUU
         e60cluVw3qD/AGqaJWwBZwefYasHxQ0enwQTE/iW+ynZRdhFxutQaYiuO/WnudKP9sNs
         hTLzXYQKSGYyyT5QyXxJOCKAJsd/158NAdN/ssjpZ/k3XY9F0lb/O9YQeL94hEDm2WIv
         jXsAYzhUl7WYZSfJlAJTnO2tq3SsqjtPBdFQHnXr23ygSwLzUpDH1GzDrnQe2P197BAj
         iqQrCegwjZaZzwMSxcXr6cN4BcWQOmG6VBfvS48Ph8ZTatVbYTqy0u3F3zVsiaKhPaEm
         99/g==
X-Gm-Message-State: AOAM531ehw4PQqJvFNTVvfaR6x6S5WiS9hy4QJxm4C9ZiI/nBfW5a9+j
        eLjlrJtpUxD62lM9bfAvzsI=
X-Google-Smtp-Source: ABdhPJyTIgSD1QxyuKdo/hOw3kz38HcVnjtV13TNHThPCBsGsx7wn4iheuKlWK8i42JthGjl+OLDNA==
X-Received: by 2002:a63:5fcc:: with SMTP id t195mr48796424pgb.56.1594379274962;
        Fri, 10 Jul 2020 04:07:54 -0700 (PDT)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id g3sm5581621pfq.19.2020.07.10.04.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 04:07:54 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        greg.tu@genesyslogic.com.tw, Ben Chuang <benchuanggli@gmail.com>
Subject: [RFC PATCH V3 03/21] mmc: core: UHS-II support, skip set_chip_select()
Date:   Fri, 10 Jul 2020 19:08:38 +0800
Message-Id: <20200710110838.29018-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

mmc_set_chip_select() should be called only in UHS-I mode,
and not for UHS-II mode.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/core/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 85c83c82ad0c..c6540d56646b 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -898,8 +898,10 @@ static inline void mmc_set_ios(struct mmc_host *host)
  */
 void mmc_set_chip_select(struct mmc_host *host, int mode)
 {
-	host->ios.chip_select = mode;
-	mmc_set_ios(host);
+	if (!(host->flags & MMC_UHS2_INITIALIZED)) {
+		host->ios.chip_select = mode;
+		mmc_set_ios(host);
+	}
 }
 
 /*
-- 
2.27.0

