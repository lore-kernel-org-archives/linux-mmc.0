Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705733A7194
	for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 09:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789119606; cv=none; b=OMMK29uke3rC/PDbkM85hOmFuD7BpxfQZrBzqVpmh/+j66F35F6X/o+hwsXHvWGbDA97CcjT7J34A5bae1aFf7BLHZhY6DiaJeDEpwMcOLm+a4OK2tqrWMEiFGoVYZCWwbX6YzOg7yEmY+z1BoHMPJcO/q2sZKpdXMx7ba2islU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789119606; c=relaxed/simple;
	bh=bsC1feJRpqzd0Nbr+etWKk/hN9TrxWr4aoH1+V1XhyM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iA/oPlS/UX9aZ14/xGEFmYutFgF/55LhE9pVp3q3YpHIXTJpw4XlzBhfYrdqZhgId/rdYdE1b0NNW5pl0vzT818TM9brioAjEqbl1dhAK/kmB8qlJaKY5soa4YlMNkeiEBSUd7ggOM9FXTDv4yspaVRX7OfjrbhkZF49kiSNKz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BBSh9Y9Z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iz8ROJQI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BBSh9Y9Z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iz8ROJQI"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68B7kfip3366295
	for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 09:40:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=FzFT6kXhpHl
	ikCbZq7Ay1pC0UHtIg5fj9LyUX6GW0CI=; b=BBSh9Y9ZsLZwvAKdZwo7IrLpNVr
	YfFJuhv1aiH4arfu68Pz+LCjEC4h+XBzHCaEYXiXFJ+ruu/w4oatrSu/eSsqajFl
	+TaNgEJzOsOzvFLqMsuzUYxGR/5znCR8cqrSDKIV9kgnSLJAv6HCVUbY1Gb27/Qw
	VR7zlHuDki9UBfd7TWi6Ylydt/dsNUaIkK0ct0dQuNME+LqL06odnFfEfM2o4Urm
	EciunPeIBRbGHlg1wXK4aMbG2FIy9cK9O0T2IMStO9J2sbzvwsxGXXh/Kf8/LOCn
	S2+9RM8R0DVIv3ikYbP56ziH9FTL9z9XXnbr4/JGoxI8P+QlmX9f3PoGMkQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gm1k2b6a6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 09:40:02 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3968dfff779so1145781a91.1
        for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 02:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789119602; x=1789724402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FzFT6kXhpHlikCbZq7Ay1pC0UHtIg5fj9LyUX6GW0CI=;
        b=iz8ROJQIqT1rrW0Jvaev6iQYMshfszH5dq/vlyGcubTZAsiMdSUg3IXx9/dqY423I9
         5NkBLBkoXUMFya3lOvFCgyFJ0Sq+OzD2YKs9HStWbqScGujQkZLMfQ5huERSiArAWeGM
         QWNO0lxXDBnW9dkdAFFNXtB6EUGTuWopj9LoODqqzAshQXaue7TizM+ES7QPjtfuqXqO
         9D5Y88Gn7PFDs0+DX9BgZFZF4DuHCgIvTWXv8dXnM+HPZNNFTO/2WRzrmYc/gvJpRrrO
         AtP6vDYpFy367o2Kju7FVhxeBQPKlWtjkcTdJzCTHKkccBBqsByNrvqmfKBI7jFuoiQ9
         b3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789119602; x=1789724402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FzFT6kXhpHlikCbZq7Ay1pC0UHtIg5fj9LyUX6GW0CI=;
        b=iPsc6dzmfa8l1YsCvfw1yThBz7SLwgk+6R2LRrjbUNxdmUAGwuwmLJj/p0d+i3S2HA
         VapPunTNkT0CU91iqWXrOvS+78KMswPSc8IARtnkLTFdFw9elYD1Pos49H31v7KuZCK1
         CtgEWw6Beduz4YOz54Ryquf0yeYejmOES7CdIIrtcNKQPKdFvP5b6aHoKxtT2P5L3vxj
         FBH1EVH8syxWW8vY3aywtoXymKW2GqCAh+yGuh9p+jm7k/QRy1FqlI7OKAgX4kGpo5fh
         nzJLTS7fj06GWXoHK4xNkZxnS0yLpYPd9uYUTyh/7y8CKJmqfpoEt0gFaOFwMC6jMags
         1wzA==
