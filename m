Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66874EB64D8
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Jun 2023 20:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjFMUef (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 13 Jun 2023 16:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbjFMUee (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Jun 2023 16:34:34 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DB0B8
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jun 2023 13:34:32 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f649db9b25so7440701e87.0
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jun 2023 13:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686688471; x=1689280471;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LrZysrHENuW7Go4ISnRgrIAfcenSBPlLC8M9RsAwT2M=;
        b=xPagHHSysBnXwwl7UbNSgtYhf7WnjXzwEItZgkcsvapQyoFhrh2IWdQvXlH1ndEsQP
         QefpdQZZhgHRvwJS9KmdbYP9noACVipd2lqaqy9VShtStbK56yoL5dmgYO0GhZYKSotN
         aAK8q0Fq3d0mCNdzJHD2uqFZBaVS4z0UW+QfQOQuFuJ/czUWQKxLBfsXh8GcGXSJMMfG
         GEdHJk5VaC7+VL6xJuN3HU61zPy16zv1pL0jNSYtfM5nsY2qC5RyjAHAhNsNbWrHZAWk
         QNkpFJLW4ogesncx4t0gLoyPptlyfucxpHxUmkaWI7ZFhnPUeZdd3o1N+eOdXF66x4Lz
         qy0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686688471; x=1689280471;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LrZysrHENuW7Go4ISnRgrIAfcenSBPlLC8M9RsAwT2M=;
        b=l1oOnPdcGVAzmjIOp7KC3m/u9ygIHhiOP+EaQ4po76r4Js6JHaPFcc7vCFWCI+PLmC
         L22SzLMA9SlP8Vd7+UxtjHAaYis95CPoCvSEkgFWpMBekTozYjUGXA5UCz2uvHA8ddAx
         5k84/TyUmLYmVPJy1njh164UUwXXcaf7fUYvCf7Z6es3QIizGcU+syptX1mVgo1RSvBz
         9AY9OtgITqoxnGScfMMOxr6Kci7jUc+guXRgsK38tfWjQGrNVz4X5q+AkvVPZK0sNfDV
         p/tDXbbScpKVkO1gVkZcLYhxxOIJCERulSNb72q3+q2VHj0/yEbBDxAsDQKLRtKAMJit
         P7uA==
X-Gm-Message-State: AC+VfDzHSX/01a7WuicOcqkqzeUPqeMJWhGZUJZ+iP27+qSbKa7tFCvq
        O0nv9RuYtjqvs8WzIeb5lH6BzCLsLotNIcRTUOH4iA==
X-Google-Smtp-Source: ACHHUZ5LaeGTyGWYf/6jYG5YnmIHRVeFpdY5z5E1lQsdVjyrL/Fba0h8+LYGk56qpQsSe1vHkghBTQ==
X-Received: by 2002:a05:6512:457:b0:4f3:a91c:23d0 with SMTP id y23-20020a056512045700b004f3a91c23d0mr7147416lfk.31.1686688471016;
        Tue, 13 Jun 2023 13:34:31 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id l12-20020a19c20c000000b004f26f699e9dsm1897813lfc.184.2023.06.13.13.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 13:34:30 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 13 Jun 2023 22:34:22 +0200
Subject: [PATCH v4 06/10] mmc: mmci: Retry the busy start condition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-pl180-busydetect-fix-v4-6-df9c8c504353@linaro.org>
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

This makes the ux500 ->busy_complete() callback re-read
the status register 10 times while waiting for the busy
signal to assert in the status register.

If this does not happen, we bail out regarding the
command completed already, i.e. before we managed to
start to check the busy status.

There is a comment in the code about this, let's just
implement it to be certain that we can catch this glitch
if it happens.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v3->v4:
- Accumulate status flags outside the if()-clause in the
  busy detect retry loop.
ChangeLog v2->v3:
- Rebased.
ChangeLog v1->v2:
- Move over the initial saving of host->busy_status from
  an unrelated patch to this one: it is clear what we are
  doing: we don't want to miss any transient
  (MCI_CMDSENT | MCI_CMDRESPEND) in the status register.
---
 drivers/mmc/host/mmci.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 3b1a23e4ec1c..a412ecdee63a 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -664,6 +664,7 @@ static u32 ux500v2_get_dctrl_cfg(struct mmci_host *host)
 static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 {
 	void __iomem *base = host->base;
+	int retries = 10;
 
 	if (status & err_msk) {
 		/* Stop any ongoing busy detection if an error occurs */
@@ -684,21 +685,35 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 	 * Note that, the card may need a couple of clock cycles before
 	 * it starts signaling busy on DAT0, hence re-read the
 	 * MMCISTATUS register here, to allow the busy bit to be set.
-	 * Potentially we may even need to poll the register for a
-	 * while, to allow it to be set, but tests indicates that it
-	 * isn't needed.
 	 */
 	if (host->busy_state == MMCI_BUSY_DONE) {
-		status = readl(base + MMCISTATUS);
-		if (status & host->variant->busy_detect_flag) {
-			writel(readl(base + MMCIMASK0) |
-			       host->variant->busy_detect_mask,
-			       base + MMCIMASK0);
-
-			host->busy_status = status & (MCI_CMDSENT | MCI_CMDRESPEND);
-			host->busy_state = MMCI_BUSY_WAITING_FOR_START_IRQ;
-			return false;
+		/*
+		 * Save the first status register read to be sure to catch
+		 * all bits that may be lost will retrying. If the command
+		 * is still busy this will result in assigning 0 to
+		 * host->busy_status, which is what it should be in IDLE.
+		 */
+		host->busy_status = status & (MCI_CMDSENT | MCI_CMDRESPEND);
+		while (retries) {
+			status = readl(base + MMCISTATUS);
+			/* Keep accumulating status bits */
+			host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
+			if (status & host->variant->busy_detect_flag) {
+				writel(readl(base + MMCIMASK0) |
+				       host->variant->busy_detect_mask,
+				       base + MMCIMASK0);
+				host->busy_state = MMCI_BUSY_WAITING_FOR_START_IRQ;
+				return false;
+			}
+			retries--;
 		}
+		dev_dbg(mmc_dev(host->mmc), "no busy signalling in time\n");
+		writel(host->variant->busy_detect_mask, base + MMCICLEAR);
+		writel(readl(base + MMCIMASK0) &
+		       ~host->variant->busy_detect_mask, base + MMCIMASK0);
+		host->busy_state = MMCI_BUSY_DONE;
+		host->busy_status = 0;
+		return true;
 	}
 
 	/*

-- 
2.40.1

