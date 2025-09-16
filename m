Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EAF369323
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 15:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034836; cv=none; b=hiAFl8KNffJVm5/utAOhauQ5p0eURjk2WNzrKrbxbOMAhn1QAUIhzRXJOO7fo8V3hjyQg0LPtr/ZufvLPzNues/MYvdnXY2ribL1PX/UorNMnpzH0WzNh0Jywn+mRJZSbLDVG7vYLU5rYniVhzvIbjkF5QHD7+Mqp0hAOncmsHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034836; c=relaxed/simple;
	bh=EVxv7pTuTXtbJBbTq1cFIyCcb5+PnMhD77kH76TEvKM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JB0mOFy4ifriX5x8TJCjGAMXnptoxDYaJdu/EPouoUvj9lWnaHZh2IrGXQnRIa/wkz+VM2JezwZGZpOztqltEaYQ8qD/4vJW3vpUT0k9cwNlos8OInEHZjiDFyUkS1I/DSZejPtvNn3HaWJ3LqmExZj6c3c8c6qN4SL5aSKYZh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RYXPikbr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RYXPikbr"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GAlqUW019431
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 15:00:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lP2WRzsTd7EkrIRJP7HeDDxQJ4fUG5rGQbk5fNbcD/c=; b=RYXPikbrLDGlEhvD
	aVn9+vYOfZluHjfcYh7dop1N5HQXItlx7J6vIlux9taW3Ksr0o0IFBiwPtp04y8z
	XdzMId+eKnYMG3w4fG5L9BkgFmq2ieC+YdcZsXVbqKDx2+pPxfgBULQ/Kci7hPSJ
	5bKX6JulQfDINT3Pc0jSZ2wbjUOGdIjDiLGwoy6VmFP0tZiMTvJSwf0uNjrUyqns
	0t8ftDLBb4VB4SC6OmsNgZeIXnAyrW/5t6G4x3aPLOl2ShEx+stZ8LbIru2iK39d
	fRDf+wQ7W2CIfRQyvDzH5ple0UZIdf69lHFubwY8M+020xOX74m6pK/6R2UJDojP
	7eCBEw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496da9dn70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 15:00:33 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-25177b75e38so66120745ad.0
        for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 08:00:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758034833; x=1758639633;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lP2WRzsTd7EkrIRJP7HeDDxQJ4fUG5rGQbk5fNbcD/c=;
        b=C5JdQDmUyq8sXZqKPjLnOLrFId3C3T3gnZ220O2IR/k4QhGliBDUlwZs0DGUohukMQ
         1VkgW1+4yfA71tUhX8fuuM9TYnkbrOPMsa1SNflSqXcPDoVYIj9I3O+ZKgjA16SJkfP8
         VviWWvvuAIP5a4WY9Emywq2h9UmOhDL5HKDZYGa1nFBXVcaUe4WH59gplAas8k4AKy7e
         qWG5nZqr78TZzzV0wg/lUEqLxh7K3/jEReG7W7Deo01CFsyZ5JulDNETgOcc3ysytJNB
         dS7wokvJPMnfT1H0TOvH7vodGZ2+B/t0InIM5GIURQnbwOj1cdci9c6P3dsD7fX/h1f6
         qlug==
X-Forwarded-Encrypted: i=1; AJvYcCW02wXBbf2pMK2u3ntGqVX5PzyfWjdMWU8IrrJPivT3fop3K0VhKHAA6QfMwr5hkAppIbWREzebKL4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7eBYfq7PfGcDFpacvoGdZVW9dNySW61N0gLc9GgMGfp9FpDSB
	Zk1VY8eOzRNNBNl8A6PwTbTI+bqfQy7k47p5DDJLmq+sdoMOpUA0D5FxXuO65szVxajdfu44HdN
	Z6Gtu0cWYIk8F3ksM79UhiJ3FmpEIplIOKNU/W5rG4ObkuBb7oFh7fKRO63gb+1U=
