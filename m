Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED176C761AF
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Apr 2023 06:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236708AbjDEGui (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Apr 2023 02:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236804AbjDEGuh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Apr 2023 02:50:37 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA5E3A8E
        for <linux-mmc@vger.kernel.org>; Tue,  4 Apr 2023 23:50:36 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id d7so305721lfj.3
        for <linux-mmc@vger.kernel.org>; Tue, 04 Apr 2023 23:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680677434;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qiM54vpHAvlLc1pdSUZ0ibiOpnt1h50sa+Xwq+/IdPw=;
        b=NrIzxPmGSXw+D7zfQWluH8L67j+7Z5MeDhw3zqZd5jjc3icWMdC0My/4MCvihvPCZK
         onfKRBKS/1mUMkIL0ijSbq5OZKFmkM1NQhIHMWsNNdkBB2uH63+Xz4ewbNurBVEzD7hK
         aGPKZki4YxEwtXS06+AZqPV1ZtxwX6QAZq8y6c4wVflu3XZ6mkjzqkfNaHo3vTF/FyBn
         UFYWXmOw0XASQOEAyKdMImwGlYsXqMzMeBwU3p8Os0jayDDQYpRZtfqzu9UIKllkaLdI
         eBdQ5I6i+vVFSZAeY1lowqoodbxbKsgy3Hv+ldudIDG7+VbTbkn/mGQssA21b77sTtI/
         4Bhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680677434;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qiM54vpHAvlLc1pdSUZ0ibiOpnt1h50sa+Xwq+/IdPw=;
        b=4OIJl1rt8r4wHLF5Rp9BT/2VR928f4ex6u7HxqF0Ul7ZoXfGD9LJOVMHSrkjNuafKS
         CIwukbvMXFDFiY/5KdC8QTZb51CGQp64NQtisG+xc688R3DAur4l3bac1c7To0M1HZLM
         eGDwYo3qLxKH5ic2drU+ORCr9K/12nsHX8Km2/XBLNvIhyf2fK7fp2q2zjZVeMP2hDhl
         H2pBEEmi5Q5eNjyz913mZ8h1/HU7zXy4CrDpzuC+4wDYoH4S6TKLffPCkHXQO8F9DTr0
         fFakDLvitebX9HDOVRHfgBmmZ2n/ZTc7d/HlnTlTuXIoyjpFq06npjUCFV6sItvFAb1l
         OlgA==
X-Gm-Message-State: AAQBX9coK7NX3IJYz+VNTWa5hOOirBk7XMqOTIcNH30ayRAEREI0Ey9X
        a17L8jJNe+kJDStMXysviPAa9y3hABY/rRBuFHM=
X-Google-Smtp-Source: AKy350bgqog8tYcwKoOQ4OK5DxI1lxCKOcQXvd+tbHHbQya6iSPCxpQb5CJPGihAIirSEe3C3YDMCA==
X-Received: by 2002:ac2:55af:0:b0:4eb:2a0:4021 with SMTP id y15-20020ac255af000000b004eb02a04021mr1365131lfg.34.1680677434539;
        Tue, 04 Apr 2023 23:50:34 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id z19-20020ac25df3000000b004eb274b3a43sm2683086lfq.134.2023.04.04.23.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 23:50:34 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 05 Apr 2023 08:50:27 +0200
Subject: [PATCH 01/13] mmc: mmci: Only call busy_complete if callback
 defined
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-pl180-busydetect-fix-v1-1-28ac19a74e5e@linaro.org>
References: <20230405-pl180-busydetect-fix-v1-0-28ac19a74e5e@linaro.org>
In-Reply-To: <20230405-pl180-busydetect-fix-v1-0-28ac19a74e5e@linaro.org>
To:     Stefan Hansson <newbyte@disroot.org>,
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

The code unconditionally calls host->ops->busy_complete()
if we get a busy response and the variant supports busy
detection (variant->busy_detect = true).

However there are several STM32 variants that define
variant->busy_detect to true but do not define any
busy_complete() callback. This looks like a recepie for
a NULL pointer exception.

Check that the callback is valid before calling it.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index b9e5dfe74e5c..bc150c0d5eed 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1381,7 +1381,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 		return;
 
 	/* Handle busy detection on DAT0 if the variant supports it. */
-	if (busy_resp && host->variant->busy_detect)
+	if (busy_resp && host->variant->busy_detect && host->ops->busy_complete)
 		if (!host->ops->busy_complete(host, status, err_msk))
 			return;
 

-- 
2.39.2

