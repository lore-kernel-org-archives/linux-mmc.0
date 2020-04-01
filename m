Return-Path: <SRS0=Vjr6=5R=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A84C43331
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Apr 2020 14:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9885D2078C
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Apr 2020 14:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yE47rub6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733062AbgDAOzs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 1 Apr 2020 10:55:48 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45464 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732749AbgDAOzr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Apr 2020 10:55:47 -0400
Received: by mail-lj1-f193.google.com with SMTP id t17so26118738ljc.12
        for <linux-mmc@vger.kernel.org>; Wed, 01 Apr 2020 07:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bYU7QeY1a7IIXFQO/jwmz3hXaskowVHLsLdG+qiYwio=;
        b=yE47rub6AfkfEUMl+SpKqdMTGgl+0p76TgEdtp5Ofbcw7wjR4xDM7PcRLVinwIbXP1
         SA1xppNMOD5JoztIV1GM4lE9/As0u8jt2v2qtv2MF0ZpfrPgsPkr6A1o80qRFsIkddjy
         38wvMogUv1yg7JHLKK7HwV6Du1n7FqhHt41ZQ705VOF6WCFAOm8x/zl5uOjOoKhE8mqj
         rSoPVj9gFgMEQ2O5pL3nNKNVGIO9GPtHpxWqmFsTt77psrwCicMemWOZGwFkshtWCWgh
         Ui4hPXzI5Y5ULpOBgGYRTntj/G8FCB2+y/hnK243eQHLJ9vC79tHn0H0s0tOC5b1gVrR
         pynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bYU7QeY1a7IIXFQO/jwmz3hXaskowVHLsLdG+qiYwio=;
        b=YetvL6G7AHVIxVwi35LsthDYsuDhosJqwokH2EUCdtLz+fsd5RZTTXgB/8gIdx7lZW
         W/Jwpg/XZGXXk7VP5624RNt2LRK5OeNdMdYR0v/Z9tBu05Ifp/YiQ4ogBkSVOfMZD7WJ
         IGK3cS/HSmkZJ0ARe1ybhG7v+d5/1A19iHHD83Y/3A2WmTBIPc+Tol03u+q8i8KElKg7
         SfpAVWo7j0DiV6BNBRDBHglIBbyjkUuB6MEpBUCi7eNNDhlkbwZQnQTmNPe6STHLOh+k
         CYI+tQ7oW2hm1uev1FwRYjekyAQ0jqQbziPwo/YjgUbkF4yFvgM848PJl8626ZHSFw5B
         LNgw==
X-Gm-Message-State: AGi0Pua/Eh1+uUYL+1UKihmJ1MGrxBV56PXwIqIN0v0l9IvYGIw7M6Bb
        PMC496/xI3lZ3+ba+78yGFw7vxjri88=
X-Google-Smtp-Source: APiQypK3NvoBTUSYHtDbhiWyG29rdPPfQ0HucsRx29dy+taZIDIBEdhLZUv35IlXUFvm85nCebyEbw==
X-Received: by 2002:a2e:8914:: with SMTP id d20mr12637025lji.148.1585752944615;
        Wed, 01 Apr 2020 07:55:44 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id f9sm1393485ljp.88.2020.04.01.07.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 07:55:43 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: android-goldfish: Enable MMC_CAP2_NO_SDIO
Date:   Wed,  1 Apr 2020 16:55:31 +0200
Message-Id: <20200401145531.23247-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Instead of explicitly checking for SDIO specific requests and then
returning an error code, let's set MMC_CAP2_NO_SDIO to tell the mmc core to
prevent them altogether.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/android-goldfish.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/mmc/host/android-goldfish.c b/drivers/mmc/host/android-goldfish.c
index 914e17bab3be..ceb4924e02d0 100644
--- a/drivers/mmc/host/android-goldfish.c
+++ b/drivers/mmc/host/android-goldfish.c
@@ -27,7 +27,6 @@
 #include <linux/mutex.h>
 #include <linux/scatterlist.h>
 #include <linux/mmc/mmc.h>
-#include <linux/mmc/sdio.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
 
@@ -404,14 +403,6 @@ static void goldfish_mmc_request(struct mmc_host *mmc, struct mmc_request *req)
 	host->mrq = req;
 	goldfish_mmc_prepare_data(host, req);
 	goldfish_mmc_start_command(host, req->cmd);
-
-	/*
-	 * This is to avoid accidentally being detected as an SDIO card
-	 * in mmc_attach_sdio().
-	 */
-	if (req->cmd->opcode == SD_IO_SEND_OP_COND &&
-	    req->cmd->flags == (MMC_RSP_SPI_R4 | MMC_RSP_R4 | MMC_CMD_BCR))
-		req->cmd->error = -EINVAL;
 }
 
 static void goldfish_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
@@ -482,6 +473,7 @@ static int goldfish_mmc_probe(struct platform_device *pdev)
 	mmc->f_max = 24000000;
 	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
 	mmc->caps = MMC_CAP_4_BIT_DATA;
+	mmc->caps2 = MMC_CAP2_NO_SDIO;
 
 	/* Use scatterlist DMA to reduce per-transfer costs.
 	 * NOTE max_seg_size assumption that small blocks aren't
-- 
2.20.1

