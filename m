Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDA5C7EE2F
	for <linux-mmc@archiver.kernel.org>; Sun, 11 Jun 2023 19:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjFKTlt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 11 Jun 2023 15:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbjFKTlq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 11 Jun 2023 15:41:46 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEC7E50
        for <linux-mmc@vger.kernel.org>; Sun, 11 Jun 2023 12:41:45 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f61b45ee0dso4160109e87.0
        for <linux-mmc@vger.kernel.org>; Sun, 11 Jun 2023 12:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686512503; x=1689104503;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=leQo1eQI2yGMA+F1whh7Mzh5/OHjjWPGlqQlPIARggM=;
        b=JzHmoRxskRPBqRU0oxKMdWiC2ux9EoTDP5BA2bYiUG0GeVVIU7Utrz8oOaEDumSQmr
         LjKCrXIwwSQPFIBDkQ4m2wQqemqC7fXKtgX0A+Ih5Y+XxUIQiP7d8Nuqynn1IIuF4vl0
         YQHJE9ZVparD2CXEpB9wSwFNr0EJAXGwW0TSXfR8orn6EoyHDGuGuirHQw6CL6Y5L7bI
         bCXFtjmnC+3No/SzLyPTE5SPBcNZxVzDIqafdKyAlytg6tOyEeYEMnziCHXB216sBU75
         UPXazQ0LQrzBTY7woP24hkPo3y7DMryNqRofh31mSHFmKLBze+7IeMIaJq3g6YzaYPfd
         GjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686512503; x=1689104503;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=leQo1eQI2yGMA+F1whh7Mzh5/OHjjWPGlqQlPIARggM=;
        b=jaPZbCCUFT1c+9qDpyCVLOVyxErNpsRvc2J+TgrLhbu9qjCBkXwWQTEwkiXFCPD2mx
         aNx8N5pEbTdMYtn+7wgblnZ81ziU93EovCRvuoIjbFc4+2mhHtignIM7570WaE9JkZBj
         pLsfezLszPksZIh67chvqFbQi363KgqeDNfLMz/7ZxuSzkpoQLe34hTsKEbCtesFJYRz
         egjUSJXPxXbEP+UdLLsrDj8vezjMxJBEUY/hlPGa4uBdWEnDS07qGPz/Dqr5Vy9qY+xj
         MnoVFG9aY/bi4o3dJLB72h7v8+0LGnqDc1Hon0/BOdpzOuHJXL0XHlHoTtNARx7TqwlZ
         47nA==
X-Gm-Message-State: AC+VfDwmKUDfrNBOLahLCNJCNVR5DFAr6h/iFUQNJJzIOqPx7gecbuf7
        XTvA4oWB3RlifRlpxgdDvRtvqw==
X-Google-Smtp-Source: ACHHUZ6ULkkOOmgR+U1/7iaSinRzCgPnItOqoS3hN/U8Qa60/d6WPvkdwtgBFv4NuUS9F58fDYBJZQ==
X-Received: by 2002:a19:711c:0:b0:4f1:2986:3920 with SMTP id m28-20020a19711c000000b004f129863920mr2977578lfc.41.1686512503739;
        Sun, 11 Jun 2023 12:41:43 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id u24-20020ac243d8000000b004f14ae5ded8sm1246960lfl.28.2023.06.11.12.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 12:41:43 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 11 Jun 2023 21:41:29 +0200
Subject: [PATCH v3 03/10] mmc: mmci: Stash status while waiting for busy
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-pl180-busydetect-fix-v3-3-cd3d5925ae64@linaro.org>
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

Some interesting flags can arrive while we are waiting for
the first busy detect IRQ so OR then onto the stashed
flags so they are not missed.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Rebased.
ChangeLog v1->v2:
- No changes
---
 drivers/mmc/host/mmci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index d8e7b17adaee..73b5205592ae 100644
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