X-Forwarded-Encrypted: i=1; AKwUvBwKFBIJFNhNO5+R/jQG4sfXmTfAmkxDSMAUKXd+8lYrVnkmHRqAV02GA4u2m4GtPI96wAqNYoBo5TQ=@vger.kernel.org
X-Gm-Message-State: AFuF++noro7kwjJwGCR9M1zh+ed4czvGEYc5rRkpllHNJjkwk1wXW98u
	fL8Kaa3ltwSOYQSj+djgQaoXcOEOxPkjwgz9Ov0ZoO/Ml07Os40MXRVqbqWzmRUOTBBBSIKMGBg
	AKwEqOmHV9FlPHy8DJY05j9u+yb/Oad4I3Ty//E9lWmPGakRJxEV7HVBzPtQNPuo=
X-Gm-Gg: AYBFou3RkECOjQRKBxUi/yLm10Bq9M35HoKBZfM6c826Bt7WC9Yh8IeaKAQYufBvrdw
	aIuFixjs1tOBFR2CAab70CnnSLNl15RY0Qd3Smaqs7B0N59M+hS4+gI8AJJ4Sqc6hs5nOHZECaJ
	1AjJQXv09hvOcscszYM1Mu+8ThbnyE8FXJ4opG6VTrxnOWKlzeh4sVPVXYAbnyjWYy4LdKBYp9m
	/YHexVuQO0cPi6sTuwCpHm+fylJ2ZRleaSdCuUSS0F0vAnzWJqwDyP6xmt/srT9dJTE5ceNBcys
	QuMhlpUxU2PS3F+OywYtUKT4NYDNQA5KBBYUtC3NdMvR8aZqCYayPw7zLLri9LhGrj+CEeAKusD
	aN6e5VsG//ZMmny3fZkFxc+9mgQ3F/AKJLr8=
X-Received: by 2002:a17:90b:544b:b0:394:ed5c:ff9f with SMTP id 98e67ed59e1d1-39d77b1d022mr6555557a91.17.1789119601630;
        Fri, 11 Sep 2026 02:40:01 -0700 (PDT)
X-Received: by 2002:a17:90b:544b:b0:394:ed5c:ff9f with SMTP id 98e67ed59e1d1-39d77b1d022mr6555487a91.17.1789119601027;
        Fri, 11 Sep 2026 02:40:01 -0700 (PDT)
Received: from hu-mchunara-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f55735sm5549984eec.24.2026.09.11.02.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 02:40:00 -0700 (PDT)
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
Subject: [PATCH 3/3] arm64: dts: qcom: Enable SD card for Shikra EVK
Date: Fri, 11 Sep 2026 15:09:32 +0530
Message-Id: <20260911093932.2376058-3-monish.chunara@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260911093932.2376058-1-monish.chunara@oss.qualcomm.com>
References: <20260911093932.2376058-1-monish.chunara@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=cM11IVeN c=1 sm=1 tr=0 ts=6aa3cc72 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=lpphfDA4Acmd_1yfjz8A:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: nvulDIaZZd-ckbDicEC16Td5qDDkR9ym
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDEzNCBTYWx0ZWRfXzNVqUdSvPVYj
 NUYg4Wo/ckksAdDKv0gyu5HsesX5U1x+QAtYB89Sh+CgdYRqMMzZC5UGWXAkW9RR91U2YPW9Xsw
 GZM7/XNNoVNvopsBvKh1+Gs92Woa/lI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDEzNCBTYWx0ZWRfX9iZEn8cWoe8K
 R4xwiD8M705ARHRfjVKZoa/zmUoVF2oPmbvZ3gv6XLDiIkAzJxIZ02AZWvSu/dJivGG/VsDM6lF
 xv94diOLch3H4B3TfifUHc8ZKa1SegXwmj6QF97V7KOqqXdPCznuHE2BjhY/o3QvhtqSTcqZGhS
 gVZo4/NSMERdFKyoMSvFJpQPIXvarVt2jAVFsM0baeUFm76grPQqH6hp3LN71d/SIBLpnXAP2i/
 Vxv4yRiYAXmA8uCJ5ohTR/VjvBLhv0T2Uj5y2UQzeGdsBS9SfH2xdZQbK0uDwj8AT9u7tFjFkYd
 Ihqz5xSjYAoNXgTgLMtIVODw6KTAYMbiAljlVDic1ZyBdKO6wcEPsXLupQrClsHt1HODdsktBOK
 3QkjJYgxFtBTebe/uqjy7IRl9Sk4oLmij6l5pwsXRTdiMxyzNCQ90Veg6a0gbLzgnjsKGUgFoD6
 59N/s9ZeLGpXqs34ezQ==
