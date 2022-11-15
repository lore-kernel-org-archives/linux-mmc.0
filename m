Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886B3C4332F
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Nov 2022 17:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbiKOR2n (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 15 Nov 2022 12:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbiKOR2k (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Nov 2022 12:28:40 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6840117AA3
        for <linux-mmc@vger.kernel.org>; Tue, 15 Nov 2022 09:28:38 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id d6so25499208lfs.10
        for <linux-mmc@vger.kernel.org>; Tue, 15 Nov 2022 09:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5Zsxhl1TYkSTxNL/AaKGZ9xhkYvd+wyYJFAyYon0sM=;
        b=BMTj5Dak6W+WJH+TKdUOI2FV0SSmcOlhtNa8pLoMKG7SvhOIUFobG47saheBFT4egX
         abIUbjO5j64XvRfZbNDNZPJ5inwwZYFFrryFf5rC/ExXxi6+SdSuvfONWR3edjZFZSML
         JhS4nbHm0NAGBq71Qy909MdqoaLMuA8m+uql90no3Un+RIZBUPoU/6FL/EFI26sX17fW
         WZklZFyEiqKM69Ra9hE75X5+EHP55jo3WebwSjkVCDUkpixxcW2UBuTq1OCQb02ITFle
         sY5BBizcxCb2OlhHDatRvm/hEDPg3y2ZNS6MIsOJkJcjk/LtYJuqABIWKkfj+rygshhC
         pxdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5Zsxhl1TYkSTxNL/AaKGZ9xhkYvd+wyYJFAyYon0sM=;
        b=CZugF5VM91Tud1/pntym+Pn0y6OxZMmzPFNKcX95Xr2fKxp1gyswXJM+8gDosKzH3K
         YlYYIRzD+kwm6N7DjeDgIh8LpJJ5yvgJHLSEGKYyYAJ0Q9LD07ryN4CYGrZhokZfCejU
         bQEBRmlbCug5STl0aPN+vEEZGFlUt9EX1tOKxOTiKhSBjXEz2AVlsbhe0YAQaMKGWBd2
         y87SRTdHwomVHQEh6qScBiOitKweZAxlhLAi3BA2Cs34a+Ze9T/1eS96FL604ZT+mfHR
         3B3wauYOfs/MvOCXVYCvg6UvgtSjO3c9A9ODA59u4rDESWzK0l8i+uUSDNaXtjzv5kze
         TgpA==
X-Gm-Message-State: ANoB5pk7lf2iuZKHxKSHCUabSopse9bVv7skYDC1ZX+02F7b706i06I1
        6S1RDYCxG5cklJoEzg+V3Y9QkQ==
X-Google-Smtp-Source: AA0mqf4HHR+TSuVMQPzoZGW2Uia1qZKNs1X6DTvzzrqBJa7wf2ZAxEgAOg8M2Hp7Xiecxvd2tj0YDw==
X-Received: by 2002:a05:6512:312c:b0:4a2:1d18:45d8 with SMTP id p12-20020a056512312c00b004a21d1845d8mr5855145lfd.330.1668533316803;
        Tue, 15 Nov 2022 09:28:36 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id b42-20020a0565120baa00b00496d3e6b131sm2261511lfv.234.2022.11.15.09.28.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 15 Nov 2022 09:28:36 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: [PATCH 2/4] arm64: dts: qcom: sm8350: Add SDHCI2
Date:   Tue, 15 Nov 2022 18:28:26 +0100
Message-Id: <20221115172828.14372-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221115172828.14372-1-konrad.dybcio@linaro.org>
References: <20221115172828.14372-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add and configure the SDHCI host responsible for (mostly) SD Card and
its corresponding pins' sleep states.

The setup is *literally* 1:1 with 8450 (bar SDR50/104 may not be
broken).

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 79 ++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 552c0da3c479..9a118112facb 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1761,6 +1761,46 @@ tlmm: pinctrl@f100000 {
 			gpio-ranges = <&tlmm 0 0 204>;
 			wakeup-parent = <&pdc>;
 
+			sdc2_default_state: sdc2-default-state {
+				clk-pins {
+					pins = "sdc2_clk";
+					drive-strength = <16>;
+					bias-disable;
+				};
+
+				cmd-pins {
+					pins = "sdc2_cmd";
+					drive-strength = <16>;
+					bias-pull-up;
+				};
+
+				data-pins {
+					pins = "sdc2_data";
+					drive-strength = <16>;
+					bias-pull-up;
+				};
+			};
+
+			sdc2_sleep_state: sdc2-sleep-state {
+				clk-pins {
+					pins = "sdc2_clk";
+					drive-strength = <2>;
+					bias-disable;
+				};
+
+				cmd-pins {
+					pins = "sdc2_cmd";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+
+				data-pins {
+					pins = "sdc2_data";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+			};
+
 			qup_uart3_default_state: qup-uart3-default-state {
 				rx-pins {
 					pins = "gpio18";
@@ -2329,6 +2369,45 @@ compute-cb@8 {
 			};
 		};
 
+		sdhc_2: sdhci@8804000 {
+			compatible = "qcom,sm8350-sdhci", "qcom,sdhci-msm-v5";
+			reg = <0 0x08804000 0 0x1000>;
+
+			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq", "pwr_irq";
+
+			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
+				 <&gcc GCC_SDCC2_APPS_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "iface", "core", "xo";
+			resets = <&gcc GCC_SDCC2_BCR>;
+			interconnects = <&aggre2_noc MASTER_SDCC_2 0 &mc_virt SLAVE_EBI1 0>,
+					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDCC_2 0>;
+			interconnect-names = "sdhc-ddr","cpu-sdhc";
+			iommus = <&apps_smmu 0x4a0 0x0>;
+			power-domains = <&rpmhpd SM8350_CX>;
+			operating-points-v2 = <&sdhc2_opp_table>;
+			bus-width = <4>;
+			dma-coherent;
+
+			status = "disabled";
+
+			sdhc2_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-100000000 {
+					opp-hz = /bits/ 64 <100000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+				};
+
+				opp-202000000 {
+					opp-hz = /bits/ 64 <202000000>;
+					required-opps = <&rpmhpd_opp_svs_l1>;
+				};
+			};
+		};
+
 		usb_1_hsphy: phy@88e3000 {
 			compatible = "qcom,sm8350-usb-hs-phy",
 				     "qcom,usb-snps-hs-7nm-phy";
-- 
2.38.1

