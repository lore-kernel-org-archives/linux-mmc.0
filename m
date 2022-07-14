Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C12C43334
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jul 2022 09:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237718AbiGNJLD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Jul 2022 05:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237659AbiGNJK4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jul 2022 05:10:56 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E39237FA
        for <linux-mmc@vger.kernel.org>; Thu, 14 Jul 2022 02:10:54 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id y11so1759430lfs.6
        for <linux-mmc@vger.kernel.org>; Thu, 14 Jul 2022 02:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2x572kTW28ZwxF7SkDqo2Pgfax0p5nEhs9ONN4/XetI=;
        b=CLH1FzwjyJ4pmTHbuWqH5403hryL88/aa4JMFAOal47Ch7yeojUBszf8t6oR1ZIHMX
         1w9qrTNDP91qC2lkLz8qdiuhF9q2sZ547S7uo0QEX4+Cepop/Rtl6r+jNtRMQWzc061R
         /eYH6LWobnSVyYuoAORZ8seCFEyto0X8E8ytDKG9bAnkipMM4ecYHCbrQbbzUEXyveXD
         +8UZuGXQ3sXGYXwKTaGzzuHqIqk+a7F1tKJTmUZRDdKDy3TN258rYqukGk34qsDyrYei
         0cVq3lfGEiY55NfAhk3lArBeWde0WfJwAd7KomizIe/jzmqV8k0dBOVIqiA2QoW0IW+1
         gaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2x572kTW28ZwxF7SkDqo2Pgfax0p5nEhs9ONN4/XetI=;
        b=pcvBrgQYyVq6XM72NisMCopNFB5kHAbVduEwrghwx6WASIJCjDNR94ET/DTHtShThL
         4qGD0UVcEeEnIvQd64dnn8Xk8SKgDSuvKRSiA39mpszk55lWwf15dP2a6uuHokoduVab
         VYRHIRS0yc29smT1s/Nxu/VTdpp9EvLtoghs0luCzkd73POEKr738mLxzpTLjOdLBvox
         WFUDT24hyWfb45fgSLxu0s6dQG7EMdFoSktO0Hwis8C1YEoU/lWXzzYG0+c+gKXleTzI
         Tc4vkxAbVPM2IDdn4otw4vE/sPIY6yhhmNCZE7JC4Y+K8Kblxmhn5yjc7hgHICnjDjjw
         nmmg==
X-Gm-Message-State: AJIora/AHmI5H/SaWGqltQaskB7cPPgs6pYX8uomfAZj2i9eIdcjqlS5
        Hly75b+dMNkSaj8BFhrPYNM4YdoJeJGhKw==
X-Google-Smtp-Source: AGRyM1s+3qiNZ15HG5d2PH4s1iZLuiE2VWhiHT8fecPh3CdN6vbvO+FbbSsDbvSrpwI4NK0f1aRNUA==
X-Received: by 2002:a05:6512:ad3:b0:489:ec0d:761e with SMTP id n19-20020a0565120ad300b00489ec0d761emr4841296lfu.2.1657789852970;
        Thu, 14 Jul 2022 02:10:52 -0700 (PDT)
Received: from krzk-bin.. (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id d8-20020a056512368800b004790ef191e3sm250006lfs.216.2022.07.14.02.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 02:10:52 -0700 (PDT)
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
Subject: [PATCH v3 2/3] arm64: dts: qcom: msm8998: add MSM8998 SDCC specific compatible
Date:   Thu, 14 Jul 2022 11:10:41 +0200
Message-Id: <20220714091042.22287-3-krzysztof.kozlowski@linaro.org>
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
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>

---

Cc: Konrad Dybcio <konrad.dybcio@somainline.org>
Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc: Doug Anderson <dianders@chromium.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 85bbd4f7306d..e263a59d84b0 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -2076,7 +2076,7 @@ qusb2phy: phy@c012000 {
 		};
 
 		sdhc2: mmc@c0a4900 {
-			compatible = "qcom,sdhci-msm-v4";
+			compatible = "qcom,msm8998-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0x0c0a4900 0x314>, <0x0c0a4000 0x800>;
 			reg-names = "hc_mem", "core_mem";
 
-- 
2.34.1

