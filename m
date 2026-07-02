Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31433932DA
	for <linux-mmc@vger.kernel.org>; Thu,  2 Jul 2026 07:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782977663; cv=none; b=Ev39ObtwJ/9+r6bwBXCUF8OGtsRycGzRu464J1n8y6UQ5KUxKvEeJIGYUfMyjyLxRiNcNd0RZdzcQkhrp+R1DTqflH3XhoL9+qVYbAPOyqZEUK2DELBcSV0SWUKEDZF2CMAn4aJPrrOmaWg35rnu9Lznf63B9Lr6/m6q6JqEvz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782977663; c=relaxed/simple;
	bh=wAT1T3fnjrOVEasLUZ6kLgMLRxNhI2fWS9D7tT5i3Xw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K8020haIkG5BLoRi2Xx8CWbyEFofzZO3L+o9p/rTSrDUm/2Ke4xrcblKr9aFiDyIW2rnuYV8aGAAlN/WMmklkjRd0yeUFmcJ8MDW1PiHJ67wDUaxR+VWPQG+7WrWJt3B9VF93Yr7UgCCShjlB8NXyUaqLJqBsmFtpGFF4qF269M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ebcFGPX2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Yhvn4piC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ebcFGPX2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Yhvn4piC"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6621KWNf2917552
	for <linux-mmc@vger.kernel.org>; Thu, 2 Jul 2026 07:34:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=sIJYBVb2Xk1
	IN+E6IOH2B3aiN5MM890hUqbaJ5dnjXo=; b=ebcFGPX2LBNY3H3x6JkDZp+pa2B
	KWmm347s49RJN2n7s3wI8bbJPFPXNoLhovOzHXcYCLlGPouC2IZu00zGYsyRGyBJ
	ZOD4qtiG97wybVAttT0AMbV9ZfIeH07q2s66Gw1BabUZUgh2ZSIjf8n4UPetBPVh
	d+WoqEnD2Rkwzgjv1+rISMZ77WrzVoZIJLQUUgQmUwrH+gwHdF3Y2F6CERhbtoID
	TPQip2sRkkYlu4gAZrS3c6Tfeo4WaVp7FiEpCFrlLH9iHG/JvewJHfgXY4l1/jIb
	MJ2ckLBa+SCWf5qasvEQ8uvLwy4JU7ZStmrJknkDgjop82bBUzYQ61gM9aA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f53q0bp5c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 02 Jul 2026 07:34:21 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2caa9a3cf7aso2362045ad.0
        for <linux-mmc@vger.kernel.org>; Thu, 02 Jul 2026 00:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782977660; x=1783582460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sIJYBVb2Xk1IN+E6IOH2B3aiN5MM890hUqbaJ5dnjXo=;
        b=Yhvn4piCXeQPnH3KWjMeMjPmUw2CCr98y18SZ2kaXUakx295KLdWvAvlH+ZnnTQb0v
         bhu8Eit4xTOzr8AOwFqI7Zdij1BbpsRk3HaE4ltdlip5rjeYb9Cmr6C5aZB3xL/fVrSN
         2pWC3qiOUbSV43YRd/n7gQYRr33J/+vLd96wYxxXEoZvSM55+mEpKTtVcstbwj20mMcO
         WPChO627uDAYDd+MkuqYS5M5Pab05ZABLyvXsqXblsom/xrKA9a88NsR7gu0Gscxtv3w
         wShevXqlVytORqe3OF/y81sbXImL0KIgcwK+xXDeWXbTJ9qZaUwvqLK6HGC0xOXjtx79
         f7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782977660; x=1783582460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sIJYBVb2Xk1IN+E6IOH2B3aiN5MM890hUqbaJ5dnjXo=;
        b=hHaaVknYB3XSZ5DcXqSXUKQegW7/PhP9samZ0tC1pARnV7lIvNrTsXEW/CSC1YIrOE
         OrYhEHGOVUqz8+i5pezwXpX1iUp0zzP6H6suilHvIhPNOxmfUMPAVs8hxHeTb2+xSzr4
         HTcq9q9uiBJmSLit3Cl6MBCXpzqI2mfuQYPYTzd/ub7+GxiT5Bt9EE1DqkPwwUrSyPXv
         zkc5JsF9jgvaPhPZehwTsqcKON4DfUZE2RIocJ90itunM1kv/uKr51/216Dg+vkDpLPj
         3j29AzMv5lCY0ZRIZI3HnIp8FdXLHd4HzmKIgRNugJkMq5XeS+ajd94n6R9VjwKoMNBi
         oEDQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqz+yuuZk0G6tSWKE1Ks+hmro8rIQ6dvi1JauOjh/EbhsRQ0+1nFyt/uHJPvByIoWRkUMcjXDXrcAo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3LnLYIMPYKkId+Sxb5C6CVOVr2CJ2gXu2yrSi3VqnLWmpmdsQ
	OHrXfUshQLW2z5A5wR8Km79H+bg++xqGswr7axqLuz8ypbVWvvmA84jOmsLtVywmkT8NhG1+zxW
	4Cg+ci4yBQ0Fp9yBw/4vV7/e34g6C0xZLuhnhDLIcmT3nAnehQIdXlttbP050RiA=
