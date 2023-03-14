Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE41DC6FD1C
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Mar 2023 13:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjCNNFv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Mar 2023 09:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbjCNNFc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Mar 2023 09:05:32 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE804A7AB8
        for <linux-mmc@vger.kernel.org>; Tue, 14 Mar 2023 06:02:00 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id r27so19887235lfe.10
        for <linux-mmc@vger.kernel.org>; Tue, 14 Mar 2023 06:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678798890;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4u3Z3dy+BkRpYnwJeMmsX9DLvnoWFwoNz/SMy/Kse+s=;
        b=R6VpuJWbVVzzE4q64gQTKAVhgNCiCHCAZH1BJZ3Z7ZFkKr7l3BjI0zTx3LTyqexCie
         GuPrUrBRI2hLzt4pw9p/pd0+JCyYhN94aphyQL7m4mSKGd3v2LHYd9+aKGUTTRts1g+L
         Xt/uE9fSBzY6kZuYx9OPv0bxWOchOk9ChG00IT+6aD4VdL4xuxdn+eaW1hz/ihQMhW0k
         6k5BzxVaDqu5iII0g/y6o/JXdWMkuWb4hGpkz5XTFxJ3Zh3vAUizdNQsTZoVLT4WyxYy
         4ucBbi5VUIILirlYzdoUCDwSp2LLqMB9Z2xUpcfUpu23kclohi4+xEqx28JNSkdG+1Mt
         wJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678798890;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4u3Z3dy+BkRpYnwJeMmsX9DLvnoWFwoNz/SMy/Kse+s=;
        b=w4KJe2afE9vSBSf4kIZ4rnlk1NyX0WSMDRIFF5nK/6bHRdE2CQKjjfehVChbGSLV7a
         CXHxwY34eirNlsvE4rLN4LiIgSvYeRjqvUm6DHrqU4gRjp/Ax+7TdbTHLPjAwnr+9Yu6
         txHaxT/81eF9k3UMlkpLzSTArU5KZmVeZ5LtXqfefVc0OVEK9sHSTOJRcY0Z3wSfRcm2
         o1vYeA+XeKwNh9rqbM5nbHHMPXyT7r1mTpQ0MFmVNhOAxIjihMw6Ii1ZcRhVVgFWnjTt
         GLTsnuTBzeoxwhRid+WXEZcL1ERA6HzJk6xwY4yZ8OrhdFl60YcO/XCaD1mvePFSNj7n
         fnsw==
X-Gm-Message-State: AO0yUKV5+PyTXfMlEb+YgfK56vPKuiOGepDMgy6leQTngFPlUg+J92cA
        NlcD+7Ik0BXHdaEeYGW4uzcETCv87cBr6rVIHBY=
X-Google-Smtp-Source: AK7set/RixxVNKujsAXzNyntLdalHXNIeBxQK5g7qnTRfuTqqa5fNYgeB41cA485GhqwyPyUfX88XA==
X-Received: by 2002:a19:f613:0:b0:4dd:af74:fe1a with SMTP id x19-20020a19f613000000b004ddaf74fe1amr821319lfe.48.1678798395683;
        Tue, 14 Mar 2023 05:53:15 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id s9-20020a19ad49000000b004dda74eccafsm395374lfd.68.2023.03.14.05.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 05:53:15 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 14 Mar 2023 13:52:59 +0100
Subject: [PATCH 4/6] dt-bindings: mmc: sdhci-msm: Document QCM2290 SDHCI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230314-topic-2290_compats-v1-4-47e26c3c0365@linaro.org>
References: <20230314-topic-2290_compats-v1-0-47e26c3c0365@linaro.org>
In-Reply-To: <20230314-topic-2290_compats-v1-0-47e26c3c0365@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678798384; l=760;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=N4Xjte+JpBIPh/cB6jQob/nXlB7qFTxxjX08BpaMx4c=;
 b=cHqD/zIBdnuelq4KzPpe+lOLAwsvFvrsDfIS2+ESZPop3zz77xxi1NVoWRRX75v9bCykU+2lLpRf
 it1bWjpxDnXB4TIUAStq4P+tuYLYJi0SmeK0/c6UL3mtMdQbw89A
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Document the SDHCI on QCM2290.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 64df6919abaf..7d4c5ca25e0d 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -36,6 +36,7 @@ properties:
           - enum:
               - qcom,ipq5332-sdhci
               - qcom,ipq9574-sdhci
+              - qcom,qcm2290-sdhci
               - qcom,qcs404-sdhci
               - qcom,sc7180-sdhci
               - qcom,sc7280-sdhci

-- 
2.39.2

