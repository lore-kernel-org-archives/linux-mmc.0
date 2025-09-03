Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D73A2FCBEB
	for <linux-mmc@vger.kernel.org>; Wed,  3 Sep 2025 11:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900069; cv=none; b=ctXGYeUAOlazgRB6U6D3RHzwm0NQzyf4ykatoE0yq077lnEJxyXayfyubBk9npr50B6N12bDum1h9mTHz5BIsb1wRWE0+/Vk64NvN+uZEu7I8fU6PJdaohWY1rWex/VBnG4XE6sbX34aMXyJx3/6NvDHykpsZePYQLFZCnLx5K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900069; c=relaxed/simple;
	bh=ysbyanGTOQDdoDKZfJO9JNRcUI5DPnSHLHid2+/WQqs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uAwUVy4UYeoHEp77C/77LYQFuE0fE94CGOUZBUAIPfZF8OWhNedpLR4p3q8D/amq0Uwq2J7em/u1vt6kYFqCU14nq5daH6up56DRyu443xkcvkytQD8O1aT0NVv7SdcjXkwUOnxRn5j4VATHcsM/FGk3ZHCl8cBNnLQLMjyhF2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ux+wfHK1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ux+wfHK1"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BFIK3011335
	for <linux-mmc@vger.kernel.org>; Wed, 3 Sep 2025 11:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xhPpuYTt60KwuxaKo5to6sQuHTwQVddj1aOmX6ZkoGM=; b=Ux+wfHK1cBoB0Hvk
	rvAIe88ITSgQ8Ttq360ZDVtd/GKWMsEJi4mP/3PoEqHp2JzC8LXsKHpgR4b9B0+Z
	Rp/+9bzgcciDH32xHnN8UQKqQHlMxJ7F693ZEU8AM3B2xQHk0y/Q1IrmpOv5F/zb
	OHXOeUc210RTJhpX8lO5s80mo2T7c0oKvP1LrkQjBkK676GnX8g578HGPynFvg/y
	2ocspCZP7PAVse9jCgE8AnoWS6mWTtJs4VHxYra/ztJNb2XD5yXYdXUKWxBpBnYH
	41SircZLP1Nm6ctowKulcUwim9LaP38B+9fyI3T6AdB4AKwCTX7FEeTSGcsjX1Ei
	97/tAg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjkejg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 03 Sep 2025 11:47:47 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b47174c65b0so8940931a12.2
        for <linux-mmc@vger.kernel.org>; Wed, 03 Sep 2025 04:47:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756900066; x=1757504866;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xhPpuYTt60KwuxaKo5to6sQuHTwQVddj1aOmX6ZkoGM=;
        b=pyhgTKQL2RVX3GYkpbTmR6UksJCXZWDV/SPx3u7r8akQ4w5WLByQZPzBsGRCvMuXBf
         RH28zmDetjYAlAqyTqbAuf/y/6qHCOIpXI0djCmvJdeyX+l2t/GYECw+NHIgU1VOtZok
         HCLp65FN71MPMT2CGo48BpTMCMWYkE0PWcBCDMZUvBZMzXk+i0bTOvgkxhmPSm10VQTb
         0Nx27ODrgFhhVMkUohW//9JDjdHzuIpTXtYFvLS+gZWTpsZI1Ie+hdTISWrWSaPJZV+P
         ZODVDEiyDYWVHQ8hU2SOHXXN7Hcx6xKn7JdHbrIP7ghskBaJl9eOR6E6KOJZ6PwzTt9r
         l+Eg==
X-Forwarded-Encrypted: i=1; AJvYcCWL+WfOkOl0XDXoo4XTCX0M8XJIxTj2XqIahB9fYtMJ9/+anAgbDfGyUakh3h9Dq8EyPNnDIOATT4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnW4PRFCzzmXzDmptjSDliME6Dkfwn/ikvvdTNEfRkcQrGcMVM
	RhbUgkZuGKH2G7v88HvhIIp1/E7Ba/BetuWYWeVIJaLgySLcgTQZUxfMy8FMf/vySN+ZYXlRMp6
	3DJmELH2kMoPUTybx+nMXWDucCdJ2Rpk5OGO7GzjvtcKkQBRRtqWYH2J1F28qrUFJoLeujyc=
X-Gm-Gg: ASbGncs3l1QuuKoXzpcJbJJQY8GA8a/y2XNb2ky3ISOEI77awZOjaucj8M8wFF+GUVx
	i+2dUFL0B0gIO1ZN5H0iI5jCt3sY5gdL2O+WgE0R9qys42LN0ZdwjSKFjmQNVjKn7Zh5BmGmgAm
	ujkVh3+OHMBvEzXQ9BHJaPzcauVEF8BGD37IQB6bOjUUt1YV98Y9GYZMKj/5ExwJXxR6vk0vEmb
	t46B7+q5iJzl8o9/RwkbwkBke/gIAQRaq4RejDf9ydVpid2FKUrujzhcsH+6757oM5N7TmHmGl5
	bv+oWeKhr9R7nbCqtn1C+tX+vW9+V7kULpgVg5OlOvi6ejLj2fm+O0tv27zLbhRoA+e1
X-Received: by 2002:a05:6a20:3c8e:b0:243:c36f:6a5b with SMTP id adf61e73a8af0-243d6e6912dmr22964621637.24.1756900065692;
        Wed, 03 Sep 2025 04:47:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFAmG0Z03at+D5Pdmb3Z8BI8QwxUitl/Q9M4OQtvK1yAW0xniPbq3DRETbxohnwIERBbRMZA==
X-Received: by 2002:a05:6a20:3c8e:b0:243:c36f:6a5b with SMTP id adf61e73a8af0-243d6e6912dmr22964592637.24.1756900065252;
        Wed, 03 Sep 2025 04:47:45 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4f8a0a2851sm6584074a12.37.2025.09.03.04.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 04:47:44 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Wed, 03 Sep 2025 17:17:03 +0530
