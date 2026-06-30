Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1843D75D1
	for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2026 16:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782838651; cv=none; b=c6W2sFSDBYMr7p4clDr9URu7Go962vSWxD7VYrx2DeN2eIY9kQwQkmXrGUA2zHYrLUN2oofigI9+qaWVlqD7eSIdvakho4iQ4zJdkRtrcXcKlnAHGjA8L8TsCnIh8K3/VtKiej1vZXz++2LCnaTES345MlEUCUni/VI9AFGGDtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782838651; c=relaxed/simple;
	bh=FtSrgC45FXuU72qtV83eFk9spgUvKjy95UIvIbL30ec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CD6QI/dQmvjS3l4L+1guRUr57BBkfvck0yiQxATyqL5uFgTOe/PHeUNB/JCO0gqWY+CofAYCGgtIC4fSZWBxUuB8KyE6ox7aWuR82PDaqciRw9Jr1iqUgdEzb7l+B8CinY8rFNmjEN8gMGGP93LVefhK4v0PwrmWhvKBmTxM0ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WHjaNpx8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LKn1gGGu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WHjaNpx8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LKn1gGGu"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UGRdCt2432681
	for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2026 16:57:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=8YJC20VUmc8
	hG0TDIKBt7XhKJfZsFAsHt8W+4dAsV2E=; b=WHjaNpx8ZdH9l9N7AKcn3RmsStB
	L63mlhqo9Z72bhGi2ce3/Y20NPtFwoo2DatKVDWFL+Ajot/VpaTVa4aPKDmSBr6Y
	iRse/RcZgPvYULW6A2Tm+JoIDGE2yrf356yQC2f64bikg0kbAnD1CKXMV1te0DWR
	5njWZVHxuyhDaYZeUHDUDLxs+GJkTVjhJGl8qm9xL204i0JimQGK2rYvwY5cUcpR
	ueXYrmXsKGd2iwq9dxeSP4tB0cPhnR0yDCqZAWN5CWfZ3O07fSnExcI/M9eqU0la
	qWaSPIyPFbX+PCRIqHPZgWLo257koyjPdo7NKnwypFUjE8ZiAjesjjOCNZg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4hbd04hc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2026 16:57:29 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-139f2c46ef1so3751837c88.0
        for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2026 09:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782838649; x=1783443449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YJC20VUmc8hG0TDIKBt7XhKJfZsFAsHt8W+4dAsV2E=;
        b=LKn1gGGub8wMElkGAq29ivlLPVdZSa8kIIythyKSN93Nj3xNyJoPXAmWwJFvIemSzp
         H9qvt9egaXACccWFBIqDY6FyaC131GEbkRog3zM2Zrga3Jf5LpvSXD9ervpMeFh66iD8
         tIzsXiUH+oWXO9jp+KdrSAExDSfAZ1mV3zM2R+dTtKj9ERGAruECvd/vBOUDHWtnWFJH
         HC87sMI/pUzZxTJ2RdfkBpIU2Se8luXQi0wE+A00QspW2A2/MB2vURMIv2V+ZMyZqde+
         F4s+vreOjwVvlq2I1DDhZU82IrMzxewkFfsYtQb6G09FJYzm88QOwlF70ne0n7jT/HKs
         D1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782838649; x=1783443449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8YJC20VUmc8hG0TDIKBt7XhKJfZsFAsHt8W+4dAsV2E=;
        b=SKtG8uPAvhYXUHFtotXpue6+KET57SuSLWWjYHAJJl1TSANIXLBq/PJwxEWC5mDs+m
         aoRda9Z4LZNZCYADk4pbnrCOqHM2vCqcvZLvwgLOViJu8xj0fIruGqDTWlR+y/fexaeT
         CgAKoTKE/rKjT0uc/m0lm3mVtAqSWFlNvHW31mr8+fVava/KdyBIeGiXbI2rEufcYMF2
         TGU11m3gi7EmMfG/E844ESXycIekvuYZzMeMUqKW7Jxua8oX+FIvK6X+Fi2lkU/wrfgU
         TTiXvYV96YWBfKW84Rg4kIQVpkN2WRF3A2Flr8WKl6nEmtkv8Hkd4eOkCjvkqTYtAvKI
         RNjw==
X-Forwarded-Encrypted: i=1; AFNElJ/P0+u6YEwYumYeGsDqBTHG0GHquRZuAX0HeYnSt209YFdRaBPvAvrWdeBEzUEwC0VFCiRhPHnC1Ww=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjSvb/02xlInEEwshswecC/VfOh8NKEk6A/Rq7rnI+5ElA1f0U
	R/pjcXynhF1GphkPWRSDDh9T7kheDwthWkkmgy5Kp470h1CCMf1qXAThm8pLNazyACdXSFAHSFr
	DDTI2vOFvcNFSmI2cqDkrgoefrXifzFM2Wxk7orCAS6OAPzQT3Ygoup8e7gK7N6c=
X-Gm-Gg: AfdE7ckp0oLfEOjgX8lAGZrfk2XJCT//+U8RNGa1fpz2M3vPy9d9qvHKOpFFuqmWYfZ
	DQlbaE6s5cf3mPGiODDaB54aOGPzIL5VKJzSTwYJpAKkP4GT1MTjXuMfpspXCWK2OglLDtdRPiZ
	vtFe/gvnemCq6HrvCvy+VV+H/HXEMIgUXCKXsNP0DetXK51bGtZjFdNBP2KFC1hDoNXFKHqvnQB
	gvte52ysPN3CraigYbUS6HycMAW9pgozObTbnUbt5mQNaqOlFU1EQnIKmt60NTL3qF36WBzxSXt
	9tEaTBP13AImctxQ9YbqBsiO6YROiwNYh7lg89cDu6vmNMgLXp6egcdFBY/GotOnPgfITwfNnbs
	vDzDDYEOIju9hW7iQTMGerTphddgFq113QnnvFGg8P89iTw==