X-Gm-Gg: AfdE7cnZjhbtV++edKJkjjiy7slzAPIfKss0KX+3hv4huFJGPQ1B78k8yK/3qXQlHoD
	j4cKr/qq+Sy4tKlVn9tO+eNxWeXbbJnbmXZAFAn0ygMDCfXlOfrVVzJEbLoGl6EIAnpKeunuIVp
	+soOgLR6Wo4C71KIhQNYrrSw2f5bgixDNH6f4VEWw4mCK0J7ZsYsS9nFnnI7AohEbsbqj4IPUJj
	bUqY1LB1HopJ1jGo3K6k66URP0hC0RVeHr7azqLYwi+jYL8d9ZWEwyQt8a30hL2ZVrqNfIbF/Nn
	xKH0o1dVINQGR6NCV/qefO4OnfOGozIdRM73ZycNUnHS5TcFTtMhXzU9hNEDKqKGZ0afQasYOaQ
	MtzCQEX3nCRpstbxKfLYtxsvDGX75xf8L6sxm3UcRMUMllA==
X-Received: by 2002:a17:90b:4a0b:b0:36d:c138:e0a0 with SMTP id 98e67ed59e1d1-380aa07d617mr4242191a91.2.1782977660326;
        Thu, 02 Jul 2026 00:34:20 -0700 (PDT)
X-Received: by 2002:a17:90b:4a0b:b0:36d:c138:e0a0 with SMTP id 98e67ed59e1d1-380aa07d617mr4242174a91.2.1782977659724;
        Thu, 02 Jul 2026 00:34:19 -0700 (PDT)
Received: from hu-mchunara-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-380e163211asm587380a91.3.2026.07.02.00.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 00:34:19 -0700 (PDT)
From: Monish Chunara <monish.chunara@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, Ulf Hansson <ulfh@kernel.org>,
        Kernel Team <kernel@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-mmc@vger.kernel.org, Nitin Rawat <nitin.rawat@oss.qualcomm.com>,
        Pradeep Pragallapati <pradeep.pragallapati@oss.qualcomm.com>,
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Monish Chunara <monish.chunara@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH V3 2/2] arm64: dts: qcom: Enable SD card for Shikra EVK
Date: Thu,  2 Jul 2026 13:03:54 +0530
Message-Id: <20260702073354.3641966-3-monish.chunara@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260702073354.3641966-1-monish.chunara@oss.qualcomm.com>
References: <20260702073354.3641966-1-monish.chunara@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=dtnrzVg4 c=1 sm=1 tr=0 ts=6a46147d cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=xck8KZ0arIIkwrKT9kkA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: o3HIR56gA9zCl3BtFHRSt2x29PGbH83B
X-Proofpoint-GUID: o3HIR56gA9zCl3BtFHRSt2x29PGbH83B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDA3NSBTYWx0ZWRfXwOY8qPVZbODz
 ahvK3uhaBjA0XqdiXree0aZjDWURPfDVPxPoBM4/4tNZP7gav7/sx8CVpBIzuSsgjCMvudT9e4r
 1isd+OAsMA+oIYDWljG8vZViBpO51lpuEhNF6v83i9TFvHtt42czvKhe3Gw6o96Br59GZOyiAY7
 7bi57YhClrgzyMC0VyEQkrZ+4+uadNHPpXQgUHSwafCacqVbA+oTyd0zUAWxdCfmJLCD5HycYPJ
 FDgTDkdGDJ2ZTmEkFC8WpTbt6yHC2ZXMUWaqyfzh51DfdVRsHMZSY7pSinizXGUnN29KOCHdMQI
 kpJ5GT2HSX7ZDBHFSKUim+66du6+QnSNWQNNkFRQ9mzyq3B1VN67gJB0wLPUOtfPQWxfK24KLc4
 XwXMHNDz4jRVq2+XMq7y6bxXZEmI8ZZdqGIOA/MG2M0N473XGfk2G1ut+pW2VfarNbcXyDT81JO
 DFEUJCcNKEqitybVcXg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDA3NSBTYWx0ZWRfX/g+mOrHaRTC3
 FDVxM+FlUnbu7wM+AGGpLAfBInJYQxAO2r1Vy+nGk3wNsrWvpK4XqHxGz+PFQkGonIiogeUh4iN
 HAQiiEUejhCPdN5g9MyGHmcqb193mEc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020075

