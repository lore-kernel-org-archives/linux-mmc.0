Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D558F3F8893
	for <linux-mmc@vger.kernel.org>; Wed, 27 May 2026 15:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779897347; cv=none; b=QZSUE6Y8cdoEV5kHG141LbLxmGlxi3qfcYKBFNc14Lqm5WHpUfcgbV3POeqX9WPD+V926uUk1nNwk8vUJIYXB1fNb3DnRnBTJntx7weFtmfy0putHQLR/Bi6TEd2CKHnWI46FbCw/uuA0FYzkBpmLhJTHPaYz2WXDz47+sD2uYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779897347; c=relaxed/simple;
	bh=ODfMe8YwpE9zm6WOKy1yvRuBsZs9KnzIUkMMO4tFT3E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=idj5qFeV1CFMy/BKn6o6XR+uf7MoOzxQUg2I6DNJhaVNc6KDTEYYHCWz2bMYeaJgnd/F8mchZUNvhkCnmpq6NLczBrimCE1bfjXGcH9WjBeS3L/cHdml+N68LIp+Hp183NkmujlPnY7wl0WQurNa8hkLMPQmXn++EgnYDJmtZ80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WU9qjH8r; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VEXyDDh+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WU9qjH8r";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VEXyDDh+"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RFbeHw871123
	for <linux-mmc@vger.kernel.org>; Wed, 27 May 2026 15:55:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IlhEybdLwbReB9UAd0lx67zdA/XyQhjGmwbRzt5Ttzg=; b=WU9qjH8r9ZMfZOvn
	xGk4nGQujRa2iT6mIbQ1Cn30NtUcnlZJ4X6H7BwmDPOLLg1uSujPOw2DN41JtqUF
	lO9O1qTO8PBGkt/5Jop84u9pmUu9JxqBEBGagBdU/1RkvM9f/YH5VAlQSzS0VGaL
	pFItSV3y2fheiBIWirki7YqVNv7lWVw5wfPNnhG8RleKhxGgIBWpBRm3ZSHZggxG
	KZUD2X97IV4J/3zvXOfY5j4jExBArQ9dVPZzTMBH+IHCfmMvMUdXi0OBXsQWDJTM
	ysohmQUHK6micIWZ+R0Twtb4bIXMtygv9LJS6nwAg23zBejgsoP7GlskgNpXwHQW
	zDsCnA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edurua1jk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 27 May 2026 15:55:44 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ba115ab6bbso130591745ad.3
        for <linux-mmc@vger.kernel.org>; Wed, 27 May 2026 08:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779897344; x=1780502144; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IlhEybdLwbReB9UAd0lx67zdA/XyQhjGmwbRzt5Ttzg=;
        b=VEXyDDh+54cZv1Xfk+palgHSpMRy2zUrbue58PZdGS2Swyz0hixE0q4Z8tZHVLJOv1
         Av/W/nx6CEAi0TyH9isS6u6zAEtH1I541z34hkWEoKMjUygvonfNxErrBL5xKflth7b+
         VsvHIqeOMbojCD8wA/rbuiovcFxrgy7ULzgwKqM/Nx/cJ4GQfczc/Xh9xuqZxyWOXNpj
         gWslUZjVp3YPgiwwnx2tQZ7TbiMZgP33lR3xarCn7pAk0WgX69xGQ0DuHwnzyF8IjF7a
         RVpTDLbl6DxdcxvWMNyAcZz4b+3WquMoFf4TgwVa4qy4C0M1+xNlMdFaaGDouyLaQvzo
         CrfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779897344; x=1780502144;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IlhEybdLwbReB9UAd0lx67zdA/XyQhjGmwbRzt5Ttzg=;
        b=Iu9Eq+bdjRfx4bLmMcSSgM2d2as7+jpWKOcV5f8eUQQXdVLcXnMoDNSe9L6PUWYkoe
         /Xf5I8o29AotYHNObWTPJVBDMM+fUVRU0LOW7qyomLFX2izpQibkISkHfiR5v2VdYltI
         c0DKHBsSvHxgPSwpMKiczEOwOAK3l+wCVQgXw1rxWHIeEJ4JymVB/OIg3WC7A/9jdQK5
         VYknRrG6OZqJNUWBFdU7w0oZwrq2AL2kjpZZnt0acAt8Lbr+fPszJu0a+mEkZlaLYJxE
         q0Tv0svBmCEDNmq5oHjJrgHJ/m2v7g+VngceNShN/Kfy3x8/Xm8YCNKQStYRQGfma3gD
         IW6Q==
