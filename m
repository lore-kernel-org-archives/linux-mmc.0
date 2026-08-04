Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4B33749F6
	for <linux-mmc@vger.kernel.org>; Tue,  4 Aug 2026 12:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785846094; cv=none; b=crXbTvXpO8LMOFGrtluzIrabVpnoG02WLpdt9bSiKN09X43SZi4UUrDEopEPLp2mrt7Y5PiUoOxNkrcIFoAJifnwxzfOIb0qjTR6nfmGrOLEX4r6uxdVQUpsh4zpPebFBfGcT7spopsr8WQBDPDTG91rbQQ/SjZhHTxrp/8Q3MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785846094; c=relaxed/simple;
	bh=rWfS/GCkMUv7Te1Qr+CUw4vQjhgfT/9rFBEVUHa1xAs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dfSrX8SF7PqftQ5lDJJJDl45K5yS/0iPIwUYfZigaMeom0d5T9M4WOTQQVwdzJylefSItjCX/r1oqXCbXDiDpW/TPZ0FRzl0dAi7vJrx89hH/mrm7FTKmc1PRAMkFYn40h8lahB2SJ4eQ/+d3rOgSuNmp4Q7gOg/GQb1vwzToZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RZRsVm3U; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Em6jkCkv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RZRsVm3U";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Em6jkCkv"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6748CWNt3531693
	for <linux-mmc@vger.kernel.org>; Tue, 4 Aug 2026 12:21:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=CiYq0GXAxFO
	OekgF0TYapRMD4yuOgKVaynEdP3L4Q0E=; b=RZRsVm3UiWC7fIZhGJgFBCGVpVz
	CD83jr3GXnkv2pJhhuGPZGyMGrAe+u4z5tCbGk/9ub+StKbdlWStxhflDjO0S0uH
	BZpvYV1NdcQIIMmuXw7KppBvCA9vpqxaU6TAx39oINVHUPt10JdPM8l5wCEJTLDo
	RkUwSMO9MLO391Z9jzgfGDTTIUKxqZ+/V07qnK1adaRthRUS+DOp5XCFEHqO4712
	ZpVEEBDj6G9IMG1A089qUjR5rAGtilfC2CsB0BDSMb7chXNjXKAvNXhyhIYXgSiK
	iGb5Za0c+6qXZ2NnAE2trAgj7nf0XTj/E7hFjmlmSrio2rNfHaSXaCwfB9A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fty3sm7ww-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 04 Aug 2026 12:21:30 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-388b404eaa4so1194565a91.0
        for <linux-mmc@vger.kernel.org>; Tue, 04 Aug 2026 05:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785846090; x=1786450890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CiYq0GXAxFOOekgF0TYapRMD4yuOgKVaynEdP3L4Q0E=;
        b=Em6jkCkvw0Rx3ooUxjks7v2xOX5AT7FJm2dOkGVCAaRbzSCsD+qwpanTTIMtEkwsNS
         9W0LygfZenSuG7BSPxXsyLCQ2lC8r1ehv3ED2GxVCkHfmGxy98SArTlL3+Juc05eUbCK
         giwptQ0a9b3BF11vvUW0lFTTN4O2O4/ZoIv/52POAEPZ0DzBJDsfvjHUmE0u9CmuPRll
         xtE6SdtjLWdfrG1z09ae+yWY9+oH55MNHkk3r25NtqdP/JK2srMOlC7+fl8CypYzPZPH
         YB5uFIY/UXCCFFbDczTOrsXMdpt3DASG5eEgHBNZNobwOqOpHCfRnv1BGidsdyFn4nvo
         WEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785846090; x=1786450890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CiYq0GXAxFOOekgF0TYapRMD4yuOgKVaynEdP3L4Q0E=;
        b=Rez+iR1TIHjF3xCaOiK8hmFgXMk5vPOMoGkh0VeCEGSLZ1/XDme0LTFBWuFJWTwqVE
         m1bfEbZ1Cy+maChrpFVS1B+Ot/NqfcVQh348+NM5jWxp/Biv33O34JBiYACi8cHnDpvm
         Ij58n6xsYCuAJFQSPG9m3qvuHbMClCXOU49bTJQ1Wu1E0a+X/FPaQgTNVMUR3EqktyRT
         VO1JQyqCV5gz1DgUVXXwxoWfhlLHV0ftgKvfTFhQ39RxnEsLnbnUPsXWX+3reSTKX+It
         klsnt3pULITv8aKaQNXosxUH2XatR8pU5Hgnw1LgRRxeDTaDgSmKhppbF232C3q885YL
         WAXQ==
X-Forwarded-Encrypted: i=1; AHgh+RpqxhE1oPMLliXqp/lYhZfvQo6Zc+tp1w3nv15FxWktcJvRBDXtoT68pn+wt82zUWuh6RtP5rP32dk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVj6qyuGv71Ld3e+lxEsEhOtov2BpvccoNNtUiiO36njVviapG
	SQ1sJZ/0juZ9UbXINrxcbhAfuk3le06jE6E9eSsuwayFNyHHA8s+QywucPyat/cFwPQ/byTZeGp
	RfT8QtBUQZvMpuHqvaO9NvbgK/+9YHXRZSU5L5GUBviou/Iou4Jp6Dxs2JFPJsQs=
