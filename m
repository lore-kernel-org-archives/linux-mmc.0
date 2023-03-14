Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77C2C7618A
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Mar 2023 13:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbjCNNFS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Mar 2023 09:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbjCNNE4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Mar 2023 09:04:56 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2324EA5913
        for <linux-mmc@vger.kernel.org>; Tue, 14 Mar 2023 06:01:12 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id x3so61629501edb.10
        for <linux-mmc@vger.kernel.org>; Tue, 14 Mar 2023 06:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678798871;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FQYNV4JS9J59GL9ARq0SzSc6IYTv8e6Odhxu43xh8dM=;
        b=w0ybSl7s6jLz9clc5J+OSRuU68+LYJxjQLJOZKhGaa2TJN0/mvoIzPk7oZlYp2353K
         KaRkn1J1SLN8Qh/Kbh4CnWrjRScz8DOxEFhwZtHgUhwYXYZpUV6T6dqp2cOipsoiWez7
         ctjpCOHVOrU6lBHW6y0DEuZFbJggK5oSWJWpY8HF3HRQs0pUT0u9DIln0vEwB17xd7re
         W4tD1oTaz10fSjgGPG4YcTehFd8iXdnCHmNLjRzzX6IfhOQ5r/SaoZ4YQkr/WHbro4te
         y8Y+6/j/0IxDopiiJfrEZcxcfbA8MtiEeKTPwUve2i0jvE0yZq2FR34HRWAExmc41epI
         uq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678798871;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FQYNV4JS9J59GL9ARq0SzSc6IYTv8e6Odhxu43xh8dM=;
        b=yVkW/DuTd4ojb4CN/no7nVbY0Xwl7qZ/tXpHFn+sHTsQxyBgUcuwdP4f0vMxAafQ33
         TrMV1xc1DunemQef/nk7P77v6FkKdNr55m8j40FBZfA43ANIfy34KYMGpZLqVK+ldzNr
         1ZYmV7AcrMStWF4BNjPssO2mY5ouHUmM40+hNhqrSC9dmgXXrQSn7l9HsYtBFDozLPtx
         gvy99Q84EAC8YXgw3bSwsbPuJv8LAaR5hWWO6jetRXocHPPD/BFotteWt+fB2isXUtlk
         R8cuDCA1j5Cnr8g4m2d7w6g2hBRH+iTwPlKHl3XHN6BL4m6R42gDnsQE4jQWtzNKyWuU
         dw5Q==
X-Gm-Message-State: AO0yUKUePQst1p4JKJuO69jCQtHrJDQd1kDKjKyrN1W+5z+yWkW+nLRC
        1yDeCYo8vhDor9giVJyOHLWF6mTVuGObWTBCypc=
X-Google-Smtp-Source: AK7set/mIFSkFUi0R/m1jVrscAIJA30bZ0/Za28UAQk9sWPAr9Zdpre4fTc8I9Ct7+OhtZVjkPjGnA==
X-Received: by 2002:a2e:3a16:0:b0:295:b0a5:f66f with SMTP id h22-20020a2e3a16000000b00295b0a5f66fmr10286645lja.28.1678798397989;
        Tue, 14 Mar 2023 05:53:17 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id s9-20020a19ad49000000b004dda74eccafsm395374lfd.68.2023.03.14.05.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 05:53:17 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 14 Mar 2023 13:53:00 +0100
Subject: [PATCH 5/6] dt-bindings: usb: dwc3: Add QCM2290 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230314-topic-2290_compats-v1-5-47e26c3c0365@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678798384; l=984;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=6UMUh/04krKh/2VacWll/qoFcprxFJbKkd3m3SNGTZM=;
 b=/oaiLc0pXANHZhWzQ/BEVQSNywVPnQB31vN4WC+T8+P+ztrzZ8NNt0yoLTJ+2er1hnvbb21gkHWH
 kqGpBpdUDsPK0PfXwn5NMl/sBElXyHKHZwL7EtIQ0THs9nQTJV+Y
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Document the QCM2290 DWC3 controller.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
index 4875c5b7d5b5..a2aabdac4105 100644
--- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
@@ -21,6 +21,7 @@ properties:
           - qcom,msm8994-dwc3
           - qcom,msm8996-dwc3
           - qcom,msm8998-dwc3
+          - qcom,qcm2290-dwc3
           - qcom,qcs404-dwc3
           - qcom,sc7180-dwc3
           - qcom,sc7280-dwc3
@@ -300,6 +301,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,qcm2290-dwc3
               - qcom,sm6115-dwc3
               - qcom,sm6125-dwc3
               - qcom,sm8150-dwc3

-- 
2.39.2

