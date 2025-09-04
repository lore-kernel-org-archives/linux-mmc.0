Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2EE338F2F
	for <linux-mmc@vger.kernel.org>; Thu,  4 Sep 2025 16:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757004026; cv=none; b=PCknCxMdLwAxNtQb7LEJ9Kuxo8azTg2BxDwVO0IrMGEdYiqRgA5NHpsyDOUGB78C3bfpvrZ3/cJS7L7Js5otg3t/aIXMO9cPK6SYR73XO9nkQTq7YM6zFYfNgESoTSbNHH4xCKnL0HlsOnzwA5wYo5C0RA8z9TYBUnwgTG97dqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757004026; c=relaxed/simple;
	bh=7mhTBB4svXSgzedxS2sKUinK/GsrJ13ZbXexdU6hXAg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=acn/gmrOO/HftBrcATy8OEWnLLk8KMDxy44nkb/2Leb1DoIpqv/qD4WIuwZ3JglQwp0NrXw8GYmy2nRof/gWsgtrYREG8NdPLZvxYqUeBIpyzj/xzFn0l1I3t8IRVMTRiRCSTG6otSerkowcXBVZoX3xqzURo6Kyv3DCyY7VVxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gq/d+ta1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gq/d+ta1"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849X8Qh003803
	for <linux-mmc@vger.kernel.org>; Thu, 4 Sep 2025 16:40:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LLLFa1vgqgzhTWyXHQNG3xljguUOpM2dwOXSKlCIgOw=; b=Gq/d+ta1LGKa7X8f
	xgVG/lmshqku4IWctLWgQh1eVSo2aOK9Ho/jqc576HSFFWNr0GUH4sW/Zs7DCc62
	5UTMgDyqPITIv88aCIGv3SgJvwFcY1J0/Wbhe2BjQ8Zh4wBlQnbu2gsoi79YvGEx
	Gi8fP6ey9zkb4WahA+fg+ClaWtBYs3fR5DbkD2hp3CZBcadmGBi3HsU/CJsFsrz5
	1r/LRLFnqiJZaNXiOSLlLRuFt2DGnnjvbeEgipNkTWMXVP1Ng1HwgmJjMoiqOdNx
	zt4DdpqdADu6GUIIsYduTIBlJAhnY5zlnvDT8O/H6LyWXtDpmbIWfRK54K3lDB19
	BN3OtA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8s88m8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 04 Sep 2025 16:40:24 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-77241858ec1so1197842b3a.0
        for <linux-mmc@vger.kernel.org>; Thu, 04 Sep 2025 09:40:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757004023; x=1757608823;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LLLFa1vgqgzhTWyXHQNG3xljguUOpM2dwOXSKlCIgOw=;
        b=UEoqahInnDf1Z4AJF1YnxM8ezqoFB0EBI2TtXmLVADWxvTn9fe0InoRYSr71id0LeK
         fQRSUEjbcsV708C0fMouP93lBMhPPOTlxchG0+3AxgDJTNnGW5DJcSLrYrCjlGDpp/A4
         3/LDlw/NOk4yNC3XA52rfXjh8YHFcZ9XfZaX4DWeZtRbpcdIfd0nYT/8ww2bUQbtFyYk
         KiNQojsHx3uawMgjpEyEtVPS3thOYGm7+H4XDuElNUZ/g7xsg18VSYy0DWAc+/Zusktd
         8ViXpmYCH+n+y35aiWJtO6SS3EsmwsUr5CLZPQPvzvq9LP5gYpOkxhK29Cy7G/ieaPm5
         n6og==
X-Forwarded-Encrypted: i=1; AJvYcCUGElCtARTZvycCBmQ5P0WArTgo7AERKjsbET6JP13+d+SKF8gdXr05uztzcnlPUyGwoKKFNd+T29w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdBH/EfvgXNY0jU0F5P6jceTvcX8CJoSJ2h1FlO0K60mQE1eQ2
	QsUd0oZxmeDGrWFFcq/TqmkcMVw+gAT9Wjx/EY6cvJl4l+dRfDb6h6wBybGVjBn0eEx9iZQZRC0
	2h8y0MFRmLjcxztFog6YSBn/2d2am9Gmrolwyb3mkDW/bjC2ntChK+H20nXNOiGxccI89s2I=
