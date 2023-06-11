Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506D8C87FDD
	for <linux-mmc@archiver.kernel.org>; Sun, 11 Jun 2023 19:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbjFKTlw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 11 Jun 2023 15:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbjFKTlv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 11 Jun 2023 15:41:51 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D971126
        for <linux-mmc@vger.kernel.org>; Sun, 11 Jun 2023 12:41:50 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so4211544e87.3
        for <linux-mmc@vger.kernel.org>; Sun, 11 Jun 2023 12:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686512508; x=1689104508;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mzqgnubCrQNmFQQRG76ba6Xb4A3msmE4+GEzwS5EvGY=;
        b=DtPdIKvWV7nxGFh/sAytmeI2kE7/UE+3zDp1pa3x5xP3tHALcFDnw2i2ijaQR7T0mc
         nl2P7fkYEIR6kCzGmLgiclGHDjzTAypC4xVdTuw50xuR9ABEP/v06KxQSX01ku7YY82i
         QADKelWU5kxbMe3u+3gZ5wqCyPiesW5HBnGnxiUvRK0aPfDkYJjqKQ0CsTGBCUvZaKwA
         ItMqrDYxW3LEm0z7h+ey4jM1ahP1PvOznoVXXbG5qAPCC9IRRkA4IrDC66X819mxoF6O
         3KSHbAY9pOWzJ5jebbJ7CIphZkkYiN8K6YdsxqnWmw++78CVTHzrPQXJ2qEwaCMgi1Dm
         3WgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686512508; x=1689104508;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mzqgnubCrQNmFQQRG76ba6Xb4A3msmE4+GEzwS5EvGY=;
        b=gIdIIPJFoFSwrFfrRnY5EyAizyJQfJ6iXzjPB+RA7ZPATXu6kEhIH+/74ZFmarXXaT
         5T87NXSdqOBHjf1B04nwo4d0h/pNZBOXxg/vwVD1xG0hd3yjfhcGXGKq1pH6SZ08KV+h
         BcGGJgBuQGP5uh8k9VX/nxawNa1PDEBsizzdkKmYNUFvWOa8AuKGvsDUpf2nHyj17pMK
         GSHMbZmGVpoW60mnKXVnPGux0Y61uV8PvmieXosFDTyDZLFhDtfcsWkQU4yn7RSxIRjb
         /IHPGcE1KyUAbwkhDfWXyfeFiKj+gMrix16oaJ/MTLGuQArlCZ7GNylH0Q0wAeEWGKsK
         VyoQ==
X-Gm-Message-State: AC+VfDz1Jir0RvdDoNe0kwrZPmCfH13A0iRNde9EjL+I/m4tYr22cjYa
        lMGoPma8LzPtiprD5LNvwaSWXw==
X-Google-Smtp-Source: ACHHUZ6Oy90IMsC6hgXxCtYYcJIsf4zoXIIia97ReoBpGIM9mjzY227XjC7bthvVB4KlV1LrjyPiEA==
X-Received: by 2002:a05:6512:548:b0:4f6:4a10:ac4c with SMTP id h8-20020a056512054800b004f64a10ac4cmr3112046lfl.42.1686512508452;
        Sun, 11 Jun 2023 12:41:48 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id u24-20020ac243d8000000b004f14ae5ded8sm1246960lfl.28.2023.06.11.12.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 12:41:47 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 11 Jun 2023 21:41:34 +0200
Subject: [PATCH v3 08/10] mmc: mmci: Use a switch statement machine
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-pl180-busydetect-fix-v3-8-cd3d5925ae64@linaro.org>
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

As is custom, use a big switch statement to transition
between the edges of the state machine inside
the ux500 ->busy_complete callback.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Rebased.
ChangeLog v1->v2:
- No changes
---
 drivers/mmc/host/mmci.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index fe928f8f4d8f..e80dd7e7a001 100644
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
-	if (host->busy_state == MMCI_BUSY_DONE) {
+	case MMCI_BUSY_DONE:
 		/*
 		 * Save the first status register read to be sure to catch
 		 * all bits that may be lost will retrying. If the command
@@ -713,8 +719,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 		writel(readl(base + MMCIMASK0) &
 		       ~host->variant->busy_detect_mask, base + MMCIMASK0);
 		host->busy_state = MMCI_BUSY_DONE;
-		goto out_ret_state;
-	}
+		break;
 
 	/*
 	 * If there is a command in-progress that has been successfully
@@ -727,12 +732,11 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 	 * both the start and the end interrupts needs to be cleared,
 	 * one after the other. So, clear the busy start IRQ here.
 	 */
-	if (host->busy_state == MMCI_BUSY_WAITING_FOR_START_IRQ) {
+	case MMCI_BUSY_WAITING_FOR_START_IRQ:
 		if (status & host->variant->busy_detect_flag) {
 			host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
 			writel(host->variant->busy_detect_mask, base + MMCICLEAR);
 			host->busy_state = MMCI_BUSY_WAITING_FOR_END_IRQ;
-			goto out_ret_state;
 		} else {
 			dev_dbg(mmc_dev(host->mmc),
 				"lost busy status when waiting for busy start IRQ\n");
@@ -741,16 +745,14 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 			       ~host->variant->busy_detect_mask, base + MMCIMASK0);
 			host->busy_state = MMCI_BUSY_DONE;
 			host->busy_status = 0;
-			goto out_ret_state;
 		}
-	}
+		break;
 
-	if (host->busy_state == MMCI_BUSY_WAITING_FOR_END_IRQ) {
+	case MMCI_BUSY_WAITING_FOR_END_IRQ:
 		if (status & host->variant->busy_detect_flag) {
 			host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
 			writel(host->variant->busy_detect_mask, base + MMCICLEAR);
 			host->busy_state = MMCI_BUSY_DONE;
-			goto out_ret_state;
 		} else {
 			dev_dbg(mmc_dev(host->mmc),
 				"lost busy status when waiting for busy end IRQ\n");
@@ -759,11 +761,14 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 			       ~host->variant->busy_detect_mask, base + MMCIMASK0);
 			host->busy_state = MMCI_BUSY_DONE;
 			host->busy_status = 0;
-			goto out_ret_state;
 		}
-	}
+		break;
 
-	return true;
+	default:
+		dev_dbg(mmc_dev(host->mmc), "fell through on state %d\n",
+			host->busy_state);
+		break;
+	}
 
 out_ret_state:
 	return (host->busy_state == MMCI_BUSY_DONE);

-- 
2.40.1

