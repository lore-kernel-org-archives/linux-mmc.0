Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E0EC43334
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jul 2022 09:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237650AbiGNJK4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Jul 2022 05:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237677AbiGNJKw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jul 2022 05:10:52 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8F523BFA
        for <linux-mmc@vger.kernel.org>; Thu, 14 Jul 2022 02:10:50 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bu42so1831867lfb.0
        for <linux-mmc@vger.kernel.org>; Thu, 14 Jul 2022 02:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QeR3DFLgzM8qo6wNayqmpjIsz3WLvihoJpHEg++lMwQ=;
        b=M7BhE574Me+yvLXZ6Xij24gXgaXCtQq3v67mXre6GxQ8vC/RVAcZDmOv/be+cOTi/+
         ksEM6bRwNQaDvDTrSTfrJc7hgZLZJXtLji886bzG70FCKn6hZh7Nw/f6+AH7MHF0laWS
         G2+D+Rsa2xdOJoYQT/o4955QBbLfA1LOG5FMItuoZPmObuLjiYm6a0SYrQTczzTLNvFV
         GoltiqMoBEk3p27P5ZUHAcO3irtOnGVlfZgA3KVvc+9i8K/+27vUnsxtdqCMZz6XBtDm
         zfqUQr/Xfckd0mBvAYjqpWuuI2md7/n76QNciMgvb2BPwuB8Q3tBxRRgAv6aFB/qbCkU
         P9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QeR3DFLgzM8qo6wNayqmpjIsz3WLvihoJpHEg++lMwQ=;
        b=UiMAjwdy5vfTw84ws9U2rdoKx2wM8exPyVkgg7z6rb1GVAuOPo3QroCvlStXJInFvB
         OcDEe5c/9sbmUg9J9IxtDZvUZL+HkWoO/7B3wnWS9tRqwRdkWvFSgM1OqtneEkAmoYQz
         9ufgCWStW7hAPaZytMAQR3N4qu2Stw0Ynd1rffrkpiBje7z0Us8wlfBzDpDAjt8d0UL2
         uUJUzpaVsDnEDveHIvgMaX93P6rXYx7WzMieT3RxYesDQSo3wdaZ3xJ1v4hmdeZwPdUp
         RB+zk/pBtDdP+owlSW3XTKG/NFzOvIhXBXFZ8Ov6zJuqvtVyBV1TG/fuhqwSy0h2MlKm
         CAAw==
X-Gm-Message-State: AJIora88O5joJPSeD0gdHkMTc+BnyVyjuot/n6W7EETcNmvEwS8Ixygw
        Syg6YtwleAZYb3toBExRIycsAA==
X-Google-Smtp-Source: AGRyM1t8330HgtAwWfP+SD3hrM0LmatOLtfN60is05O//2BlvyszFHD5/EgfOJja6qrNjWZ5aU5Pjg==
X-Received: by 2002:a05:6512:2241:b0:479:6426:15af with SMTP id i1-20020a056512224100b00479642615afmr4548835lfu.631.1657789849190;
        Thu, 14 Jul 2022 02:10:49 -0700 (PDT)
Received: from krzk-bin.. (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id d8-20020a056512368800b004790ef191e3sm250006lfs.216.2022.07.14.02.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 02:10:48 -0700 (PDT)
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
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v3 1/3] dt-bindings: mmc: sdhci-msm: add MSM8998
Date:   Thu, 14 Jul 2022 11:10:40 +0200
Message-Id: <20220714091042.22287-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220714091042.22287-1-krzysztof.kozlowski@linaro.org>
References: <20220714091042.22287-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add a MSM8998-specific SDCC compatible, because using only a generic
qcom,sdhci-msm-v4 fallback is deprecated.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>

---

Cc: Konrad Dybcio <konrad.dybcio@somainline.org>
Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc: Doug Anderson <dianders@chromium.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 31a3ce208e1a..0853d0c32dc7 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -30,6 +30,7 @@ properties:
               - qcom,msm8992-sdhci
               - qcom,msm8994-sdhci
               - qcom,msm8996-sdhci
+              - qcom,msm8998-sdhci
           - const: qcom,sdhci-msm-v4 # for sdcc versions less than 5.0
       - items:
           - enum:
-- 
2.34.1

