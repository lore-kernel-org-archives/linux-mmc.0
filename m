Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A08C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Jul 2022 14:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbiGLOnZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Jul 2022 10:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbiGLOnJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jul 2022 10:43:09 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86639BBD1D
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jul 2022 07:43:06 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id m16so10119045ljh.10
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jul 2022 07:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V/FtuLFdmIRxnbje2Eo2i81s8OyO/mSxb1mfLprbMvE=;
        b=B4R2gfOUjxKZzgOzs5OEQJY5a6oap3oGVrgwv2jNF1pgkaR4RRhfcBF8yxGvTRaXQs
         wKdsCzkjcFaVe7qj3fU/4RVGC3s9Tq/jfHeblcns/P0ObXL7xFNKEMIESrgJBZP+0Q5y
         IBiuTKUMiiorGj2NeiAIcifWxffy8m8cEbYZUlxXqFO6Vw8QYF35Er0UewZAtIEqrDby
         8JJtcvHytaTKabbLyCJcKf/ofmUewrrpsKBDn7+5mqnfowWT3UjOMEN6OoYXkSVdPxvA
         oXnrk1YmGJ13q4l0wHmJSpmNNmVg8jfXVwqPEcJMB+drFd1dhzxfAm+taPmsM11lbMME
         ACMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V/FtuLFdmIRxnbje2Eo2i81s8OyO/mSxb1mfLprbMvE=;
        b=GWlfZMukzhtFp2OrChEkRcL7AESULokKMnj26mvmqFHHD2avIkd925fQ05YRK3VaMd
         6vphSiyHd17nsN29WrGaLEp9vVEM1DNyxpN7q9ZV7xJY17nvCIE7iyybClj/0XwKsqmt
         xydxg60FFSE4iB0rhsf/YEMJZdF5DScq085vJ7OocB42XtLpLXPMo/US44GZJerx1jPk
         Yi4oLHIljqPJYVnlp5CejMuqJRHdAv5lo1pa05hVWOM8ZAyMohAQAmyB16DUBPJnaZN1
         HqGEaCEgCS/MP90zPm7Iokxt83KBI0S6eN+91NG78M9RzDA1dP9oeqJSPj2ne/AS6lfp
         5gMQ==
X-Gm-Message-State: AJIora9X+37yk2O9ZtX4XgUGyB5ZTCKs6IgCfljPXWa5QGaWK7G4qFYT
        QYb750NpDChRbkovGvvDZ5Q1Xg==
X-Google-Smtp-Source: AGRyM1t85QNC2/Uho8vzpBeWMcfT9bur+Ub8F+cx3bQHPKmCkGTsPMVb2iqQicCs+izWakkvP25ejg==
X-Received: by 2002:a05:651c:1581:b0:255:48d1:fdae with SMTP id h1-20020a05651c158100b0025548d1fdaemr13235383ljq.286.1657636984517;
        Tue, 12 Jul 2022 07:43:04 -0700 (PDT)
Received: from krzk-bin.. (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id w15-20020a05651234cf00b00489e88d6a72sm737577lfr.198.2022.07.12.07.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 07:43:04 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v3 4/5] ARM: dts: qcom: align SDHCI reg-names with DT schema
Date:   Tue, 12 Jul 2022 16:42:44 +0200
Message-Id: <20220712144245.17417-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220712144245.17417-1-krzysztof.kozlowski@linaro.org>
References: <20220712144245.17417-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

DT schema requires SDHCI reg names to be hc/core without "_mem" suffix,
just like TXT bindings were expecting before the conversion.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm/boot/dts/qcom-apq8084.dtsi | 4 ++--
 arch/arm/boot/dts/qcom-ipq4019.dtsi | 1 +
 arch/arm/boot/dts/qcom-msm8226.dtsi | 6 +++---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 6 +++---
 arch/arm/boot/dts/qcom-sdx65.dtsi   | 2 +-
 5 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
