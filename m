Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBB4C83005
	for <linux-mmc@archiver.kernel.org>; Sun, 11 Jun 2023 19:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjFKTlt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 11 Jun 2023 15:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbjFKTlr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 11 Jun 2023 15:41:47 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EEC126
        for <linux-mmc@vger.kernel.org>; Sun, 11 Jun 2023 12:41:43 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f6195d2b3fso4240428e87.1
        for <linux-mmc@vger.kernel.org>; Sun, 11 Jun 2023 12:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686512501; x=1689104501;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZK0mkbjHAu8JAeEkTRBOfo0afA15/I72HAPEj6zPizo=;
        b=lf3qjqz6c7HOa/hWJYdEzlwmZ9nRwDuCifWRyX10OijK5MuueM4fuIU2gL+JiQcCKY
         KT1uCtul0Wsdx9fi1ULMuQsfdwxIdme8/sclPwDmqthuCTt3rhWAnAdKEOjX/8UT4mEl
         m6BfyjV/x+1H5Ewfq+jitm2R24ATsNk/mtyAjMGq4RWOeMUHF4Qv2Y5LU0WN58tm2o7U
         Y1oJhrrRqf2I80ltpUPspXQAgVFe0ijwB0Z5v9A0/Hig03KS+3KNppMoxwRjePzNFFPH
         LN6n+ATRHFbffJqN4whYJWFWnCz2yVzcboROJ7gc25MoINn7IO4Eq7hcd50F/Bk1w0wo
         BkZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686512501; x=1689104501;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZK0mkbjHAu8JAeEkTRBOfo0afA15/I72HAPEj6zPizo=;
        b=JLjcAS9R1E4FRdJbEKPtWm3M6syAK16vk5sTXvwlab7l6xDsn0eJZFFfZq32+26WdX
         DlZFobZh4QBTR75fGRTcOWJVgX1chwUth9DjTKbmorKj/6WVUD8VclSpX9waj5LXBCwO
         5P7ky9JZL3R9DLLYx2uJTVWLlQvNcugGm4YZjplaGo9U/CvPBuZ05cirEOlsr7RG6MSN
         gSmrX8JOS7n4dxDKeCXl60rD9p1FxrfPRxBt+rN3P12M92eCK/M2QuLAGvt0pRghkhjU
         ZO2NfGuPKnvYIxD2XWQRU7CSs+iHfpDxlWoPK88t7xFkN+/f6QhO8siunaBinZt/Wwh8
         /QQQ==
X-Gm-Message-State: AC+VfDx3+RkypW/r899KTHxaClQ6+olPIVcJwV6Ag0xd4klT2ZqoioFf
        zkkloU88AW3J+lQoHg8M14dkog==
X-Google-Smtp-Source: ACHHUZ7jKBMBuYlNtBKwlZYc72v7+1ashCmnM6/royQj08B4wm4S141TRISJSSuxEpWDx39jDiuYSA==
X-Received: by 2002:a05:6512:614:b0:4f4:aea9:2a2f with SMTP id b20-20020a056512061400b004f4aea92a2fmr3634906lfe.57.1686512501410;
        Sun, 11 Jun 2023 12:41:41 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id u24-20020ac243d8000000b004f14ae5ded8sm1246960lfl.28.2023.06.11.12.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 12:41:41 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 11 Jun 2023 21:41:27 +0200
Subject: [PATCH v3 01/10] mmc: mmci: Clear busy_status when starting
 command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-pl180-busydetect-fix-v3-1-cd3d5925ae64@linaro.org>
References: <20230405-pl180-busydetect-fix-v3-0-cd3d5925ae64@linaro.org>
In-Reply-To: <20230405-pl180-busydetect-fix-v3-0-cd3d5925ae64@linaro.org>
To:     Yann Gautier <yann.gautier@foss.st.com>,
        Stefan Hansson <newbyte@disroot.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-mmc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.2
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

If we are starting a command which can generate a busy
response, then clear the variable host->busy_status
if the variant is using a ->busy_complete callback.

We are lucky that the member is zero by default and
hopefully always gets cleared in the ->busy_complete
callback even on errors, but it's just fragile so
make sure it is always initialized to zero.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Clear host->busy_status no matter if the MMC_RSP_BUSY flag
  is set or not.
- Now we have an if inside an if left, so combine these into
  one singel conditional.
- Resulting re-flow the if-clause.
ChangeLog v1->v2:
- Unconditionally clear host->busy_status if we get a
  busy response.
---
 drivers/mmc/host/mmci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index f2b2e8b0574e..14d639872952 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1238,7 +1238,8 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
 			c |= host->variant->cmdreg_srsp;
 	}
 
-	if (host->variant->busy_timeout && cmd->flags & MMC_RSP_BUSY) {
+	host->busy_status = 0;
+	if ((cmd->flags & MMC_RSP_BUSY) && (host->variant->busy_timeout)) {
 		if (!cmd->busy_timeout)
 			cmd->busy_timeout = 10 * MSEC_PER_SEC;
 

-- 
2.40.1

