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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E19C19F3B
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Aug 2021 22:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69A3661042
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Aug 2021 22:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236458AbhHQWn1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Aug 2021 18:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236323AbhHQWnY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Aug 2021 18:43:24 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8585FC0613C1;
        Tue, 17 Aug 2021 15:42:50 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id w21-20020a7bc1150000b02902e69ba66ce6so517942wmi.1;
        Tue, 17 Aug 2021 15:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gpMEBO/+/zx2zX25uXsvANdeVI0qcyfmsmZC6h/+wRk=;
        b=tcxkRuOt3xXTe8TyPuRlHiTOA44Taoqa4oGWdjBtgtJb4CsUOtiTI8/JuLP0vG7vqE
         ZGcDL0c35KuVyzWLGn2EBgCj5HUrfKaQzoY34B/hC0IKHzA/veVfE7ST3kxi+G3P3CAX
         RFwapMPaZcXvogSqh1o5N6pB5HfMCtHScEbvU6DLykyKoiZP0ckdEuZln3eCKpeJKwIZ
         E8mRDIpaAOKl08o2fV19eaJRKFadn39kusT73k5udU2uMsf1Hnnz/mlfjV6u0hHqp3nj
         4UcWugdNs4AiN7ZcKzjCeBBYy7rLBRJBqAJz1nVjlL2ZLgypFLEO6bgYh813rf0czcML
         0yFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gpMEBO/+/zx2zX25uXsvANdeVI0qcyfmsmZC6h/+wRk=;
        b=pEX32EDR/fe/g+zDEkO6slvUHhfpfN/zZD+sDlAvm14key/ay9ouMFF2ovwL88Pbca
         +a8Nr7DECSajsdW0TJHbvwLNlBf15TlRX0nnm2YmQlxQObdN32oi8JOeyqKDigUFZKXH
         B3TjUyK9XdPDC1yEc5vH+gGJ4LfDIbf2b8i8SlzcKoOTnjOhJp1RGcOMRZWot1q9ytQT
         ipcEOrpNiUVPeDMbZ5w93T9/yGTnDCbTvfNewdo7CnWA4cxUIx6FueCFqLem4bWVMuKl
         7LPO+ocCNLuXq9XBlmlwU7uQtcjuJNRU3nYT7QTjlev6xM3dl0+jjiBIn5y/GZl1ss28
         wE5g==
X-Gm-Message-State: AOAM531o3W+Cij4XqpjRd6awmuIaYC04qv/K1gfZOAMkYFLREyphajP5
        tH4MY5LJIKBFgDcvOlzhWV4=
X-Google-Smtp-Source: ABdhPJy4qQx9Z4md5jAFxdSNbG6S9PB482bHNldTLpBPX3lVUnkXQmhyLOWia4DW12r76kZy9rOLNw==
X-Received: by 2002:a7b:c7d1:: with SMTP id z17mr5507286wmk.50.1629240169231;
        Tue, 17 Aug 2021 15:42:49 -0700 (PDT)
Received: from localhost.localdomain (ip5f5bec31.dynamic.kabel-deutschland.de. [95.91.236.49])
        by smtp.gmail.com with ESMTPSA id a3sm3976850wrx.38.2021.08.17.15.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 15:42:49 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bean Huo <beanhuo@micron.com>
Subject: [PATCH v1 1/2] mmc: core: Issue HPI in case the BKOPS timed out
Date:   Wed, 18 Aug 2021 00:42:07 +0200
Message-Id: <20210817224208.153652-2-huobean@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210817224208.153652-1-huobean@gmail.com>
References: <20210817224208.153652-1-huobean@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

If the BKOPS timed out, the card is probably still busy in the
R1_STATE_PRG. Rather than let application in the userland continue
to wait, let's try to abort it with a HPI command to get back into
R1_STATE_TRAN.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/mmc/core/mmc_ops.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 90d213a2203f..0c54858e89c0 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -959,8 +959,15 @@ void mmc_run_bkops(struct mmc_card *card)
 	 */
 	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			 EXT_CSD_BKOPS_START, 1, MMC_BKOPS_TIMEOUT_MS);
-	if (err)
-		pr_warn("%s: Error %d starting bkops\n",
+	/*
+	 * If the BKOPS timed out, the card is probably still busy in the
+	 * R1_STATE_PRG. Rather than continue to wait, let's try to abort
+	 * it with a HPI command to get back into R1_STATE_TRAN.
+	 */
+	if (err == -ETIMEDOUT && !mmc_interrupt_hpi(card))
+		pr_warn("%s: BKOPS aborted\n", mmc_hostname(card->host));
+	else if (err)
+		pr_warn("%s: Error %d running bkops\n",
 			mmc_hostname(card->host), err);
 
 	mmc_retune_release(card->host);
-- 
2.25.1

