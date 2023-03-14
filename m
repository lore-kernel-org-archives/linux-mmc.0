Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7329EC7618B
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Mar 2023 13:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjCNNFQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Mar 2023 09:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbjCNNEz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Mar 2023 09:04:55 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36569A591C
        for <linux-mmc@vger.kernel.org>; Tue, 14 Mar 2023 06:01:14 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l7-20020a05600c4f0700b003e79fa98ce1so10083342wmq.2
        for <linux-mmc@vger.kernel.org>; Tue, 14 Mar 2023 06:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678798846;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H57htoQkTUg+UFTR1sq6q65W74NoULtO9Zp7Ye5hgiA=;
        b=AkQ1FaxvlVlPtEGLWVLb/WVCrtFaA8bPHc0eP9GBCfEw4y706R2/zafxWW/JhRKPJ4
         oSFPiH9BiQBccDebHMSkCKL+PeOXPC6rA5g/O3ekLCjik+WrCBXHrNFWi0BN0l7JIh57
         sbobisM4Q2gWuj6f/RF3/HqS0K4rc9QFC8yJ7322jVuL5RipkqOs7MIZTYbpiSv4kpA/
         s2yHegwg56cHmXu5NK7/zXIy54XFmiPg5RgiOEwxmp/8ypflDVO+h8b+wcJON1Y5WIQ0
         UeB4ArFdsAd+STccJ3oEYrPOedmSmNHMUNfd/cliS6xfd1Rcqnb4JPeVUM/1qVQOYxy1
         Rs0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678798846;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H57htoQkTUg+UFTR1sq6q65W74NoULtO9Zp7Ye5hgiA=;
        b=JMxra5jU5bDRuPFFm3Qr2Tr/PDQ0QPIJXN1USKSpMLNhc1uP+y5A6iox2lI2tI531V
         HGckg8vtG15aB1hsFLu0XToCKCmlQV9guusHZcT5V6+Gv5oCSYV2wz5w8ZF7awF9o+47
         +fnQoLvTiq5YDvxnXvKvrUqiSXSB50NQKySS2gCQC+Y+gnd7C3Bbx+BxkFGcLgdvjhN2
         L8a5yrHDNP0H+2fFKBuqbETasHYmyEc8eOSw4vZyZ1kY4dkkbNppvkqXd9CuigPKLCUr
         qx3LTupCbky4PGj2Py1Sw/LywTcOFdPZcYcXaf9hMQdCYonrzJPV4v92ytA/AAGhXzNc
         2niQ==
X-Gm-Message-State: AO0yUKVvf4rBkXwwL4qIKfGQ56gnYp5kkm+r6o/NPqzmn68SK7diOOp/
        XADTEDV2W6+vWZbHbpCerFlp50ZgGFsTDsgloYA=
X-Google-Smtp-Source: AK7set+LGzXnfPO9yxrQ7i+5lJWHJr8ilHoSFFsG62K03rnONrPIjtofPyo8KNV4If/IrFwW1hAinw==
X-Received: by 2002:ac2:53a6:0:b0:4dd:749b:2d5e with SMTP id j6-20020ac253a6000000b004dd749b2d5emr658238lfh.13.1678798389023;
        Tue, 14 Mar 2023 05:53:09 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id s9-20020a19ad49000000b004dda74eccafsm395374lfd.68.2023.03.14.05.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 05:53:08 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 14 Mar 2023 13:52:56 +0100
Subject: [PATCH 1/6] dt-bindings: watchdog: qcom-wdt: add QCM2290
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230314-topic-2290_compats-v1-1-47e26c3c0365@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678798384; l=804;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=5U3ca5wHa6L9Uqd71BtW3lQI84JxQ8icLuw8PMs5taA=;
 b=NtWhoOCxoiWQoOdiz2KumOaoFLzyepdvtefGrM6rQG0T+1vcJphHx4O58b5FRFhG29N0R0ZWIcA/
 csWPf2qLAUZbDFmWgOGLjLq3J5a5lAJMwSgks6lRLLJeqrPATjUS
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Document the QCM2290 KPSS watchdog.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
index 6448b633c970..db3e260fb2ef 100644
--- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
@@ -19,6 +19,7 @@ properties:
           - enum:
               - qcom,kpss-wdt-ipq4019
               - qcom,apss-wdt-msm8994
+              - qcom,apss-wdt-qcm2290
               - qcom,apss-wdt-qcs404
               - qcom,apss-wdt-sa8775p
               - qcom,apss-wdt-sc7180

-- 
2.39.2

