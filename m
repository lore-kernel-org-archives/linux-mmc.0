Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D582043D4EE
	for <linux-mmc@vger.kernel.org>; Wed,  8 Jul 2026 12:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783513093; cv=none; b=pGVK0zVJfXXn+OMxD6nkd9VJkgkKTIOMeJs8O/3YaPnutEK3y/7bgPQKP7QdqGCUZ2ZuWemRqx/c5fWPNkiJVJeHvSC2oquE4CUoX8HsOM0dkkltsb/3rxBRqFhbSh93c6/fRLIk6TJ1z05rE4InAuB1jq794J00sPPDp5xz6Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783513093; c=relaxed/simple;
	bh=JKX5E70My+XVRb8vy3rdWNaWfMYpHPcqDmprlGqm6Uc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bxwYiFLwPdumtAjUPUQH9gB6HCoEKhR1VWwAw93d/YTI5Qp4vuWFStNzAlAJ209e52v2ngBgF2daaBe6XrRsywvE/4n/ttbAoXVLfdT5St84BxHeXeydycZ/87tfDpwT+9tc9ah/cxsIHHqNDLIvg325u2ve3K93c0JNXG/ItNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aZyyFRQn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RUhha3n+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aZyyFRQn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RUhha3n+"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668C39Ex2605298
	for <linux-mmc@vger.kernel.org>; Wed, 8 Jul 2026 12:18:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LtyVAmWN4f3TIqof37EPSTRIN6h1TXFrEzrycroYe/g=; b=aZyyFRQnAV2yNo6+
	YCqX2aMadCo3DykmCnaVYkCChqNK/etTIskBXrxz9wfOQv6eNKFhAQb7tkivKBbK
	cjVzd3z3IWbs2kdaDyjbLWW0RiMIDMIZ7/oGXqEP6DiAAx5H0cEwFvBQ9HmRxRIH
	5wgvmcAIc3dsR03S9pQ0ny6DvRbCjPXT6+GeVPxGDjapLmWeHt1Sl9Qw4HcuNxZx
	ys9kSlKzJdRuRf79xe0CmtxCooOVTh+mBZ0YnWJG8Zez8laA3a5Bbo5Vk/hWr/3e
	dFpe3knAlilEqzeiSf6NTlZnucWUZ66IU+bAYtliLzISJmF5m30kJpDPuY3Kjnd5
	sxN0Ow==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9be5ajfh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 08 Jul 2026 12:18:11 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-848415e9e8eso1064068b3a.2
        for <linux-mmc@vger.kernel.org>; Wed, 08 Jul 2026 05:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783513090; x=1784117890; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LtyVAmWN4f3TIqof37EPSTRIN6h1TXFrEzrycroYe/g=;
        b=RUhha3n+1XTOV+EBR0N9/PNsoDnUxJ4dTUdZWG3Cb3w9lj3Pn4RU8KwKPltkr+dYa+
         ZRBnT01W0skUtqdV5E/oKuHmdFYgMeQk1+xWXDBTuLoGXo66yLE8nTKGpHm0erQyasSi
         //XAtkoQNDEUZyQvpfhzhv4lHCpX4mlLurBxEP7Hhtd3BnvWjF9mBdbKaDhpF9GFsvWV
         dEyGyE/VxjBG0R+Bz7hjo7hSzodTN8fI8nsobnetDVIkBj70AyUvD2W3KRO9+yHvuPBt
         KuItBMpEpyDWeyYP+3VMJgWcTS7hP+xZTHLt/Vxxwv01H4vp1oTae4xVQ2x1UqlByfBJ
         OLLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783513090; x=1784117890;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LtyVAmWN4f3TIqof37EPSTRIN6h1TXFrEzrycroYe/g=;
        b=dE2nuL6gY2RNgGd69gGpGPlzAwT4fTBPNAoGYFcuTVvTDYC+P2QFSXZHfQor6k7kN/
         yPTRFDuAB2m46rzrNnEaEFgGbIu6unZT8ObcZCrmSLs4vLctEH52aicwqmeYYVEMj9q+
         BS4kGQgEUUW9G2/atvlWqqc6B+xzvqzgt/5m+3EjbuSmH/BMMkDy/s+Sm9ALCKpclWQm
         uYvtRoMvGgfzyadW85H56RDhOTUGTGeT20o6eVFzY/f86iLKs6FRTYnXNv5irWJrm43v
         w/39AtYVpEANskXrdGFgfm4jgqS1Lk+qHtTmvyakKCLgVlUF/yYJIPNgYEr6iPNVpwKy
         H1oQ==
X-Forwarded-Encrypted: i=1; AHgh+RqOcwFXXe13Uv3y05XXMEEvh0Zgs+pc5I+4GnjdJZ5NY3rhGFITWsXpZMbEnkbGJP2+vagbwadhSHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLmkJjQQT4brE+nn7fRKPKcXq0AnsDZC4Lwax53OeawOsej7FW
	STRxfFwFv5C++RCjvc0DanCj5yDhaunplNwDIUzKYp4ZqUNhIigArNGKhd3RDsl/gWgT0dbpGEu
	rSfmUoHr0PCB/sDoqxw2DpKlJyskgrQxVMPc1YyjAuLswuAh37SoLUty85ZIPU1k=
