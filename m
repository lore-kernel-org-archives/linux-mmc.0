Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66B730748C
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 10:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758019674; cv=none; b=vDTUzz9dI/SZAeE/x610MRX+aRCTUyWYffgSvUd4XIabwLQASLbP7lYZpTQrjWIK2y+Ts7YAT2lDq7/LxAtbRMSS5WSfwcTgxK7ux1KfJ8/A1/hABqWsLcmJk89ZMIQn4YntMtutcEWscilKhP40BOp0JK0+rWLg+K9ZdWSZdSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758019674; c=relaxed/simple;
	bh=H8QwqcbzikZ9doV2z6v5RmxCk7YJMt4fL77bDu5hjC4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bOa8LK/zEJQ4ZnMbWaUMeUWAIgbI968OxFJrhBLHKXdOW6IwXMpmIOPbvukWrdaaEeBOnF/cFfRhJGdFtCyRglQ522Xh/TQzp7eP154mE2tS39xS+7ILdHcnPHEzcYRf6QVgemrHSIhHDfebC3eqDM5JKPrcUES17XgIlF9lQFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DtnSm9pv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DtnSm9pv"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GA9hgc004797
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 10:47:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kbefT7A0C0BpxFO4WkUOl6TDFSMTNVjZvsErL/F9ONQ=; b=DtnSm9pvgWiQaAgX
	3K70hc1rDLKo1yBqk55BKr+e7FPZOkbS3mu10faweF5kiRtBkIQaL/5v0Xr/vYvY
	MpYNKnvzcCH6eeyHAzAfRrQjYtP9xk1SWt8huUOtzfWxsdMLxwcXH4v4QItCsn6s
	6APTKSjBlw8fdG8j2SeyTPj8T/yEOzi2QQYxEpjTtPO41K8PtLH5gZUPDuTwasgJ
	uQ/nPudEl+jdcc/YAZzX7IMeWzOFwJuuAn5rmnjqUoB87QOwOZON8k77jclrimw2
	uBK/o5VqfbKexHnMj4FYy1NequU8Nonunk841yre69sJfLC2bTOiiUdIiJYeRkmQ
	qjiaGA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494wyr8udt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 10:47:51 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2659a7488a2so43535105ad.3
        for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 03:47:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758019671; x=1758624471;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kbefT7A0C0BpxFO4WkUOl6TDFSMTNVjZvsErL/F9ONQ=;
        b=PiR0SxPEgM9XkdzK3AWujNV6DTPefthu4ZjCzti3I+YU8imo4qeGt+l6VqHRD+aHB2
         FeMeEUGvl9sz8UpRwdV0WnCHE8hE5nUEjGcd5ADsU0/CwTcPmKqfBOxucHIXytFBFlGL
         4Sgm3sPiKhqSfVsvAJZ2NS+6AzwiDYycjMOWmrQ56948vkVGYeJelnIM9pNAkbWYcQj0
         BZl17gxLo0kO4xzyh0niozMXwjMIEPPmRDSBq+HgEfvl9LqVaKb8EnEvbbozVvZjH8z2
         ptZcSc3rv08zc9U7w1cFJftfPT/8LgXHAtDbXvZ3b2ymVoE+Z6TIOMfLEJZNjWf8haA9
         /syQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGrYbNIFrMIyDCCMgYO2X8RTnFB3/cW4WeZ8I411HgCM+SnE2pRdkfRIpCFs0fqqNralmEJxmVKTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrwwdfoDmOmPN/9JGK+65KaxbVrhceGaV6o5vvkB/hNxt+IM0K
	q2hP8gIjcoLwVSJe/brO9TIlh6j55qdNa7LHOsrMInUzYK5axLUgCkP1u8BhMm7Gq6DWkG9rfj9
	XGjCEVNhiDCptCvigNBoYUJz+gb0fpdi6EbFsViTIEVD0GnHFmePD2o6twc8/FxE=
X-Gm-Gg: ASbGnctpxUzWfsHoB+nUgVuM5/1YOlb/zHmV4+myDw9K3t8Anm0A3fBGFAkZmAaUHYs
	KK1JoFdd/QWJGV5cAdpAQh/SKI2HWwu3arU+1eWO1aZ49N4LyA9MGsTDrcTI3XXNk3ZthV/IiJ8
	/ooVnCBqo70dWnrrTeCr4cRoBfFqDPEvniRuE/2Qbe41W4iOMY9k0dyAHIZ6ArOj3cZ2GA3S1Lj
	oB4pSCYrSMTEfUck1CGn1O/qn0MmCfuPqIRmC6fH2JEG2bRi+C6t+CLG91iEmymamu3c7vrrruq
	Y2f5AIDrh7wUjHiQm8Pzm0gokRY/UiY9E2I/Al0Y52lLWZYF5TDRq1cho71EBsa8Q48R
X-Received: by 2002:a17:902:ccca:b0:25d:f26d:3b9e with SMTP id d9443c01a7336-25df26d3c13mr191532325ad.11.1758019670592;
        Tue, 16 Sep 2025 03:47:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIwlPFkFrF0A23fYEzT2xF+R+svZM56yfsGO8ZANDLvL6HFROJPYSPUG1fzKuQzM3uWNZfCg==
