Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770A02253FD
	for <linux-mmc@vger.kernel.org>; Thu, 12 Dec 2024 16:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734022257; cv=none; b=N1QuD1GNM4mr7fr59myM3/q+GLxqdJ5I2b/iUUagWNAOUg5/MJVJhwJK77Lz89/BfpwfC1HSjb1xIX4NhGqD2XtSfwFsRd2j3VLxaPf2yI2tyhbaZB2KUVMiSuO/OKfD++SAorIpamnPAhD1XqnoaPRowg/e2bxvDvmDUgxUwWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734022257; c=relaxed/simple;
	bh=sIhmfEp6EiWv8csO0CuaF4kwgOWRRyIe0k01jMlrCDc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LVaAbcBY5GsHS3+wWC9t+pw1ta+pqp//kDFX0upB6pXNkCLkSO2H3p9Mowjlvz7/sGVWCIkulrx9NmHYc47JflXhNq4VzlDjBmDD0VGTz0kImRVFit+0qdxWZZTax1Awcio4SR5ukcGHxw3YlFb/Bh2iY+loGALctFDGPVWOeqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bi+N0Ctv; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bi+N0Ctv"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38634c35129so628399f8f.3
        for <linux-mmc@vger.kernel.org>; Thu, 12 Dec 2024 08:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734022252; x=1734627052; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M9lSbMOTfhbYFTwB5k4YX11cdSZ30itLnwZ6t9D1jNk=;
        b=bi+N0Ctvvpa3JxwQ1FwPV7xFay21pCwHgjV1kuRJdbOunZyOttd7vLexmnoKKzdK8L
         tfxvsno/XaRHtnFkrangWdHnq9G4CBekOgLWhiBsJTuk9tFe347px5ZnYoJ8HTf33jIe
         pZug1cIRoOnfojAxR3GbaWlICNhbqeHp0tl3T5aUNbIE4hTZ5rXYCpNm1cZ3oYvu2ZCw
         eXLn8nOtlGOyvKAZe8JlcoZCOVNYHZ7XTPApScnvY2rVbZnvjcBTW2gw+7ijzoARtMN6
         uZFm3UgwEoGP1UuoorbynWaiadS3fqY2cgWvEwc13eDeNnWnZWAeENZyy8R4nVGtBYfR
         +LgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734022252; x=1734627052;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M9lSbMOTfhbYFTwB5k4YX11cdSZ30itLnwZ6t9D1jNk=;
        b=YxFyiLPF23T8X4BHWrex/Hbz4Qw1LTeGUFp47c6IiyIxk3nTScBQ8kbsQJmHiLPfCZ
         K96ByFIV7B63l1tyDYGSQIFScDMTRpc2C7mS2HA245TiDcDpnqxW5Rz3ycN7PCfCTHXR
         T4fS/WGPjx58PaadN8ihQz16BlU+uM/nPwuMCBe0QFYIb3Sb3aWRe72+X5l1hNOVeQ2o
         tb1iTWeKKSmQrr6Fh7VAi5BIlAbU9IkThtOI6x4h/I2bL2MPI9WlQFQ2j+oFty7dKPAz
         N2ewruQfPe6ZAzGdCanQJVHfG/IjUDvXjQPAbCge+dk67TdWHk2mDsb0yTSfHdv5s/jg
         JgmA==
X-Forwarded-Encrypted: i=1; AJvYcCWB7061M4jEVRMcJghWs30ejNc//MMCDK7kwmL/gB/dgZFEAlD+P0XTmEHSRFENiZRMdRAYNZMeXO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTcebdWzyBAt0K+JtfdAn6h242waFtKwBSk40MXxnofjJ6X6RT
	vwlG1/CLE23QEQoJGyGSGWqfYOumSd8/ysMJOj23c5wJFwZSLRb6DoFasLMcrQE=