X-Received: by 2002:a05:7022:1e10:b0:139:f6bb:c907 with SMTP id a92af1059eb24-13b3142abe4mr854602c88.18.1782838648481;
        Tue, 30 Jun 2026 09:57:28 -0700 (PDT)
X-Received: by 2002:a05:7022:1e10:b0:139:f6bb:c907 with SMTP id a92af1059eb24-13b3142abe4mr854548c88.18.1782838647886;
        Tue, 30 Jun 2026 09:57:27 -0700 (PDT)
Received: from hu-mchunara-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b2a9b425asm12690272c88.0.2026.06.30.09.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 09:57:27 -0700 (PDT)
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
Subject: [PATCH V2 2/2] arm64: dts: qcom: Enable SD card for Shikra EVK
Date: Tue, 30 Jun 2026 22:27:00 +0530
Message-Id: <20260630165700.1886608-3-monish.chunara@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630165700.1886608-1-monish.chunara@oss.qualcomm.com>
References: <20260630165700.1886608-1-monish.chunara@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE2MSBTYWx0ZWRfXxZ0m1/pMucNi
 J+9SvxU5SVSdENWq1HebzpoMlTnrm7yWBsMYy66dg096VzE0UaD/U7S1LwoTYmJsV+8qV1uxTn7
 NvO8Wa9gcakLoRNcpvf7HSweuM10A0A=
X-Authority-Analysis: v=2.4 cv=MpJiLWae c=1 sm=1 tr=0 ts=6a43f579 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=5uGxXp5b2Q1zeZBlDmAA:9 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-ORIG-GUID: DP2y2bEvLSbI0OGZzbKQxLqrOdEYkTXl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE2MSBTYWx0ZWRfX4oB23bsFy+Ie
 NhZUfe7y3PPEwQ7HaOzo6rvP9pkM/mH8Zygnca5kVUHIxbwO9DsJNZu7BGxF2jMsPWoxVsl2xpd
 mK8VVgsMzW8WdBo0f2+QPQZarYaHI22gH4ikDCr7uLOfRyTBKHtrV5QfsDus7VuhJNirx8r61Dv
 bHkH4W8OfEtdnTVVe0WlZUGxAVEps3VSOw/6SMubTTx/BehRlDGXhAdAXvZyCBVPgLl80NYcD/O
 aJCIEAwlut37viBuTj2Q/WTACEgvCjeHjXNdFLwouhRLoF4KIeMQ2Rpaw3Ao5spXPz4GAQU3hBs
 iRhfGrsjVMFRIbKWlelapi4sDk8OwP5RYTZSHQBAKJhWvDzvUW/KGD+EesrelkyQgHHyUpKnuxE
 W07cCMYx/Gmkuwu1WWkAukOmuIKgUyR3D0R/fIxxHKGs8wRQQMmpuVgLpo6Ac61MqWhqg1aR+ys
 ortuv6Yl5ZJnSbFCXgQ==
X-Proofpoint-GUID: DP2y2bEvLSbI0OGZzbKQxLqrOdEYkTXl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300161

Enable SD card for Shikra CQS, CQM and IQS EVK variants. Configure the
vmmc/vqmmc regulators and gpio-based card detection for each board
variant.

Signed-off-by: Monish Chunara <monish.chunara@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 18 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 18 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 18 ++++++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
index 683b5245923b..8212bd41f74e 100644
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
@@ -95,6 +97,22 @@ &sdhc_1 {
 	status = "okay";
 };
 
+&sdhc_2 {
+	vmmc-supply = <&pm4125_l21>;
+	vqmmc-supply = <&pm4125_l4>;
+
+	no-sdio;
+	no-mmc;
+
+	pinctrl-0 = <&sdc2_default &sdc2_card_det_n>;
+	pinctrl-1 = <&sdc2_sleep &sdc2_card_det_n>;
+	pinctrl-names = "default", "sleep";
+
+	cd-gpios = <&tlmm 89 GPIO_ACTIVE_LOW>;
+
+	status = "okay";
+};
+
 &uart8 {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
index 26ff8007a819..5341e145977c 100644
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
@@ -95,6 +97,22 @@ &sdhc_1 {
 	status = "okay";
 };
 
+&sdhc_2 {
+	vmmc-supply = <&pm4125_l21>;
+	vqmmc-supply = <&pm4125_l4>;
+
+	no-sdio;
+	no-mmc;
+
+	pinctrl-0 = <&sdc2_default &sdc2_card_det_n>;
+	pinctrl-1 = <&sdc2_sleep &sdc2_card_det_n>;
+	pinctrl-names = "default", "sleep";
+
+	cd-gpios = <&tlmm 89 GPIO_ACTIVE_LOW>;
+
+	status = "okay";
+};
+
 &uart8 {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
index fd691d53a0fa..0548de0d3a74 100644
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
@@ -103,6 +105,22 @@ &sdhc_1 {
 	status = "okay";
 };
 
+&sdhc_2 {
+	vmmc-supply = <&pm8150_l10>;
+	vqmmc-supply = <&pm8150_l2>;
+
+	no-sdio;
+	no-mmc;
+
+	pinctrl-0 = <&sdc2_default &sdc2_card_det_n>;
+	pinctrl-1 = <&sdc2_sleep &sdc2_card_det_n>;
+	pinctrl-names = "default", "sleep";
+
+	cd-gpios = <&tlmm 89 GPIO_ACTIVE_LOW>;
+
+	status = "okay";
+};
+
 &uart8 {
 	status = "okay";
 
-- 
2.34.1

