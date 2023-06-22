Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB21EB64D8
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jun 2023 10:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjFVKxf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 22 Jun 2023 06:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjFVKxd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Jun 2023 06:53:33 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB401BC5
        for <linux-mmc@vger.kernel.org>; Thu, 22 Jun 2023 03:53:32 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b4826ba943so58930931fa.0
        for <linux-mmc@vger.kernel.org>; Thu, 22 Jun 2023 03:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687431210; x=1690023210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fAAd8JtH4zYPLMTCIKY+Yne0KWOXMwDZDoPI05bkqp8=;
        b=qjZBCxmZxL+Eh36jvWumDK2DRD5p+kazF0Gun092VmNoLwIpTp2Xs82s17VVljkCZc
         y8LaN0As1JvRWVU8IwV4ZRUvz4EsZpjuPLxFoPUpikBWf4gfWGdFBNNQ6IUiP1TJlgz3
         0AhiMsS8srlTMnQ4iJOwLM4DjUSG+rtlzityUHFrTZHAOdkb1vAOPs6rmTHBnYXExPPQ
         olmDaqZ4HBChhUvSU2POIagqAzDQDlYVZRknGxLbi4ihVHcP/uLa8e6rPXbYJRV2IB60
         43cwU6P8IKaHgywg6o66jVRtokVtUViW8B1wKFUFGeSho1/ukE0Ko2+RQBWB4r1s8tUf
         Pmbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687431210; x=1690023210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fAAd8JtH4zYPLMTCIKY+Yne0KWOXMwDZDoPI05bkqp8=;
        b=QL+dCUz641O57qj4vZW8aBnGVvpGaEv7SofKoFpiu5S2ICvXvzYfLZIf4TneCDssv5
         ZSBQX265CqdFrHlWpdcZslmikJk/AikBnQ2ObDJwZ3EXB50LBB1ftCz58opL7caklh1s
         WjvY5omTYy35izUvNUr3lgBPpNY0dDMCB2M5ov3wKJXza4MhG0O3ULTyPcsz608F822j
         l6XJyjL3dx2w4VPRXji/vBcZtvWFQ3pEUl8mdWEWY6BJAkkvgOMzJyfQt3S+X/rVreXs
         lIWFCiV7xFOFFVXxM21osOKRtdmkxPJc5KV1xxR+b4BmZ050/OCMF/FDbzCh+mvNHphK
         0VNw==
X-Gm-Message-State: AC+VfDwQ9z1x/P/821u7D37R8MpK4Lx9/PcJgA/8Snt10W4xi9vcW8Wn
        6fYX8F7pFdxUUphAdwwiGZUuX6hKpYigWm1ArXQ=
X-Google-Smtp-Source: ACHHUZ4nHM6Q4AYt+U9zTwFnLj3fidlXpclz83BLY5riwkGo7dEB1wMJ8L3mLjs0IkmzknIK2YAhFw==
X-Received: by 2002:a05:651c:20c:b0:2b4:5c80:786d with SMTP id y12-20020a05651c020c00b002b45c80786dmr12060575ljn.12.1687431210370;
        Thu, 22 Jun 2023 03:53:30 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id v17-20020a2e9611000000b002adb98fdf81sm1267318ljh.7.2023.06.22.03.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 03:53:29 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] mmc: meson-gx: Drop redundant WARN_ON() in the irq handler
Date:   Thu, 22 Jun 2023 12:53:27 +0200
Message-Id: <20230622105327.77296-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The host pointer is already being dereferenced earlier, so let's just drop
the redundant WARN_ON.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/meson-gx-mmc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index ee9a25b900ae..d652374f37b2 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -948,9 +948,6 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 		return IRQ_NONE;
 	}
 
-	if (WARN_ON(!host))
-		return IRQ_NONE;
-
 	/* ack all raised interrupts */
 	writel(status, host->regs + SD_EMMC_STATUS);
 
-- 
2.34.1

