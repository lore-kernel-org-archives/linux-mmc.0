Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B808F1DE4FB
	for <linux-mmc@vger.kernel.org>; Tue,  7 Oct 2025 05:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759815917; cv=none; b=k1eSVW7f3s0wN7hVZASXWOXQ9XM+UEUm2kH2RGvZp2UggIPY8RUNDXbpsXwFZQxPbjSVPtuusby6Ows7P5HuyKK94U9sGXUirP8SXlfVQ5BFnkKYTjFQSy35fsXsdhKHivHUwIziJ1XNtvkyWnqpvnMDEVeqrE55WHfcHI7PIbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759815917; c=relaxed/simple;
	bh=bQ7elM7f5BL1Lifxhw5fuJsFELFQKaeSC0XXu2tQuYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HnMKFXc0wHi1IX6vVeNt0tWMbaBO98ChepXsDC4sgwGRybDzbmVcLjUUURhPojIntExwP0knWlfA3m7owhsstyf9Vi+C/kmTjTB1Re6dMxqFJOQk9dTTjJnGvNYEDmR4REOrt6n91Q4AAv0Ri/qGifnCKdYOZdRyaTxFMZAlzT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bq9XKxKW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bq9XKxKW"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5972s78I000300
	for <linux-mmc@vger.kernel.org>; Tue, 7 Oct 2025 05:45:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=MMhRpxaDY07
	1Od8E3CVtmEeDDOJ5yH67ZSz1WszGtF4=; b=bq9XKxKWCjKSbKImhp5r9pbnR9j
	FLH0kQuZM2L9CUPFYs4AfauoP6Tj55Q4hiDuIXg0BTJTQ5tz3H+bnNieYFWFBt9L
	sk1f1m0VdgQrT/soBFautmrmv4ldTICXbzPOdRq67+Q8bhBewWPhPhu9dHNTxQJG
	yN9v8+H8ZQtJDDLCuF+bIcDX+IxRzN7lkgy8OxArapUAUCgSTKIlFs6ieZKxtTHF
	O9WcNkRSXBpCBIrHSWa0kXAvIRy4JOzzcoZ7itaRNePVCowADvEcTn0Te/rUo9FZ
	kSRF7yJeXSEHft3D6RrGKM0fT6UTGq7DoVm5WEdaDbxZuytduUJUbDEOHfQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jut1p3ed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 07 Oct 2025 05:45:14 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-33085284badso1104353a91.1
        for <linux-mmc@vger.kernel.org>; Mon, 06 Oct 2025 22:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759815914; x=1760420714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MMhRpxaDY071Od8E3CVtmEeDDOJ5yH67ZSz1WszGtF4=;
        b=dwf67+H4RFZc1BfeEwMNLbVpS0StHO0QSq1Dm/YOthQ9ojU85lMLix0anvU1YMaAdl
         echHRo3Eo5Bnu/Z+02UKjTAyzfBI6XdN+v9dpPDq/n/axIzikilptMW8bcvz8J8rXMcL
         zN/pqryUAGtJe4+j5vuS/L0DkSVeN0NO5MbklGLNcrORCl7Hd5RVWCDjil2YyPeZDntC
         JFDG042QvPw6P3aOS2wj+GpXO8Pibss2WvD8XFhjHlEplUcHmAslGIGZgANsmzHQvQCZ
         NIBP+canJTMA4yYOKtGqfiboy95h29Tbr7dWHWeNx2arD+F/N1u4AUiJUby6yRKak7W/
         OmqA==
X-Gm-Message-State: AOJu0YxA9MyiuMZQwpi8nVDbeKoUAr+VbhPBWa5e+JXUDGSjyfjc/RzD
	M5fHdq+RHnXFjvQosVa/jX+9BJb1OsYLUBb4h+i0dPdojIOqKFaOdM21brwruXGFXgmWaHgC0ka
	Ls2M55mdBSaXgCvnWKjN5vQVkWR4LpIO04TMD9X/b3mmxvPPj8T9ZGzAZ80g3hw==
X-Gm-Gg: ASbGncvsXSLj3swJMsbwwE5PnZrkhll7KIOXLORFCBxs0BjqTURjRipii0cLoG29xgj
	8AhxRdiyWahdlk7voeXQ7F96EUH1wIvB4YS9Dvp5R+Kju47pG5d7N4u20trg18Kg6RSLadtiNLM
	7ARlTswex4V3Qzce85ryJiqxjTbK1KDC+AL3V+Gsi/UeCF/Nmrjn6n2DMFU86X/sVKTqGFKPX4V
	6lcJcHTWhrReYe2CM5fDITHllNL5WgY9R584ec//rEOy2b9M4FCFd+gw97dqxO9ucLdzaENdgvb
	vUYNl3wxBsEE4wrDZLZ3Mr3zBNgbcFmecqvvEKv7q/8zKtd1q5FgAFQaEYYVu25I0nv1eCqRJwF
	E
