Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860AEC636D4
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Feb 2023 20:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjBOUCC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Feb 2023 15:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjBOUCB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2023 15:02:01 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0F686B5
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2023 12:01:57 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id s13so2618419wrw.3
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2023 12:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TDuLc/Vv+/D54ip1urJ0aPwrswjREsdYP1joaEHODEM=;
        b=B9Puxk98hSEtzhZlGwqtYzI1yDF2qTvNsaxBp9XUic1dHe84Ef24Ggi+Mgd9Ecz2Dk
         taLgTtcMuL8tjSEuTxyWesjna9AJ6RMZkbHdpKfHQqOctwjLrXNK3I3PFiJZuD+OQmLe
         +9uPIV+mLgpdFyeyQXI3k6I8ZhN1qQJd9DQksKxiCkUd/fePBokheFLpuU+CBldP3BjA
         kwq4yEXFBSr8s1CoJe0OT3U6CjgLtEFgKkBNLBWfdD7lWOHncdQMAlMuwBvqv7lNAcvt
         BVug7M6w2V0ohQlVzwE67MLq0tBYSRbqDDAqYkEKETu+zn/nG8n0Xr71yULZHZS/M0RD
         DfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TDuLc/Vv+/D54ip1urJ0aPwrswjREsdYP1joaEHODEM=;
        b=CT+3YAuAfqRG9Z5+qXNo5g7GnvU/9NSJvs8tsFSbWeY/MNDg/U1H62E8oxWbSeGGAF
         VhzXsdtEV/0250bSmXmbU+Y1eUoUFHLapS3jGCQdDmEFB4XCjglKtC8t99RDwmTls98b
         RkDg7A5zzk3ghS+74F/Xl9+7CkjxWW6kp2eTd98Rho48vyMH+qrgA/jUeNE5nfVrcZZ0
         YqsN0X1pNyjAhrZ3e++o8esPQmjdw5lRrXV9EWqvDb1tf0V8NaPT+HA+uBIjtJdsTTbU
         XKePWQrIAfgbRTMPGBq4YabgBG6OY9Y4rvOfxhpFCLDQixGPJ/X64Pqe/Uar1jctl6mi
         h/fA==
X-Gm-Message-State: AO0yUKX+GRC8JZFoQPcaPHtIV7d1ylnVgj4CZwnkYBBzs0zb2IfFykEs
        IPX3GkeZEk5DZnlN2+mL6Lxo5j+ochU=
X-Google-Smtp-Source: AK7set8YP4kJK2NB9GcOPW6s0+dzQgPDiAyIHo4G+LHzZ+aZV0Wx855kYSEisgkfKCEOyG90bBFqhA==
X-Received: by 2002:a5d:574a:0:b0:2c5:582b:bad1 with SMTP id q10-20020a5d574a000000b002c5582bbad1mr2852064wrw.30.1676491316020;
        Wed, 15 Feb 2023 12:01:56 -0800 (PST)
Received: from ?IPV6:2a01:c23:b9d5:9700:ccee:9a0d:2992:c73? (dynamic-2a01-0c23-b9d5-9700-ccee-9a0d-2992-0c73.c23.pool.telefonica.de. [2a01:c23:b9d5:9700:ccee:9a0d:2992:c73])
        by smtp.googlemail.com with ESMTPSA id f8-20020a0560001b0800b002c577e2fc87sm143815wrz.15.2023.02.15.12.01.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 12:01:55 -0800 (PST)
Message-ID: <70e5520f-e327-111d-9ea4-824460e41561@gmail.com>
Date:   Wed, 15 Feb 2023 21:01:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] mmc: meson-gx: constify member data of struct meson_host
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Constify member data of struct meson_host. This also allows to remove
the cast as of_device_get_match_data() returns a const void *.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 6ed95c555..641ea4292 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -150,7 +150,7 @@ struct sd_emmc_desc {
 
 struct meson_host {
 	struct	device		*dev;
-	struct	meson_mmc_data *data;
+	const struct meson_mmc_data *data;
 	struct	mmc_host	*mmc;
 	struct	mmc_command	*cmd;
 
@@ -1195,8 +1195,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	if (mmc->caps & MMC_CAP_SDIO_IRQ)
 		mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;
 
-	host->data = (struct meson_mmc_data *)
-		of_device_get_match_data(&pdev->dev);
+	host->data = of_device_get_match_data(&pdev->dev);
 	if (!host->data)
 		return -EINVAL;
 
-- 
2.39.1

