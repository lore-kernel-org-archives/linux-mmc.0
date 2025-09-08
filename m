Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300E12EB849
	for <linux-mmc@vger.kernel.org>; Mon,  8 Sep 2025 08:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757319623; cv=none; b=dACHnwjftbzuy6WoLsBTLXAZ2C8e0iTHNR9OFBM3IOr8ALJyqGw7mF2G7/+MNtK6BSVdz5ibNSxU5+yzU5OnOSBMOzz+s/xoYQB5qIqn8od8KqP7ki20XGd5tBCi1aKSNVIkQtPnOuRiNMThiFHnVUMfGBhXCbSo78iqK28v+hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757319623; c=relaxed/simple;
	bh=OOKP3IxxuvrHC6Z+46EpwtrPsYz3mUsSZbROsUuhS2c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zfwnqv8SD7/w8POgtz9HnGfY3RWHrIaUK30YrDLazxvhTyRb0p2mgBWGhyNdt2Wkug1Vl3j9iV+fixVizU0P/jzmXJDiN6+CjdT8iPv7tjV+/h/kLq6uoH/uL5dmrJf2tmiKHDQnnXDJ+6YpqUyi4y60tEIm6wi4ecniZJPK/OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jTQ3RELc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jTQ3RELc"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587NGXFC029227
	for <linux-mmc@vger.kernel.org>; Mon, 8 Sep 2025 08:20:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	faMteZ6S1wHqGokADuRhWLiX/zE3TInCiyV91pcLmgY=; b=jTQ3RELcSIjLOBqi
	CWSulV4ekygDoZK/oQ4NjO0kvdb2AkK9AxUQ8yF3RxYySSubX9/+2AucqCG5+C7I
	IYaxzzy7PLGbbt6JBn94mbck5aEufSN9acqRLA+j6gC7bjz4B9y+KL3c0EpDmEsM
	DnrqmYc9/2Pfn4q7CBmykkRBsSuTSPN6HO2ojljQQ9/R5QAGksoTS7Pj3X9N6M8+
	QD5LIbTqpiMPPC8mOoo1FuBw+hvPWxLPKNx3diCpwQNMd/mq++6xsfTLuBilwqn2
	biCAf0i/0N8WZ6hnbZexg7gKT5nytDYRw9kSUxvAGH7Kic3BpuQ+j5MyUQJ3vYDl
	F10zzw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490d1vbtmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 08 Sep 2025 08:20:21 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-248d9301475so79734495ad.0
        for <linux-mmc@vger.kernel.org>; Mon, 08 Sep 2025 01:20:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757319620; x=1757924420;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=faMteZ6S1wHqGokADuRhWLiX/zE3TInCiyV91pcLmgY=;
        b=meEgIrmNCt4zcfG6rbLzSM86fzs8hteKM1Zpz7HvohyGZE8raUp8XRpku+msNYOn/1
         ce5k7NhpjPVoCBnkkX/ZUD49OBVMyOwbCtbeohDKWnIaSvuoHx8V20pPGIxrXjYRcFri
         p5gc06rgTwJ2zb9n4v9aGsOoouqw+18HP+SMK9ErAen5vTYDZTZUp63O9Dl2rwNQ6YbE
         5f+N6NsUokvhvZmtWB6OKwjbNWFuJ1lwuwjzYrXFI+FYBZIKyERHbfib/YDJXGHHceEp
         K37uQHy2oXoHqAQstDrAoL5YOgWArNm1jCFizT+YAGDlCXWzLt37FpnBHvtyOSOq8ayO
         1Dhg==
X-Forwarded-Encrypted: i=1; AJvYcCWc55qNpXUeuOtuFmkbKF3Te8dtSjC+KBTXoLiFrdLQxnHNYLRtZau5Cfy4jPNJQj22v/HoJMN5jrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXqDGdpUHPyNjY9SH2CAhkFrIv4k2mNNWJ61qvURd98dTY1tC6
	y3SK23rDyffhSAboZvuaJI3VlV0UarHlJAeuNHIJmC3jyd7Gyy+LlipJ2jTWL9Jzg9iCU0QwWVw
	OfAKDYjbWzbfHq3e2KvR0GdB8fq60G6d+lJeoAudqnfJZtbo7OBOd3CN/zIhv1QY=