X-Forwarded-Encrypted: i=1; AFNElJ8hOcC+Jl4RR582DaEFjswSo9RLT90DBgXtNP3N6AUEEC4dM6YBRmyWe6zBIiFHJUc+nvMrh4Z+D3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI5UjNs1UGwTIOWghHB4dymmEA+t01egfM3YGZM+kjf1Mzz5hH
	r/EjX7YjG79r1B+DJiEnUWSQYo0FB6MXyAEqpVnP5vcibybJXCMiD/PYWeyr7WWkouOQ4325C0Y
	xt2ex/19jnl9eSvna+qzfVqOIEHdJyTrBBptLKvuqB17n3IEuQoZ2DgcfaKbe3vU=
X-Gm-Gg: Acq92OFDbcRma24ANZiP0XLtaGx0OBFymXFbR0LMGoqc7lfImim/fQ9YJVSNpBpGSMg
	ro6x2hjNeLVFfk8xGrQCDvaRXkx721AQ1S7Bqn8s5XgD7cJGLy8ne4g0a13k0Hn3N3nUpk4BbbY
	QndTHYbSXeKle6hmnMH+rXFJ7jKZu9tUXepmAZfrTzcMElqQabFhyFldQHlxO99SASyPSJqAw+Y
	0Q9ozNXHgYipwRY8uSEYDpfHa+vl3DXpiGM5AK95qp7iROoPdhrGwgVv9O2NxtNTDRxig2wtHLc
	mIvuRoNXS43delLH1hiJSrhO8XcCeXvV7oqp/KfLS1Biw5retlkQy4WNjJJEEdx0PENxp9+Us/L
	CjzaGKMywnOrqPyyZ/dc9vWxT+UPUxOOReNqn
X-Received: by 2002:a17:902:ce92:b0:2bc:a52c:c8fa with SMTP id d9443c01a7336-2beb076ead2mr253425355ad.26.1779897343621;
        Wed, 27 May 2026 08:55:43 -0700 (PDT)
X-Received: by 2002:a17:902:ce92:b0:2bc:a52c:c8fa with SMTP id d9443c01a7336-2beb076ead2mr253424805ad.26.1779897343045;
        Wed, 27 May 2026 08:55:43 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beff36894dsm1264135ad.37.2026.05.27.08.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 08:55:42 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Wed, 27 May 2026 21:23:54 +0530
Subject: [PATCH v4 4/5] arm64: dts: qcom: Add Shikra IQ2390S SoM platform
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-shikra-dt-v4-4-b5ca1fa0b392@oss.qualcomm.com>
References: <20260527-shikra-dt-v4-0-b5ca1fa0b392@oss.qualcomm.com>
In-Reply-To: <20260527-shikra-dt-v4-0-b5ca1fa0b392@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-mmc@vger.kernel.org, monish.chunara@oss.qualcomm.com,
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779897312; l=4539;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=ODfMe8YwpE9zm6WOKy1yvRuBsZs9KnzIUkMMO4tFT3E=;
 b=jyYeXsEL0Bq3VtQJhwc4rgTZTSMqWvMGcrLs8kjWOWBSArHZoDD/7m3I9UTqNjdmpgWOTDU9J
 Xt6s/sxjLkABhszm5a2pHyGBWlTP2T7No2xluZ5mUuWi5bjuNwhXpy3
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Authority-Analysis: v=2.4 cv=VY3H+lp9 c=1 sm=1 tr=0 ts=6a171400 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=IZjsGcCFCfEoDLf82CEA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: p6ZqTc0952kqJibjcL_iS5cdAUzjO6DW
X-Proofpoint-GUID: p6ZqTc0952kqJibjcL_iS5cdAUzjO6DW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDE1OSBTYWx0ZWRfX7EX2nGX+w7ez
 Njjf4wzrkYUMmR9R8xvsDQjm8ih9pLlnDPoLSlnhY33/IrehxA94FlW+dRZ3SpNTm7T7RrcHWXY
 KJKsku+PQBv9B9bSHRpB6PYeEScK2L/3a+BJ7cT2n6ZRxbtPkzbEuVJVYeWOrJWFu2SYzgvZiDb
 5+4wuSjAfBgKMLz7fnhDGXEps3MeS/CEnM4nay+sMiZG2ddud4WzSfC9OC0CIhr5oSYfahBojum
 S05aXn+WuRc7RoR5K2PKDqQKAc/WOGjuOV5vvjnx7Z4rCzuUR9hSSqKbRwZX78tkWLMc2Lis+l1
 g5Ex136HOaY09jmGlKLNzEmFqTfk7shWQVeDhSqIGI118adLLdhl++noTzEInTJSdvh86KWLI0B
 jlFoDjfnUIkdutAv/HyCGHnbOp1Dt8NWn35yTVbzMRlgb3SVBy5PVzJDwCj0UKeTFiO6U7TCtvd
 q6uKHA6SDCTRbazuXkA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_02,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270159

