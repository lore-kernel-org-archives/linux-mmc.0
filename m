Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D98EB64D8
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Jun 2023 20:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjFMUej (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 13 Jun 2023 16:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjFMUeh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Jun 2023 16:34:37 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957E6DC
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jun 2023 13:34:35 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f644dffd71so7542789e87.1
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jun 2023 13:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686688474; x=1689280474;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SAfIo/HStS4ssmJ5VnFiRuxpA+ACqAiRQGlqQ7Ljwos=;
        b=J9jgl1fHcdpUNuOaw8NgNxbIqW9ldZJGhghSwketWliDS3ppFYG1x1QXcJ/Gyv6gWI
         CC3fFu8jUh1ymG75hNlIh/1KsbNjfgZN6d02JSA19Gmd3Ro6xPkL9xMBQAHuQ5HJ+ojV
         id3kYghTPHZVL5Ku8jMZQpiPzciWWePbIqX0cf1uY+dUesHp79NcQBmOpHCi/7hZncAp
         t6TiFGmRBYtSuuvjH2V79rxQHeKuDjyVv2QjyoDiJjRsC8FhIp0HPZ3MsKZ1DGjS4PGd
         /hkJSIhLEf1OHsAy41qNeyMjv5mHc79km2qGSJgiMFwy2JuWohXl5KW9eRdfUCcypiPx
         5oWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686688474; x=1689280474;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SAfIo/HStS4ssmJ5VnFiRuxpA+ACqAiRQGlqQ7Ljwos=;
        b=Os+BHeyeItnYDn9nIsOVJtYVN2rScckWTz2Qbz34UE7DWs94yX7sQFt8Dl3/Bdbmnm
         GtLQYujziDqRMoDYvxX0CaFhlm/wtWF2qQcKku4R93b10lS9tGmz2+SirivwdsXevQ9w
         69GVKLix41ilxVoiZw1awQ3C8237Iv3qxmDclUT2QdmA3cFzGdjPgajO5tUPypJOPIay
         4imx6s/w68IJvnb4Fzy0Aq9s3b5ZWflEnYOO7dEDrysBndwpwAZYTbhFv3dBEkbihVau
         3fnuSpMzaOGPAtY25sbho00Kw+EAQjl0tN0EMXtXdX7owxTDUdkfi8aLGiy5AMHk93oW
         HgPw==
X-Gm-Message-State: AC+VfDx4jHdrQLqA4DWM5TIk7xAreJ98O4uoD4pXBoYZU+mxYsJbI/tx
        WqIKT2JVTdc4FrKDLnrEkEzFfA==
X-Google-Smtp-Source: ACHHUZ5xvUSgzRJCXb8G6VFIK8RZEFvMypqc6eZdYCcV/6Cf2jx9ee1Qy9lYaQlE/YexEGmCv5ixZw==
X-Received: by 2002:a19:5e18:0:b0:4dc:807a:d144 with SMTP id s24-20020a195e18000000b004dc807ad144mr6502866lfb.39.1686688473988;
        Tue, 13 Jun 2023 13:34:33 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id l12-20020a19c20c000000b004f26f699e9dsm1897813lfc.184.2023.06.13.13.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 13:34:33 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 13 Jun 2023 22:34:25 +0200
Subject: [PATCH v4 09/10] mmc: mmci: Break out a helper function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-pl180-busydetect-fix-v4-9-df9c8c504353@linaro.org>
References: <20230405-pl180-busydetect-fix-v4-0-df9c8c504353@linaro.org>
In-Reply-To: <20230405-pl180-busydetect-fix-v4-0-df9c8c504353@linaro.org>
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

These four lines clearing, masking and resetting the state
of the busy detect state machine is repeated five times in
the code so break this out to a small helper so things are
easier to read.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v3->v4:
- No changes.
ChangeLog v2->v3:
- Rebased.
ChangeLog v1->v2:
- No changes
---
 drivers/mmc/host/mmci.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index cb766b8d419d..478f71dc7f34 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -654,6 +654,17 @@ static u32 ux500v2_get_dctrl_cfg(struct mmci_host *host)
 	return MCI_DPSM_ENABLE | (host->data->blksz << 16);
 }
 
+static void ux500_busy_clear_mask_done(struct mmci_host *host)
+{
+	void __iomem *base = host->base;
+
+	writel(host->variant->busy_detect_mask, base + MMCICLEAR);
+	writel(readl(base + MMCIMASK0) &
+	       ~host->variant->busy_detect_mask, base + MMCIMASK0);
+	host->busy_state = MMCI_BUSY_DONE;
+	host->busy_status = 0;
+}
+
 /*
  * ux500_busy_complete() - this will wait until the busy status
  * goes off, saving any status that occur in the meantime into
@@ -668,11 +679,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 
 	if (status & err_msk) {
 		/* Stop any ongoing busy detection if an error occurs */
-		writel(host->variant->busy_detect_mask, base + MMCICLEAR);
-		writel(readl(base + MMCIMASK0) &
-		       ~host->variant->busy_detect_mask, base + MMCIMASK0);
-		host->busy_state = MMCI_BUSY_DONE;
-		host->busy_status = 0;
+		ux500_busy_clear_mask_done(host);
 		goto out_ret_state;
 	}
 
@@ -714,10 +721,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 			retries--;
 		}
 		dev_dbg(mmc_dev(host->mmc), "no busy signalling in time\n");
-		writel(host->variant->busy_detect_mask, base + MMCICLEAR);
-		writel(readl(base + MMCIMASK0) &
-		       ~host->variant->busy_detect_mask, base + MMCIMASK0);
-		host->busy_state = MMCI_BUSY_DONE;
+		ux500_busy_clear_mask_done(host);
 		break;
 
 	/*
@@ -739,11 +743,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 		} else {
 			dev_dbg(mmc_dev(host->mmc),
 				"lost busy status when waiting for busy start IRQ\n");
-			writel(host->variant->busy_detect_mask, base + MMCICLEAR);
-			writel(readl(base + MMCIMASK0) &
-			       ~host->variant->busy_detect_mask, base + MMCIMASK0);
-			host->busy_state = MMCI_BUSY_DONE;
-			host->busy_status = 0;
+			ux500_busy_clear_mask_done(host);
 		}
 		break;
 
@@ -751,15 +751,11 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 		if (status & host->variant->busy_detect_flag) {
 			host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
 			writel(host->variant->busy_detect_mask, base + MMCICLEAR);
-			host->busy_state = MMCI_BUSY_DONE;
+			ux500_busy_clear_mask_done(host);
 		} else {
 			dev_dbg(mmc_dev(host->mmc),
 				"lost busy status when waiting for busy end IRQ\n");
-			writel(host->variant->busy_detect_mask, base + MMCICLEAR);
-			writel(readl(base + MMCIMASK0) &
-			       ~host->variant->busy_detect_mask, base + MMCIMASK0);
-			host->busy_state = MMCI_BUSY_DONE;
-			host->busy_status = 0;
+			ux500_busy_clear_mask_done(host);
 		}
 		break;
 

-- 
2.40.1