X-Gm-Gg: ASbGncsW6RhC3bHJwg6/bPNgcRuu3ZZx1celOVSTHLDDVlnmQeyETBDDN8F7xQS8KHi
	s4YLE5bZon9rgJvBERCYRz8U408R+HGPeNvNjaJNPWEv798FTFSPOJ98T/WSYOVgf+tcIFDx6vS
	FX9u7bVxvOTBCeNjbv2qyS8L8SbV45NV+udAdFd9DFkI2HfNN1w4pUe12OqXIyfXfz74vxHhRDa
	gX2HoXoA9dygxQweQPCoG0DA5p2T53D69gWrPIsxxB2KwLIgLTJ/BtfU9uhBQFxLQKx4D8m3qOf
	LU50Aq8hsx8Anw55BpKUCmU5NiTM9lDKOQRYnjgOadNLhscwRh1K5Y/lpfV/7rIriZH/
X-Received: by 2002:a05:6a21:6daa:b0:243:95c4:e681 with SMTP id adf61e73a8af0-243d6dd5ab3mr28357426637.2.1757004023338;
        Thu, 04 Sep 2025 09:40:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuNo1sZ5orbQxvhguCAh0osRzXm3m+81fnaQsPma3tdpJgpVRtibJ9Oeu8EQ6S/Y+S0RnwVA==
X-Received: by 2002:a05:6a21:6daa:b0:243:95c4:e681 with SMTP id adf61e73a8af0-243d6dd5ab3mr28357385637.2.1757004022822;
        Thu, 04 Sep 2025 09:40:22 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd006e2c6sm17346371a12.2.2025.09.04.09.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 09:40:22 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Thu, 04 Sep 2025 22:09:08 +0530
Subject: [PATCH v3 12/14] arm64: dts: qcom: lemans-evk: Enable 2.5G
 Ethernet interface
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-lemans-evk-bu-v3-12-8bbaac1f25e8@oss.qualcomm.com>
References: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
In-Reply-To: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
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
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757003953; l=3602;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=bKUautJj8bbERUSto/29GMUNDvM8H52kZaOY4JPKqO8=;
 b=Lfmp9xIvwkHZb/i/QoksB+5bNmIUT/8hdNBJ0Yl7G9Wbyagc52ldUwgblEf9DbYHLrbrLa0MN
 tmDM7D1ppkcBpVZylKyQ9RnoWM5xls/VyFtLh8/MSBRpBIDUVbnxCYn
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfX+NHrA/Kc9dOm
 MHzpRdWOh7ZhzCs1OebY+6eJK8OuW6mPX3GKuRfe0deeIX17FN97qTzZgTO5zdKxjFVE7aKfv3v
 SZGL7gpfk8Vfh11IYYoBANk2yybb22NCGHYtrAwdNRJl5BwNcPj++F5fWHLvPZ1ATEVjGfyd0WJ
 FQ6NBUUWccqqoG+enrRmWzqQEIaq9TxmSU92qBoUhdCA+op3qUUwAQzlYESdyHkbY1/R8ALCYfq
 5gPIS1vNn9w0wi35KYlw0CbuyseNBlRy4jyKZHiXPVj5FfsTS1naNZgsr9P5XFvbWe/GDsjelp5
 NE4R9rzplSetuP8VRdQN84NQVNVNui1IqDMTq3dxu6L2LeN7Dyxremdpaj7Emz9T66r2KUzISZI
 MNiwWS4K
X-Proofpoint-GUID: ll7HZQFJEYyYndPFJ8plf9Y1Ssk4Ka61
X-Proofpoint-ORIG-GUID: ll7HZQFJEYyYndPFJ8plf9Y1Ssk4Ka61
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68b9c0f8 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=z9nD9lg9_nmlpaFE3BIA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019

From: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>

Enable the QCA8081 2.5G Ethernet PHY on port 0. Add MDC and MDIO pin
functions for ethernet0, and enable the internal SGMII/SerDes PHY node.
Additionally, support fetching the MAC address from EEPROM via an nvmem
cell.

Signed-off-by: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 115 ++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 7a85ba044ed4..9abdc8c9f2e9 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -16,6 +16,7 @@ / {
 	compatible = "qcom,lemans-evk", "qcom,qcs9100", "qcom,sa8775p";
 
 	aliases {
+		ethernet0 = &ethernet0;
 		mmc1 = &sdhc;
 		serial0 = &uart10;
 	};
@@ -300,6 +301,94 @@ vreg_l8e: ldo8 {
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
@@ -352,6 +441,10 @@ nvmem-layout {
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
@@ -499,11 +592,33 @@ &sdhc {
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

