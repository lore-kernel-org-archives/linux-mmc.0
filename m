Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7DF36CE16
	for <linux-mmc@vger.kernel.org>; Tue, 26 Aug 2025 18:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756232496; cv=none; b=XeIFZamZGq5D5TutIEA8TARlBIourYv5DzX5h5Cwtzk/xydnfpsU7s8yzvf8Gn59IDc02lZILtolHfhgk5mDSj4EuhedXf+O5XUnDf8m/kZDphh+u4IR3KycSwF4cuktoYWBmcAzpessMGQ+5VYF+zbO8BFdrtRrpr+aBdYn0p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756232496; c=relaxed/simple;
	bh=yWU3RivgQn3vbJTn8CogrNAVBOPhegI+Ts8EdEZi0XI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lSHBYGQUkfwCu2GmK8N5Izgmj2E+w//gjHRaS8eECDaO96/9JLTBInn4SJ0D8HhC1bmk7nYCpDXX1gQrTJOFiSu/tBQfG/H9rdOTcOd4DN9pZTmNV2wUM/debl7wNTowV7/vm429h7Tx0a7jcb5+H2wrVLQP0VPUHIT9reysHKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Lf+PO+xz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Lf+PO+xz"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QHLD5j027963
	for <linux-mmc@vger.kernel.org>; Tue, 26 Aug 2025 18:21:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6CWFtNYNaEgVqp01nisBqI7axE8gNr8sIPVugGWzaME=; b=Lf+PO+xzGKPfzJFi
	7wWVc/PwJkmE0azfNCuH3VXJvUSsnPRJlaAeeasS7PmZDeziIc8XwiulcLkpDSeO
	SQAMsan7QFLQ0TZNM9e+GQIFyreu9GNZwsEeUm8KrLF7KLG0nUJQtP2IOouN5F/V
	gNKZPV8UGa18DaOCC+kWBZsM9el7G234PbZtqWEDcT0vN7CQYnYPfapQo/PHN/L+
	Eb20Ibk8za1wA/k7RcICwJPy6RRjDBpI/uTrsf5oXgxoOtaQBVaBuqVt6K70E92x
	kDJ4Oa4yFo8bnU+4KRMOJIOqiL1k7YW5KaWE+8DGmdENqlOUrZ4CgDvetzlH2C1Z
	0brUBA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48sh8ag6bh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 26 Aug 2025 18:21:33 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-325228e9c12so148140a91.1
        for <linux-mmc@vger.kernel.org>; Tue, 26 Aug 2025 11:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756232493; x=1756837293;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6CWFtNYNaEgVqp01nisBqI7axE8gNr8sIPVugGWzaME=;
        b=Y9bGxmZpFwDQaNt7Y/4/UaFPU0AiAeueDn+MHZHT6V4kxIVIPadqq/a/WZZmHd7ms1
         t3UpZu4pLyAm1r3MDrHnUJhwVRKG+Dy5/VVmJD369KkjlgI0tqev61SZ2U1pki4lpmol
         HoIMbG8QfGL13PomyP7jny7gJgJk9HdRJj6p2s1oaY5560vtXkwZZ2++KTDSAfXan1A+
         BMzX+a7nr/bF5n+bf4ISh+8DLDmQFmmdjYGzQlNtrRx4rrP+VYqTZ+jvJTsfvMFuUt0+
         sjdBolA6czLFzqUxpIGKLzqv5i+95EI+SCFRUFYbTRpZiAuHRPR5lG4ROiPG9A0oXwyo
         igrA==
X-Forwarded-Encrypted: i=1; AJvYcCUNhBHL7mgrHIV4861s9M6TcHwReeUtMMtfhVf6+BE4XPaeInoTnkwvrLVkPEWLeOBr23OA64AR3LQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIVHDVRDh4Zoieu1u04aag/bfmfyMU6iMLOfTVzBhs1STYUu6f
	8gmsoQM2ll7JPi8pQgwQLBfN7LXyg6zAFVEJZ/ChMnE4k7Xh86iMfZ8tWPkVMZyuORFWIGpGAtF
	p51wK7p4xMjJVDeNjsqvs6wcz2XO5mCghyQrBMonGQjzFgjZGPjyy8CjiFPlzgKI=
