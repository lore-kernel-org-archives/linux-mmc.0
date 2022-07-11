Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F6DCCA47B
	for <linux-mmc@archiver.kernel.org>; Mon, 11 Jul 2022 08:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiGKI1W (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 11 Jul 2022 04:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiGKI1U (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Jul 2022 04:27:20 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009271C10D
        for <linux-mmc@vger.kernel.org>; Mon, 11 Jul 2022 01:27:18 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id u13so7485243lfn.5
        for <linux-mmc@vger.kernel.org>; Mon, 11 Jul 2022 01:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W8rUqsmVeNGPcv4uGkX2i/Ld5DwZ1wusiAJMmwbqUgk=;
        b=v2CMObhrTOddgEjrr0+bghWnB4h/z22A5y7FKA2PHQR1eTlqRfnQRWtZZiwNjbBVLG
         T/5C5IetoJPCKb9xzw9WRLuz0Cix163/qglucnl4FvGOjsl/YJV2txoeE323EnOSYCkN
         17FsKOIJZvw2mZ9shGh/6MPZT9RmM0HvwJ4GP5wZO1Q4PYVywtkxJ/DMmxesQBcGNiKO
         1DtC5FP24nr4vv0if2Kcw/mMbqRvZUf4bwa+5qyhe8LrxmfRLdN7PlaZke++P5pqeDGo
         gU0ndEiibmDcEFKnZUg0FpMY/e4aPIchxRf276CJPyb7ZmlVTvuoyisevBpJQqs6iexj
         PlGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W8rUqsmVeNGPcv4uGkX2i/Ld5DwZ1wusiAJMmwbqUgk=;
        b=RVcr2pwTuuhic91D3DBZ2hk9QxBXJOncGGuC2ivQOzqA4BYnVfL1zc9ECKc2Ub0+VI
         6ev6AJ34XLmrtodRofubavl4Cot3Nb6BXzQsihsTJ9bU4pPhU60Q3sJBFZmWHyAFMSzW
         GIKn7e2CD2QzC0PklI3UeGfMZESia/U2YRpZIBQzpP7BBKHef9dK7MuD++NK7XhxBsXh
         DI8kBXQZjQpaDzQJ7hVW+udTq6C9igFdqHbb6aflNtkxtaGnloRgLUAwDdvZRGGiwDbi
         4qAd/FFwPN9BNjSDjzdGCtZcfD59vPvAPz4Dk6cx5XkiJP+t69+G5s8q7Y/7CQP7zPlp
         M5UQ==
X-Gm-Message-State: AJIora/4rE5i8RTOIssz7XeS2FGFcxrroJHpltl98MSX2CUiatjI/IbT
        sMdYp3ADGiWPa4YqWfE8gmcYAA==
X-Google-Smtp-Source: AGRyM1uzvQJsnfYcU0P4T0ZycZ562CsktrXMECFdRFCBWHAhJngSNbH4lXwGQ+5ZMFWxLetllQMKiQ==
X-Received: by 2002:a05:6512:2305:b0:481:10db:46d2 with SMTP id o5-20020a056512230500b0048110db46d2mr11355012lfu.452.1657528037313;
        Mon, 11 Jul 2022 01:27:17 -0700 (PDT)
Received: from krzk-bin.. (fwa5cab-55.bb.online.no. [88.92.171.55])
        by smtp.gmail.com with ESMTPSA id c30-20020a05651200de00b00473c87152bcsm1408994lfp.127.2022.07.11.01.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 01:27:16 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Douglas Anderson <dianders@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] mmc: sdhci-msm: add MSM8998 SDCC specific compatible
Date:   Mon, 11 Jul 2022 10:27:08 +0200
Message-Id: <20220711082709.39102-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220711082709.39102-1-krzysztof.kozlowski@linaro.org>
References: <20220711082709.39102-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add a MSM8998-specific SDCC compatible, because using only a generic
qcom,sdhci-msm-v4 fallback is deprecated.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/mmc/host/sdhci-msm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index e395411fb6fd..bb169c1c2b5e 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -2447,6 +2447,7 @@ static const struct of_device_id sdhci_msm_dt_match[] = {
 	{.compatible = "qcom,msm8992-sdhci", .data = &sdhci_msm_mci_var},
 	{.compatible = "qcom,msm8994-sdhci", .data = &sdhci_msm_mci_var},
 	{.compatible = "qcom,msm8996-sdhci", .data = &sdhci_msm_mci_var},
+	{.compatible = "qcom,msm8998-sdhci", .data = &sdhci_msm_mci_var},
 	/*
 	 * Add entries for sdcc version 5.0 here. For SDCC version 5.0.0,
 	 * MCI registers are removed from SDCC interface and some registers
-- 
2.34.1

