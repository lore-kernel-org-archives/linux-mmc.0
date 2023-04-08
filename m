Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8CFC77B61
	for <linux-mmc@archiver.kernel.org>; Sat,  8 Apr 2023 22:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjDHWAs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 8 Apr 2023 18:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjDHWAq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 8 Apr 2023 18:00:46 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EB255BF
        for <linux-mmc@vger.kernel.org>; Sat,  8 Apr 2023 15:00:45 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id d7so13374720lfj.3
        for <linux-mmc@vger.kernel.org>; Sat, 08 Apr 2023 15:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680991243;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/LHmw5cP/mktYU3ZkTHFGE0ry3dquVBbcV8PSndMvnw=;
        b=yMyhy+Ihg6G5x+T2QZ+9BFIOcqTsNMP/ImmEzutXidDwICWaT+uedcy7b52mXWVDFQ
         v42FmEeZSJ/xKI6NXJkmNIvbtLvrO5MtD2I5gUIsVxJYRQgdqMOre+bgy31fXctRjDmZ
         09FNLUNXAKMIEJUex7HQkMSAfh2pGeF0yeTrSDgDd22ZCbx2IuplZncdJhRIafiCPlDC
         nYkqloRGn8cnMuJ7dCH5CHEZlvpySriNKnQejQwn6ZCCQyonS6vNPRMuHdtZ7LSsveuU
         4ZmO7Brq/Wz71O651U1oAKoY4tPEcXIrTLcoUtZqylvlldjiV/rbOmSJxhXSIcUaU09w
         HxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680991243;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/LHmw5cP/mktYU3ZkTHFGE0ry3dquVBbcV8PSndMvnw=;
        b=YyrDhhT8SYgza9srCrMzFupBCqxjlv4c9dgynW4qjEAqBfMdck2hC6D9WyPNWL7yai
         sSCSSWXW1T5ZLQkQz7RPZxDXW4OsJpoEfRoU5XJwXNj2dcQHsKSj6tmqNHIlZlQKSYFv
         H6ldlSksPm2j1YEmcf/NM29PqUQ2ADYXFAE89V9zv9hc1p06QOqtNFef/UHxJeCeMtHy
         ck9R/ZbOfDL3IVNYjZsEqcoy3h5BKFnLari0gqx0V61MTKt4uJJtEC/FZqQ96V6oBgNm
         UN7XUaAP0xET7THdGOMU08oxlLmv/c2D67CuXW1en7sRxAibvigPGTKZq4bhCF9KsAVm
         1Lhw==
X-Gm-Message-State: AAQBX9fTDxoizNdtWxJqOceUZbNyANl+lTQA5Z00ym2IPR2T42fWrjZK
        8Zq6ex/cGIN0qQwhkNaTJgIb2Q==
X-Google-Smtp-Source: AKy350ZuZSKTqn5CvyZR6lbMeyKnlxxnApYA3GcKVyg/68BqUZNskF5lIsVOhC+ly4y81O2l7Q2/OQ==
X-Received: by 2002:ac2:551b:0:b0:4dd:9eb6:443e with SMTP id j27-20020ac2551b000000b004dd9eb6443emr1606943lfk.31.1680991243598;
        Sat, 08 Apr 2023 15:00:43 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id v9-20020a056512048900b004e9cad1cd7csm1328904lfq.229.2023.04.08.15.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 15:00:43 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 09 Apr 2023 00:00:31 +0200
Subject: [PATCH v2 10/12] mmc: mmci: mmci_card_busy() from state machine
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-pl180-busydetect-fix-v2-10-eeb10323b546@linaro.org>
References: <20230405-pl180-busydetect-fix-v2-0-eeb10323b546@linaro.org>
In-Reply-To: <20230405-pl180-busydetect-fix-v2-0-eeb10323b546@linaro.org>
To:     Yann Gautier <yann.gautier@foss.st.com>,
        Stefan Hansson <newbyte@disroot.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-mmc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

If we have a .busy_complete() callback, then check if
the state machine triggered from the busy detect interrupts
is busy: then we are certainly busy.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Do this in a safer way that falls back to reading busy
  status from the hardware if the state machine is NOT
  busy.
---
 drivers/mmc/host/mmci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 9a7f441ec9d6..180a7b719347 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -339,6 +339,12 @@ static int mmci_card_busy(struct mmc_host *mmc)
 	unsigned long flags;
 	int busy = 0;
 
+	/* If we are waiting for IRQs we are certainly busy */
+	if (host->ops->busy_complete &&
+	    host->busy_state != MMCI_BUSY_IDLE &&
+	    host->busy_state != MMCI_BUSY_DONE)
+		return 1;
+
 	spin_lock_irqsave(&host->lock, flags);
 	if (readl(host->base + MMCISTATUS) & host->variant->busy_detect_flag)
 		busy = 1;

-- 
2.39.2