X-Gm-Gg: ASbGncvZzXiq58UWtdvHUYIJMEf6/izkKHzcScP9yICqewm/hWUWGacQFUYV6lFiU1Z
	fjB1PVIQSWdmQvl23jD2mKn5N38Enl9zHpfIxmFd+O+eebaOPIrJtK0TCf5YqZ9D74PpAD+i3HE
	NSF9MCD4x8bSYPaAmt33EI8xHaXvoDerBWNIwquYxFVhNWxJ2qYNVE9iX+Deat68Wo7GwhMJW8B
	MoumALfRLLNtY1ryxg1wyDMbuDIxqtiNjUxSJXRcudv1lb42UkOD0SBc8drnaxfJ3ovkBw6Lenx
	wem2Tn7Wfd6njzq2Iz8DoRSNLwnYNajTa1ZcicDu26ni3qkyAjYoQT1ZUjrEgQ2hxlVP
X-Received: by 2002:a17:90b:2cc6:b0:321:90c0:bc62 with SMTP id 98e67ed59e1d1-3275085dcd2mr3198423a91.5.1756232492929;
        Tue, 26 Aug 2025 11:21:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFr2OB2Tzya7V5bOJicBL0B3wirSQbAL+ZfTDUgv6121Z8M/mZAZO+9N9e/6vhBkZJkKiqf8Q==
X-Received: by 2002:a17:90b:2cc6:b0:321:90c0:bc62 with SMTP id 98e67ed59e1d1-3275085dcd2mr3198388a91.5.1756232492459;
        Tue, 26 Aug 2025 11:21:32 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77048989fe6sm9881803b3a.51.2025.08.26.11.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 11:21:32 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Tue, 26 Aug 2025 23:51:01 +0530
Subject: [PATCH 2/5] arm64: dts: qcom: lemans: Add SDHC controller and SDC
 pin configuration
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-lemans-evk-bu-v1-2-08016e0d3ce5@oss.qualcomm.com>
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
        Monish Chunara <quic_mchunara@quicinc.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756232476; l=2794;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=BtvHt3RnBFKrwdg4LW9eLBm4zcqkJ/W0U6ZHK95NmLk=;
 b=is7dhE0oGK+/vxF2srT20lK72sY+++kGuxaIMDfm2xKpK5ci5glE4cqppah1S+Kb1/g1UkIgf
 uvQfthfE2pOBAvKfAOfsHGCfuWNXLH5oy/Kc2mNDuK+ZCOlPxmGhK74
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Authority-Analysis: v=2.4 cv=cLDgskeN c=1 sm=1 tr=0 ts=68adfb2d cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=-whTAWJFRCiZhxz9DBYA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDE1MyBTYWx0ZWRfXyQlhQ1vbAZO1
 Te2F1+4Gb9qB20OI9Ixl2QKE2/yYI/z9H2olBQRDVCZr/xNDhHZIVzpc0ISmwtnEKJQEzJJpjPh
 W9QiYM7F8DAVLRe2vSVPa0VAziRyxRldB3ORB3m0YVrOH8KvIqi8A4vzDKSIBgTptS5hx8S72i3
 aD7zInOAzOMiyG2fG5l3tMu3NdFmoUK0Pgls63QjY1+QmIn1xpmCPPWeEzqjjOdvSAuxzXDl0E5
 Dyi9BB0cgFBpEs/vztkad3pDC3DQswghvEmfKXMyqb3LGX7JU7bjqyXTEvFquk4ExxBQovxmdVb
 fHYptf3r99Dl6ilV/S2muZLZjL1RT3NCgJiGddP0acGJeF8l8hgafDeG2Vam0UPAg3LvjocvoTh
 X+BVjto/
X-Proofpoint-GUID: pqYa4TpAGis-TfGF665FIGX9zsGW4_nC
X-Proofpoint-ORIG-GUID: pqYa4TpAGis-TfGF665FIGX9zsGW4_nC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 malwarescore=0 spamscore=0 adultscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508260153

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
 arch/arm64/boot/dts/qcom/lemans.dtsi | 70 ++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index 99a566b42ef2..a5a3cdba47f3 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -3834,6 +3834,36 @@ apss_tpdm2_out: endpoint {
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
+			iommus = <&apps_smmu 0x0 0x0>;
+			dma-coherent;
+
+			resets = <&gcc GCC_SDCC1_BCR>;
+
+			no-sdio;
+			no-mmc;
+			bus-width = <4>;
+			qcom,dll-config = <0x0007642c>;
+			qcom,ddr-config = <0x80040868>;
+
+			status = "disabled";
+		};
+
 		usb_0_hsphy: phy@88e4000 {
 			compatible = "qcom,sa8775p-usb-hs-phy",
 				     "qcom,usb-snps-hs-5nm-phy";
@@ -5643,6 +5673,46 @@ qup_uart21_rx: qup-uart21-rx-pins {
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

