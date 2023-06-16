Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E828EB64D7
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Jun 2023 08:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245423AbjFPIan (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 16 Jun 2023 04:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242529AbjFPIak (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Jun 2023 04:30:40 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106652D7B
        for <linux-mmc@vger.kernel.org>; Fri, 16 Jun 2023 01:30:39 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f841b7a697so466640e87.3
        for <linux-mmc@vger.kernel.org>; Fri, 16 Jun 2023 01:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686904237; x=1689496237;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ghF3xs3yQs3rXYpWsa33Muru521Sx+tCdBOCvTmZKM=;
        b=Y72Kg6S+HS9H/kKU98N2aG7RMxLkI5SqQER+/1E7WxjgHQQZJGIZlUiC5I1sdMNvJ0
         LvVvYKGl5hvJvZ8rHILjpp/9C061rWu1HjH0QOUEEhCL664Qagll5+R8ZbraXz4L5OYB
         JJa9McOUT72+9ierH5xTtYa9EDpfeWDsWl3r2u/BON6KPVM7FtjZ8WqNZuofd6z3wEtA
         uZNFLCqKy54/0NJwHJ2M/WOWn7g9naoBh8rtOZ82AgBBQ/sqiVhoChgHTQXnGE1l+x91
         FfVZH5UowipJBt9uw+CCMIy2MIu94JP07nsRM1v1qggJV/MzlsNo/37rvjDC/Ptv8NRy
         VCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686904237; x=1689496237;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ghF3xs3yQs3rXYpWsa33Muru521Sx+tCdBOCvTmZKM=;
        b=L6zexfmKccfMbLeEMeBsoSqetz3B/Y83pmVGo7kkOqk+mTNBRQaimYnBOKQNIVQtPn
         tfuWSAJrX7tVSGTT0brf5B0GNeRT3KMYJFz19XDkuJFEqde23yRFnC1dS291JKKoXJZt
         8UbMl5c2PoLg2Ovjl0qJe28C1yVYEHe0RCninfDMmwkLnCPCoHnl0hDnNZBcMUpoIFj2
         MuPxT957FC54nQATrp0WeL3gdbUOgdfbOLDD7pL6tZCXps5PO+Q5wHuoB2fL/fU7CSvh
         koQ9eDg7qHCe9y6K3y/7We/ccpWOtn53a/cUHiNd1xEGfU9zrzUnp7XM3Kdcn4Fqf6KA
         f8Kg==
X-Gm-Message-State: AC+VfDxzMhah95mt1Jx88IK5OlFQeFu0y5zh7Y+4+lUmkUST8Qyfq/O4
        Mhiwfz49spWPWUFm8Ivo6mnYpg==
X-Google-Smtp-Source: ACHHUZ62k2noxCvM8fqALPVmY/PVnzzSyFYRFFqiq3iaxrSKtVg/R2icMjX1lNvG3js9VO32t+lVuQ==
X-Received: by 2002:a05:6512:2f4:b0:4f8:582e:f4f2 with SMTP id m20-20020a05651202f400b004f8582ef4f2mr369827lfq.47.1686904237351;
        Fri, 16 Jun 2023 01:30:37 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id j8-20020ac25508000000b004eb44c2ab6bsm2918106lfk.294.2023.06.16.01.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 01:30:36 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 16 Jun 2023 10:30:34 +0200
Subject: [PATCH v6 2/9] mmc: mmci: Unwind big if() clause
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-pl180-busydetect-fix-v6-2-b850ec8019f3@linaro.org>
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

This does two things: firsr replace the hard-to-read long
if-expression:

  if (!host->busy_status && !(status & err_msk) &&
      (readl(base + MMCISTATUS) & host->variant->busy_detect_flag)) {

With the more readable:

  if (!host->busy_status && !(status & err_msk)) {
     status = readl(base + MMCISTATUS);
     if (status & host->variant->busy_detect_flag) {

Second notice that the re-read MMCISTATUS register is now
stored into the status variable, using logic OR because what
if something else changed too?

While we are at it, explain what the function is doing.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v4->v6:
- No changes.
ChangeLog v3->v4:
- No changes.
ChangeLog v2->v3:
- Rebased.
ChangeLog v1->v2:
- Only assign the cached status in host->busy_status if
  we have busy detect signalling going on.
---
 drivers/mmc/host/mmci.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 0a4b6b6e0f03..eee449f90915 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -654,6 +654,13 @@ static u32 ux500v2_get_dctrl_cfg(struct mmci_host *host)
 	return MCI_DPSM_ENABLE | (host->data->blksz << 16);
 }
 
+/*
+ * ux500_busy_complete() - this will wait until the busy status
+ * goes off, saving any status that occur in the meantime into
+ * host->busy_status until we know the card is not busy any more.
+ * The function returns true when the busy detection is ended
+ * and we should continue processing the command.
+ */
 static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 {
 	void __iomem *base = host->base;
@@ -671,14 +678,16 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 	 * while, to allow it to be set, but tests indicates that it
 	 * isn't needed.
 	 */
-	if (!host->busy_status && !(status & err_msk) &&
-	    (readl(base + MMCISTATUS) & host->variant->busy_detect_flag)) {
-		writel(readl(base + MMCIMASK0) |
-		       host->variant->busy_detect_mask,
-		       base + MMCIMASK0);
+	if (!host->busy_status && !(status & err_msk)) {
+		status = readl(base + MMCISTATUS);
+		if (status & host->variant->busy_detect_flag) {
+			writel(readl(base + MMCIMASK0) |
+			       host->variant->busy_detect_mask,
+			       base + MMCIMASK0);
 
-		host->busy_status = status & (MCI_CMDSENT | MCI_CMDRESPEND);
-		return false;
+			host->busy_status = status & (MCI_CMDSENT | MCI_CMDRESPEND);
+			return false;
+		}
 	}
 
 	/*

-- 
2.40.1

