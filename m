Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF252FE050
	for <linux-mmc@vger.kernel.org>; Wed,  3 Sep 2025 11:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900082; cv=none; b=GCu7GVE/UCre6eh2z+V71Pj1zdPm5ysHQ+UxCoJge/P4AJyzjKodvbCKwATHAa3OCYUcJMJ5rOOEj2egn/1A/greYf99X7/3gmYdj4cdBLOdzKRlwKk8/wFbP1tEIV5l6HjVVvRAmG0SpVxddOaGn2R2bnwIIvkkKgFTwZdoR5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900082; c=relaxed/simple;
	bh=wdoGSAgGZMAmaK8tU1XxpqdGvDf4YgSCTZ1IvUnFg9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eH2ph2+7axzvEh1VVqp2sozoLB+GnuAwLRYDuAUEnUmw+m9ppcLHE0fDAbvkWFEkizEKnHPjJAvtHt+wZpQ4NDpnpiMsrpnp5APHd5TIOvXkyPnw4w3rmRQ0smUGYsaaMKvxbEPJt7DsIyelv9QJ952hKrGD+9CT+tgMdKoa8fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aHMtxU5f; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aHMtxU5f"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BFUxH011499
	for <linux-mmc@vger.kernel.org>; Wed, 3 Sep 2025 11:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cWI9iycidWz9x65mS5Iihs700rJi1nYbUsileo1tpTw=; b=aHMtxU5ff7aY68oY
	xlQRXBncUnmMhqDC3Ljv6CkNYTKYSo8ulqmH2N6EwD1lBa7fQFyPEfzN8/IMCGQ3
	CIHFKQCam8kiVJ0b3KUFNcnzx3NHQGLwDuwdhDknoivfDOqkX0bxQ/8JNBGJc2qt
	CVUTugE7AUkKoVZZzKN06C0nHSMPod1ZjFAYnIBXtSoTWI/kuZcpIH3LLq6MjOQx
	OuZW8X0T8ystoX0bcHJz9OFg9VzL2574Aqs3FTPmzv9XTZ22alXKoP/1bSsK4m9u
	hrUNhWT1rrs0em0dJV1Qn9GUP3VO+lscmQCMgwxX/QlSX5kxhhKoUe3yWtWxcPx7
	Z1oWmg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjkekc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 03 Sep 2025 11:48:00 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b4f87c691a7so3880160a12.3
        for <linux-mmc@vger.kernel.org>; Wed, 03 Sep 2025 04:48:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756900079; x=1757504879;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWI9iycidWz9x65mS5Iihs700rJi1nYbUsileo1tpTw=;
        b=Odh/XZ46nDDruFRRKDTkXdXLL5blKlf9eJsAPcuXV9AI8zNeJLM5cukjPWdG4quckW
         3l1z/eiqQ5eMffeYaSrAlxTgPw+yNZMRM59ntzmWoEcBwAzEB2Ix45Nrveu+r6eH90/Z
         9ieCJKuxnP+uy7O/9OcK1i2JRgpvIhprpF1w7oXg/qeEQp3oMq4oDT+8bVmb5u4tNot9
         k/GFGaYotJor2aykA0cQu4U+7w6B7AZa4Yy59FpHlVPpw7go7eYX/YGaQc0tNfiaxaA4
         97rLYu2Ku/L73YMxMQ/rGBOT3Gdhg7c3O5Lw9NhnIOD3H5sWaSw3hSLqeNZE0Ys79Oyf
         Vvtg==
X-Forwarded-Encrypted: i=1; AJvYcCWm/ppa2YiU2Ni5FDhz+RD/itpbDEmymynDYGJcSmB2fmfDzUM9BzXOW9AbuWDFwh58d4d+ksjyfvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0gmdObuoMMRDK1Vzub+yovoepHL3eEUk19BMYzqbN/IPLjri6
	/lCA1bZM2hV7HDf0fsOOgMVnVALQFGyCEYZ3OsSVf8A+ADiewOPbPCDbq/Su1KHXCIwFvKRIvIB
	ykg+sNtti8tj+ftg46qDzL1nSqb2woKff7eE7RjmisWD9YGhCTTSk/r15lMwD4EpPDVi0dTw=