X-Gm-Gg: ASbGncs52SZVaqFpjVMM9NO+OElmNfR4YTXY3Yjp+NEJSMUt5jZ0NE0L3UqzR8lEetL
	rWaQjap+BmVNWP+LLepUo2RZt9Zd+IPNxrWh4toYV3j4+zOG7T71Hudjdc8mJQxHyRtOWz/j3/g
	XI9bIDHm4/EBwW++QTKvJ9wHApgl6+4UqXKFt37Ycmu+x/jl2ly+ZO8tDydsmlZsm44GlELdKwl
	F5U7qZH0m65SXXSFpW8HYEUd0zH+IXSZdvuj8LUueuPz7z2CaPKxaaP
X-Google-Smtp-Source: AGHT+IEyTYKfRpE6aMH53NZRDVK//qBKCrcKyafSIj5G8xqq4Q6eSjBsg526CQ95QPHfVy48MeQtZA==
X-Received: by 2002:a05:6000:2802:b0:385:df6d:6fc7 with SMTP id ffacd0b85a97d-3864ce9f30amr4202233f8f.25.1734022251727;
        Thu, 12 Dec 2024 08:50:51 -0800 (PST)
Received: from [127.0.1.1] ([82.76.168.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387824a4a25sm4518264f8f.27.2024.12.12.08.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 08:50:51 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Thu, 12 Dec 2024 18:50:39 +0200
Subject: [PATCH v4 1/2] arm64: dts: qcom: x1e80100: Describe the SDHC
 controllers
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-x1e80100-qcp-sdhc-v4-1-a74c48ee68a3@linaro.org>
References: <20241212-x1e80100-qcp-sdhc-v4-0-a74c48ee68a3@linaro.org>
In-Reply-To: <20241212-x1e80100-qcp-sdhc-v4-0-a74c48ee68a3@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4749; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=sIhmfEp6EiWv8csO0CuaF4kwgOWRRyIe0k01jMlrCDc=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBnWxRmQ6u1rxFVhZtdOrF+LjRiF8NBF3DTNfeOX
 HH6tRECqyuJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZ1sUZgAKCRAbX0TJAJUV
 VjbFD/9UJ2SdMeBUGcbC3/7E5MkmE8dCQcpFkS4MavlMx/iS2StReAuYNwlnXBM770m6DPDCydH
 jxuFr0iWVnjpvRz5EtvXpHTdhR4UUY5x6lNmXjpw5/+vsgMuQhjOQPFK4lF2J41xC1vcM8zI4BN
 +y3YSj0pJuheV8rVHVc80aYYLvELZd7VdSeZLprlSfDetOSVMU5dfPTOQPaaqG99VQlFk0anW7L
 POsMV0nTxNfUbI6kbfQGvY4hui1IToIiKBxNEIqcXclG8jVud5KRyafwlpSCWPwL63DLPTMMxpb
 v6BGDyfTp9ZciLn2wKr+Y1cHM+KGxF0ehVaOPP644XulIQmFsNjltL32MJazMSVZuD3Bxi6V2n0
 ISxa//MGbv/IEAghXp2qgPzT0aC68H5NjMHhSbDBMfRsPK2GhB+urAvuMzi5ARmtLQCSTpoPdHA
 7CosmoeUrfzkfV63kL9PMEy3ynbCA3tdg0kaecamvL3T0NLyFVRoTOdSI/htmdkvLIGJjhP7Wtx
 3hi81wK9KEzi53rYaY98drW8RIm22tOjHuB24V207OVjXw/qEp2iJDE8w7LbtOn56OcAHqbsadT
 PjFTk/MQKt24pFIh5HkD1CmNeTIHm7kL71zxOdUN7KeRO79ZVvvbEMq6WvJ6u+Id3oALk75FfA+
 GbbTO136/Mj1oxA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The X Elite platform features two SDHC v5 controllers.

Describe the controllers along with the pin configuration in TLMM
for the SDC2, since they are hardwired and cannot be muxed to any
other function. The SDC4 pin configuration can be muxed to different
functions, so leave those to board specific dts.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 142 +++++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index c18b99765c25c901b3d0a3fbaddc320c0a8c1716..1584df66ea915230995f0cf662cde813f4ae02a1 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -4094,6 +4094,108 @@ lpass_lpicx_noc: interconnect@7430000 {
 			#interconnect-cells = <2>;
 		};
 
+		sdhc_2: mmc@8804000 {
+			compatible = "qcom,x1e80100-sdhci", "qcom,sdhci-msm-v5";
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
+			iommus = <&apps_smmu 0x520 0>;
+			qcom,dll-config = <0x0007642c>;
+			qcom,ddr-config = <0x80040868>;
+			power-domains = <&rpmhpd RPMHPD_CX>;
+			operating-points-v2 = <&sdhc2_opp_table>;
+
+			interconnects = <&aggre2_noc MASTER_SDCC_2 0 &mc_virt SLAVE_EBI1 0>,
+					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDCC_2 0>;
+			interconnect-names = "sdhc-ddr", "cpu-sdhc";
+			bus-width = <4>;
+			dma-coherent;
+
+			status = "disabled";
+
+			sdhc2_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-19200000 {
+					opp-hz = /bits/ 64 <19200000>;
+					required-opps = <&rpmhpd_opp_min_svs>;
+				};
+
+				opp-50000000 {
+					opp-hz = /bits/ 64 <50000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+				};
+
+				opp-100000000 {
+					opp-hz = /bits/ 64 <100000000>;
+					required-opps = <&rpmhpd_opp_svs>;
+				};
+
+				opp-202000000 {
+					opp-hz = /bits/ 64 <202000000>;
+					required-opps = <&rpmhpd_opp_svs_l1>;
+				};
+			};
+		};
+
+		sdhc_4: mmc@8844000 {
+			compatible = "qcom,x1e80100-sdhci", "qcom,sdhci-msm-v5";
+			reg = <0 0x08844000 0 0x1000>;
+
+			interrupts = <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq", "pwr_irq";
+
+			clocks = <&gcc GCC_SDCC4_AHB_CLK>,
+				 <&gcc GCC_SDCC4_APPS_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "iface", "core", "xo";
+			iommus = <&apps_smmu 0x160 0>;
+			qcom,dll-config = <0x0007642c>;
+			qcom,ddr-config = <0x80040868>;
+			power-domains = <&rpmhpd RPMHPD_CX>;
+			operating-points-v2 = <&sdhc4_opp_table>;
+
+			interconnects = <&aggre2_noc MASTER_SDCC_4 0 &mc_virt SLAVE_EBI1 0>,
+					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDCC_4 0>;
+			interconnect-names = "sdhc-ddr", "cpu-sdhc";
+			bus-width = <4>;
+			dma-coherent;
+
+			status = "disabled";
+
+			sdhc4_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-19200000 {
+					opp-hz = /bits/ 64 <19200000>;
+					required-opps = <&rpmhpd_opp_min_svs>;
+				};
+
+				opp-50000000 {
+					opp-hz = /bits/ 64 <50000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+				};
+
+				opp-100000000 {
+					opp-hz = /bits/ 64 <100000000>;
+					required-opps = <&rpmhpd_opp_svs>;
+				};
+
+				opp-202000000 {
+					opp-hz = /bits/ 64 <202000000>;
+					required-opps = <&rpmhpd_opp_svs_l1>;
+				};
+			};
+		};
+
 		usb_2_hsphy: phy@88e0000 {
 			compatible = "qcom,x1e80100-snps-eusb2-phy",
 				     "qcom,sm8550-snps-eusb2-phy";
@@ -5852,6 +5954,46 @@ rx-pins {
 					bias-disable;
 				};
 			};
+
+			sdc2_default: sdc2-default-state {
+				clk-pins {
+					pins = "sdc2_clk";
+					drive-strength = <16>;
+					bias-disable;
+				};
+
+				cmd-pins {
+					pins = "sdc2_cmd";
+					drive-strength = <10>;
+					bias-pull-up;
+				};
+
+				data-pins {
+					pins = "sdc2_data";
+					drive-strength = <10>;
+					bias-pull-up;
+				};
+			};
+
+			sdc2_sleep: sdc2-sleep-state {
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
 		};
 
 		apps_smmu: iommu@15000000 {

-- 
2.34.1

