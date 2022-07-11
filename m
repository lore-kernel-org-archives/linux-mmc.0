Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729E7C433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 11 Jul 2022 08:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiGKIaM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 11 Jul 2022 04:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiGKIaF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Jul 2022 04:30:05 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182F71EEC7
        for <linux-mmc@vger.kernel.org>; Mon, 11 Jul 2022 01:29:55 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id a9so7464898lfk.11
        for <linux-mmc@vger.kernel.org>; Mon, 11 Jul 2022 01:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2gVW47IgmRx1vKZS2dex1FR+qcYbiSpveO6smMK6miE=;
        b=dmLmpu7odEiBNxCs/eu1tV0kV1400WpTN73alyX9IVIpe/umqwXuNUa8pyeaC0Eb4L
         dKPfNMwG43WSUEc5xMMLbVTopEJ8Bz1FS3OWu5vpUL76lucr/DN5BfZ/Jo1d5XCTBcTc
         sziQYL8JqSY7OS0/qvELTeMCqQGPmmViCRkDLtwjiKKYWlk8WdFiPJzjtaukaeJy5Wc1
         gOk0Onjlt3AQb5nl4Vci3JOxmhkcAgw7FrAGszH0ofJF+bWiVCZsQg4wJpA/FT8Xd6Dh
         BMxql0GRLAhr5Uhh2aBLhx4gNQ9+XLXig6kWZ+ElRIN1b7qQc06Lc2FSbNePKrZs7mJe
         WlmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2gVW47IgmRx1vKZS2dex1FR+qcYbiSpveO6smMK6miE=;
        b=MTS45uJ1D/1p2AvMY+TzHDjvVuE8PNQjhZSIWLAqnBItIPLg1isMSN54F4pnapmLLa
         Z4T/VvcfYWFWtAAN9fv1YpaIxs1hHJH3sSHAQTPK5/L0vhPNtwxyOwj7a5/MrxXNJxY6
         CwB9yDJtJEyr6vCu+oXHZDJejRa4I4S0/0Q4J6MGsKsIeF+iz0asTfHdtKolBzACMMJN
         djw7J586KV2BkIYx37Cz/S3yIX5KHNPg2a1sUBmMQ9SgL7efznEUre0tAHxcdcxP+n2b
         gNGZBZ4lL7Ijr1GmYpKbunk7w/EeGxbthHrA70UPxmxoGpACuLuXhqwBYAR27uWvG8W5
         SjJQ==
X-Gm-Message-State: AJIora8zD8YELrTPcP4GdYR9QcgtrHVqpM2XyfJlbmAAm7neuwUrJdbe
        i80JZlKnPfR7t/uyD/o/BRbVJA==
X-Google-Smtp-Source: AGRyM1ta6IBf43di382hxKPOQozp33nV8V5Y1+5U/Kvadh+V2iDRAxsP/Alc58GcbZNsQnbpmVl4Ow==
X-Received: by 2002:a05:6512:e88:b0:489:d187:9b3c with SMTP id bi8-20020a0565120e8800b00489d1879b3cmr5147465lfb.669.1657528193463;
        Mon, 11 Jul 2022 01:29:53 -0700 (PDT)
Received: from krzk-bin.. (fwa5cab-55.bb.online.no. [88.92.171.55])
        by smtp.gmail.com with ESMTPSA id u2-20020a05651206c200b00488ab8914b5sm1401504lff.213.2022.07.11.01.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 01:29:52 -0700 (PDT)
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
Cc:     Douglas Anderson <dianders@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 3/5] arm64: dts: qcom: align SDHCI reg-names with DT schema
Date:   Mon, 11 Jul 2022 10:29:38 +0200
Message-Id: <20220711082940.39539-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220711082940.39539-1-krzysztof.kozlowski@linaro.org>
References: <20220711082940.39539-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

