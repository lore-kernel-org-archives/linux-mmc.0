Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133AE348C52
	for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 07:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782718584; cv=none; b=AFm2jFm8wmT7sZ4qmT/SvbbsWEeNHON53WvnPvyC4K4/QFOR+WqaPz4ijT+sTKcdvqtAKjvKs8cNV0QMUKpo4wPV4bPqwgr/czdtgODgpNOZ2d5L70oPL9jm5/Cp76TZlIxiAZI7ykO21mVo4BZqm5rI+eu2gjbOvfPlnCC8R8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782718584; c=relaxed/simple;
	bh=T3CEPNSb8/M/dIWXVKivM2Blp2huvn6qcxNDVkeD2e0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TLxf6qLzmcmSqwtOuHQxXh+ArO0Rl16E86FL9wNIHe9nLX8aaXjfFGJBtAd1Ir7IaCuaLfa/lPUqsoy9K/yMYpomFgQoTYV48epxvry2kwcrbip8p/aaK1wQSTpTaQSDiJJyvaK/gDGxp7Fo0FfyRJ6J4tfHl8EGmxnLertlfbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K7FDqHdA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e0fayKy2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K7FDqHdA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e0fayKy2"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T6reoN2125093
	for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 07:36:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0C+QKuMIW0soZc99z5bsH2GplHTlcg46DYutDjU8hP0=; b=K7FDqHdAOWM8RANw
	w8d0LOSvmepGPmsZw+w3gasQ6nXzv5a//W5IBXSwlx4WvMaiMApjNc2RY7TRAUhj
	mlFO7wNokVZT4BJMXyYOshr4u3PENaioqgVN1jiz7I60M1ktjevoYwIhLu/Qs28E
	kdUy1mRwg9E+pLOJXMlZvhDs+PKuZfLVJ5ZBxdHdzd55epgicIny5X2s4Cx4H5B2
	+WYTl95fOXRjPh37WcskqxyHIdR8bSz66gBVlVle78hhxP8KQLVXKjFHI00EEzqe
	oiLlM82kqcPsxlYnwUa0evExK3oMzOV+lASxpYQX2OQVVpSojr22RMDuDW/1UP2o
	NnOG0g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27335b3k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 07:36:16 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-37d4eede8ccso1779289a91.0
        for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 00:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782718576; x=1783323376; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0C+QKuMIW0soZc99z5bsH2GplHTlcg46DYutDjU8hP0=;
        b=e0fayKy2iBd+oqR/GJq06YzWSed8wiVrKnVIyKOfC8qeyGMzon/wHP15dRoepD05hT
         xf1PSKDNKzqol6hLww5N3Mn4dAncbu6fxrQj0Bia+mxHh257ySCtEcXoJd7bZ8o1OBUd
         ZnA44RWMMkc8F6UYqxf7pnoCC+J7NLz0mprF3TtGDEgxvb+4KTvJ+dw9GI/8MfsSD/0J
         zm49X9y5zGFcfEUzP2sJoVA9ExCyXmnk/469UBtDSBaROK3frQH65KQwDcvDAMUSUf5f
         fIAMnmYhKfpqb25G4giLh6kPlIYXT+V7U/FLCwVRke5duXO+xsz/M8xVv9qXMd2KSFph
         /J4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782718576; x=1783323376;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0C+QKuMIW0soZc99z5bsH2GplHTlcg46DYutDjU8hP0=;
        b=rI9gxCuHV5t3NcLqaM5uhiE+bV0xIHY6TPmVPBNQRvfA1QC3fJGvZtivkuttbKG6gT
         8fqyEoidNXpTYI+RS5JBoLlqpYetOCTGBq9y6zAXxkqmKG9kIoq6tLa8+41IJk0SH65e
         M/C56OyKmU7t2OjUJ5NnpVJXfDD5c0N4RjX72bXTu0ozyhkpu5BO2b3I8SrgfloBA1nI
         MiZDOSDiWZ5szHfU7d5ccwwAfXCIuuq0jnbwio2q8jHY2MOsSznYcUCsW2WruiOxWAlo
         aD2eLhKulgFPBuxXl6k1YvusaRu4mNKmI7QKe9uCsB/8eT/SJ7Iyi1n752ik4yLYm4W0
         d3aw==
