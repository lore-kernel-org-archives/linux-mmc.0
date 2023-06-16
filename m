Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB450EB64DC
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Jun 2023 20:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbjFPUmi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 16 Jun 2023 16:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242048AbjFPUmh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Jun 2023 16:42:37 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA0F3A91
        for <linux-mmc@vger.kernel.org>; Fri, 16 Jun 2023 13:42:35 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f764e92931so1683810e87.2
        for <linux-mmc@vger.kernel.org>; Fri, 16 Jun 2023 13:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686948154; x=1689540154;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RJ/lYkJaS0LH2m3+0Gfk93tQBU1oPRi1nXcMIJdJKlg=;
        b=qdfB+W1xo1X8kL0DzWuF6yndtLd2rh9VRNEcfHocgTjTpXlrVcnYr077uDuJXpXNDI
         TgN62dcvPcLeEQqiM3QBudPdV1msK+HfAX/n+pWKTXpPLGKl5dBUvLxaK+UM+yPZqJYn
         ann8ohJH7Ws9YbWjF37gVxLAysSSGyLbRXmd/MvvLROtjggMRyzYNbPoLUf135zN+xx8
         nCUNmQiJGV/JShWXJWNu0S9pFpCLaIdvn01GnImfm4pPdhKAs+BxYdRPhxkUCn7rOG7W
         dFU2LOlm85eVSyR27Drff7YEDJvWZVvx+y3Lhh5kwYeoxrUTTeED1Dh+JGTtrzQC/WHX
         Qh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686948154; x=1689540154;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RJ/lYkJaS0LH2m3+0Gfk93tQBU1oPRi1nXcMIJdJKlg=;
        b=VdlCqoq1Fns6g957ieLr60u7sXjpmEOZmEVKt64Bq3Re8Xtn4rto8DfHQOig1dtpFz
         ly8IUVhjCT+wKgDUPT1oAPTMQE/O4ryFHnoUoPNP7o5E82LtpJ6JKs6QsLVTXz3W0Bya
         yCHyA1pfO5y4dTjyxhiY6mVH8X6SSOnuFET0/ZkvK5lyaJxzxmqnCDnahJ+dLlEt8jnT
         dbvS9LCMkRixGYNOeRgR0IwzD2vFGmCJFNMiNweQ2Q/IerV9+YLSMDScvFxxAU8j/XEc
         eAtcTKgjputenUnTJgleperRf3rRkcFA0JjVhGOzDwIfJU3BzWqDda2/mg4hZOS+TZpN
         K2yQ==
X-Gm-Message-State: AC+VfDzdBTp69Uh6cr/8cZTSLLtb+0mvLF1WjXiXLexng0bPlgbbetYn
        OTskQPsaXOUVWlzuIicLRJRlIGeLvfDrTMgZ6bc=
X-Google-Smtp-Source: ACHHUZ6yFZtRn/Ra54pqvdEbxTlxjqxhVLGS8D8VoYO51DVRB2mfN172DqDZJYU8wPQURExHPJeyuQ==
X-Received: by 2002:ac2:5f98:0:b0:4f2:34f1:cf24 with SMTP id r24-20020ac25f98000000b004f234f1cf24mr2449125lfe.22.1686948154143;
        Fri, 16 Jun 2023 13:42:34 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id d22-20020ac244d6000000b004f845907454sm770981lfm.232.2023.06.16.13.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 13:42:33 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 16 Jun 2023 22:42:22 +0200
Subject: [PATCH v7 4/9] mmc: mmci: Break out error check in busy detect
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-pl180-busydetect-fix-v7-4-69a7164f2a61@linaro.org>
References: <20230405-pl180-busydetect-fix-v7-0-69a7164f2a61@linaro.org>
In-Reply-To: <20230405-pl180-busydetect-fix-v7-0-69a7164f2a61@linaro.org>
To:     Stefan Hansson <newbyte@disroot.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.2
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The busy detect callback for Ux500 checks for an error
in the status in the first if() clause. The only practical
reason is that if an error occurs, the if()-clause is not
executed, and the code falls through to the last
if()-clause if (host->busy_status) which will clear and
disable the irq. Make this explicit instead: it is easier
to read.

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
 drivers/mmc/host/mmci.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 417dc3b1c744..e493fb7c724f 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -675,6 +675,15 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 {
 	void __iomem *base = host->base;
 
+	if (status & err_msk) {
+		/* Stop any ongoing busy detection if an error occurs */
+		writel(host->variant->busy_detect_mask, base + MMCICLEAR);
+		writel(readl(base + MMCIMASK0) &
+		       ~host->variant->busy_detect_mask, base + MMCIMASK0);
+		host->busy_status = 0;
+		return true;
+	}
+
 	/*
 	 * Before unmasking for the busy end IRQ, confirm that the
 	 * command was sent successfully. To keep track of having a
@@ -688,7 +697,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 	 * while, to allow it to be set, but tests indicates that it
 	 * isn't needed.
 	 */
-	if (!host->busy_status && !(status & err_msk)) {
+	if (!host->busy_status) {
 		status = readl(base + MMCISTATUS);
 		if (status & host->variant->busy_detect_flag) {
 			writel(readl(base + MMCIMASK0) |

-- 
2.40.1

