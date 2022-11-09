Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE48C4167B
	for <linux-mmc@archiver.kernel.org>; Wed,  9 Nov 2022 14:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbiKIO1Q (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 9 Nov 2022 09:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbiKIO04 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Nov 2022 09:26:56 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3F8DED4
        for <linux-mmc@vger.kernel.org>; Wed,  9 Nov 2022 06:26:37 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id k19so26033852lji.2
        for <linux-mmc@vger.kernel.org>; Wed, 09 Nov 2022 06:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1puYbvV3BBw2uUHTBpwVqMdBJxbx12reSCzoMBBxdjY=;
        b=kzu1EyV1aV2pofuK4QdBWzRGgFDw5fmb4qNQ5LyCgF9VeZuC29FD6FufF0WBQjlWko
         FibfHH/v9WPCxRVR/1dmUaqrslwECLe5QWYqmy4XjifcvmEyKHGXHtDKj8TfN/lIVQlz
         i3z3lrs/t6hbHbSzxvYsJC68bchQkOpcTgIBPFj6cyJMHAMZTTbBZoMmLVKdIekRvs0G
         9Vc3DtYaFyD0PKQBkHW/jSMkYepUlXkv0xogTE/zt48AfGseD7sdouvEXDoww5xhu+xM
         Z5DQyVyuz+EkXoMfgLx5G2q6D5B+j55Jerac6cGyJBGAp8+xJtfaJXLun2hzaM6FDeyd
         GAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1puYbvV3BBw2uUHTBpwVqMdBJxbx12reSCzoMBBxdjY=;
        b=Ua1o/JW54fA6/l5LhKinYcXMaDG1assy1z9wRcgS0JxlGaYGb0ndbSJMkRmteJg5yU
         gPCklAcV0lXcTJ3b9GbrZRJEc2u2C177kB8vUmocfUCCPCY8FwiefQM2TDJ/fxgWj1ec
         +QJnUj6G2rws0fPpjQZXnc8K/mXBFNuD1nFZkIiR38o0WH4mydSI1AjL3BMJPWxOo16/
         TOGIo3z6uXPG08yF281+NdtfI8B4dYu4aiTLL0pHfmt3QkGfCtvP8pkx+FlApfOE/p61
         sKVBoD3rkmpbnLlpMRdx6IUH4vLVkCYuw3FByWU2A/SoVIDmR50OVxyTM2JDnulVMPQu
         rHqw==
X-Gm-Message-State: ACrzQf1oowQXyGluWo/L2bH8XnmpuwVTcEI/V9L0gkkYkDZA4LCF0Xt1
        Sh+bKBazk4eRCgP9lzSmMId2/Q==
X-Google-Smtp-Source: AMsMyM7mKATFyBk3GS1QOkEosdXKj4Wo958Ts0D2K7Fwe59WQHhbkkcI4pbdyUgQHitqGntVMhT+xQ==
X-Received: by 2002:a05:651c:98a:b0:26d:fd1f:10 with SMTP id b10-20020a05651c098a00b0026dfd1f0010mr21197490ljq.323.1668003995514;
        Wed, 09 Nov 2022 06:26:35 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id q18-20020a056512211200b004a2ae643b99sm2241008lfr.170.2022.11.09.06.26.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Nov 2022 06:26:35 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: mmc: sdhci-msm: Document the SM6375 compatible
Date:   Wed,  9 Nov 2022 15:26:21 +0100
Message-Id: <20221109142623.53052-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221109142623.53052-1-konrad.dybcio@linaro.org>
References: <20221109142623.53052-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Document the compatible for SDHCI on SM6375.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index fc8a6b345d97..12def0f57e3e 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -46,6 +46,7 @@ properties:
               - qcom,sm6115-sdhci
               - qcom,sm6125-sdhci
               - qcom,sm6350-sdhci
+              - qcom,sm6375-sdhci
               - qcom,sm8150-sdhci
               - qcom,sm8250-sdhci
               - qcom,sm8450-sdhci
-- 
2.38.1

