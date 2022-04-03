Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2DDC433FE
	for <linux-mmc@archiver.kernel.org>; Sun,  3 Apr 2022 14:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359079AbiDCOxn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 3 Apr 2022 10:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244222AbiDCOxm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 3 Apr 2022 10:53:42 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D46939B8A
        for <linux-mmc@vger.kernel.org>; Sun,  3 Apr 2022 07:51:48 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id bo5so6706903pfb.4
        for <linux-mmc@vger.kernel.org>; Sun, 03 Apr 2022 07:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C3zoiG+f8JGVz1ginGh+WpIukd/W3+NQcd9twqB58ow=;
        b=CIoCQkSS489lEotJcZBHd+04zDuXDDXDYKYJZuzwgbGIlhXOEODtPh/a5YBZK/EGEU
         pT0RHCxnLecm1YAcuE1ghwkswn0645UV5E4LvwFgd7S5rwjzPU7GOo8eoa7RXtnJsHll
         D7nrFocqA8phI8J3WmN5O2mfK53wigAavkYIxvmd9Ts7oDlUQK7lsPMob0ar3KypaOEx
         QnOcNiE3YR2H5GwGYaXviBqLwxB1jjd+P6mqBFsrp8yeNL3DlM9txhwmbL9tdQBXPJ3N
         iHG3TIOh9qd1VKyI+7wIv7N03vMXqUFIhVErOKqlg3iCXvdFYKQjPMrhSmYbJEQYUFkv
         lNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C3zoiG+f8JGVz1ginGh+WpIukd/W3+NQcd9twqB58ow=;
        b=BuNNjB6WpuhzScjf9Tm8Yx/DRm00VvUoE2Ow/E6TfThwCTC1ZvQo4dgcy//CuTmIxB
         5aOYQKo32yeaC4+8y2QirwPODGQCc34Et8B6+P7GLtagTBAwYTMW49z70s6SSqvWyYM4
         1AflFQkUeC77JxWouxgXvoYbjW9T0j51aa2i98DD4zgypKQBE3eg3OTkJGG9LN5Gi8Zh
         LltkRiPYy+BGJxPNBsL3Hna7ijGGT3rHUs2j6zA0+0YLOwct5Hhl+WXiVJzt/ddIio4D
         Sk6Zk8YBBp44XndkYRlk4ZT28tA5W3xoT2egF9FtIpoSL7jzK6UNoD09L/cxyfEKQCNJ
         iztA==
X-Gm-Message-State: AOAM532VpTKorHU7SNr9OV7tZFYl3G/XXEOZ8Id+oo3IIoyaSq3NNEPD
        Xa6L8av32Lbv5XEIW7ZJekVWBio+sytJWQ==
X-Google-Smtp-Source: ABdhPJxVDBJsPqv4DSqoOQ3FQHpF7gQd+oUwex0arHcl2zipNPRUICKpeUltEhkTAWQELAInNzV1Zw==
X-Received: by 2002:a63:d257:0:b0:399:2df1:2fc with SMTP id t23-20020a63d257000000b003992df102fcmr252809pgi.268.1648997507541;
        Sun, 03 Apr 2022 07:51:47 -0700 (PDT)
Received: from localhost.localdomain ([223.233.64.251])
        by smtp.gmail.com with ESMTPSA id q6-20020a056a00150600b004fb2d266f97sm9317866pfu.115.2022.04.03.07.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 07:51:47 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-mmc@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, bjorn.andersson@linaro.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 1/1] dt-bindings: mmc: sdhci-msm: Add compatible string for sm8150
Date:   Sun,  3 Apr 2022 20:21:33 +0530
Message-Id: <20220403145133.93583-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add sm8150 SoC specific compatible strings for qcom-sdhci controller.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
index 6216ed777343..35a7d78da213 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
@@ -25,6 +25,7 @@ Required properties:
 		"qcom,sc7280-sdhci", "qcom,sdhci-msm-v5";
 		"qcom,sdm845-sdhci", "qcom,sdhci-msm-v5"
 		"qcom,sdx55-sdhci", "qcom,sdhci-msm-v5";
+		"qcom,sm8150-sdhci", "qcom,sdhci-msm-v5"
 		"qcom,sm8250-sdhci", "qcom,sdhci-msm-v5"
 	NOTE that some old device tree files may be floating around that only
 	have the string "qcom,sdhci-msm-v4" without the SoC compatible string
-- 
2.35.1

