Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73260371E9D
	for <linux-mmc@vger.kernel.org>; Tue, 26 Aug 2025 18:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756232503; cv=none; b=Wx3U/GwLPK7odIDKQvpV8s/V6D3qOiknl0lLORFcqOZPIQBwPQqKs/vxxEwGzzAY1bsUBgtyykDfmYEt+zsMF3WQPIpJmP4hRBN19FPdUePefC46uUrfSOB7xlUACkMXz4JAXIC8t8RXVe+HibUYMHBHI9II7I0TVTBI0OPENHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756232503; c=relaxed/simple;
	bh=xOgv7zJjUxTUkuZxadg//0KJhmC8y3VYrXmju+3Ofds=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bKlBgorvSaTbcq63ljbHTVu6kGcwYU4KKID5yGcElkSGs5G+WTySILJLJHfXsJrg7KfCN/rQcjs31/8F2f/nfLDSU9FVwB7uHAS7yH5UpfJawm4x8ItroMc4So29VectiON8SN0o4goTQjVP4ZjvjNTEH121kTLFjkG+9E4zxow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SVIs0grA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SVIs0grA"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QCFVGO021749
	for <linux-mmc@vger.kernel.org>; Tue, 26 Aug 2025 18:21:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FChFkETmwCKzhb04Z4mzU3cThn++D6k4p3IfeMQ223Y=; b=SVIs0grA1OEqiSaZ
	/wE8aQL27Y3g4HuO1/4bxN/BirRhZ4bSACR4j3ZvItyBmtMSKLPZxSSMZ2YE9826
	YSrPQM0cZPZALfz80Bqv+ZtA523eAvZtTC8nXt64BLsoqP1Tvg74SMkbgeMAlbW2
	Ri3TVKfg9Z404GKAEnjFpujEGtecWl0tINTgQxWvPravHMk5ual+MZWrHyI1+aea
	ZkSTglV3MH6g5UY4N1OP4HoM8+zOQKT4+BPjWJCfi+JBVELJ+IfNHvELnW4gfk6g
	UwywKAaB3blf8ePPIH6M9ixTXDiw7yyb92N6Lyz3MY4yVeguubvuGziBSW+Cn951
	06wPkw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5w2t3rk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 26 Aug 2025 18:21:40 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76e2eb6d2baso11166664b3a.3
        for <linux-mmc@vger.kernel.org>; Tue, 26 Aug 2025 11:21:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756232499; x=1756837299;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FChFkETmwCKzhb04Z4mzU3cThn++D6k4p3IfeMQ223Y=;
        b=pCUeGmhEpj5DIrWd+E2xNB9oyHRzZHu4tno1C8A/l/2BFPqCEEObnpCNU7pmhdz3SI
         kh5LyCxvJkDvDK/JwS5LEmUUoyEVSKqyKxnsgQkzyrqCh00IFi8CdJCK8WCS2+jTgfVE
         +Dxe8Fl9WWBymOVJZHbMBeJMs+vuYpFQILlLrmy4nOgMV+H8UvKsuGLUIsew1dw2uQKX
         MtclnOZENK9GxIK4dJxFtQU+DAIvuAft700aGFK1vqvXaFR60U/naZ7DKEoTOlw2oUuY
         HOVHVk6sPj4rgy9FBR4UGlgjNPVOjJYx8LOCOJMEH9BdVVwz01jNpOz8lJSY5lIrKGng
         Wbzg==
X-Forwarded-Encrypted: i=1; AJvYcCXLB/ON6+RfwHLV4Gc6A+dXlz0JqMQf5njoux1ns1JFUQ3WSqwjBVrxyLvlfBkk7KIDK81MYBIC2f8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2BDCsOSCDvAoABvg5TfjeXuao0Weop53ysgZEywScqDdeoPrJ
	yh5+fLYKt8OtokuxHp7RD6DT+2jXk0EzMMYBCDmMq+j90M5MfgXkV+YhbcaskqZS6URp47LizX8
	FtF5LpELWfTanf3qEZf39Tjv5yo0D2M2M5p75Z1F8SrTFgG0ztgfckE4HpoYbr+c=
