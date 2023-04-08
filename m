Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF92DC7619A
	for <linux-mmc@archiver.kernel.org>; Sat,  8 Apr 2023 22:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjDHWAt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 8 Apr 2023 18:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjDHWAs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 8 Apr 2023 18:00:48 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301B56A4D
        for <linux-mmc@vger.kernel.org>; Sat,  8 Apr 2023 15:00:46 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id e11so2232052lfc.10
        for <linux-mmc@vger.kernel.org>; Sat, 08 Apr 2023 15:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680991244;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pkQYbCEjQjRXzRX/K8hF+kF32jmLe8MMLCT5UxEXp3k=;
        b=dN4Sif9FwK2AKgY9RtwUQyZSenp59SlULTS32GEgCCPwGhdP9zo9mT5vL+4GKpGjBg
         F5u2H50Hht1eZT4cFxy9a9KG/tnEL6ZgF+onkvvU/QPp1ohh+vhJPR2ZzsViuR9egCD/
         oM/boKwODw3hkVDxxR5jTqYTZFsXvLMFoW2ETfZFtrM+Y67641QUGXuX+gJYSUDqo9Au
         F9SbyW2mzPW8WRR6eUwyBEdNyX+ZvteZpEgo+kcAo8DZu5mQFU1o0xEypi1stuUoCUKf
         7oodWVX16V125nMJ94Ff8ievHleQ7ronScCTNnjw6bXVVak+MyLmSB1pBZlA0djDYi82
         2dyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680991244;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pkQYbCEjQjRXzRX/K8hF+kF32jmLe8MMLCT5UxEXp3k=;
        b=2/+6hClqrbpgsppjsb6y+ONEPygXlAf6a7GwDQnspr1kZQ7vKKj99xwNi+8q+s/rZR
         42f7SE1WJTv/U5W77iuIiszLoPwHzWF8r1ovJaFuASc64Z6OD/W5akbyWOHZsvP4/jCU
         XaGibtaZPWQCFA5KZsinLH+0yy9MxKljZGvbb9bHZQIqdN78Lq4Uq9VXSJPuSiIMmYLk
         uxYMTHGPd+vjXP1TcFaxD3qAl6rYH5cT5ZtzCh7pDXB6FqgDvNS6BC6OQfplBPDOoxuB
         aHAxTaMVCPJhSz4PQGHIV6d3h7jZA5Klu7toMjD2ExninMljGHFZs2W2558ivjFazSZr
         Dhpw==
X-Gm-Message-State: AAQBX9cLAh0kraAHz/cN4TEuxW9MIZO46Mbm9qpdvDQeyJCWH5QH8lTM
        HRg21ePUYuvsz7U9ZXBzToBg2QvK/sSDNENVoPE=
X-Google-Smtp-Source: AKy350ZQGnM+k/Wd37miZZuhFoTdrColl3OzRBE7aZn2aD+nmoCN3Te3icSUTua7vrHaBYUy9BZjSg==
X-Received: by 2002:ac2:43c3:0:b0:4dc:4b92:dbc4 with SMTP id u3-20020ac243c3000000b004dc4b92dbc4mr1301602lfl.14.1680991244466;
        Sat, 08 Apr 2023 15:00:44 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id v9-20020a056512048900b004e9cad1cd7csm1328904lfq.229.2023.04.08.15.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 15:00:44 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 09 Apr 2023 00:00:32 +0200
Subject: [PATCH v2 11/12] mmc: mmci: Drop end IRQ from Ux500 busydetect
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-pl180-busydetect-fix-v2-11-eeb10323b546@linaro.org>
References: <20230405-pl180-busydetect-fix-v2-0-eeb10323b546@linaro.org>
In-Reply-To: <20230405-pl180-busydetect-fix-v2-0-eeb10323b546@linaro.org>
To:     Yann Gautier <yann.gautier@foss.st.com>,
        Stefan Hansson <newbyte@disroot.org>,
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

The Ux500 has these state transition edges:

IDLE -> WAITING_FOR_IRQS -> START_IRQ -> DONE

The first IRQ move us from WAITING_FOR_IRQS to START_IRQ
and the second IRQ moves us from START_IRQ to DONE.

This didn't come out until after all refactoring.

For STM32 we keep the END_IRQ state around, because that
is indeed what we are waiting for in that case.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- No changes
---
 drivers/mmc/host/mmci.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 180a7b719347..17233702e7fb 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -758,7 +758,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 		if (status & host->variant->busy_detect_flag) {
 			host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
 			writel(host->variant->busy_detect_mask, base + MMCICLEAR);
-			host->busy_state = MMCI_BUSY_END_IRQ;
+			ux500_busy_clear_mask_done(host);
 		} else {
 			dev_dbg(mmc_dev(host->mmc),
 				"lost busy status when waiting for busy end IRQ\n");
@@ -766,20 +766,6 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 		}
 		break;
 
-	/*
-	 * If there is a command in-progress that has been successfully
-	 * sent and the busy bit isn't set, it means we have received
-	 * the busy end IRQ. Clear and mask the IRQ, then continue to
-	 * process the command.
-	 */
-	case MMCI_BUSY_END_IRQ:
-		if (status & host->variant->busy_detect_flag) {
-			/* We should just get two IRQs for busy detect */
-			dev_err(mmc_dev(host->mmc), "spurious busy detect IRQ\n");
-		}
-		ux500_busy_clear_mask_done(host);
-		break;
-
 	case MMCI_BUSY_DONE:
 		break;
 

-- 
2.39.2

