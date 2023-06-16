Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B3DEB64DA
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Jun 2023 08:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjFPIan (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 16 Jun 2023 04:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244545AbjFPIaj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Jun 2023 04:30:39 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CE12D77
        for <linux-mmc@vger.kernel.org>; Fri, 16 Jun 2023 01:30:38 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f6195d2b3fso482358e87.1
        for <linux-mmc@vger.kernel.org>; Fri, 16 Jun 2023 01:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686904236; x=1689496236;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qAY1A0L5J452WPGRxo2jOeYk3l6HQDTQHokl5FBzRto=;
        b=TLXlhCuU302ifQfNQoGNRhJC8CZdyuaqtoALXuOD0e25eDoWqDmD/Hm7GrMB2U6RuU
         43ZFqwdNHyl5blYFuUsU0PioZlXOFbTp1nzMPHS+uRGrlm4KZrdGRd5h8vxFXHgnc59/
         FajLrU8zRg7HRmnmJifqmHFelmjJT0Kc+QbVOQ1geIela+/zEzI7Ix1vSA53P0F9slGR
         QPVrgEC3cNTARH11oCYogx3maZZwqRvlgT57Z8VDSK8GJAhiEMmIN5nF8Clx/nQff7fz
         9NBsCdSHTSwPF0Mafwy7Y11Yy/lZstY/Y0bQRAWY1jIHkYjRETra/x6lj3S29wVupsGy
         /VLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686904236; x=1689496236;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qAY1A0L5J452WPGRxo2jOeYk3l6HQDTQHokl5FBzRto=;
        b=gEw9EtQv0KGudm5ieCPad7FcqG69VjBD9ABLUTxV4m8ULgwTWCzgL7t67/Gj3MfkxB
         QTvOqUHwdqh6ugfj4o/co/pMvwkTs09la0NrF7Eq3BvlJWGi2iYtC8rAkPS4ErjA4Qvr
         A3sHMUfyiXFStoeCH9edl34bMPeXzjzpE+S8yC2fjnTIaofFXFbWz8IDOfz3+t/ym+9R
         7DgcDAFs6eKXQObrWKw6YoNBmoTfqKY4rkh+AIljc1dXxMojiAelKUObXFq0v9TSnh5S
         xAJzelS14c4dU+Y36J2ZKWwLHyHeYFjA76sI2IxCOeeVxB4TmR2X4T1Jb9z5MOAvz1t1
         gvkw==
X-Gm-Message-State: AC+VfDxd1VIP//43C2LbLc6W5UlGV5pkDE0HLfK8M9sThq2eGSn/984T
        Z5ZsAkmEQwD2kk2hhZ2bduzqqA==
X-Google-Smtp-Source: ACHHUZ7BSgxJiY9sOkyLihVNLPsqyXx/q5hvthiq2DHxAnf55Cs1Sz0NyP2V6OPFvMmmxmRajzwqyQ==
X-Received: by 2002:a19:441a:0:b0:4f5:bc19:68dd with SMTP id r26-20020a19441a000000b004f5bc1968ddmr737690lfa.53.1686904236383;
        Fri, 16 Jun 2023 01:30:36 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id j8-20020ac25508000000b004eb44c2ab6bsm2918106lfk.294.2023.06.16.01.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 01:30:35 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 16 Jun 2023 10:30:33 +0200
Subject: [PATCH v6 1/9] mmc: mmci: Clear busy_status when starting command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-pl180-busydetect-fix-v6-1-b850ec8019f3@linaro.org>
References: <20230405-pl180-busydetect-fix-v6-0-b850ec8019f3@linaro.org>
In-Reply-To: <20230405-pl180-busydetect-fix-v6-0-b850ec8019f3@linaro.org>
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
ChangeLog v4->v6:
- No changes.
ChangeLog v3->v4:
- Fix the oneline stray change to semantic order of busy
  flag so the patch is the oneliner it's supposed to be.
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
 drivers/mmc/host/mmci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 97a77eefb11a..0a4b6b6e0f03 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1238,6 +1238,7 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
 			c |= host->variant->cmdreg_srsp;
 	}
 
+	host->busy_status = 0;
 	if (host->variant->busy_timeout && cmd->flags & MMC_RSP_BUSY) {
 		if (!cmd->busy_timeout)
 			cmd->busy_timeout = 10 * MSEC_PER_SEC;

-- 
2.40.1