X-Forwarded-Encrypted: i=1; AHgh+Ro5JMGU2ONU2FS8NgxklAN9IhimXtzXj25wx1iJ2E+ZcKDXXNEqWME87ijPkByWSJ6RYr4CQpgaiTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLOZiP4v0XcbKdT9ijADunULGSmYR8d8qnhfkiUAMiItDzY2sP
	dfSlhkQuyYslRzzbjqPFWJ2GueAJLjT30h5MnRSjnnm80qhQPSuxj2NSiXHl0jkEHdSd/twMV71
	fUypJLmVvgZdndO9Vxn31gu/JMjmJv7EgH5zbEjcH77i8+mjRhvbP9M8QEtLDw5A=
X-Gm-Gg: AfdE7ckPHGwm811FDjVJXP5VlneLkCGpsH8cJzxmQpnyoLkWX6GJ29Vyg/CmmJA1p24
	aEp+g4eh2bwmZhpbqVPUWq4MGYWhWb28lpIf9g+GNezC+uf3TddBRqbBGYk7PFHOiWYXh0aUdxk
	tLpquy7PRtcvuK+zn6Sqcn8FNJuxMtU7i4scLIXDZFDkrU17Hk66T0yLU3eKMGAR18ojDsI7PB5
	teuXdvRm5wAyKn7zVOnTuGwtYP980bIonw/CKlFCUJYYwTF5I7eBjeUw5Lwbpmj5fnFvh22mLX7
	t1bPRpuxZ9sMJzutUiB4xFkw+I6d0mKwAOWQ2pAfuJS4iKGhgYpTLaH4lYMevjWrf/8pfc0d/rY
	K/EBedJAfiT/B3KS1G42yAqVUHBFwI5jf9G1rmiqqsXQQ
X-Received: by 2002:a17:90b:4fc1:b0:37f:d9dc:557 with SMTP id 98e67ed59e1d1-37fd9dc06ffmr5040238a91.16.1782718575572;
        Mon, 29 Jun 2026 00:36:15 -0700 (PDT)
X-Received: by 2002:a17:90b:4fc1:b0:37f:d9dc:557 with SMTP id 98e67ed59e1d1-37fd9dc06ffmr5040220a91.16.1782718574982;
        Mon, 29 Jun 2026 00:36:14 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37fa9629f8fsm4537979a91.8.2026.06.29.00.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 00:36:14 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 13:05:32 +0530
Subject: [PATCH v8 2/3] arm64: dts: qcom: kodiak: enable inline crypto
 engine for SDHC
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-ice_emmc_support-v8-2-1a26e1717b85@oss.qualcomm.com>
References: <20260629-ice_emmc_support-v8-0-1a26e1717b85@oss.qualcomm.com>
In-Reply-To: <20260629-ice_emmc_support-v8-0-1a26e1717b85@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neeraj Soni <neeraj.soni@oss.qualcomm.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=F+FnsKhN c=1 sm=1 tr=0 ts=6a422070 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=uKQuvSuCY7vHg_iPvDkA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: 3l1Ax6gUIG2p3qTqRURgfiMDVukC1kCz
X-Proofpoint-ORIG-GUID: 3l1Ax6gUIG2p3qTqRURgfiMDVukC1kCz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA2MSBTYWx0ZWRfX5Ti1EQ2aD0ji
 IJv2ptvpe79QHtK++zE0jLUQmr5Co29IeqnU/O64yrVqCmCRWMOOwFSl2hbx+0o/gkddXD1tv0U
 vYDCwmfjeD8GnOWUWZI7J7TvA5OQsdaqxZgrpty/bYNu8SP77Fi8VIUFM0RLr9Z/6+ZaCOKo9OF
 xmeOzJJN5KGJj7SBRF0h67mireEr/lAY+E5AzS6boSxKduz81APqryTisdGF7tf+wejXNmDCozZ
 GhZf8q5ZPeUGSjCrHOzgXWNKLM4uUZ4yFj+wVrX3nMEBfh/0CmDaldscaPXUmsEsbSJ1vuJ5wkb
 9y+k5xfhM6nolK2uQ/IW2stE6Vy+Yd7Hye+EGM5aqQpX/wUnlci1hMTplforbbM0o2lCzxo+RUh
 Fsso0uGCTsbmKShsx3xG7E5MfSYNVN6UalqZ+I+QFp2s7sA2QPXBrZ2fRakswF5u7Bv8WX5b/tK
 74qpxZkuHyKj0k+9onQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA2MSBTYWx0ZWRfX/t6GqyfDNnTZ
 7HwdY3lj3OnLbR+lnOYrTzNSnkroPBO2ubz/DgAj0MrhSXS9SprJR4pLoeNfY4tVyO2ujUHv6JH
 A55UkPSznpYpwREHdhthc4f34yQMJ1I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290061

From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>

