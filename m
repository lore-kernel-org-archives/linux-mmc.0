Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAD4C47089
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Nov 2022 02:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiK1Coz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 27 Nov 2022 21:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiK1Coy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 27 Nov 2022 21:44:54 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B1D634D
        for <linux-mmc@vger.kernel.org>; Sun, 27 Nov 2022 18:44:52 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id o1so4609561pfp.12
        for <linux-mmc@vger.kernel.org>; Sun, 27 Nov 2022 18:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kwkzsxls5ZWblSq857VINffaoA+3YsLSkG7RdKigW24=;
        b=E65i522lAPGxtB0Jjp9iAOdnEHGT70IwSQZ8r+AQKPbRARFTOp9riib2vgA6OXFuQd
         hYSuUZZS0BbKykDE8MKRhMr8DDBd6zPUH5j0t+XrRufd4eaJsskG2WuZARBn7UA8zUhu
         4Xq9zVqu25ATDLJw3Ge2WkCK9I/4PsDzvEoY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kwkzsxls5ZWblSq857VINffaoA+3YsLSkG7RdKigW24=;
        b=UXmWDc5tK26hT4Q+c67Kcl60biZL/UWYXh0TXK03/XGIMzPMCdnBnBuXVgVoXPACRZ
         LnCImqOMUmnM2Z5xEHMlchoiUF0OE9/DCVBZy25CzLTsWif0SxkDBTJQJwxKG230iUVD
         GgZXGY/SEXUvPYWO+QcVacF6siMqc96dAfUDhjEy5PhlxNoxY0BjRmoA9vW8aJA7oTJZ
         GsJlU/8UNttRir252qVmCrxuwlPy3irM1LLxMyWOghZK57D3gGTosq049PdMMS55BRj/
         Up+X59R7W0FcG+ouOdxJbcd+4H8KW14rrLPXRvuqfTrsmJsKv7ZNK81FQf35r4ljDIbo
         jc3g==
X-Gm-Message-State: ANoB5pnaSqGDZEPIR6wF498HaDiOkM1YEqGot96ZSDsDhiDcUDv32fOV
        5WO4NETynX+4BPWfeWEOnpLNtA==
X-Google-Smtp-Source: AA0mqf4BeNiJxg1a+9CVbsFBMOpOCIpJF+fUVWmNi6djSdwWpDpvsDlucTpIcmcm078pnnI0z3hvgQ==
X-Received: by 2002:a05:6a00:26c8:b0:574:c159:ce3b with SMTP id p8-20020a056a0026c800b00574c159ce3bmr13624667pfw.74.1669603492220;
        Sun, 27 Nov 2022 18:44:52 -0800 (PST)
Received: from doug-ryzen-5700G.. ([192.183.212.197])
        by smtp.gmail.com with ESMTPSA id z16-20020aa79910000000b005752201d4ffsm1431568pff.213.2022.11.27.18.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 18:44:51 -0800 (PST)
From:   Doug Brown <doug@schmorgal.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Doug Brown <doug@schmorgal.com>
Subject: [PATCH 4/8] mmc: sdhci-pxav2: change clock name to match DT bindings
Date:   Sun, 27 Nov 2022 18:44:03 -0800
Message-Id: <20221128024407.224393-5-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221128024407.224393-1-doug@schmorgal.com>
References: <20221128024407.224393-1-doug@schmorgal.com>
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
index d76131b8986b..a0c882d03d0b 100644
--- a/drivers/mmc/host/sdhci-pxav2.c
+++ b/drivers/mmc/host/sdhci-pxav2.c
@@ -192,7 +192,9 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
 
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