X-Received: by 2002:a17:90b:3b8d:b0:339:efa3:e099 with SMTP id 98e67ed59e1d1-339efa3e3dcmr842444a91.6.1759815913985;
        Mon, 06 Oct 2025 22:45:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEI88usWGiFCUosEbxk8+Vn9Li4jjEysOSm/+1UFh9yCY+hNAK+X5JXiib5yPF7jP3Awp20Qg==
X-Received: by 2002:a17:90b:3b8d:b0:339:efa3:e099 with SMTP id 98e67ed59e1d1-339efa3e3dcmr842415a91.6.1759815913464;
        Mon, 06 Oct 2025 22:45:13 -0700 (PDT)
Received: from hu-sartgarg-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339ee976b81sm502624a91.6.2025.10.06.22.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 22:45:12 -0700 (PDT)
From: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_nguyenb@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sayalil@quicinc.com,
        quic_nitirawa@quicinc.com, quic_bhaskarv@quicinc.com,
        kernel@oss.qualcomm.com, Sarthak Garg <sarthak.garg@oss.qualcomm.com>
Subject: [PATCH V1 2/3] arm64: dts: qcom: sm8750: Add SDC2 nodes for sm8750 soc
Date: Tue,  7 Oct 2025 11:14:44 +0530
Message-Id: <20251007054445.4096630-3-sarthak.garg@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251007054445.4096630-1-sarthak.garg@oss.qualcomm.com>
References: <20251007054445.4096630-1-sarthak.garg@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: sMD6TF5PO2Oq4_S5RCHffoiV6EMSTjKL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyNyBTYWx0ZWRfX4eMYB2aNI7qG
 3PK15aZnN9Mml9qyVy9wQTyWbgGwpKYdvMbQM5G+OphmaTkshK/s4epqIqj8BHklVNKySN3E/6P
 zBZoTQQfekgytCSJQhVAw5mfbVj9xpY01Po5LVGDOB/IP0H8WdSszndxEWMjMoo7SdF7KF9uHhg
 8lP0Zj8UMfVvt6iyzN1zARz68jZc8WBL/uZ9ic1t8o36wOGQPvqNTn8jx+F6V0I6IC3Di8CdiSI
 cd2Ny+5H3A+AkYKxeK4WWCicPdQiih9puf+oL+aN5Ak54h5BtgLwh2jWCZh/oBZtfiBd7s6TbCk
 oBF59a9cXgYMwAyvArTcbQOlXcf9+39aj/62ip7e7S0jepiw4cZMmEo6LRiaUTOKgKobMT58Zb7
 kWAI0OH27Uuwh5Y4Jp6KQpWYYc47Cg==
X-Authority-Analysis: v=2.4 cv=Vqcuwu2n c=1 sm=1 tr=0 ts=68e4a8eb cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=AsSGxY1rZHGoL8xKvT8A:9
 a=SDuTNzKu6uzCYS2L:21 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: sMD6TF5PO2Oq4_S5RCHffoiV6EMSTjKL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040027

Add SD Card host controller for sm8750 soc.

Signed-off-by: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8750.dtsi | 63 ++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
index a82d9867c7cb..dce70443f719 100644
--- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
@@ -2060,6 +2060,55 @@ ice: crypto@1d88000 {
 			clocks = <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
 		};
 
+		sdhc_2: mmc@8804000 {
+			compatible = "qcom,sm8750-sdhci", "qcom,sdhci-msm-v5";
+			reg = <0 0x08804000 0 0x1000>;
+
+			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq", "pwr_irq";
+
+			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
+				<&gcc GCC_SDCC2_APPS_CLK>,
+				<&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "iface", "core", "xo";
+
+			interconnects = <&aggre2_noc MASTER_SDCC_2 QCOM_ICC_TAG_ALWAYS
+					&mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					&config_noc SLAVE_SDCC_2 QCOM_ICC_TAG_ACTIVE_ONLY>;
+			interconnect-names = "sdhc-ddr", "cpu-sdhc";
+
+			power-domains = <&rpmhpd RPMHPD_CX>;
+			operating-points-v2 = <&sdhc2_opp_table>;
+
+			qcom,dll-config = <0x0007442c>;
+			qcom,ddr-config = <0x80040868>;
+
+			iommus = <&apps_smmu 0x540 0x0>;
+			dma-coherent;
+
+			bus-width = <4>;
+			max-sd-hs-hz = <37500000>;
+
+			resets = <&gcc GCC_SDCC2_BCR>;
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
+					required-opps = <&rpmhpd_opp_nom>;
+				};
+			};
+		};
+
 		cryptobam: dma-controller@1dc4000 {
 			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
 			reg = <0x0 0x01dc4000 0x0 0x28000>;
@@ -3121,6 +3170,13 @@ data-pins {
 					drive-strength = <2>;
 					bias-pull-up;
 				};
+
+				card-detect-pins {
+					pins = "gpio55";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
 			};
 
 			sdc2_default: sdc2-default-state {
@@ -3141,6 +3197,13 @@ data-pins {
 					drive-strength = <10>;
 					bias-pull-up;
 				};
+
+				card-detect-pins {
+					pins = "gpio55";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
 			};
 		};
 
-- 
2.34.1

