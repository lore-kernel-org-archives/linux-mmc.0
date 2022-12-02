Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA6CC4708E
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Dec 2022 03:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbiLBDOC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 1 Dec 2022 22:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbiLBDOA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Dec 2022 22:14:00 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA3AD427D
        for <linux-mmc@vger.kernel.org>; Thu,  1 Dec 2022 19:13:59 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id s196so3345555pgs.3
        for <linux-mmc@vger.kernel.org>; Thu, 01 Dec 2022 19:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=agIvM+RESqFOi6zq2PfLhwbAmjFDfRo+ieTUEwufHOc=;
        b=eaVziJwbJ8GXqtHJD7dVAD9LkmXFaz+/poyw0LaBJDLiFpSyHR+1VRLe/nqkKbrDki
         zMFNro3K5/jF+5N2wM8g6zjqN/SUzk6j48iJrdU4dmje0CkvEX0Y8vgtCS8Zo2ChzbG1
         5K1y6rNSZDThLxCrWlpCeWeEk3ZfnErSv3xZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=agIvM+RESqFOi6zq2PfLhwbAmjFDfRo+ieTUEwufHOc=;
        b=8LZwIJ1yX27LKMvuBSaxcbg/iQTyYh5wGMNna6JpDQ9/SN/yz43BxEWC+V5F8cpoZc
         ld9yCB91w5XktysyCgxkBiS4rwVryl6jAICgJu2T3KVD1pj5x/TfYn+awSRJUx3tTKAi
         J1wc1/gXm9CSNLkti0xI4SkjZ6ov65r5QLS10R/sUVZrM4CcuVBmSVn9tKW0+iYxqrat
         bwHyRtHrQ9UTQ2HsvCuKVuDh5EMnv/biRdFDN4X7c3hD8fJGnLojr649KJgpB9S1LE2j
         vQz1LOZE4QBEYGXOerOGPREyuQmXZ78iT+bE48mLZmcVt6QtmKjLKgkLCdLSddN30Wsw
         7gBg==
X-Gm-Message-State: ANoB5pkNO4QhD0STGslTpxF5LP082TSDv8KzIe+i00YlhLXVvt3pKvIf
        3uzAiTOq21gEOQ5I5hLNPdBW/w==
X-Google-Smtp-Source: AA0mqf4K1NiC1zJPzjzp/rwODq9vS7RxKPAosQIViGm6J4QjknqA1LGCxbi/8+JFxVBqnV+XLQPZlA==
X-Received: by 2002:a63:e510:0:b0:476:a862:53d2 with SMTP id r16-20020a63e510000000b00476a86253d2mr42354672pgh.163.1669950839021;
        Thu, 01 Dec 2022 19:13:59 -0800 (PST)
Received: from doug-ryzen-5700G.. ([192.183.212.197])
        by smtp.gmail.com with ESMTPSA id jx24-20020a17090b46d800b00213202d77d9sm3708410pjb.43.2022.12.01.19.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 19:13:58 -0800 (PST)
From:   Doug Brown <doug@schmorgal.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Doug Brown <doug@schmorgal.com>
Subject: [PATCH v2 4/8] mmc: sdhci-pxav2: change clock name to match DT bindings
Date:   Thu,  1 Dec 2022 19:13:26 -0800
Message-Id: <20221202031330.94130-5-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221202031330.94130-1-doug@schmorgal.com>
References: <20221202031330.94130-1-doug@schmorgal.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The devicetree bindings for this driver specify that the two allowed
clock names are io and core. Change this driver to look for io, but
allow any name if it fails for backwards compatibility. Follow the same
pattern used in sdhci-pxav3.

Signed-off-by: Doug Brown <doug@schmorgal.com>
---
 drivers/mmc/host/sdhci-pxav2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index 0a16098b963f..509ba5dd4a4a 100644
--- a/drivers/mmc/host/sdhci-pxav2.c
+++ b/drivers/mmc/host/sdhci-pxav2.c
@@ -189,7 +189,9 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
 
 	pltfm_host = sdhci_priv(host);
 
-	clk = devm_clk_get(dev, "PXA-SDHCLK");
+	clk = devm_clk_get(dev, "io");
+	if (IS_ERR(clk))
+		clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(clk)) {
 		dev_err(dev, "failed to get io clock\n");
 		ret = PTR_ERR(clk);
-- 
2.34.1