Subject: [PATCH v2 02/13] arm64: dts: qcom: lemans: Add SDHC controller and
 SDC pin configuration
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-lemans-evk-bu-v2-2-bfa381bf8ba2@oss.qualcomm.com>
References: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
In-Reply-To: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        Monish Chunara <quic_mchunara@quicinc.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756900050; l=3338;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=zv+OQgP7QtiWYcdAbwJZxI9mvZNQ5t0ZoDEvN2ren5k=;
 b=+pX2aDcvWB0Up+pV7UeQ36u+TUFaBDJt3mfpFYzvaSXU8X+AOhKStUH0wVGQsCKuIZpqhLntb
 sxtFEPktuRoAlmJELhEAWZ9UBStrShpYQe5dwwOEvkV9lL2vuX36Pn0
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68b82ae3 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=uosFifNmqa3Wiex5iiQA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: Z6L6XJEd92hbOwhOJkHeYdaXuFXAYO9o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfX268EXlNef11E
 SZsUWwvKktK/lFDaWtZX056yXTPraXMs1yy0gtkmHhoSsV9/LtTyXmL9YHnJ4EpxNd6nP7bUaoE
 /+h/0iEEfCKgHJt65FsL3hxCCxUP8e7Sw5h/U4BpB3t3JBtWfbTdWjba7Rk6oRWO0ZuKGrrXU8s
 xWfpq5agRdZ8EESxtl1dzzCYTGpWA22ltQdRhXPNeYRrXWh6g37wWFplNQ69AkZUg1SQ0/TRck/
 NGpD1sgMFkU9J6e76plBEqbA4Rbb1AeuiGXBAK28Yt1ALaexeddXJHjbC0o9CdWi5AC7lWdSXGL
 TWJMNV3bQxeXK7H/GTcGbdPGR7/HMQkNZcS6+594MQwu6dUMyD4FhuyUUnumJIoX5O7Fgb9C78f
 JUm7U6k3
X-Proofpoint-ORIG-GUID: Z6L6XJEd92hbOwhOJkHeYdaXuFXAYO9o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024

From: Monish Chunara <quic_mchunara@quicinc.com>

Introduce the SDHC v5 controller node for the Lemans platform.
This controller supports either eMMC or SD-card, but only one
can be active at a time. SD-card is the preferred configuration
on Lemans targets, so describe this controller.

Define the SDC interface pins including clk, cmd, and data lines
to enable proper communication with the SDHC controller.

Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
Co-developed-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans.dtsi | 91 ++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index 99a566b42ef2..9e4709dce32b 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -3834,6 +3834,57 @@ apss_tpdm2_out: endpoint {
 			};
 		};
 
+		sdhc: mmc@87c4000 {
+			compatible = "qcom,sa8775p-sdhci", "qcom,sdhci-msm-v5";
+			reg = <0x0 0x087c4000 0x0 0x1000>;
+
+			interrupts = <GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 521 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq", "pwr_irq";
+
+			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
+				 <&gcc GCC_SDCC1_APPS_CLK>;
+			clock-names = "iface", "core";
+
+			interconnects = <&aggre1_noc MASTER_SDC 0 &mc_virt SLAVE_EBI1 0>,
+					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDC1 0>;
+			interconnect-names = "sdhc-ddr", "cpu-sdhc";
+
+			power-domains = <&rpmhpd SA8775P_CX>;
+			operating-points-v2 = <&sdhc_opp_table>;
+
+			iommus = <&apps_smmu 0x0 0x0>;
+			dma-coherent;
+
+			resets = <&gcc GCC_SDCC1_BCR>;
+
+			no-sdio;
+			no-mmc;
+
+			qcom,dll-config = <0x0007642c>;
+			qcom,ddr-config = <0x80040868>;
+
+			status = "disabled";
+
+			sdhc_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-100000000 {
+					opp-hz = /bits/ 64 <100000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <1800000 400000>;
+					opp-avg-kBps = <100000 0>;
+				};
+
+				opp-384000000 {
+					opp-hz = /bits/ 64 <384000000>;
+					required-opps = <&rpmhpd_opp_nom>;
+					opp-peak-kBps = <5400000 1600000>;
+					opp-avg-kBps = <390000 0>;
+				};
+			};
+		};
+
 		usb_0_hsphy: phy@88e4000 {
 			compatible = "qcom,sa8775p-usb-hs-phy",
 				     "qcom,usb-snps-hs-5nm-phy";
@@ -5643,6 +5694,46 @@ qup_uart21_rx: qup-uart21-rx-pins {
 					function = "qup3_se0";
 				};
 			};
+
+			sdc_default: sdc-default-state {
+				clk-pins {
+					pins = "sdc1_clk";
+					bias-disable;
+					drive-strength = <16>;
+				};
+
+				cmd-pins {
+					pins = "sdc1_cmd";
+					bias-pull-up;
+					drive-strength = <10>;
+				};
+
+				data-pins {
+					pins = "sdc1_data";
+					bias-pull-up;
+					drive-strength = <10>;
+				};
+			};
+
+			sdc_sleep: sdc-sleep-state {
+				clk-pins {
+					pins = "sdc1_clk";
+					drive-strength = <2>;
+					bias-bus-hold;
+				};
+
+				cmd-pins {
+					pins = "sdc1_cmd";
+					drive-strength = <2>;
+					bias-bus-hold;
+				};
+
+				data-pins {
+					pins = "sdc1_data";
+					drive-strength = <2>;
+					bias-bus-hold;
+				};
+			};
 		};
 
 		sram: sram@146d8000 {

-- 
2.51.0

