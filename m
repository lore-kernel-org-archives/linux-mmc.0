Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E5FC77B62
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Apr 2023 06:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237022AbjDEGus (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Apr 2023 02:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236964AbjDEGuq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Apr 2023 02:50:46 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F574224
        for <linux-mmc@vger.kernel.org>; Tue,  4 Apr 2023 23:50:44 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id bi9so45297140lfb.12
        for <linux-mmc@vger.kernel.org>; Tue, 04 Apr 2023 23:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680677444;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CZrJBp7bxoAmhQOHIoV/FMgL+sx0Mt/COQx900KM35s=;
        b=D835TBlnPHXFapIYypyvesZyxDll44ncpPJGjZwsseIA5xWhnue7u2ULafh1Mgvlyl
         YjOJnM9b1HvRutgUyTLMGE9WGf6JrOU5dCfzBHzSR9Xe9WsLTG3P0nk32KZLeApRbArW
         1aTojXFiLyOZCOrmdOWZ8Obte3mGx9cOW+LFjTie0AJ7BkkteCuMtcrbwogRUbV492yD
         I0qerXkzk2jh31o7/Nblf4zTN2ZfqNrPnAu8LPYXmQAM6ryqEwQfXThVxA1ToSpqiKtA
         8PtVjFrfVLTf6xoCgJ3R/pKXWYQgACPT4TkZStnVJRUDf/DnbGV8LKHsQ32rl+0cGHTQ
         jF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680677444;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CZrJBp7bxoAmhQOHIoV/FMgL+sx0Mt/COQx900KM35s=;
        b=G7ogzZWqt+0bNbx5ZcOWgBR25rD72lckOeg9UpV2Ic3wkNcxKzI3ZbvksdPI4wa+7Y
         UKaNv29J7E3fydYo+ecFGN5UKTIQC2ExpOYXRlWiSx9iC1gcRZjZ4Hlc4P/sxpn0mFv+
         L/EqhSu+LkSuiD7pLMipf0+V8MryJLkJOWHXgmGgDp/EOU6QRGqSH+ubzmnVMOZS4MzH
         tnTiY5K6NG5tDbML/fJwugI2elBM5h5xaN2sKDxniTUpa2sZ6AUshJ887zx/+LzXlMAN
         CkpEt0z2OC6b8/jdG89WBX/0KDeP3xA2bhiegp5a4kgINmZOBxxxMstWK7eVQLVhpSL2
         TKAw==
X-Gm-Message-State: AAQBX9eII+gn1movcP/gaDfWlI56cftwtS3hc1tJtbjlx176WZwt0F3D
        HVcmj4tFHVtjiMIkH807tsyrGQ==
X-Google-Smtp-Source: AKy350Zfmmhvue8OWU2JCIJTabcCiWBx+GsA92bBBeT4onZu0NRIuw9PoqPJ9+MUp9fIf0TV7V/lsw==
X-Received: by 2002:a19:750b:0:b0:4dc:82b0:4c68 with SMTP id y11-20020a19750b000000b004dc82b04c68mr1159856lfe.50.1680677444364;
        Tue, 04 Apr 2023 23:50:44 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id z19-20020ac25df3000000b004eb274b3a43sm2683086lfq.134.2023.04.04.23.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 23:50:43 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 05 Apr 2023 08:50:38 +0200
Subject: [PATCH 12/13] mmc: mmci: Drop end IRQ from Ux500 busydetect
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-pl180-busydetect-fix-v1-12-28ac19a74e5e@linaro.org>
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

The Ux500 has these state transition edges:

IDLE -> WAITING_FOR_IRQS -> START_IRQ -> DONE

The first IRQ move us from WAITING_FOR_IRQS to START_IRQ
and the second IRQ moves us from START_IRQ to DONE.

This didn't come out until after all refactoring.

For STM32 we keep the END_IRQ state around, because that
is indeed what we are waiting for in that case.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 2779d4985b63..a4c9a3a9b037 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -753,7 +753,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 		if (status & host->variant->busy_detect_flag) {
 			host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
 			writel(host->variant->busy_detect_mask, base + MMCICLEAR);
-			host->busy_state = MMCI_BUSY_END_IRQ;
+			ux500_busy_clear_mask_done(host);
 		} else {
 			dev_dbg(mmc_dev(host->mmc),
 				"lost busy status when waiting for busy end IRQ\n");
@@ -761,20 +761,6 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
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

