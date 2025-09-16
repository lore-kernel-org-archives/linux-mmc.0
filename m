Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6CD34A30B
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 14:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034788; cv=none; b=Jfwcb8VDsJwGnJ8dgpIDD0sVIgR3I5lCG7z3s9Ix8oH7ol2rLokr6DzXbWauKCuNLtxg4YSA0A+ksOGWzhcQdjuUvKUf8nz9twN9FarEfPFbkA+WwzIZxFa8SUf22zhEU3YP65yLew9Q5hptItovZILu61kxGNndnVaA6rJEfrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034788; c=relaxed/simple;
	bh=N+DvkIEf+jK1FXGRrKsm8BXra7/1jp/K2c4WlAE5nwE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S3UZuTLwT9PyMSNsSwm5E+QSxQNc5YeF+gpRv42AUnQvmSrt5b02SbH9tdQ3LYiOynY3rfmtltn+EwtLpegl3eWKaejqDU98WrHYeWyGDwo49hikoQh0aR/t6AiDmfaOM8A5ynrbxZYoCS7LluDvW2MdwBH+kvG952q4TNK6fac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GkbFwWts; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GkbFwWts"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GACdw8020146
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 14:59:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LGivlFPRUFzyqdDIJCQVoLwxyXyURMZg/RLnf3kJUBE=; b=GkbFwWts5iUCJ013
	4VG1GtpapIatmlerSzt7TsNl2fXvLsKcmoc8KRa4p/qtTmCZASLWDikQYg9ZGH+u
	njFA84FXkb80ZzVfYeakvmR6JR7GltU+o+td5zqhfgzZKD/F9szUsUU2b4Gno6Ws
	lvePQgcQBlp9FWkfzoJutvVXqkOfbWF2gPv0kZu44eDRGt+MOf90UYmtMsUSuhZ8
	jwvGyw4NBLskRjbcnKbplS+8EJ9qPuOn4lD8SwBLftmI2f0ffcd0zv2fCr8zrN3F
	LsBbLoIf8GLovUBEAVNkMRjSh3mPvy/g4DE7QiAv51Cl8OX/c0xldkWPrur/vsv+
	HQ3xzQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494yma982g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 14:59:45 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2659a7488a2so47957145ad.3
        for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 07:59:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758034784; x=1758639584;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGivlFPRUFzyqdDIJCQVoLwxyXyURMZg/RLnf3kJUBE=;
        b=woGf+i62JdvmC4Ipp6A/95mXpGf97AdckPfuZxbJaoOBAoq46We0n40bWepq3t4mWP
         oy7kVvbWJQQazIQrhqKNB3aaAK11ZFO07SWgRUw65TwKJF0N8wr5CGpquJ/UYKRQmqCY
         Y2YOaxG3/QbuYtOtmZnfEfyzqV7IHZU3qS4JjtnRgvsM3Q0s2pFQYc6gqV3S/R3/0owU
         sZKtgCxvOx5xDxTc7SzSYKqdPgZNM72DYARtvJ5G3nOm+Bo8WbIvCBrVf9S2DjiRMfoL
         j7fR9wsFcfuT1ON/BRCyfJvamYXG1UPsK70MIxlQ8n8JbSuA8PsQGToWwzWaAF/S+jga
         m8Ag==
X-Forwarded-Encrypted: i=1; AJvYcCV16u+66IZSvdAhtUbC4ahcIfmJDMX/I54A/qOFCXY6v0LWRi+0WNAavOWkvfjwrZfTJA11KjSTwwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsFMKPM+Ac9L/j6ullk8mfS/USjrYncAoj+k0DImGS5ayEg+xG
	3z92Cp9ZXi6Qy6LkGgPLSEaz9y1jn86wut4J6xMDLypaUt9VsXtv3EvcdZM5Ipc2IakWx/l9544
	DeHRnjTUvT5xT/qAqV6Ke6pm1J/0JyuyEuDGL06u7/gu0lUgAhFqvnfnWr6DdCCM=
X-Gm-Gg: ASbGnctmw2BaW8d2H/p7rACvrfrP6+IhYJlflW6nVsZRQ/A0gcvtDwib1UwqKnyZDfr
	ejLseb0YeHT5qqxa51pEA0ztnP/gqzk8gmzPVdSh6zhSeUBQFHyuGnUi43r9ANxc/pkRXgABC0Y
	+Tvxh0iZ26WWvjxbmYilFsUOA4/h8WZu+uKfdPRNNinLP6dbRzsK1ngwfvvpHf8Rf8vWFi1jqWm
	O7ZrJ+hIC3BpLEqwgtWwZZ2rrdX+Cc7pDvQWcYqEbhtAG9QQJl9pfvAMY3sIFE2as93/KXDkyxC
	gpLy1yUJFdBvLMPuIG+DxI6M75s+azyJydzoIaqOBilTKbg7DmfVU0rwPqA3DtOwyG6n