Enable SD card for Shikra CQS, CQM and IQS EVK variants. Configure the
vmmc/vqmmc regulators and gpio-based card detection for each board
variant.

Signed-off-by: Monish Chunara <monish.chunara@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts |  9 +++++++++
 arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts |  9 +++++++++
 arch/arm64/boot/dts/qcom/shikra-evk.dtsi    | 11 +++++++++++
 arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts |  9 +++++++++
 4 files changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
index 683b5245923b..d4a7d31fb111 100644
--- a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
@@ -7,6 +7,7 @@
 
 #include "shikra-cqm-som.dtsi"
 #include "shikra-evk.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "Qualcomm Technologies, Inc. Shikra CQM EVK";
@@ -15,6 +16,7 @@ / {
 
 	aliases {
 		mmc0 = &sdhc_1;
+		mmc1 = &sdhc_2; /* SDC2 SD card slot */
 		serial0 = &uart0;
 		serial1 = &uart8;
 	};
@@ -95,6 +97,13 @@ &sdhc_1 {
 	status = "okay";
 };
 
+&sdhc_2 {
+	vmmc-supply = <&pm4125_l21>;
+	vqmmc-supply = <&pm4125_l4>;
+
+	status = "okay";
+};
+
 &uart8 {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
index 26ff8007a819..a83e9fa98797 100644
--- a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
@@ -7,6 +7,7 @@
 
 #include "shikra-cqm-som.dtsi"
 #include "shikra-evk.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "Qualcomm Technologies, Inc. Shikra CQS EVK";
@@ -15,6 +16,7 @@ / {
 
 	aliases {
 		mmc0 = &sdhc_1;
+		mmc1 = &sdhc_2; /* SDC2 SD card slot */
 		serial0 = &uart0;
 		serial1 = &uart8;
 	};
@@ -95,6 +97,13 @@ &sdhc_1 {
 	status = "okay";
 };
 
+&sdhc_2 {
+	vmmc-supply = <&pm4125_l21>;
+	vqmmc-supply = <&pm4125_l4>;
+
+	status = "okay";
+};
+
 &uart8 {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/qcom/shikra-evk.dtsi b/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
index 5411f22426b7..a9a5a6c99313 100644
--- a/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
@@ -9,6 +9,17 @@ &qupv3_0 {
 	status = "okay";
 };
 
+&sdhc_2 {
+	pinctrl-0 = <&sdc2_default &sdc2_card_det_n>;
+	pinctrl-1 = <&sdc2_sleep &sdc2_card_det_n>;
+	pinctrl-names = "default", "sleep";
+
+	no-sdio;
+	no-mmc;
+
+	cd-gpios = <&tlmm 89 GPIO_ACTIVE_LOW>;
+};
+
 &tlmm {
 	sw_ctrl_default: sw-ctrl-default-state {
 		pins = "gpio88";
diff --git a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
index fd691d53a0fa..0fca5d0ac66e 100644
--- a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
@@ -7,6 +7,7 @@
 
 #include "shikra-iqs-som.dtsi"
 #include "shikra-evk.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "Qualcomm Technologies, Inc. Shikra IQS EVK";
@@ -15,6 +16,7 @@ / {
 
 	aliases {
 		mmc0 = &sdhc_1;
+		mmc1 = &sdhc_2; /* SDC2 SD card slot */
 		serial0 = &uart0;
 		serial1 = &uart8;
 	};
@@ -103,6 +105,13 @@ &sdhc_1 {
 	status = "okay";
 };
 
+&sdhc_2 {
+	vmmc-supply = <&pm8150_l10>;
+	vqmmc-supply = <&pm8150_l2>;
+
+	status = "okay";
+};
+
 &uart8 {
 	status = "okay";
 
-- 
2.34.1