Add device tree include for the IQ2390S variant of the Shikra
System-on-Module, an industrial compute module integrating the Shikra
SoC and PMIC for industrial IoT applications, designed to mount on
carrier boards.

  - shikra-iqs-som.dtsi: Industrial SoM without modem (PM8150 PMIC)

The DTSI includes the common shikra.dtsi and adds PM8150 PMIC regulator
definitions specific to this variant.

Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi | 170 +++++++++++++++++++++++++++
 1 file changed, 170 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi b/arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi
new file mode 100644
index 000000000000..73945bf42112
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+
+#include "shikra.dtsi"
+#include "pm8150.dtsi"
+
+/ {
+	gpio-key {
+		compatible = "gpio-keys";
+		label = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&vol_up_n>;
+
+		key-volume-up {
+			label = "Volume Up";
+			gpios = <&pm8150_gpios 6 GPIO_ACTIVE_LOW>;
+			linux,input-type = <1>;
+			linux,code = <KEY_VOLUMEUP>;
+			wakeup-source;
+			debounce-interval = <15>;
+			linux,can-disable;
+		};
+	};
+};
+
+&pm8150_gpios {
+	vol_up_n: vol-up-n-state {
+		pins = "gpio6";
+		function = PMIC_GPIO_FUNC_NORMAL;
+		input-enable;
+		bias-pull-up;
+		power-source = <0>;
+	};
+
+};
+
+&pon_pwrkey {
+	status = "okay";
+};
+
+&pon_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+	status = "okay";
+};
+
+&rpm_requests {
+	regulators {
+		compatible = "qcom,rpm-pm8150-regulators";
+
+		pm8150_s4: s4 {
+			regulator-min-microvolt = <1080000>;
+			regulator-max-microvolt = <2040000>;
+		};
+
+		pm8150_s5: s5 {
+			regulator-min-microvolt = <1574000>;
+			regulator-max-microvolt = <2040000>;
+		};
+
+		pm8150_s6: s6 {
+			regulator-min-microvolt = <382000>;
+			regulator-max-microvolt = <1352000>;
+		};
+
+		pm8150_s7: s7 {
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		pm8150_s8: s8 {
+			regulator-min-microvolt = <570000>;
+			regulator-max-microvolt = <650000>;
+		};
+
+		pm8150_l1: l1 {
+			regulator-min-microvolt = <312000>;
+			regulator-max-microvolt = <1304000>;
+		};
+
+		pm8150_l2: l2 {
+			regulator-min-microvolt = <1650000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		pm8150_l3: l3 {
+			regulator-min-microvolt = <312000>;
+			regulator-max-microvolt = <1304000>;
+		};
+
+		pm8150_l4: l4 {
+			regulator-min-microvolt = <875000>;
+			regulator-max-microvolt = <975000>;
+		};
+
+		pm8150_l5: l5 {
+			regulator-min-microvolt = <788000>;
+			regulator-max-microvolt = <1050000>;
+		};
+
+		pm8150_l6: l6 {
+			regulator-min-microvolt = <875000>;
+			regulator-max-microvolt = <1000000>;
+		};
+
+		pm8150_l7: l7 {
+			regulator-min-microvolt = <1504000>;
+			regulator-max-microvolt = <2000000>;
+		};
+
+		pm8150_l8: l8 {
+			regulator-min-microvolt = <1150000>;
+			regulator-max-microvolt = <1304000>;
+		};
+
+		pm8150_l9: l9 {
+			regulator-min-microvolt = <875000>;
+			regulator-max-microvolt = <1000000>;
+		};
+
+		pm8150_l10: l10 {
+			regulator-min-microvolt = <2700000>;
+			regulator-max-microvolt = <3544000>;
+		};
+
+		pm8150_l11: l11 {
+			regulator-min-microvolt = <1100000>;
+			regulator-max-microvolt = <1304000>;
+		};
+
+		pm8150_l12: l12 {
+			regulator-min-microvolt = <1650000>;
+			regulator-max-microvolt = <1950000>;
+		};
+
+		pm8150_l13: l13 {
+			regulator-min-microvolt = <2921000>;
+			regulator-max-microvolt = <3230000>;
+		};
+
+		pm8150_l14: l14 {
+			regulator-min-microvolt = <1700000>;
+			regulator-max-microvolt = <1910000>;
+		};
+
+		pm8150_l15: l15 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1900000>;
+		};
+
+		pm8150_l16: l16 {
+			regulator-min-microvolt = <1504000>;
+			regulator-max-microvolt = <3544000>;
+		};
+
+		pm8150_l17: l17 {
+			regulator-min-microvolt = <2700000>;
+			regulator-max-microvolt = <3544000>;
+		};
+
+		pm8150_l18: l18 {
+			regulator-min-microvolt = <400000>;
+			regulator-max-microvolt = <728000>;
+		};
+	};
+};

-- 
2.34.1