X-Gm-Gg: AR+sD10CiCpLDmUepTL3SbTxKO0MVPy5bvLt6c2shlKHqDpOJ9M4kffqZB+ymM3MQ9u
	fT9XhfUeBaJpbSHuryylqoerl7SqBayFL1MNz/7C62Oyfh3GOe/D5TpS1zb4taq7vDdr5j86FtO
	lUTBSE1AU7lmHN5jZhVmUC44KIhqAaxzAlVuRAzXYwgxrco03xYbLpluwJPITUO4aDO3VTdAJcj
	X1Br7Iyr3dYd/OzIp3xDKv/mcvGdN2eObpn+i5cMOGZ3520fLzCLXxsP5lq8O4DaprlhJQHr8PC
	uGk2CO5xKJLHweXom0drYb9K30tawVGhXYMHtLwh9bu48YzR7xzpNbXPOarkjnRcAH/IvOVBKha
	/iG5/MTwIcHvMYRHgOu9q5/esXkh9Dz3+CeI=
X-Received: by 2002:a17:90b:5605:b0:38e:9e9e:ec57 with SMTP id 98e67ed59e1d1-38fbc561025mr13225896a91.43.1785846089946;
        Tue, 04 Aug 2026 05:21:29 -0700 (PDT)
X-Received: by 2002:a17:90b:5605:b0:38e:9e9e:ec57 with SMTP id 98e67ed59e1d1-38fbc561025mr13225871a91.43.1785846089478;
        Tue, 04 Aug 2026 05:21:29 -0700 (PDT)
Received: from hu-mchunara-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fedc650a0sm1237832a91.14.2026.08.04.05.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 05:21:28 -0700 (PDT)
From: Monish Chunara <monish.chunara@oss.qualcomm.com>
To: Monish Chunara <monish.chunara@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
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
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH V4 2/2] arm64: dts: qcom: Enable SD card for Shikra EVK
Date: Tue,  4 Aug 2026 17:50:54 +0530
Message-Id: <20260804122054.3462145-3-monish.chunara@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260804122054.3462145-1-monish.chunara@oss.qualcomm.com>
References: <20260804122054.3462145-1-monish.chunara@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA5OSBTYWx0ZWRfX4PABlRJziP7h
 kYhDilUgzDgT5uwrqnJbdTiORDQegcADh00ZbqVzx/vApEggjTvdIZccKaq/Ew9Sb9yF8FwUhcI
 A6BSwhO/zYT5mV6oKJwOQNYkU+CcClU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA5OSBTYWx0ZWRfXwTRCr1ghaghZ
 RRh2h6bHXlkoLeXquPGpkD6bxIEyrbuxvKpyW3qklCjMEBsnHgApphCuqBrI/JkcChY3d8WYHGS
 rGVZ6lklQZ7/22HmDMzrIxKv8kVBHWaekHRV8cVbbCIBxwxn9Mf5SNT5TN0HRWEt8QwEIYcMreT
 NeOcc3qEW9PLyaLW12wFuP/tJFnszSFTc0G/jStGQhvKBDpGNl9vROpRLmXImv0wsssoc/4ow6B
 68twGHhAZPfi5WqW6Yn+0vL7J8RB0dYTHHEqG79nFMerIJVnCfb4Nxkwy/dWPwV4JpTu/x3DTNe
 Tu06U1KygiFIrk+blM0dosvSDts5ONVI76ajhClqH1F2E0qFS5ISASJ5PmHpmBXYuiIdZnMgA7Z
 foL314Lhxd7Ww3K5EHzy6V9BfBSb5ZbvO++GFmpOZ36W8v4nOIcjtptArvBPZpkQR5cHUvp4eH/
 3kcrUKwMWu5DkhrcoWQ==
X-Authority-Analysis: v=2.4 cv=Nu3htcdJ c=1 sm=1 tr=0 ts=6a71d94b cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=fJiEX4jLqVLmUz1iUe8A:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: -S-oyhk93P34dAlrQcir4GTvfEDkP2_Z
X-Proofpoint-GUID: -S-oyhk93P34dAlrQcir4GTvfEDkP2_Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040099

Enable SD card for Shikra CQS, CQM and IQS EVK variants. Configure the
vmmc/vqmmc regulators and gpio-based card detection for each board
variant.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Monish Chunara <monish.chunara@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts |  9 +++++++++
 arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts |  9 +++++++++
 arch/arm64/boot/dts/qcom/shikra-evk.dtsi    | 11 +++++++++++
 arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts |  9 +++++++++
 4 files changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
index 0a52ab9b7a4c..8e4656a51371 100644
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
 	};
 
@@ -38,3 +40,10 @@ &sdhc_1 {
 
 	status = "okay";
 };
+
+&sdhc_2 {
+	vmmc-supply = <&pm4125_l21>;
+	vqmmc-supply = <&pm4125_l4>;
+
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
index b3f19a64d7ae..c13a02cfafeb 100644
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
 	};
 
@@ -38,3 +40,10 @@ &sdhc_1 {
 
 	status = "okay";
 };
+
+&sdhc_2 {
+	vmmc-supply = <&pm4125_l21>;
+	vqmmc-supply = <&pm4125_l4>;
+
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/shikra-evk.dtsi b/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
index 6eb4184f7642..177a599cd2c2 100644
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
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
index 3003a47bd759..5d400d50a7b1 100644
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
 	};
 
@@ -38,3 +40,10 @@ &sdhc_1 {
 
 	status = "okay";
 };
+
+&sdhc_2 {
+	vmmc-supply = <&pm8150_l10>;
+	vqmmc-supply = <&pm8150_l2>;
+
+	status = "okay";
+};
-- 
2.34.1

