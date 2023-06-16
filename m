Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FFCEB64DD
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Jun 2023 08:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242529AbjFPIap (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 16 Jun 2023 04:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245214AbjFPIal (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Jun 2023 04:30:41 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1713F2D6A
        for <linux-mmc@vger.kernel.org>; Fri, 16 Jun 2023 01:30:40 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f655293a38so504941e87.0
        for <linux-mmc@vger.kernel.org>; Fri, 16 Jun 2023 01:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686904238; x=1689496238;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eDWfJmNzbQmAA05jmoYd7JfIZxnwDGKXAdDTLkWtQe8=;
        b=rnRES/KizDc5sZNv1sxzWYXABFokGf5WfqZ4Z5QCzoPAkNGS0PZiGzBnvfszK0qSDz
         pKiLL6uDm8yoxCHV90drVHHsVJvv1m+P8hVYxgSH86akSYG6YEuut2qeGuzi64gXpznu
         gsBv8sOMLCbx90Wp4ymOh+dR1CkdLpQiauu1YYljK56vJxymqT05vMpvaOGG8S3GpfIt
         lwWtiwevyOQiwKvcOpNFMNBobd3H5sCOaN+IdnYkvgj3GRviThDF8/dEIrEdr25uYRvR
         I0dpQzO9QzYKTm3eWAguadGptMGdWDetd6RzDCKw+iufED5MozIv8yTiA5fwM9QPRRrw
         scFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686904238; x=1689496238;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eDWfJmNzbQmAA05jmoYd7JfIZxnwDGKXAdDTLkWtQe8=;
        b=hXxx6H8uzask7DqmHF6DpSS3gtKEX6i9uLxu+C7aT1A/7KPbKd+kFrz+EPCPRn8Iyh
         AUec/31sy+2TGa4REdFNDcMXVxDcnEmyRpM6pmfrCq3Xbiz37c33NEkTDOKOCb2rjZYt
         iDUZI95T94G4pFzBQy3D+twWPdCr9CKJ8URmyL9ZCXJFyIUY2FxfjBZNFKuM9xdFowFX
         3njqTKY/PXcg5VSfKnn7qR51LHHxugAHbRiiEgCyhzcpM7q5rAjGlEcPfbY7XnVtAZlR
         qRmpkW19EP0ziZQeWPgRtw/XFrBvFSeOlZnBHxwQeiz1Qovlus1nWkBsruWfG4rB+mHp
         q3nw==
X-Gm-Message-State: AC+VfDw2beYE7I0VwHBd8LYw+mlrfE+JmaGXEF80o76POiRG/vLyTIr+
        gLv0lWB2YxacjguvohP3Dci11w==
X-Google-Smtp-Source: ACHHUZ43n6Onh9gPaHpBFHKAz+4wBfXNSaEw9klHW3mmZGfZx9mivm/Sm/i5wD68dFDsVnhL8xibtw==
X-Received: by 2002:a19:ca50:0:b0:4f8:578f:ace1 with SMTP id h16-20020a19ca50000000b004f8578face1mr367985lfj.21.1686904238280;
        Fri, 16 Jun 2023 01:30:38 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id j8-20020ac25508000000b004eb44c2ab6bsm2918106lfk.294.2023.06.16.01.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 01:30:37 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 16 Jun 2023 10:30:35 +0200
Subject: [PATCH v6 3/9] mmc: mmci: Stash status while waiting for busy
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-pl180-busydetect-fix-v6-3-b850ec8019f3@linaro.org>
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

Some interesting flags can arrive while we are waiting for
the first busy detect IRQ so OR then onto the stashed
flags so they are not missed.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
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
index eee449f90915..47b306e45f78 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -703,6 +703,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 	 */
 	if (host->busy_status &&
 	    (status & host->variant->busy_detect_flag)) {
+		host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
 		writel(host->variant->busy_detect_mask, base + MMCICLEAR);
 		return false;
 	}

-- 
2.40.1