X-Gm-Gg: ASbGncuwRi2YiXGevHzLaZQudiKT/++qxai7vOd1MzUF4U1wdVkCaQPie8wYwG2+2Ly
	A+TumRJSdRsiJEds9XtSAgucziOzfH85XgJ+LlVPnw6YgoZaQePRISe0wy3g3awXJVCqZXpCqtq
	krbHK/LH6r8QRix4bZ+AL+fTXxkdfleV/wcjz/B4b6mUwdCpBGy7rWbCKomdBlwLBjHP73KnDUc
	gwQKGltFIOOa4jG1irHH543Lj9ozSDpgSqp2K1hB7KyR+P/WG0v3KcqabJdDykqAXU+uZi7mkR4
	HjraUaVNBpnH1cdbDepfUb13bE2JzPTMdWyCjnHMCXEKlKgKqWGmZKbS1QftU2QO6TDo
X-Received: by 2002:a05:6a20:938e:b0:243:15b9:7662 with SMTP id adf61e73a8af0-24340d6e2d0mr23095145637.60.1756232499249;
        Tue, 26 Aug 2025 11:21:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqTO7Pu0wOsLUCAduferZquK+24b2fZ5cpErQjBpKf3mge15QU2OPVpb0Li9cR7UXqWFEfvg==
X-Received: by 2002:a05:6a20:938e:b0:243:15b9:7662 with SMTP id adf61e73a8af0-24340d6e2d0mr23095093637.60.1756232498783;
        Tue, 26 Aug 2025 11:21:38 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77048989fe6sm9881803b3a.51.2025.08.26.11.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 11:21:38 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Tue, 26 Aug 2025 23:51:02 +0530
Subject: [PATCH 3/5] arm64: dts: qcom: lemans-evk: Extend peripheral and
 subsystem support
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-lemans-evk-bu-v1-3-08016e0d3ce5@oss.qualcomm.com>
References: <20250826-lemans-evk-bu-v1-0-08016e0d3ce5@oss.qualcomm.com>
In-Reply-To: <20250826-lemans-evk-bu-v1-0-08016e0d3ce5@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Sushrut Shree Trivedi <quic_sushruts@quicinc.com>,
        Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Monish Chunara <quic_mchunara@quicinc.com>,
        Vishal Kumar Pal <quic_vispal@quicinc.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756232476; l=10592;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=xOgv7zJjUxTUkuZxadg//0KJhmC8y3VYrXmju+3Ofds=;
 b=ZBDUOyKj72T2Epo88S7kxV1KbaHgLdo80+cqZfVrLUo7IRmBJSaI6wh3yfUQUbfHGP+/THE1/
 GaFh2EtgzPZB6wOLZVWOPNtP8MYLDFtVbOd7EvUaPktuJ1V1HEctrgE
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Authority-Analysis: v=2.4 cv=Z/vsHGRA c=1 sm=1 tr=0 ts=68adfb34 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=fhKFeyVKGdTqEzYY0RYA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfXzCREhBLTEDXg
 owWUAgw8DTIpaK2WK9tcNjd1AjJ5S80ZcwNKyOBoXLwA6ppVvlT3Uw8GuRtJmL7A6HhvxxGpYLF
 JK0rPLx7SbEbvxh6L+hK6gi9C9u+kHFiFTcqFl2CxUOZwUNZVT37psA/uVIZdR4imRXch4pj8Uo
 g1Mcbz81dpNJq2n9AN5NdfMsYQge+8qD9/p7JXDhrS+hS+UwuQXHIJ1P3Y1uCfC5PNFgaor5d+T
 inH2KEaGaGe1JDvEh6FrQ3WTG/W9aGT+SWs6s1uXVFs0WXJa/g2vXVEKh2UiranVNqZ3GCOq91r
 DSY33mxkvPagsBCGiiPJoASdg3yZksEKFpvFw5Z5d8ZMYkx9vxB1csAVupDS4tIthzSokSUIOF2
 QNignh6h
X-Proofpoint-GUID: 5BdMeiW-Y0JgmW_IBqerYUoWtVdZRaL3
X-Proofpoint-ORIG-GUID: 5BdMeiW-Y0JgmW_IBqerYUoWtVdZRaL3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