Add the dedicated ICE node for kodiak and reference it from the SDHC
controller via qcom,ice.

Keep the ICE node disabled by default in kodiak.dtsi and enable it in
board DTS files where the corresponding SDHC node is enabled.

Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Co-developed-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kodiak.dtsi                       | 14 ++++++++++++++
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts                   |  4 ++++
 arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts      |  4 ++++
 arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts          |  4 ++++
 arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dtsi      |  4 ++++
 arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts |  4 ++++
 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager.dtsi    |  4 ++++
 arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi      |  4 ++++
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi                   |  4 ++++
 9 files changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
index fa540d8c2615..633ebfd86352 100644
--- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
+++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
@@ -1050,6 +1050,8 @@ sdhc_1: mmc@7c4000 {
 			qcom,dll-config = <0x0007642c>;
 			qcom,ddr-config = <0x80040868>;
 
+			qcom,ice = <&sdhc_ice>;
+
 			mmc-ddr-1_8v;
 			mmc-hs200-1_8v;
 			mmc-hs400-1_8v;
@@ -1076,6 +1078,18 @@ opp-384000000 {
 			};
 		};
 
+		sdhc_ice: crypto@7c8000 {
+			compatible = "qcom,sc7280-inline-crypto-engine",
+				     "qcom,inline-crypto-engine";
+			reg = <0x0 0x007c8000 0x0 0x18000>;
+			clocks = <&gcc GCC_SDCC1_ICE_CORE_CLK>,
+				 <&gcc GCC_SDCC1_AHB_CLK>;
+			clock-names = "core",
+				      "iface";
+			power-domains = <&rpmhpd SC7280_CX>;
+			status = "disabled";
+		};
+
 		gpi_dma0: dma-controller@900000 {
 			#dma-cells = <3>;
 			compatible = "qcom,sc7280-gpi-dma", "qcom,sm6350-gpi-dma";
diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
index bdc02260f902..1af10068edf5 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
@@ -1158,3 +1158,7 @@ &lpass_audiocc {
 	compatible = "qcom,qcm6490-lpassaudiocc";
 	/delete-property/ power-domains;
 };
+
+&sdhc_ice {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts b/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
index bb5a42b038f1..ef126e29f09d 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
@@ -1093,3 +1093,7 @@ &sdc2_data {
 	bias-pull-up;
 	drive-strength = <10>;
 };
+
+&sdhc_ice {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
index df39a64da923..5b10ce277fcf 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
@@ -136,6 +136,10 @@ &sdhc_2 {
 	status = "okay";
 };
 
+&sdhc_ice {
+	status = "okay";
+};
+
 /* PINCTRL - ADDITIONS TO NODES IN PARENT DEVICE TREE FILES */
 
 /*
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dtsi
index 0add7a2a099c..1bb0e4b8caac 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dtsi
@@ -98,6 +98,10 @@ &sdhc_1 {
 	status = "okay";
 };
 
+&sdhc_ice {
+	status = "okay";
+};
+
 /* PINCTRL - ADDITIONS TO NODES IN PARENT DEVICE TREE FILES */
 
 &ts_rst_conn {
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
index b04888a98203..78e0309b699c 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
@@ -126,6 +126,10 @@ &sdhc_2 {
 	status = "okay";
 };
 
+&sdhc_ice {
+	status = "okay";
+};
+
 /* PINCTRL - ADDITIONS TO NODES IN PARENT DEVICE TREE FILES */
 
 /*
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager.dtsi
index 38c8a3679fcb..ff26dee6b804 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager.dtsi
@@ -88,6 +88,10 @@ &sdhc_1 {
 	status = "okay";
 };
 
+&sdhc_ice {
+	status = "okay";
+};
+
 /* PINCTRL - ADDITIONS TO NODES IN PARENT DEVICE TREE FILES */
 
 &ts_rst_conn {
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi
index a4fde22e3355..ecf518f2267c 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi
@@ -74,6 +74,10 @@ &sdhc_1 {
 	status = "okay";
 };
 
+&sdhc_ice {
+	status = "okay";
+};
+
 /* PINCTRL - ADDITIONS TO NODES IN PARENT DEVICE TREE FILES */
 
 &ts_rst_conn {
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index 8cac4ce9c851..dfefcad57f7a 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -744,6 +744,10 @@ &sdc2_data {
 	drive-strength = <10>;
 };
 
+&sdhc_ice {
+	status = "okay";
+};
+
 &tlmm {
 	amp_en: amp-en-state {
 		pins = "gpio63";

-- 
2.34.1

