Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA693081C2
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 10:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758019680; cv=none; b=ILPvSRsrpEKUlEG5Z6gNW/nG8tjR8VOBYi5E7dU7EFi9IhqrIUtfsBLr7U8wvJA1FGaFotlSP2OoKdoO9A6lqNO7FM84/RG6rUid7phxhFoIiI17mSzfyBzMkPQXHSm5j0rdFUm1TbYi+8tuWnsJC7YqyjiBz6qJjIttILJvsY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758019680; c=relaxed/simple;
	bh=EVxv7pTuTXtbJBbTq1cFIyCcb5+PnMhD77kH76TEvKM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DNZ2sr228sLFtuh2YjhmTLSb2YbKKr+c28SoncIvRSrAoSaO1uaahOH8TIYtG9hTgOqJ1ZjtRs1KwDP9MbJKvZRN2TbiJFcr7Gyug0z7cdh4iBrAO7reJIMLVNqpwOgHbHAxSqkCWHJPzwHtR3hQyfsymO2Qgl30kta8svdANGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DImXAdby; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DImXAdby"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G9mNqr013761
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 10:47:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lP2WRzsTd7EkrIRJP7HeDDxQJ4fUG5rGQbk5fNbcD/c=; b=DImXAdby+60nerr4
	Dzmp+kxlH5hu7V/UUx7cNOaGy4IpVMbvDPpX6nLvLVBRuTqpMdj7KtzLFF20lKe1
	h8jdrKqgHs43vf70Duy77C/ZC3FDGSwkK9bR7ayq4d1GA6WaKVAWk+lvKJtAYc2J
	KEB/qPMpzZzVtRdwwDPj1VqIiXMVx5IOSp/rQS3wKhWtoLtwksIYvBlgyXDF3bYE
	F22adXU3/lQQAG/m1uiA8nLHx+M6/A1ZGkLaqvdF4TPZWE4xgwoXa1v8HZbCqpRF
	BTa3mbsLRK7vzbCaGnECQUPYuI8xFIrK+pm0aSTYdDoLjCX5dkFgQ3F/40z8/0RC
	d2BEtQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496x5asppb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 10:47:56 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-25d7c72e163so81527255ad.0
        for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 03:47:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758019676; x=1758624476;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lP2WRzsTd7EkrIRJP7HeDDxQJ4fUG5rGQbk5fNbcD/c=;
        b=RhayBzbji9QxPD7MnjWXgSeGwqVceY90/ebh/DbocJA3Ixs2l+bRObTGILrvUsxX+J
         SDdS8OD0ajD40JQhHdxNOpdyjq0vsqmR5+LsOvZ9hdg3vbcqQLi3eigLarHb7W1bL5UJ
         nhkGxuEIdEGLfDKz2fLTGOy4RBBFj8jm8tlmp2S/r3JZTKnKlminAtMoeuKVLOexRtOl
         7glISAZM/9CQXhXNvtPRcs+8MvqbaBvRMU3QSM7OcRLtCYIRZ0vc5qIRzp9+O07+S3Ca
         2JNwYDeE/lbj5scakgUh6ZzJzwnCvIcOBdX13BBwtElLBa1WNfNb0mWFscY1KdRKnAEy
         /ouQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/H3mLwgg/wj51vkAzTZ9tlp4kQYT5AeYvAx9zoPKHHpeuilL1V/+FF22EMKf3LTQSZT4h3i3wqGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoyx8Y06RZ7BpGdCsS2x53OxQsAGrAzUZaGyJspdJ6SvsnbQ8m
	I+MO4PMBscPovgNBAUbBgXq2Zd5nrouXtJZo17IAsbhBusHINssZgt2X4dDaB6lQ8M1Bzlu/ExJ
	zaDjAWI9EZQUBQLqR5ElFJcXN5I4mFATPzu4aYGu32rLI8Hk9gZGRSSxirs3uxTY=