DT schema requires SDHCI reg names to be hc/core without "_mem" suffix,
just like TXT bindings were expecting before the conversion.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 4 ++--
 arch/arm64/boot/dts/qcom/msm8953.dtsi | 4 ++--
 arch/arm64/boot/dts/qcom/msm8994.dtsi | 4 ++--
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 4 ++--
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 +-
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index a6cb0dafcc17..2b9374f61d5b 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -379,7 +379,7 @@ spmi_bus: spmi@200f000 {
 		sdhc_1: mmc@7824900 {
 			compatible = "qcom,sdhci-msm-v4";
 			reg = <0x7824900 0x500>, <0x7824000 0x800>;
-			reg-names = "hc_mem", "core_mem";
+			reg-names = "hc", "core";
 
 			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 48bc2e09128d..0bdf4d39f778 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1469,7 +1469,7 @@ lpass_codec: audio-codec@771c000 {
 		sdhc_1: mmc@7824000 {
 			compatible = "qcom,msm8916-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0x07824900 0x11c>, <0x07824000 0x800>;
-			reg-names = "hc_mem", "core_mem";
+			reg-names = "hc", "core";
 
 			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
@@ -1487,7 +1487,7 @@ sdhc_1: mmc@7824000 {
 		sdhc_2: mmc@7864000 {
 			compatible = "qcom,msm8916-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0x07864900 0x11c>, <0x07864000 0x800>;
-			reg-names = "hc_mem", "core_mem";
+			reg-names = "hc", "core";
 
 			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
index 1bc0ef476cdb..97dde1a429d9 100644
--- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
@@ -799,7 +799,7 @@ sdhc_1: mmc@7824900 {
 			compatible = "qcom,msm8953-sdhci", "qcom,sdhci-msm-v4";
 
 			reg = <0x7824900 0x500>, <0x7824000 0x800>;
-			reg-names = "hc_mem", "core_mem";
+			reg-names = "hc", "core";
 
 			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
@@ -859,7 +859,7 @@ sdhc_2: mmc@7864900 {
 			compatible = "qcom,msm8953-sdhci", "qcom,sdhci-msm-v4";
 
 			reg = <0x7864900 0x500>, <0x7864000 0x800>;
-			reg-names = "hc_mem", "core_mem";
+			reg-names = "hc", "core";
 
 			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/qcom/msm8994.dtsi b/arch/arm64/boot/dts/qcom/msm8994.dtsi
index 8bc6c070e306..35c1ca080684 100644
--- a/arch/arm64/boot/dts/qcom/msm8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994.dtsi
@@ -464,7 +464,7 @@ usb@f9200000 {
 		sdhc1: mmc@f9824900 {
 			compatible = "qcom,msm8994-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0xf9824900 0x1a0>, <0xf9824000 0x800>;
-			reg-names = "hc_mem", "core_mem";
+			reg-names = "hc", "core";
 
 			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
@@ -487,7 +487,7 @@ sdhc1: mmc@f9824900 {
 		sdhc2: mmc@f98a4900 {
 			compatible = "qcom,msm8994-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0xf98a4900 0x11c>, <0xf98a4000 0x800>;
-			reg-names = "hc_mem", "core_mem";
+			reg-names = "hc", "core";
 
 			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
 				<GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 25d6b26fab60..9745df5dc007 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -2896,7 +2896,7 @@ hsusb_phy2: phy@7412000 {
 		sdhc1: mmc@7464900 {
 			compatible = "qcom,msm8996-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0x07464900 0x11c>, <0x07464000 0x800>;
-			reg-names = "hc_mem", "core_mem";
+			reg-names = "hc", "core";
 
 			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
@@ -2920,7 +2920,7 @@ sdhc1: mmc@7464900 {
 		sdhc2: mmc@74a4900 {
 			compatible = "qcom,msm8996-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0x074a4900 0x314>, <0x074a4000 0x800>;
-			reg-names = "hc_mem", "core_mem";
+			reg-names = "hc", "core";
 
 			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
 				      <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index e263a59d84b0..c98f36f95f3c 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -2078,7 +2078,7 @@ qusb2phy: phy@c012000 {
 		sdhc2: mmc@c0a4900 {
 			compatible = "qcom,msm8998-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0x0c0a4900 0x314>, <0x0c0a4000 0x800>;
-			reg-names = "hc_mem", "core_mem";
+			reg-names = "hc", "core";
 
 			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.34.1