X-Gm-Gg: ASbGnctose7JlgYqc6FQyK9vWs+liEzqkKjADIHPW+qFaTHVLuOzM7QdIITJDFrt9X7
	RTblMaiHg+dfR81B6w5akfkbyQx+b/98C2g3eZJCNlXgXnOOaIRR9h8egEpeMxqei0FudaKwr74
	Nc4ecISJiJiRXzBkvWO13Z36+Iue6LuVdCBG449hf9r3hGn35Klr0RAkX2+3RyZ15F0AZkJ6A3K
	3pb2bMpDLRWySZ2VLOVG9Fft7TUWZrRqW8yafc8SX8gm/0gUKJZ+KNDXIiKJ2qWCWblLrAFMaIV
	vJ85wH3tHqTBDtGfs+ELfzrmY1w0NfD+0UG3Z+cLbnxWVDIvAdSJdcDeHCNmhW1s70Ge
X-Received: by 2002:a17:903:2451:b0:267:b697:4ea with SMTP id d9443c01a7336-267b69714demr78103035ad.54.1758034832018;
        Tue, 16 Sep 2025 08:00:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPBKc4oG1+F9yCdpRJby4Lh3p3lSPbZUVoBQDNJrpw1NiMFGEm/RzOKKvH0qJ3DfP5gn/i5w==
X-Received: by 2002:a17:903:2451:b0:267:b697:4ea with SMTP id d9443c01a7336-267b69714demr78101405ad.54.1758034831075;
        Tue, 16 Sep 2025 08:00:31 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2651d2df15esm74232615ad.45.2025.09.16.08.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:00:30 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 20:29:32 +0530
Subject: [PATCH v6 10/10] arm64: dts: qcom: lemans-evk: Enable 2.5G
 Ethernet interface
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-lemans-evk-bu-v6-10-62e6a9018df4@oss.qualcomm.com>
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
        linux-i2c@vger.kernel.org,
        Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758034770; l=3663;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=d0901W5oS2IB+UAGgSU2EHYZ0jt+yeCd47Ja4xYspro=;
 b=ypJXIiKLDhluYwEsejhys+yKyfuxi1sg+qQaO1HJXdGZ4WTiJYwLq4HfkEfkd5s4xzJmLRF21
 UODc1p62681BMPylr/ac7aKK2O4W6/rrLTzhx/ct6Z0igfDR2CJ1oM1
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Authority-Analysis: v=2.4 cv=M+5NKzws c=1 sm=1 tr=0 ts=68c97b91 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=z9nD9lg9_nmlpaFE3BIA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: BVI_T0CdNWiJwLmkMph7G38_b-_JtdXW
X-Proofpoint-ORIG-GUID: BVI_T0CdNWiJwLmkMph7G38_b-_JtdXW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA1NiBTYWx0ZWRfXwFfT/hxU4oV+
 Loi8GX+wg5TMaLeNb7jTHVWz0a87IDETcznk5TCJw89onhygjvkdtHBeO8FhyKMckdcs5W03Jtj
 lgRaX2/knxQJ2mBry8xJ8THiAozl9b2vZSesEpOvaeD/pRnRr2xvgJbmz5bg+JlOdhR7yKCB6Zy
 GKa4MwFbUYAE5RGlo5W5dtYwm6HRZsGn1xSykfQD+8lwR690mrkDTxGd3tGBSWjEp3m9A7upIHN
 2Un6uWVpsZKAiCBMevFDrvWt9Dz2AxuMhFm5TClHwY9TqdFKYN3dZLo6L5WjLykpcb9OW+8nMbb
 ZpaWNmGoXGnroS/Q6YPl6tDEg5oep4vOWfQbJcz9AsKa9fMkpFdzBiNF/e9UndPFuFYmsoe0Tnj
 H/9gyxJv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509150056

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