X-Gm-Gg: ASbGncuamNTQvj5WMro35/QBxhsHAeGM84p/en2YjIbAO3WmmwUb1JtE/M/lw8P/Z2W
	QHXnDywJTrk7DL8eqmU2sZIaJ8jftqPbi28Pg8nVtpfLHKuoG7Bcbn00OfN/W664wsSdgPoyNYq
	f6gKbv0JFSxDBFusjEGjLSLFwn8pI3+LsDOxyNc2mLh5pX9DWy85PE3EmMxX5KhEErsLl/iG7/a
	HJ0quEmuJegntQ+1etsxkn63zbtYxbmGd7jDZPNYfG3D2SfGab+jyBwEMlT/Yxk9fG9tbH+2nAv
	rFGlJu1AtJBRrmxxUK5C4+uf3tONSiAItwAi3PQ3vNI/K1Rr8kONuhlvg+PYGxkx0uVd
X-Received: by 2002:a17:902:d2c2:b0:248:96af:51e with SMTP id d9443c01a7336-25d27d20531mr220848435ad.45.1758019675678;
        Tue, 16 Sep 2025 03:47:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhaMhuKnR3pAjBpv8t60tJ004Bz9yN6AtGwrZpjJVtA5m9XzDgoW9T0S6/ba9fgL6bzap8Ag==
X-Received: by 2002:a17:902:d2c2:b0:248:96af:51e with SMTP id d9443c01a7336-25d27d20531mr220847945ad.45.1758019675200;
        Tue, 16 Sep 2025 03:47:55 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267b2246d32sm33122355ad.143.2025.09.16.03.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 03:47:54 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 16:16:58 +0530
Subject: [PATCH v5 10/10] arm64: dts: qcom: lemans-evk: Enable 2.5G
 Ethernet interface
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-lemans-evk-bu-v5-10-53d7d206669d@oss.qualcomm.com>
References: <20250916-lemans-evk-bu-v5-0-53d7d206669d@oss.qualcomm.com>
In-Reply-To: <20250916-lemans-evk-bu-v5-0-53d7d206669d@oss.qualcomm.com>
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
        linux-i2c@vger.kernel.org,
        Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758019616; l=3663;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=d0901W5oS2IB+UAGgSU2EHYZ0jt+yeCd47Ja4xYspro=;
 b=rvMKyY9l1x9ja3pS3CXgVRZG9ysWFnYa7CyFQpUDBx1Xank5T/Mc5hl5+Q+cC0Vj5HTIOF0R3
 kuFZqw2/MK9AoDamBj2yds0dWyb3VbObnvctRJl/8IsH3rpc0UXcQJC
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-GUID: W65LTvgprOJUcSNS8p45YKVYV0nRPgYQ
X-Proofpoint-ORIG-GUID: W65LTvgprOJUcSNS8p45YKVYV0nRPgYQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDAxMCBTYWx0ZWRfXy2dugqg0O0S6
 CKh/0FJfu2iHsD/58JHM9zBc6qDB+oEiQqCSCNgZ6uhonu37LnOeM8HevMBBDEFoeIeMN5ixGIA
 pZPLKX3ESxP1dbb3cPy/Z12k0VdvyBUJGst1bIdubo/CjYjDX4NYorlpJlQ3fK5/M3GeCYsuhCT
 1Bk/hCLuy23Cql7yD7K9FIWLIpervHuk0jhL0bvdj/mTXs9GXo5Ul10KMlD9pTvEv6QbhmUQ4Qo
 Yb67YW9CSH/wHJhyjEG2mAD3RLCokCv6yJg6aSJjvccGbuFTFSXMzTKpd9pBdlkMXK7uj091Ipx
 i7yEtmUn2A9uzJ8H8lKV2L5Sxk2KxFTwfZKJg00QoFUlgas1pt8zb9Saapz/qYpKReoCR2bq1CG
 gA32hVus
X-Authority-Analysis: v=2.4 cv=WpQrMcfv c=1 sm=1 tr=0 ts=68c9405d cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=z9nD9lg9_nmlpaFE3BIA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160010

From: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>

Enable the QCA8081 2.5G Ethernet PHY on port 0. Add MDC and MDIO pin
functions for ethernet0, and enable the internal SGMII/SerDes PHY node.
Additionally, support fetching the MAC address from EEPROM via an nvmem
cell.