X-Gm-Gg: ASbGncv1QdFf7SH0dVUohnGZ9U1sZUlk8QJxvf4OnJqXqedUM3jzU3UgchWRkCizgph
	kKymHV+KuKJFoViwHbZONkOizsV3yFUJpv8YyrlnVy8SA5wUWidQ+XtbM4yzotu5WHrIP1jpmjV
	l6/g31rMRlwjm3AEFxCaGPjfqwt39sDBR6Sr4vvODWWPnVz+ipboZiBH04n0pd1Rs/mF2HD0i6R
	JybQQ9Y41u6kzASbfXd+WQ8OgXr1zs7jUjwOpzWW5afWOX2sHPX1Dvo04nc0DVOxwF8lqcykEKZ
	Fyg1e7R+hqoSOtNYdxoztYIA78ubawAAWBh9lToVi8yWACZtaLK1oVZYFdNNbxoNxQrA
X-Received: by 2002:a17:903:90e:b0:24b:1785:6753 with SMTP id d9443c01a7336-251734f3e0cmr79172365ad.53.1757319619997;
        Mon, 08 Sep 2025 01:20:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHE0/CxZRdvfy8vSn5LYlLNvjyAMh5WISGk4qCxX7YYAm8cG+QyMS80zKFSv7DBuoACRrAew==
X-Received: by 2002:a17:903:90e:b0:24b:1785:6753 with SMTP id d9443c01a7336-251734f3e0cmr79171775ad.53.1757319619482;
        Mon, 08 Sep 2025 01:20:19 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ccfc7f988sm104852845ad.144.2025.09.08.01.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 01:20:19 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Mon, 08 Sep 2025 13:49:52 +0530
Subject: [PATCH v4 02/14] arm64: dts: qcom: lemans: Add SDHC controller and
 SDC pin configuration
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-lemans-evk-bu-v4-2-5c319c696a7d@oss.qualcomm.com>
References: <20250908-lemans-evk-bu-v4-0-5c319c696a7d@oss.qualcomm.com>
In-Reply-To: <20250908-lemans-evk-bu-v4-0-5c319c696a7d@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757319602; l=3497;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=OiBTb3F2PHVd/TNBpEA9CdLRTPKY8wFa90rNHzmvnVU=;
 b=wQqZJgyyWQK1E7EecFQDbe/xkDNHHqY1QcgMke0duTkHdjcrkuZwVbAqJ2qePTObIej24bc7W
 d1hAQsGQ+BUBPazoNoZqDHcwcelBEZ2KlvVXWIztJfoYahWH9GYfq04
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-ORIG-GUID: sFBwtgTNearx-FwwuYJfSxA1mLqTyZiq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNyBTYWx0ZWRfXyLbpjVi7bBuO
 j4WQNoUZoxnC/fJBoGqkg4qNCAzIKBc/6ZFlRRloKJJQbLokZsLDvEqke77oDWxe4tyS5drtpUf
 kox5hSuFDUpTvVKfRJ4i3a5u+1+rHqQ8BbBDoeo4UlSNoVPGW9+6sg349HODtBmRc0Y5ciwE7uN
 3+6JMV2ZzEUna+VjyZd6dFdYkS9BBharrh512fZw5g8DxBdOA3gYhDUW+5bXnfjviOE6eq53an5
 bN22O5dW6oCLx72LWqgEfz4DlR1e2ABhZDeVumFCGKRlq4UjIuFus95ALp3dOmRvG76axi4i+4Y
 Rv/M21wavimBVV0K6ogIvhzTNzHCZnlqlY2In8OwhLPSk/mfi3271ZQ103iW3AmH7qdHwEesqjT
 TLMHsWgF
X-Authority-Analysis: v=2.4 cv=cYXSrmDM c=1 sm=1 tr=0 ts=68be91c5 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=uosFifNmqa3Wiex5iiQA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: sFBwtgTNearx-FwwuYJfSxA1mLqTyZiq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060027

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
index f5ec60086d60..05d5da382bca 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -3834,6 +3834,58 @@ apss_tpdm2_out: endpoint {
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
@@ -5643,6 +5695,46 @@ qup_uart21_rx: qup-uart21-rx-pins {
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