X-Gm-Gg: AfdE7clGjvIr9QbfdFchYLB9hb/AHK4KwuTSuwzoWO28AaCCHLPYaZ+ubvsU0WCsB2x
	dT+FBpwcohpFDNoFWVymBXqAAQS1G7Q61IR2MtxAae8LvDp/mqu8efKJpscaNdAfVGSrvMVZjI1
	eJBAnfAVr1UDxJwN5ymvfBcPnP/Vp5B2twdm+IBKywbeRbCM3/l3W0cTtP9bHfjJNdKAeCzz00l
	xUbUJVLiCUEouWm+DBAfJ0oDxJYJMynS0hVRFLXkNsr+5r9Nmnvnp/h/NGu9lHvQ6Zp93S9nGEJ
	Ii43nIm2POX/bsjL7VOOegQPgbFjDSOIcfX24NaCyI6lHT1ym4oSbxIvNblsTsNtMOG0vD6YYxj
	odJu1HBpRCmnSB6rohSXN/HyHGw==
X-Received: by 2002:a05:6a00:3a1a:b0:845:e41f:9696 with SMTP id d2e1a72fcca58-84842efc60amr2344159b3a.25.1783513090466;
        Wed, 08 Jul 2026 05:18:10 -0700 (PDT)
X-Received: by 2002:a05:6a00:3a1a:b0:845:e41f:9696 with SMTP id d2e1a72fcca58-84842efc60amr2344124b3a.25.1783513089953;
        Wed, 08 Jul 2026 05:18:09 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-848337d12ccsm2367474b3a.48.2026.07.08.05.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 05:18:09 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Wed, 08 Jul 2026 17:47:33 +0530
Subject: [PATCH v7 4/5] arm64: dts: qcom: Add Shikra IQ2390S SoM platform
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-shikra-dt-v7-4-977b65a300c1@oss.qualcomm.com>
References: <20260708-shikra-dt-v7-0-977b65a300c1@oss.qualcomm.com>
In-Reply-To: <20260708-shikra-dt-v7-0-977b65a300c1@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-mmc@vger.kernel.org, monish.chunara@oss.qualcomm.com,
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783513058; l=4667;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=JKX5E70My+XVRb8vy3rdWNaWfMYpHPcqDmprlGqm6Uc=;
 b=RU3wvT0LYgQ5pv/gjeo2egvywfcFhq1D5piWQdQc5qMXUgwSwcp6KTHL1k5iTElQDvkIeVBri
 FQ0UX24I72ICfEZS/Uq9fiUMGBp8Gfjgg5bwpdemUYOkx/VMpB+qrRo
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Authority-Analysis: v=2.4 cv=GJc41ONK c=1 sm=1 tr=0 ts=6a4e4003 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=IZjsGcCFCfEoDLf82CEA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDEyMCBTYWx0ZWRfX7kzYAfQ1Gnov
 UPY3WKgil5QzbeG83LEBxNfOQ2Iy+XJKVbbcO3e/Y0XGqChcC9+qDS5+veIwiVODgeYt1qrLLYA
 cBU4t+ijmU4+BU/MGmlbHjBOLsg6oKU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDEyMCBTYWx0ZWRfX6uTj6I9yuSuT
 RrxNIF25SX4TfuRpxH1sycH38rt8wjyGL6qrPgf54xiIo4I5v39wQDWVqX6CSVPQIEdYsGN3kx4
 bXZC/OtEd+FalART5TqR91RoI4BxrAYIGBsWQ/U0vs5paKRb1DfLawnwWU61VfPiwKT95787Hbk
 dSEUgVO/nVopMa1JlWxOGS+HGZcjN3BJuH8Hfgd+v1hr+3G4MlafRSQqYMC0TW8Dpu21UirQ8XD
 oFWz/JZegAY93SmgGDHuiCq/A1BPEryKSwQ5WW1xdy2ViDda4cPbRY/fm0zxw1T+s2TTzJQNLri
 tUdeHPQ6WY4tc/ogDM7SxdIy+fVguvjgGvKAEONOixbsK59ypx80UCj6WeXPKAnIu/RAxwcnRph
 +p4RMsn3f9bt5PdUgj18qx0T5OX0K/obTlsv6n8jIZs6J+6EFwc2lo4due9sfoJGOFjLcPMXrOw
 LqR9QsWk9bUnN6684xQ==
X-Proofpoint-ORIG-GUID: xGL9_ga8L6NPdpYwxe___jGKXVkqMLAz
X-Proofpoint-GUID: xGL9_ga8L6NPdpYwxe___jGKXVkqMLAz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0
 adultscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080120

Add device tree include for the IQ2390S variant of the Shikra
System-on-Module, an industrial compute module integrating the Shikra
SoC and PMIC for industrial IoT applications, designed to mount on
carrier boards.

  - shikra-iqs-som.dtsi: Industrial SoM without modem (PM8150 PMIC)

The DTSI includes the common shikra.dtsi and adds PM8150 PMIC regulator
definitions specific to this variant.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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