Signed-off-by: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 115 ++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 0170da9362ae..d5dbcbd86171 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -17,6 +17,7 @@ / {
 	compatible = "qcom,lemans-evk", "qcom,qcs9100", "qcom,sa8775p";
 
 	aliases {
+		ethernet0 = &ethernet0;
 		mmc1 = &sdhc;
 		serial0 = &uart10;
 	};
@@ -352,6 +353,94 @@ vreg_l8e: ldo8 {
 	};
 };
 
+&ethernet0 {
+	phy-handle = <&hsgmii_phy0>;
+	phy-mode = "2500base-x";
+
+	pinctrl-0 = <&ethernet0_default>;
+	pinctrl-names = "default";
+
+	snps,mtl-rx-config = <&mtl_rx_setup>;
+	snps,mtl-tx-config = <&mtl_tx_setup>;
+
+	nvmem-cells = <&mac_addr0>;
+	nvmem-cell-names = "mac-address";
+
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		hsgmii_phy0: ethernet-phy@1c {
+			compatible = "ethernet-phy-id004d.d101";
+			reg = <0x1c>;
+			reset-gpios = <&pmm8654au_2_gpios 8 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <11000>;
+			reset-deassert-us = <70000>;
+		};
+	};
+
+	mtl_rx_setup: rx-queues-config {
+		snps,rx-queues-to-use = <4>;
+		snps,rx-sched-sp;
+
+		queue0 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <0x0>;
+			snps,route-up;
+			snps,priority = <0x1>;
+		};
+
+		queue1 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <0x1>;
+			snps,route-ptp;
+		};
+
+		queue2 {
+			snps,avb-algorithm;
+			snps,map-to-dma-channel = <0x2>;
+			snps,route-avcp;
+		};
+
+		queue3 {
+			snps,avb-algorithm;
+			snps,map-to-dma-channel = <0x3>;
+			snps,priority = <0xc>;
+		};
+	};
+
+	mtl_tx_setup: tx-queues-config {
+		snps,tx-queues-to-use = <4>;
+
+		queue0 {
+			snps,dcb-algorithm;
+		};
+
+		queue1 {
+			snps,dcb-algorithm;
+		};
+
+		queue2 {
+			snps,avb-algorithm;
+			snps,send_slope = <0x1000>;
+			snps,idle_slope = <0x1000>;
+			snps,high_credit = <0x3e800>;
+			snps,low_credit = <0xffc18000>;
+		};
+
+		queue3 {
+			snps,avb-algorithm;
+			snps,send_slope = <0x1000>;
+			snps,idle_slope = <0x1000>;
+			snps,high_credit = <0x3e800>;
+			snps,low_credit = <0xffc18000>;
+		};
+	};
+};
+
 &gpi_dma0 {
 	status = "okay";
 };
@@ -404,6 +493,10 @@ nvmem-layout {
 			compatible = "fixed-layout";
 			#address-cells = <1>;
 			#size-cells = <1>;
+
+			mac_addr0: mac-addr@0 {
+				reg = <0x0 0x6>;
+			};
 		};
 	};
 };
@@ -552,11 +645,33 @@ &sdhc {
 	status = "okay";
 };
 
+&serdes0 {
+	phy-supply = <&vreg_l5a>;
+
+	status = "okay";
+};
+
 &sleep_clk {
 	clock-frequency = <32768>;
 };
 
 &tlmm {
+	ethernet0_default: ethernet0-default-state {
+		ethernet0_mdc: ethernet0-mdc-pins {
+			pins = "gpio8";
+			function = "emac0_mdc";
+			drive-strength = <16>;
+			bias-pull-up;
+		};
+
+		ethernet0_mdio: ethernet0-mdio-pins {
+			pins = "gpio9";
+			function = "emac0_mdio";
+			drive-strength = <16>;
+			bias-pull-up;
+		};
+	};
+
 	pcie0_default_state: pcie0-default-state {
 		clkreq-pins {
 			pins = "gpio1";

-- 
2.51.0

