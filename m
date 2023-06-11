Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24637C8300C
	for <linux-mmc@archiver.kernel.org>; Sun, 11 Jun 2023 19:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbjFKTlv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 11 Jun 2023 15:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233752AbjFKTlt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 11 Jun 2023 15:41:49 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234F7E42
        for <linux-mmc@vger.kernel.org>; Sun, 11 Jun 2023 12:41:48 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4effb818c37so4217932e87.3
        for <linux-mmc@vger.kernel.org>; Sun, 11 Jun 2023 12:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686512506; x=1689104506;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=14aHGZ8oHIVpggHbzlWvOkwC1BB515dSDX3YOpp4NLY=;
        b=tzfzQwo71K+8FmLa7PRd7RaqrdSICWkIxsQPh2IdvMqAjv9JnPh3ncT3GAqaKCTHPv
         GoUsSQzIppJYVy4+UJ4HP772V3BM5msioBtvbbNfdW+jmgrP2bB4qCM4Pla5bUodiubP
         Xtz/8zTwnT8kGvcNfCl9uA3rDl0lBODNTzvn1xJ17eGfKIbE1zC9R3c/D9TVZ8CDxB6l
         o0TC1DRTsCRaAtjTiW9Utv1NyCKFBP4Jr0yAGQdePcyXQBOkWxIcgD8zC6wKyj2WiFv8
         3I9jTxBbtnPR7RcPRpej0ivI7HeHZinH5TWFDiT99fARcQEHaSYyoe7q+47I89JT3Alm
         qnzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686512506; x=1689104506;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=14aHGZ8oHIVpggHbzlWvOkwC1BB515dSDX3YOpp4NLY=;
        b=bj/QQ5/6CsgiAIGo2Sh4zuSKTUp6qkxPRtrmgU+5T+jiZ3/DEkVqr8ZX5vXAjyoMA8
         D4BLz925TwCMm7j0/YnBRkJ7UZvs5p/Lmias3x1uZ5zLx3sih2Rkc4NeXRUZ/pILw+Ec
         DB4/ZPmrFTC3yzJdoUc/dLbhJL21UTGgqarr+NJInv7F+JBKgStpeWmd8igZVuN5EP98
         msRZUsT8PP5nYVrBUsD9BIeiBVPYT6RBelU6+CxSTblj3W2itVxIvpxoM4C2Du24n9go
         tKkKRG47Fjoe42yQgapeyYRrQUG8dBKiEueXp+pT/AREsYiFBwmF7UjL2ytgiQs6smSC
         VLzA==
X-Gm-Message-State: AC+VfDyMJRuuIvhldqdPs+J9aTlwF2FUL+2TDzH8P//2Q2raStb4/ftR
        xU0FTqfukTtV6cBuv9aqUx9Cdg==
X-Google-Smtp-Source: ACHHUZ6crYauMFC6n3ylXmNgLHPRvnZDSbE86QHa9gdkBoRJJY+fHDqlPvd2ItZt2U0YVCVgQvrOtg==
X-Received: by 2002:a19:670f:0:b0:4f4:d0ab:97d5 with SMTP id b15-20020a19670f000000b004f4d0ab97d5mr2903591lfc.14.1686512506515;
        Sun, 11 Jun 2023 12:41:46 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id u24-20020ac243d8000000b004f14ae5ded8sm1246960lfl.28.2023.06.11.12.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 12:41:46 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 11 Jun 2023 21:41:32 +0200
Subject: [PATCH v3 06/10] mmc: mmci: Retry the busy start condition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-pl180-busydetect-fix-v3-6-cd3d5925ae64@linaro.org>
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
ChangeLog v2->v3:
- Rebased.
ChangeLog v1->v2:
- Move over the initial saving of host->busy_status from
  an unrelated patch to this one: it is clear what we are
  doing: we don't want to miss any transient
  (MCI_CMDSENT | MCI_CMDRESPEND) in the status register.
---
 drivers/mmc/host/mmci.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index edc68fc7b642..2858d8d67129 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -664,6 +664,7 @@ static u32 ux500v2_get_dctrl_cfg(struct mmci_host *host)
 static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 {
 	void __iomem *base = host->base;
+	int retries = 10;
 
 	if (status & err_msk) {
 		/* Stop any ongoing busy detection if an error occurs */
@@ -684,21 +685,36 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
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
+			if (status & host->variant->busy_detect_flag) {
+				writel(readl(base + MMCIMASK0) |
+				       host->variant->busy_detect_mask,
+				       base + MMCIMASK0);
+
+				/* Keep accumulating status bits */
+				host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
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

