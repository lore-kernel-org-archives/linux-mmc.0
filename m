Return-Path: <SRS0=9HeC=D6=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E3CC55179
	for <linux-mmc@archiver.kernel.org>; Fri, 23 Oct 2020 12:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1322A2465A
	for <linux-mmc@archiver.kernel.org>; Fri, 23 Oct 2020 12:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1sfZ/A80"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463832AbgJWM37 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 23 Oct 2020 08:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S372608AbgJWM36 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Oct 2020 08:29:58 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39FBC0613CE
        for <linux-mmc@vger.kernel.org>; Fri, 23 Oct 2020 05:29:56 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id c16so1325367wmd.2
        for <linux-mmc@vger.kernel.org>; Fri, 23 Oct 2020 05:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7rIF8N/i8VFiSPcWy7t2VnCvFrWFZsMucLJqXY/Ky6I=;
        b=1sfZ/A80DOJRkuDn+aMTJEqRnTd7jlDaBzl/CTej9gD9qfX1ZXXwxvI9nL7Mhm2zCy
         ppp30/JsZrruqfWCbWJvNoRaBZqiukoFqxkMsDnWCvp3OOvc8RXTvrYb4BM+JnII9wtx
         vuu8zwt4MUCheX8x2ne4bex/JPdNTKobo4TXdbwrB2OkXP1PTIPGeUdA5qxC6TEgw/2H
         io/sCFvCAYFZj3Nvg8qIEhdXdn4scXwM0VjR2jviSTN4KdxZXtJiSwPSp6T9HPcA0GSX
         cq9+t8tjpmvOZQz5iYSwz2ArAQ6dTVS3ILRv0D67dVDYJqX+xgfOIBbSY3KgeA6k35I2
         vY/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7rIF8N/i8VFiSPcWy7t2VnCvFrWFZsMucLJqXY/Ky6I=;
        b=NcSFz+RuMVfgQHWU1T3MKLmohBeyFVEoGUtQQ15Fx9aiqRzXpLBf7MUvkMNhISj1q9
         LNeoQa5K8Pyp9eePhrGWkBD3GHCkSfi3Ph0tV4HaqFLW/1sLcYBoxfRyCBlfNjgOprwY
         fjvPbh9RyAyfqtjupsVKxhurtZ1Ga7BukEiuLwIz4Aw7SQSprYVWP7YFtxkDlEU9PEhp
         Z7kkk4n9rwASFWIVbN+1zvz74Ivru012WnBUuSbFMBMLHnohWbPFJtzZ8mmRa+U71wHS
         7Xu+gDGDshjfHt2qOkUvGV9KGtKjrQ9GhMTYs+HvlxGRTngiYU6DLWyq7ZsEgoV688vl
         MMaw==
X-Gm-Message-State: AOAM532aYTArnutAo5Ep44GtzZ6rBGr6LQrZLVRSEEKef4OIuyrTmXni
        mFEDhGyfHuI4PJGh0YMY2t7+sg==
X-Google-Smtp-Source: ABdhPJy8hebC8ysED7iakQTxAZEuNSTOYysF1RdKWxwQs5f/GemG//s/NvSNRjFXup1EEZ3JM+edIw==
X-Received: by 2002:a1c:2905:: with SMTP id p5mr2116034wmp.187.1603456195733;
        Fri, 23 Oct 2020 05:29:55 -0700 (PDT)
Received: from localhost.localdomain (211.160.185.81.rev.sfr.net. [81.185.160.211])
        by smtp.gmail.com with ESMTPSA id z15sm3138527wrq.24.2020.10.23.05.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 05:29:54 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc:     matthias.bgg@gmail.com, ulf.hansson@linaro.org,
        chaotian.jing@mediatek.com, Fabien Parent <fparent@baylibre.com>
Subject: [PATCH] mmc: host: mtk-sd: enable recheck_sdio_irq for MT8516 SoC
Date:   Fri, 23 Oct 2020 14:29:50 +0200
Message-Id: <20201023122950.60903-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

MT8516 SoC suffers from sometimes losing SDIO IRQs, this makes SDIO
devices sometimes unstable. Make use of the new property
recheck_sdio_irq to fix the SDIO stability issues on MT8516.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/mmc/host/mtk-sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index a704745e5882..3dc102eefe49 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -524,7 +524,7 @@ static const struct mtk_mmc_compatible mt7622_compat = {
 
 static const struct mtk_mmc_compatible mt8516_compat = {
 	.clk_div_bits = 12,
-	.recheck_sdio_irq = false,
+	.recheck_sdio_irq = true,
 	.hs400_tune = false,
 	.pad_tune_reg = MSDC_PAD_TUNE0,
 	.async_fifo = true,
-- 
2.28.0

