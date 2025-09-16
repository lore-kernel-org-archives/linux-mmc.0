Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195D234AB0C
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 14:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034792; cv=none; b=HPKRnSBHSn5FjRx/TAVVa/6kkxJGqZmNzHqyQJW3E3pU8TlLExDeSD5SmkX6OZLbkWcCGnRTLL6deoHv6uT1VdY7q4Zej/QAoZg9K0Lx8I+SoL+9PsxQzaXWJUcWGjYYFVSGRJr7a7EShKDx+pLH1lGZrCuOaXoL3xxugcvP1QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034792; c=relaxed/simple;
	bh=ucCiT2duDaoIeQYERYpaS3b404ydsb4qHh+zyj5bIXY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TSL9ngcEEkT4+vMm5sjAT9CT6Ex11Qcj1xkvjojv7x6okwKHj5E27vN30sl5aY6I5V7p10r52J3aCQCZPiLrSocUKtHbsb2Q3+qzeMbbVwc/WVOc9+4C/rNfQHe/9pAeP9qnNUI4Ky60VRPpf0NZV+QdhUu3Jbr2w3bcooWa0VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=foT1nTOD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="foT1nTOD"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GASnSP012555
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 14:59:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z3c861F2ui93zu/77nje/iPwaISHn2dkZfiQXCBPatc=; b=foT1nTODyAMpVdcL
	XcscrWD0iavaxaRSk8HBvD+zeWUpM1EOcguDZZ749PhbvPnNvw4M+NWjLtXg0s8t
	T7WFnCkEYfZEYSk+fu5kQdZugtuMK6BBZnTQBljBLrYlJy71OgOW4+EC9KNOK6E0
	BPw0/kMNKx7m0FckRw6bKkS0/t6YtT9mkt44OiWtcqNObwLTKCv2DZWRTTcPIHdZ
	wTE1hHy6Ttv/SIT7I7m4ycbGPS7KHVTKkcIdldW2+MG7k9xYiSDYZ/gq+DOyByqM
	7Fv+eV7OW3tiUfT8jDEEKl8fMJYf1nIcHH6sZ3khRvnuxUBNQRUptwxFFcoE/FMs
	1CfFUg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 495072s82t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 14:59:50 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2445806b18aso54333855ad.1
        for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 07:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758034789; x=1758639589;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z3c861F2ui93zu/77nje/iPwaISHn2dkZfiQXCBPatc=;
        b=oOtrt8k7C5IbmrjN9BlqWMRxd/CgH7civLO80ipt90cq+5B7b4AFF1zuioOwVpEtlf
         Gv76BJ5Q3XU2RdokJnC3n870YTX/5D2Rd9APdkL5GW/JUOEOcg2CRNRgRS6d6gGZrn/Y
         LQ6Xwh8av1q5jwDou+W1ZfF6nL1EYgTI5IwQ4bHWwBsFaqOx0ETeSVA8T0nypocTXrVw
         RWcsmO2KloAqqR4UgMwkRTwiNcnXSLXL/rPpMDDDjfOyKTeTEq3rppA1uOR43Kxi0BoC
         4D1Dne1P6klBr8vGjQDXiUCPZ3FjBvXGMVHNquPzW1/rua8RsC6QXe5I+z6/xDWU4yAn
         LD/A==
X-Forwarded-Encrypted: i=1; AJvYcCXFggPQ9EEfdNRPhiHw5H6iy/VlrZVsYF6YasARUU/0n/GMJU82GvcRP5UuEYCaqkl8gfVps33FnXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHq+1bebtR1xB+oqXqFLcIoQwS2kro2vPyty14PDLscfrW01WK
	h8j9N4n+FrJtR0549A/JsfqRBbSWMNDNjQwCyGiEhC8zbhMddH/2HlzhUm6zT5/T9YL1Ti+xm/Z
	1n5fHa/nxA8OO9R4Wwt2uqqmSQyXDXPEoUlxxtdoDYIBjoumEAPsY8DQu603QPgM=
