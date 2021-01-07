Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1174C4332B
	for <linux-mmc@archiver.kernel.org>; Thu,  7 Jan 2021 14:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66F7D2311E
	for <linux-mmc@archiver.kernel.org>; Thu,  7 Jan 2021 14:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbhAGOgt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 7 Jan 2021 09:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729236AbhAGOcR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Jan 2021 09:32:17 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4BDC0612F6
        for <linux-mmc@vger.kernel.org>; Thu,  7 Jan 2021 06:31:36 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id j13so3900258pjz.3
        for <linux-mmc@vger.kernel.org>; Thu, 07 Jan 2021 06:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sH2bFxCKx1Y8BaQTg3VTlV/2EBMMuPOF6dbVWV5OFqo=;
        b=TwrjFtbYmKEKZ4701FStffI+UGbHHzVTwmX2K62eDF3mHt3kvetNBQRcpG7EMYgCyU
         8wq2Xvy4jTINk9Sq8ctTDoaw+WDvRGp06dFkI2Jf9UtP2bovkwnCD7D5YFEh6u8jytoH
         3QdzU9+2T5RZ0GOa1LkWmtaoXxeICzLVRHLuyQdMS0jjN5rBOhy94/njzFIFoTStuW+j
         UhyIWDNG5UaGEjW4RZzdMwzNPnI65obm2LYtv+6VifeZGYljZhBeEzuCE8uwDz9Hi+d2
         bG/mh8vPy49lxBFzo4bo4mnd2ZLYeogrdLzw6rddh1N9VDlQWxUOjgIrNc+9zVlL8VZx
         jWUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sH2bFxCKx1Y8BaQTg3VTlV/2EBMMuPOF6dbVWV5OFqo=;
        b=MBRKlMt849dnpTHAqYyFCi8KysskQhMJYfLUad5ew2i/27GAaBBgA2Tpwlju5Fwdey
         4IZv8y9rVLPo8AkeEIqQ3PDd8FQylwEqg/pX1U2qxuMcBtLkyNpP7XwQoRv6Hq2eOJyL
         v8vFI/bMBhrmv9A1Ty9D841yWYHRl6exDsqMkcc7QTQadcf8DdSlUw85R/MsPf8pqL8e
         rZVu8TE7Pzv6ctxJFPi8YohNKCn/9zHfhBRjJ74Iqa36HNLYdXkcVZyqYcmYeGfZIZCl
         FfnUmA9en9TEvR7yBnjN7yP0sC0hd0FqHDFFWwaN/zAaxBzkxOzlQ++KspWDgCmgCwJj
         RxYA==
X-Gm-Message-State: AOAM531Sbh5eptBOvJ9wpJeiGAi1HXebwtq+vwIH+heY5/Q5jkYD8NlX
        7PuYjIX3VxjFYxuTzLvaeLnf
X-Google-Smtp-Source: ABdhPJzNk71bC17lPPMQlIwS45H2Kt1aqTQMKqplD0v8VlsGhks/Sakz2RN9lPCORLSLDErEG733AQ==
X-Received: by 2002:a17:902:d385:b029:da:c6e4:5cab with SMTP id e5-20020a170902d385b02900dac6e45cabmr9118029pld.7.1610029896186;
        Thu, 07 Jan 2021 06:31:36 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.128])
        by smtp.gmail.com with ESMTPSA id 19sm6096465pfu.85.2021.01.07.06.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 06:31:35 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     robh+dt@kernel.org, devicetree@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 1/2] dt-bindings: mmc: sdhci-msm: Document the SDX55 compatible
Date:   Thu,  7 Jan 2021 20:01:17 +0530
Message-Id: <20210107143118.2386-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The SDHCI controller on SDX55 is based on MSM SDHCI v5 IP. Hence,
document the compatible with "qcom,sdhci-msm-v5" as the fallback.
While at it, let's also sort the compatibles in ascending order.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
index 3b602fd6180b..9fa8a24fbc97 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
@@ -17,10 +17,11 @@ Required properties:
 		"qcom,msm8916-sdhci", "qcom,sdhci-msm-v4"
 		"qcom,msm8992-sdhci", "qcom,sdhci-msm-v4"
 		"qcom,msm8996-sdhci", "qcom,sdhci-msm-v4"
-		"qcom,sm8250-sdhci", "qcom,sdhci-msm-v5"
-		"qcom,sdm845-sdhci", "qcom,sdhci-msm-v5"
 		"qcom,qcs404-sdhci", "qcom,sdhci-msm-v5"
 		"qcom,sc7180-sdhci", "qcom,sdhci-msm-v5";
+		"qcom,sdm845-sdhci", "qcom,sdhci-msm-v5"
+		"qcom,sdx55-sdhci", "qcom,sdhci-msm-v5";
+		"qcom,sm8250-sdhci", "qcom,sdhci-msm-v5"
 	NOTE that some old device tree files may be floating around that only
 	have the string "qcom,sdhci-msm-v4" without the SoC compatible string
 	but doing that should be considered a deprecated practice.
-- 
2.25.1