X-Gm-Gg: ASbGnctY+w5pNp7GkC31kYNyH1PoMteunHptfB3lHyF6t9NBrlZq1Qr4K+UNouKLMq9
	lZoTsnMUT/vfCaLr98dGz4yNUNBodxECRwJVPU8f1d3jFKR/iI47L+Dw+yEkdcxWg4zUuv5zGQi
	CUpFFWQVnjyQsSWkmlw9PvAnRMSjNsEeeoDauDE98TtrHrjOiFOVO8JCS9VQUWiCOeFJoNgHAih
	67OIZKfHkRr75ybrXrUug/UmuOsEt+5OYQ12XNPyTkS5t4sD3OLcODiy+6Q1dY6XXTwstWCVDi8
	k3kwvCND1UVc0xoZ/2YeyzCb2iTGX4WqUdXNH2ULaWo9r6DQiN8KrUGaG+WPCCxHwsKR
X-Received: by 2002:a05:6a20:1592:b0:243:b38b:eb99 with SMTP id adf61e73a8af0-243d6dfed84mr21286110637.16.1756900079029;
        Wed, 03 Sep 2025 04:47:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELv+J0huqr7i25bQr2YLgBlxEYaArp9gDC5zEKP1AaY9QJtkx2cJuebcKDmtTbXjmvqHsQGQ==
X-Received: by 2002:a05:6a20:1592:b0:243:b38b:eb99 with SMTP id adf61e73a8af0-243d6dfed84mr21286072637.16.1756900078540;
        Wed, 03 Sep 2025 04:47:58 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4f8a0a2851sm6584074a12.37.2025.09.03.04.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 04:47:58 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Wed, 03 Sep 2025 17:17:06 +0530
Subject: [PATCH v2 05/13] arm64: dts: qcom: lemans-evk: Enable GPI DMA and
 QUPv3 controllers
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-lemans-evk-bu-v2-5-bfa381bf8ba2@oss.qualcomm.com>
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
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756900050; l=1145;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=wsLLJGJFupGV6CzZCYaiHCkslrVWQAlmf3KCPEuSGPs=;
 b=cVeVijLP9GWIcOH9Mn5Rb8GJlF8iOXX4RdCeMH5UUSFfrnFcJ95gmfiJcAimJiLws62ZSAjJf
 z3U7sfxYS00C0b+JZPfAvLyWuwyJhlQAr35iJbQbgejNLu2a/6P89UU
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68b82af0 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=c2l2xIwVH5VXVvV4u9AA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: SgdEjChx6Q5eOLrgJfdyaDsht9Sq_bAf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfX7/uM3ezxF1pG
 N1oFrcJEi4FojCI6i4LOG4HKtclSYcBnJ3YKRd2o+YbQjVpBsJmvQ+27IlZZUrBwnMtKof+R2UF
 f02H9VTo/Jp8FbyKZfBJATxiVZRUNl0uSYwTiu0O1M5DIjKiae2kNFbXhrv3Kmd6c9WyJQFY2nT
 oy9XzZWnFqgDMZ4SXHaPwbwMSDFZLthzniIVj4hVX9hZbHPxYXfPTHg24PKDGQC+YzXttzZojw4
 dfLq2+9HQU3V4/t6fIwX1dhfZVwIS3FIIonj3/ItncLmFxGe1k03p/GpQ78lHKb4A6gnVeHs6nJ
 5gSH6WiL4upmBkxJVUwNQ1D+ZMCEWP28EsyHwlQOua/xJ8d4HiZS91PN50M4kreXkwNfArsudh6
 k/W7Zz3y
X-Proofpoint-ORIG-GUID: SgdEjChx6Q5eOLrgJfdyaDsht9Sq_bAf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024

From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>

Enable GPI DMA controllers (gpi_dma0, gpi_dma1, gpi_dma2) and QUPv3
interfaces (qupv3_id_0, qupv3_id_2) in the device tree to support
DMA and peripheral communication on the Lemans EVK platform.

Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index c60629c3369e..196c5ee0dd34 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -277,6 +277,18 @@ vreg_l8e: ldo8 {
 	};
 };
 
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
 &i2c18 {
 	status = "okay";
 
@@ -367,10 +379,18 @@ &mdss0_dp1_phy {
 	status = "okay";
 };
 
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
 &sleep_clk {
 	clock-frequency = <32768>;
 };

-- 
2.51.0