X-Gm-Gg: ASbGncv8BYq/au1aSCudg1/JL7Rt7M8S1R3x0wqZDkFcIKJ+kvbMaLnxEzZDtED8B4J
	GDnpJld4XJYOWNb5rVzr0GN5mZANZMriMXysf/703hxQySN8Ge+TqhBpALPkNNYTTG7RCXHuUkn
	BcuAK6qdyvz4cm4lBbGxrxlK4laskKme/rlO5EG48/cjZVCcSgQv9YGV8fSzslCwh+LSl3BAY/l
	SEnFax9iBN/7jfRFWRKGHLErpujTBSiL5qxgkiFwXzaUOOcMBvaHk/QwrGnmkMbEL/r2Gaevzy6
	a/8x2PIB/GzRdHG8Fw77RKYdgCvhQ2mR58TavT4YmnPsnXpfBk2mXOodySyHCjnxPdxd
X-Received: by 2002:a17:903:144b:b0:25f:e735:e521 with SMTP id d9443c01a7336-25fe745298dmr126384295ad.51.1758034788773;
        Tue, 16 Sep 2025 07:59:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlG3XxJr++7YJRonIxD8YwIAP2fbDCR8SQyUNRaNhoCTyvi4e+VWNopVW3BMUU4avieMbUZQ==
X-Received: by 2002:a17:903:144b:b0:25f:e735:e521 with SMTP id d9443c01a7336-25fe745298dmr126383835ad.51.1758034788239;
        Tue, 16 Sep 2025 07:59:48 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2651d2df15esm74232615ad.45.2025.09.16.07.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:59:47 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 20:29:24 +0530
Subject: [PATCH v6 02/10] arm64: dts: qcom: lemans-evk: Enable GPI DMA and
 QUPv3 controllers
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-lemans-evk-bu-v6-2-62e6a9018df4@oss.qualcomm.com>
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
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758034770; l=1267;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=OJ8bh3UnEFncYOpsWZZoUBMvVw4VlPpL+mr6xLJOGx8=;
 b=Ug9LZUZ9gmLC2/5dekDdCfDPxGAy+b7lG1ieijCJiCJRkmRmh74Cn5mfUItEHOO1OB/g7Mtm5
 Q4cCiRJYK1mCTm2PNKmtdYi1QjIgZij0lhxbvVlOHghJUp+U2WQjxrS
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyNSBTYWx0ZWRfX6j4iPYvVLul7
 e+wkzbY+xdotb6z5CxAKiv9X9TKhUlRlJ23BLwneDS41dGErTmNYgO9kIVXMz1m7CF1tpFF5bt5
 Rb1D85FfwVYsialHuFjgZgdVTy51DDc/gOS2R6RoNIuB1hd3IDUVs/XC/aV5NdWYXKLDuBIHwCh
 7B/NtlUpqZwGHAvpdTSW5ZzaNFUDTqt+dSXRB7j6ryMcvdtSc4mOj/YPj/f4Hpsco3dxvUDBPMn
 S6lS7oGaklstVePTF1wtvie51SrEjLknDBFfDqZM54kL0c87N3RMw+GiFSYaYpZxvpovTEzdlKV
 FnPGwF1nZgBsGKy6ev0Ec19qqHedHwdSNYlSMi7B5AFaj41QMPHlZPAENJyRHy94o0ivrKAjiLz
 Qhno6e6O
X-Proofpoint-GUID: SUJFTVPWCgBmdRGY8gwzT3S3CNy06vH7
X-Authority-Analysis: v=2.4 cv=WcsMa1hX c=1 sm=1 tr=0 ts=68c97b66 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=HCCwzLURLT_Inys_5lQA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: SUJFTVPWCgBmdRGY8gwzT3S3CNy06vH7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130025

From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>

Enable GPI DMA controllers (gpi_dma0, gpi_dma1, gpi_dma2) and QUPv3
interfaces (qupv3_id_0, qupv3_id_2) in the device tree to support
DMA and peripheral communication on the Lemans EVK platform.

qupv3_id_0 is used for I2C, SPI, UART, and slots 0 to 5.
qupv3_id_2 is used for I2C, SPI, UART, and slots 14 to 20.

Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index f79e826bd5d4..4da2c5a12c1f 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -329,6 +329,18 @@ vreg_l8e: ldo8 {
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
 &mdss0 {
 	status = "okay";
 };
@@ -375,10 +387,18 @@ &mdss0_dp1_phy {
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