X-Received: by 2002:a17:903:244f:b0:267:d0fa:5f75 with SMTP id d9443c01a7336-267d0fa6b33mr43336405ad.1.1758034783929;
        Tue, 16 Sep 2025 07:59:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8A9Ir70Z/p5m6VgOr+1WTpcLrwaUQVF/ndq8V6egXMmz0Evup4AB0T6k7P2GKkxD72d01Bg==
X-Received: by 2002:a17:903:244f:b0:267:d0fa:5f75 with SMTP id d9443c01a7336-267d0fa6b33mr43335815ad.1.1758034783324;
        Tue, 16 Sep 2025 07:59:43 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2651d2df15esm74232615ad.45.2025.09.16.07.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:59:43 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 20:29:23 +0530
Subject: [PATCH v6 01/10] arm64: dts: qcom: lemans: Add SDHC controller and
 SDC pin configuration
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-lemans-evk-bu-v6-1-62e6a9018df4@oss.qualcomm.com>
References: <20250916-lemans-evk-bu-v6-0-62e6a9018df4@oss.qualcomm.com>
In-Reply-To: <20250916-lemans-evk-bu-v6-0-62e6a9018df4@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-i2c@vger.kernel.org, Monish Chunara <quic_mchunara@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758034770; l=3497;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=DwrtxD3ZLmemkOPdq7lhEGfiDfoe4W0WX7TMCKQ8d9I=;
 b=XtWgAoinX5GmsWiRsNvjwzmDS5RO5ART8RCF8c+fIkjVP/Z9NhOvQmClzsliu92VDWOskPaJS
 iB8qALGpyjRAZwmpi6TZDxysGhJMlPkFsOFFMk45VT5PaPtrt3sJcFW
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxOSBTYWx0ZWRfXxGtb+J0TRZ9Z
 vXY96xcC7j1JoHypx505dIPahArQDOE7GoJe/04G4qzE8hXhsZqs4rHiB3RJ3Slo0kIo8n0VKvz
 751M8bBybFdM9Ru+7Fg0Dni8md1cemIzxURIhICU+cWsDWK77sRGRHjZvvA5BlM2FIxOnK0ZscA
 ooSJ4/b2a6UnhItP5FKbnFcMpfO4jHkT2X0i/rsUV3586ECvMCFA9jYhFi19BxLPgwa60euWOq9
 EFJH01C9IQ2nP7n/UcSs07+pl9A1eXFwrtKU9+mWQ/I/nKYXFq7hG2uq+lc4fqkZKKd+nX3gpOF
 7GKXzpwpvazJvSoOaMH0iEbdWItT7r7IXj7UzJTwaRafME9FY5mV5XtA0Eye0OE1zDlPovw+Wgk
 oRlbLDDR
X-Authority-Analysis: v=2.4 cv=cdTSrmDM c=1 sm=1 tr=0 ts=68c97b61 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=ALy2IlhOjgNbs65Id4kA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 0oAjkwPdCY5xG0k5p3ho3pD7s47EZSXI
X-Proofpoint-GUID: 0oAjkwPdCY5xG0k5p3ho3pD7s47EZSXI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130019

From: Monish Chunara <quic_mchunara@quicinc.com>

Introduce the SDHC v5 controller node for the Lemans platform.
This controller supports either eMMC or SD-card, but only one
can be active at a time. SD-card is the preferred configuration
on Lemans targets, so describe this controller.

Define the SDC interface pins including clk, cmd, and data lines
to enable proper communication with the SDHC controller.

Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Co-developed-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans.dtsi | 92 ++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index fd6eb6fbe29a..b7e727f01cec 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -3835,6 +3835,58 @@ apss_tpdm2_out: endpoint {
 			};
 		};
 
+		sdhc: mmc@87c4000 {
+			compatible = "qcom,sa8775p-sdhci", "qcom,sdhci-msm-v5";
+			reg = <0x0 0x087c4000 0x0 0x1000>;
+
+			interrupts = <GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 521 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq",
+					  "pwr_irq";
+
+			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
+				 <&gcc GCC_SDCC1_APPS_CLK>;
+			clock-names = "iface",
+				      "core";
+
+			interconnects = <&aggre1_noc MASTER_SDC QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &config_noc SLAVE_SDC1 QCOM_ICC_TAG_ACTIVE_ONLY>;
+			interconnect-names = "sdhc-ddr",
+					     "cpu-sdhc";
+
+			iommus = <&apps_smmu 0x0 0x0>;
+			dma-coherent;
+
+			operating-points-v2 = <&sdhc_opp_table>;
+			power-domains = <&rpmhpd SA8775P_CX>;
+			resets = <&gcc GCC_SDCC1_BCR>;
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
@@ -5658,6 +5710,46 @@ qup_uart21_rx: qup-uart21-rx-pins {
 					function = "qup3_se0";
 				};
 			};
+
+			sdc_default: sdc-default-state {
+				clk-pins {
+					pins = "sdc1_clk";
+					drive-strength = <16>;
+					bias-disable;
+				};
+
+				cmd-pins {
+					pins = "sdc1_cmd";
+					drive-strength = <10>;
+					bias-pull-up;
+				};
+
+				data-pins {
+					pins = "sdc1_data";
+					drive-strength = <10>;
+					bias-pull-up;
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