X-Received: by 2002:a17:902:ccca:b0:25d:f26d:3b9e with SMTP id d9443c01a7336-25df26d3c13mr191531955ad.11.1758019670152;
        Tue, 16 Sep 2025 03:47:50 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267b2246d32sm33122355ad.143.2025.09.16.03.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 03:47:49 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 16:16:57 +0530
Subject: [PATCH v5 09/10] arm64: dts: qcom: lemans-evk: Enable SDHCI for SD
 Card
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-lemans-evk-bu-v5-9-53d7d206669d@oss.qualcomm.com>
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
        linux-i2c@vger.kernel.org, Monish Chunara <quic_mchunara@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758019616; l=2084;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=4ciQ96Zx1ayEnFBiXoRdRMoUhFOeRBAJsPy/zaYTqMk=;
 b=1lbihZixVOcWdOgKnh3BrHdupvH3C5+p1uNconNaGX3lNvSOxT2I2HO30GwrMv6+GXVUWNboO
 5iHoTSAox+DCQu4J7JDgdiBbMDIJmQQOU82d1T/ayjvhjHurE3gAiVT
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-ORIG-GUID: IGBxw5amovQ5-aQs73-zrMVE9QX4-6A1
X-Authority-Analysis: v=2.4 cv=SouQ6OO0 c=1 sm=1 tr=0 ts=68c94058 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=ZiJiVGjlRZjjTBZS6bkA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAwMCBTYWx0ZWRfX6vzOfmP/c4Tr
 6Isof+oqqw5JOo7WvjVo3ipS372IC68GM0B1YnTu/Us9v4q1jX66Kl4jwNqdh0smCxN3Pk4Rnie
 uKEYg04/korFNM/TZY+9i3i2/pCjMYzoC0owKMDMDBzCvwa4CQAnQZz3xdVAMRzcjx3D/ulhLot
 NEVBRMah3ic+YpvcMzfP5Gm3QQEv+/uLIm7JrHDuEV0veloKi067JC/JB2USip5Wo+yx0/8XaDF
 UPhE+2Ga7Gezcs8a9zwYKs1w9+OYVvhG9znUs2EPhTT+ZngpTNiAtRPcP/eXKpueM8OFL17cO83
 apxehbayUMVU4u6YJXstbpgYQAQWkei8+Lse40bSUgGrOlR2Xs1rSnLkWciFBMlMhC+ZQnVj3sc
 Wp2fCvT2
X-Proofpoint-GUID: IGBxw5amovQ5-aQs73-zrMVE9QX4-6A1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130000

From: Monish Chunara <quic_mchunara@quicinc.com>

Enable the SD Host Controller Interface (SDHCI) on the lemans EVK board
to support SD card for storage. Also add the corresponding regulators.

Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 45 +++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 3a0376f399e0..0170da9362ae 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -17,6 +17,7 @@ / {
 	compatible = "qcom,lemans-evk", "qcom,qcs9100", "qcom,sa8775p";
 
 	aliases {
+		mmc1 = &sdhc;
 		serial0 = &uart10;
 	};
 
@@ -98,6 +99,28 @@ platform {
 			};
 		};
 	};
+
+	vmmc_sdc: regulator-vmmc-sdc {
+		compatible = "regulator-fixed";
+
+		regulator-name = "vmmc_sdc";
+		regulator-min-microvolt = <2950000>;
+		regulator-max-microvolt = <2950000>;
+	};
+
+	vreg_sdc: regulator-vreg-sdc {
+		compatible = "regulator-gpio";
+
+		regulator-name = "vreg_sdc";
+		regulator-type = "voltage";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <2950000>;
+
+		gpios = <&expander1 7 GPIO_ACTIVE_HIGH>;
+		states = <1800000 1>, <2950000 0>;
+
+		startup-delay-us = <100>;
+	};
 };
 
 &apps_rsc {
@@ -513,6 +536,22 @@ &remoteproc_gpdsp1 {
 	status = "okay";
 };
 
+&sdhc {
+	vmmc-supply = <&vmmc_sdc>;
+	vqmmc-supply = <&vreg_sdc>;
+
+	pinctrl-0 = <&sdc_default>, <&sd_cd>;
+	pinctrl-1 = <&sdc_sleep>, <&sd_cd>;
+	pinctrl-names = "default", "sleep";
+
+	bus-width = <4>;
+	cd-gpios = <&tlmm 36 GPIO_ACTIVE_LOW>;
+	no-mmc;
+	no-sdio;
+
+	status = "okay";
+};
+
 &sleep_clk {
 	clock-frequency = <32768>;
 };
@@ -563,6 +602,12 @@ wake-pins {
 			bias-pull-up;
 		};
 	};
+
+	sd_cd: sd-cd-state {
+		pins = "gpio36";
+		function = "gpio";
+		bias-pull-up;
+	};
 };
 
 &uart10 {

-- 
2.51.0

