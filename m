Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB13EEB64D8
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Jun 2023 20:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbjFPUmm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 16 Jun 2023 16:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244916AbjFPUml (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Jun 2023 16:42:41 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8DD3A91
        for <linux-mmc@vger.kernel.org>; Fri, 16 Jun 2023 13:42:40 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f76a4c211dso1647139e87.3
        for <linux-mmc@vger.kernel.org>; Fri, 16 Jun 2023 13:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686948158; x=1689540158;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c5hpKzB4PSZ5/2TnmnUTZaUgH+o6qsetcSAjQGCuqhI=;
        b=Au1TK4WFf+YdRUpL6SQUEpTJ0E5hYlwc41KWln1nCx8aHFI7gED0FRo02seqRrzMgp
         4eoYrzUhihR7yK1XJzD5wlz0rzlr5FOE+5fOzUvAdtqku9GaLLkAX/7FEOPfVVayMMYi
         yQCsyKaZza4Dotq161PHvHk59GQ/HN4oC5IHtu0/FXznav8E5s0lnTj9xQ8et/cXWDlP
         ly7T7acoPTlRSXkYzXROe5A98xn2vBO7UBM04vW+vVZTLrAQdgENlBZjhIybJQEdwy2/
         CW1xsK3kce95T1+43/4RDBdyy/EXZdb448hHZip+tPhp0Hsp5qt/L6uGFSOVLrljGw24
         pOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686948158; x=1689540158;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c5hpKzB4PSZ5/2TnmnUTZaUgH+o6qsetcSAjQGCuqhI=;
        b=QZGvBpb+wIioHgSTbJZkSEn47OYcnl+Dudpe+UurqSqBQZrct0P93J7O5saR2RZyGu
         J0xvu/vHVpWklgyNsQfI5RUmtsejx8nL+kNHXybvahFRgJ8pM/4qfC21A3/kjxV/B4l6
         884WVtPICaO9qCxbZn7xZY5Rhl7ckr8ry9iP2eyA3sn918pfF7egbyVnFeseLiS1KWWQ
         5nZ13DYeXa0RZGrP3LuhoSjxICkAP1Ys+U4MSWah4XxfSycZo8taKf+xo2s86FNqiAtB
         AcejfC7iCpHQ1sKHH3Ydcduvf/SN6RH8y+B0yoVzEz96U9URctbfpfMrztWIelmBowwU
         ov1w==
X-Gm-Message-State: AC+VfDz+zKGh6SQgYuSey2yC5ZMHyxkvY7fJjfYx5VBezpTXtXMERhkf
        XcGVwlWF3vHklS2eLoABa4skpQ==
X-Google-Smtp-Source: ACHHUZ6WMRB2Em41hyyDro/rcfLKRlO++fqjJsjyjoma0qkFjUfJhRi7+5ERaCqHV3x/qXpYj55k+g==
X-Received: by 2002:ac2:4982:0:b0:4f6:4616:9f68 with SMTP id f2-20020ac24982000000b004f646169f68mr3008013lfl.38.1686948158511;
        Fri, 16 Jun 2023 13:42:38 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id d22-20020ac244d6000000b004f845907454sm770981lfm.232.2023.06.16.13.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 13:42:38 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 16 Jun 2023 22:42:27 +0200
Subject: [PATCH v7 9/9] mmc: mmci: Break out a helper function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-pl180-busydetect-fix-v7-9-69a7164f2a61@linaro.org>
References: <20230405-pl180-busydetect-fix-v7-0-69a7164f2a61@linaro.org>
In-Reply-To: <20230405-pl180-busydetect-fix-v7-0-69a7164f2a61@linaro.org>
To:     Stefan Hansson <newbyte@disroot.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
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
 drivers/mmc/host/mmci.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index d38ba9aa9be8..309676c7e050 100644
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
@@ -678,11 +689,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 
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
 
@@ -724,10 +731,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
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
@@ -749,18 +753,15 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
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
 
 	case MMCI_BUSY_WAITING_FOR_END_IRQ:
 		if (!(status & host->variant->busy_detect_flag)) {
 			host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
-			host->busy_state = MMCI_BUSY_DONE;
+			writel(host->variant->busy_detect_mask, base + MMCICLEAR);
+			ux500_busy_clear_mask_done(host);
 		} else {
 			dev_dbg(mmc_dev(host->mmc),
 				"busy status still asserted when handling busy end IRQ - will keep waiting\n");

-- 
2.40.1