Enhance the Qualcomm Lemans EVK board file to support essential
peripherals and improve overall hardware capabilities, as
outlined below:
  - Enable GPI (Generic Peripheral Interface) DMA-0/1/2 and QUPv3-0/2
    controllers to facilitate DMA and peripheral communication.
  - Add support for PCIe-0/1, including required regulators and PHYs,
    to enable high-speed external device connectivity.
  - Integrate the TCA9534 I/O expander via I2C to provide 8 additional
    GPIO lines for extended I/O functionality.
  - Enable the USB0 controller in device mode to support USB peripheral
    operations.
  - Activate remoteproc subsystems for supported DSPs such as Audio DSP,
    Compute DSP-0/1 and Generic DSP-0/1, along with their corresponding
    firmware.
  - Configure nvmem-layout on the I2C EEPROM to store data for Ethernet
    and other consumers.
  - Enable the QCA8081 2.5G Ethernet PHY on port-0 and expose the
    Ethernet MAC address via nvmem for network configuration.
    It depends on CONFIG_QCA808X_PHY to use QCA8081 PHY.
  - Add support for the Iris video decoder, including the required
    firmware, to enable video decoding capabilities.
  - Enable SD-card slot on SDHC.

Co-developed-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Co-developed-by: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
Signed-off-by: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
Co-developed-by: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
Signed-off-by: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
Co-developed-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Co-developed-by: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>
Signed-off-by: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>
Co-developed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
Co-developed-by: Monish Chunara <quic_mchunara@quicinc.com>
Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
Co-developed-by: Vishal Kumar Pal <quic_vispal@quicinc.com>
Signed-off-by: Vishal Kumar Pal <quic_vispal@quicinc.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 387 ++++++++++++++++++++++++++++++++
 1 file changed, 387 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 9e415012140b..642b66c4ad1e 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -16,7 +16,10 @@ / {
 	compatible = "qcom,lemans-evk", "qcom,qcs9100", "qcom,sa8775p";
 
 	aliases {
+		ethernet0 = &ethernet0;
+		mmc1 = &sdhc;
 		serial0 = &uart10;
+		serial1 = &uart17;
 	};
 
 	chosen {
@@ -46,6 +49,30 @@ edp1_connector_in: endpoint {
 			};
 		};
 	};
