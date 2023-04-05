Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B63C7619A
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Apr 2023 06:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237023AbjDEGuq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Apr 2023 02:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236964AbjDEGup (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Apr 2023 02:50:45 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5407249ED
        for <linux-mmc@vger.kernel.org>; Tue,  4 Apr 2023 23:50:43 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id bi9so45297038lfb.12
        for <linux-mmc@vger.kernel.org>; Tue, 04 Apr 2023 23:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680677441;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L/SmBW/GkWFXqDOQZgjdK6e878vcBSCxZ/ZaM+lu/CM=;
        b=CXUCGJB4hYnoAKHMAECayVXuAgAvyVtfc23qS+2hMtlWTROX2TKQJqETvCTUjeSa3s
         lCo+VCUDw+LlxqKqtPHddrVfeLPSbE5EIuGaH8YsglzkAOLVyjbOsoFrQnez/egAI3GX
         1+nujNi5QGVuqlEL9VwCUYtria6NBbyzd7efucK6nm9A9A5jm4hfcgRvMkLFtE/aJVMt
         JpDgxt10H2d8buIX2x8L6uWzJwQRYzMIYwMEYoIok1w4x+Np87IbGyBnAKPtZaRD3rmb
         y4D1r5x8NPkMOXhnYNQbymTwA7Z2lHQXTiZymdR1KPHWam0lxRKZ64Q++zYP/SUj63Ca
         dXIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680677441;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L/SmBW/GkWFXqDOQZgjdK6e878vcBSCxZ/ZaM+lu/CM=;
        b=owgQ3oBQEsX7fxDVSGBGLd/qtpB1yW5pi6f1QtaprbpaDwU3ZsCQOQlAVMSv6mw6CC
         pdlDcYu2TakEVBtY+H7iDH4tOX+ezc7+NjKnPyhYp/x2ynumFdgNBcSEu7XRbnzCweqA
         DnMWd/8AlrBSnK82pgUaH35Ol0Ra3oHoeofc3xlxOTRoBCO6uePE+ET8wsdDLjO/GTGD
         HZZA6MlC11dvcg0V5almwg7agyeIaqVU1OLFthEkN7xy4z731ELgZIx5p6ImAgxgEjxa
         NIvW+8IeKxCagzv71EF3pxBHuM4MGI8EMPMhD1CWHrFBbtJC+JeluFFCi1AIVpn7PGp6
         CBvg==
X-Gm-Message-State: AAQBX9ff/N+oKwg5dTyDUkX86uV3Xtb7riTG47d/drNd6dZ1ukkUg8rD
        4rQheUDe9l1qoU4/BpbOc5EDSw==
X-Google-Smtp-Source: AKy350a3RuFZiKyjRYefevxxRtGIx0ndWexlaTbianqmBPW+3FVCUBdrLSmoVGHHODX/1i06RCnk+g==
X-Received: by 2002:ac2:42d7:0:b0:4bb:9415:38a2 with SMTP id n23-20020ac242d7000000b004bb941538a2mr1154549lfl.51.1680677441634;
        Tue, 04 Apr 2023 23:50:41 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id z19-20020ac25df3000000b004eb274b3a43sm2683086lfq.134.2023.04.04.23.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 23:50:41 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 05 Apr 2023 08:50:35 +0200
Subject: [PATCH 09/13] mmc: mmci: Use a switch statement machine
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-pl180-busydetect-fix-v1-9-28ac19a74e5e@linaro.org>
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

As is custom, use a big switch statement to transition
between the edges of the state machine inside
the ux500 ->busy_complete callback.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 734e8364b2f6..626467c212d6 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -676,6 +676,12 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 		goto out_ret_state;
 	}
 
+	/*
+	 * The state transitions are encoded in a state machine crossing
+	 * the edges in this switch statement.
+	 */
+	switch (host->busy_state) {
+
 	/*
 	 * Before unmasking for the busy end IRQ, confirm that the
 	 * command was sent successfully. To keep track of having a
@@ -686,7 +692,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 	 * it starts signaling busy on DAT0, hence re-read the
 	 * MMCISTATUS register here, to allow the busy bit to be set.
 	 */
-	if (host->busy_state == MMCI_BUSY_IDLE) {
+	case MMCI_BUSY_IDLE:
 		host->busy_status = status & (MCI_CMDSENT | MCI_CMDRESPEND);
 		while (retries) {
 			status = readl(base + MMCISTATUS);
@@ -706,8 +712,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 		writel(readl(base + MMCIMASK0) &
 		       ~host->variant->busy_detect_mask, base + MMCIMASK0);
 		host->busy_state = MMCI_BUSY_DONE;
-		goto out_ret_state;
-	}
+		break;
 
 	/*
 	 * If there is a command in-progress that has been successfully
@@ -720,12 +725,11 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 	 * both the start and the end interrupts needs to be cleared,
 	 * one after the other. So, clear the busy start IRQ here.
 	 */
-	if (host->busy_state == MMCI_BUSY_WAITING_FOR_IRQS) {
+	case MMCI_BUSY_WAITING_FOR_IRQS:
 		if (status & host->variant->busy_detect_flag) {
 			host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
 			writel(host->variant->busy_detect_mask, base + MMCICLEAR);
 			host->busy_state = MMCI_BUSY_START_IRQ;
-			goto out_ret_state;
 		} else {
 			dev_dbg(mmc_dev(host->mmc),
 				"lost busy status when waiting for busy start IRQ\n");
@@ -734,16 +738,14 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 			       ~host->variant->busy_detect_mask, base + MMCIMASK0);
 			host->busy_state = MMCI_BUSY_DONE;
 			host->busy_status = 0;
-			goto out_ret_state;
 		}
-	}
+		break;
 
-	if (host->busy_state == MMCI_BUSY_START_IRQ) {
+	case MMCI_BUSY_START_IRQ:
 		if (status & host->variant->busy_detect_flag) {
 			host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
 			writel(host->variant->busy_detect_mask, base + MMCICLEAR);
 			host->busy_state = MMCI_BUSY_END_IRQ;
-			goto out_ret_state;
 		} else {
 			dev_dbg(mmc_dev(host->mmc),
 				"lost busy status when waiting for busy end IRQ\n");
@@ -752,9 +754,8 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 			       ~host->variant->busy_detect_mask, base + MMCIMASK0);
 			host->busy_state = MMCI_BUSY_DONE;
 			host->busy_status = 0;
-			goto out_ret_state;
 		}
-	}
+		break;
 
 	/*
 	 * If there is a command in-progress that has been successfully
@@ -762,11 +763,10 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 	 * the busy end IRQ. Clear and mask the IRQ, then continue to
 	 * process the command.
 	 */
-	if (host->busy_state == MMCI_BUSY_END_IRQ) {
+	case MMCI_BUSY_END_IRQ:
 		if (status & host->variant->busy_detect_flag) {
 			/* We should just get two IRQs for busy detect */
 			dev_err(mmc_dev(host->mmc), "spurious busy detect IRQ\n");
-			goto out_ret_state;
 		}
 
 		writel(host->variant->busy_detect_mask, base + MMCICLEAR);
@@ -775,9 +775,15 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 
 		host->busy_state = MMCI_BUSY_DONE;
 		host->busy_status = 0;
-	} else {
+		break;
+
+	case MMCI_BUSY_DONE:
+		break;
+
+	default:
 		dev_dbg(mmc_dev(host->mmc), "fell through on state %d\n",
 			host->busy_state);
+		break;
 	}
 
 out_ret_state:

-- 
2.39.2