index 3e8bded2b5c8..45f3cbcf6238 100644
--- a/arch/arm/boot/dts/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
@@ -422,7 +422,7 @@ blsp2_uart2: serial@f995e000 {
 		mmc@f9824900 {
 			compatible = "qcom,apq8084-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0xf9824900 0x11c>, <0xf9824000 0x800>;
-			reg-names = "hc_mem", "core_mem";
+			reg-names = "hc", "core";
 			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hc_irq", "pwr_irq";
 			clocks = <&gcc GCC_SDCC1_APPS_CLK>,
@@ -435,7 +435,7 @@ mmc@f9824900 {
 		mmc@f98a4900 {
 			compatible = "qcom,apq8084-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0xf98a4900 0x11c>, <0xf98a4000 0x800>;
-			reg-names = "hc_mem", "core_mem";
+			reg-names = "hc", "core";
 			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hc_irq", "pwr_irq";
 			clocks = <&gcc GCC_SDCC2_APPS_CLK>,
diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index a2632349cec4..1b98764bab7a 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -224,6 +224,7 @@ vqmmc: regulator@1948000 {
 		sdhci: mmc@7824900 {
 			compatible = "qcom,sdhci-msm-v4";
 			reg = <0x7824900 0x11c>, <0x7824000 0x800>;
+			reg-names = "hc", "core";
 			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hc_irq", "pwr_irq";
 			bus-width = <8>;
diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom-msm8226.dtsi
index 0b5effdb269a..f711463d22dc 100644
--- a/arch/arm/boot/dts/qcom-msm8226.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
@@ -137,7 +137,7 @@ apcs: syscon@f9011000 {
 		sdhc_1: mmc@f9824900 {
 			compatible = "qcom,msm8226-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0xf9824900 0x11c>, <0xf9824000 0x800>;
-			reg-names = "hc_mem", "core_mem";
+			reg-names = "hc", "core";
 			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hc_irq", "pwr_irq";
@@ -153,7 +153,7 @@ sdhc_1: mmc@f9824900 {
 		sdhc_2: mmc@f98a4900 {
 			compatible = "qcom,msm8226-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0xf98a4900 0x11c>, <0xf98a4000 0x800>;
-			reg-names = "hc_mem", "core_mem";
+			reg-names = "hc", "core";
 			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hc_irq", "pwr_irq";
@@ -169,7 +169,7 @@ sdhc_2: mmc@f98a4900 {
 		sdhc_3: mmc@f9864900 {
 			compatible = "qcom,msm8226-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0xf9864900 0x11c>, <0xf9864000 0x800>;
-			reg-names = "hc_mem", "core_mem";
+			reg-names = "hc", "core";
 			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hc_irq", "pwr_irq";
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 11b4206036e6..971eceaef3d1 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -439,7 +439,7 @@ acc3: clock-controller@f90b8000 {
 		sdhc_1: mmc@f9824900 {
 			compatible = "qcom,msm8974-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0xf9824900 0x11c>, <0xf9824000 0x800>;
-			reg-names = "hc_mem", "core_mem";
+			reg-names = "hc", "core";
 			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hc_irq", "pwr_irq";
@@ -456,7 +456,7 @@ sdhc_1: mmc@f9824900 {
 		sdhc_3: mmc@f9864900 {
 			compatible = "qcom,msm8974-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0xf9864900 0x11c>, <0xf9864000 0x800>;
-			reg-names = "hc_mem", "core_mem";
+			reg-names = "hc", "core";
 			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hc_irq", "pwr_irq";
@@ -475,7 +475,7 @@ sdhc_3: mmc@f9864900 {
 		sdhc_2: mmc@f98a4900 {
 			compatible = "qcom,msm8974-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0xf98a4900 0x11c>, <0xf98a4000 0x800>;
-			reg-names = "hc_mem", "core_mem";
+			reg-names = "hc", "core";
 			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hc_irq", "pwr_irq";
diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
index 7a193678b4f5..4f3389cb6300 100644
--- a/arch/arm/boot/dts/qcom-sdx65.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
@@ -334,7 +334,7 @@ glink-edge {
 		sdhc_1: mmc@8804000 {
 			compatible = "qcom,sdx65-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0x08804000 0x1000>;
-			reg-names = "hc_mem";
+			reg-names = "hc";
 			interrupts = <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hc_irq", "pwr_irq";
-- 
2.34.1