+
+	vmmc_sdc: regulator-vmmc-sdc {
+		compatible = "regulator-fixed";
+		regulator-name = "vmmc_sdc";
+
+		regulator-min-microvolt = <2950000>;
+		regulator-max-microvolt = <2950000>;
+	};
+
+	vreg_sdc: regulator-vreg-sdc {
+		compatible = "regulator-gpio";
+
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <2950000>;
+		regulator-name = "vreg_sdc";
+		regulator-type = "voltage";
+
+		startup-delay-us = <100>;
+
+		gpios = <&expander1 7 GPIO_ACTIVE_HIGH>;
+
+		states = <1800000 0x1
+			  2950000 0x0>;
+	};
 };
 
 &apps_rsc {
@@ -277,6 +304,161 @@ vreg_l8e: ldo8 {
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
+	snps,ps-speed = <1000>;
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
+&gpi_dma0 {
+	status = "okay";
+};
+
+&gpi_dma1 {
+	status = "okay";
+};
+
+&gpi_dma2 {
+	status = "okay";
+};
+
+&i2c18 {
+	status = "okay";
+
+	expander0: pca953x@38 {
+		compatible = "ti,tca9538";
+		#gpio-cells = <2>;
+		gpio-controller;
+		reg = <0x38>;
+	};
+
+	expander1: pca953x@39 {
+		compatible = "ti,tca9538";
+		#gpio-cells = <2>;
+		gpio-controller;
+		reg = <0x39>;
+	};
+
+	expander2: pca953x@3a {
+		compatible = "ti,tca9538";
+		#gpio-cells = <2>;
+		gpio-controller;
+		reg = <0x3a>;
+	};
+
+	expander3: pca953x@3b {
+		compatible = "ti,tca9538";
+		#gpio-cells = <2>;
+		gpio-controller;
+		reg = <0x3b>;
+	};
+
+	eeprom@50 {
+		compatible = "atmel,24c256";
+		reg = <0x50>;
+		pagesize = <64>;
+
+		nvmem-layout {
+			compatible = "fixed-layout";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			mac_addr0: mac-addr@0 {
+				reg = <0x0 0x6>;
+			};
+		};
+	};
+};
+
+&iris {
+	firmware-name = "qcom/vpu/vpu30_p4_s6.mbn";
+
+	status = "okay";
+};
+
 &mdss0 {
 	status = "okay";
 };
@@ -323,14 +505,196 @@ &mdss0_dp1_phy {
 	status = "okay";
 };
 
+&pcie0 {
+	perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 0 GPIO_ACTIVE_HIGH>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie0_default_state>;
+
+	status = "okay";
+};
+
+&pcie0_phy {
+	vdda-phy-supply = <&vreg_l5a>;
+	vdda-pll-supply = <&vreg_l1c>;
+
+	status = "okay";
+};
+
+&pcie1 {
+	perst-gpios = <&tlmm 4 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 5 GPIO_ACTIVE_HIGH>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie1_default_state>;
+
+	status = "okay";
+};
+
+&pcie1_phy {
+	vdda-phy-supply = <&vreg_l5a>;
+	vdda-pll-supply = <&vreg_l1c>;
+
+	status = "okay";
+};
+
+&qupv3_id_0 {
+	status = "okay";
+};
+
 &qupv3_id_1 {
 	status = "okay";
 };
 
+&qupv3_id_2 {
+	status = "okay";
+};
+
+&remoteproc_adsp {
+	firmware-name = "qcom/sa8775p/adsp.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_cdsp0 {
+	firmware-name = "qcom/sa8775p/cdsp0.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_cdsp1 {
+	firmware-name = "qcom/sa8775p/cdsp1.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_gpdsp0 {
+	firmware-name = "qcom/sa8775p/gpdsp0.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_gpdsp1 {
+	firmware-name = "qcom/sa8775p/gpdsp1.mbn";
+
+	status = "okay";
+};
+
+&sdhc {
+	vmmc-supply = <&vmmc_sdc>;
+	vqmmc-supply = <&vreg_sdc>;
+
+	pinctrl-0 = <&sdc_default>, <&sd_cd>;
+	pinctrl-1 = <&sdc_sleep>, <&sd_cd>;
+	pinctrl-names = "default", "sleep";
+
+	power-domains = <&rpmhpd SA8775P_CX>;
+	operating-points-v2 = <&sdhc_opp_table>;
+
+	cd-gpios = <&tlmm 36 GPIO_ACTIVE_LOW>;
+
+	status = "okay";
+
+	sdhc_opp_table: opp-table {
+		compatible = "operating-points-v2";
+
+		opp-100000000 {
+			opp-hz = /bits/ 64 <100000000>;
+			required-opps = <&rpmhpd_opp_low_svs>;
+			opp-peak-kBps = <1800000 400000>;
+			opp-avg-kBps = <100000 0>;
+		};
+
+		opp-384000000 {
+			opp-hz = /bits/ 64 <384000000>;
+			required-opps = <&rpmhpd_opp_nom>;
+			opp-peak-kBps = <5400000 1600000>;
+			opp-avg-kBps = <390000 0>;
+		};
+	};
+};
+
+&serdes0 {
+	phy-supply = <&vreg_l5a>;
+
+	status = "okay";
+};
+
 &sleep_clk {
 	clock-frequency = <32768>;
 };
 
+&tlmm {
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
+	pcie0_default_state: pcie0-default-state {
+		clkreq-pins {
+			pins = "gpio1";
+			function = "pcie0_clkreq";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		perst-pins {
+			pins = "gpio2";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+
+		wake-pins {
+			pins = "gpio0";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+
+	pcie1_default_state: pcie1-default-state {
+		clkreq-pins {
+			pins = "gpio3";
+			function = "pcie1_clkreq";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		perst-pins {
+			pins = "gpio4";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+
+		wake-pins {
+			pins = "gpio5";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+
+	sd_cd: sd-cd-state {
+		pins = "gpio36";
+		function = "gpio";
+		bias-pull-up;
+	};
+};
+
 &uart10 {
 	compatible = "qcom,geni-debug-uart";
 	pinctrl-0 = <&qup_uart10_default>;
@@ -356,6 +720,29 @@ &ufs_mem_phy {
 	status = "okay";
 };
 
+&usb_0 {
+	status = "okay";
+};
+
+&usb_0_dwc3 {
+	dr_mode = "peripheral";
+};
+
+&usb_0_hsphy {
+	vdda-pll-supply = <&vreg_l7a>;
+	vdda18-supply = <&vreg_l6c>;
+	vdda33-supply = <&vreg_l9a>;
+
+	status = "okay";
+};
+
+&usb_0_qmpphy {
+	vdda-phy-supply = <&vreg_l1c>;
+	vdda-pll-supply = <&vreg_l7a>;
+
+	status = "okay";
+};
+
 &xo_board_clk {
 	clock-frequency = <38400000>;
 };

-- 
2.51.0