X-Proofpoint-ORIG-GUID: nvulDIaZZd-ckbDicEC16Td5qDDkR9ym
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110134

Enable SD card for Shikra CQS, CQM and IQS EVK variants. Configure the
vmmc/vqmmc regulators and gpio-based card detection for each board
variant.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Monish Chunara <monish.chunara@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts |  8 ++++++++
 arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts |  8 ++++++++
 arch/arm64/boot/dts/qcom/shikra-evk.dtsi    | 13 +++++++++++++
 arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts |  8 ++++++++
 4 files changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
index 286ea46d0c36..2d81b39cc9c1 100644
--- a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
@@ -15,6 +15,7 @@ / {
 
 	aliases {
 		mmc0 = &sdhc_1;
+		mmc1 = &sdhc_2; /* SDC2 SD card slot */
 		serial0 = &uart0;
 	};
 
@@ -66,6 +67,13 @@ &sdhc_1 {
 	status = "okay";
 };
 
+&sdhc_2 {
+	vmmc-supply = <&pm4125_l21>;
+	vqmmc-supply = <&pm4125_l4>;
+
+	status = "okay";
+};
+
 &usb_1 {
 	dr_mode = "otg";
 };
diff --git a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
index 01400612d147..570e77e6d1cc 100644
--- a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
@@ -15,6 +15,7 @@ / {
 
 	aliases {
 		mmc0 = &sdhc_1;
+		mmc1 = &sdhc_2; /* SDC2 SD card slot */
 		serial0 = &uart0;
 	};
 
@@ -66,6 +67,13 @@ &sdhc_1 {
 	status = "okay";
 };
 
+&sdhc_2 {
+	vmmc-supply = <&pm4125_l21>;
+	vqmmc-supply = <&pm4125_l4>;
+
+	status = "okay";
+};
+
 &usb_1 {
 	dr_mode = "otg";
 };
diff --git a/arch/arm64/boot/dts/qcom/shikra-evk.dtsi b/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
index 7cdbd257e9c9..620c9956d5e6 100644
--- a/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
@@ -3,6 +3,8 @@
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
+#include <dt-bindings/gpio/gpio.h>
+
 &gpu {
 	status = "okay";
 };
@@ -17,6 +19,17 @@ &qupv3_0 {
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
index 543d769125ef..a1757e24d1cd 100644
--- a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
@@ -15,6 +15,7 @@ / {
 
 	aliases {
 		mmc0 = &sdhc_1;
+		mmc1 = &sdhc_2; /* SDC2 SD card slot */
 		serial0 = &uart0;
 	};
 
@@ -58,6 +59,13 @@ &sdhc_1 {
 	status = "okay";
 };
 
+&sdhc_2 {
+	vmmc-supply = <&pm8150_l10>;
+	vqmmc-supply = <&pm8150_l2>;
+
+	status = "okay";
+};
+
 &usb_1_hsphy {
 	vdd-supply = <&pm8150_l4>;
 	vdda-pll-supply = <&pm8150_l12>;
-- 
2.34.1

