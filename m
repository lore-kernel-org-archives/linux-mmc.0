Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4ED0302767
	for <linux-mmc@vger.kernel.org>; Wed,  3 Sep 2025 11:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900118; cv=none; b=Z4+kZNvhF7U9P+jmYkyeUjmcKgZulBMavuVbFo61zk6mgL4V4ejAYUR3kjuMhyCKTrwPoNbIc1ukGf4uxw5Ta0HHFYzCrxquvdy86yy7eg4Dx5skQfKawgnKMebG1+G3Zbe17wfv5s6a05sOVAPgl22BL0urIvPv24TLMuvNS+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900118; c=relaxed/simple;
	bh=JsB/vM+vDg1pqrgFnPVYbAfiodJ6g4Ketnyr07QLJjg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qtZVTRFCeQcX+8i8jFr9Ss6qHE8OZEAoP7+sXkirlbwXMG5bHt0FPboyPrjlj97wmZdTyU5Q4MF+qF/FhuLDO/iWVT2W5KWhR3FjGZMdzDtAdBSv4D45h6BYi+eRrVD/DPQkBNv4afqVCjsV4hwqa+KQShHHhH+9V3XrR+3Nj8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ce4un2Nb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ce4un2Nb"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BF1dR013822
	for <linux-mmc@vger.kernel.org>; Wed, 3 Sep 2025 11:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QI9++NezeeQHxyb4K/k5RMtpPMwIn4t3wPgvkRjOclg=; b=Ce4un2Nbz2f7tBH8
	A+oBYYn+QMFrrQv3kWkzxsoAJF0d2GatqTa+QXX4OLtjw8Kq8exbf+1vYgknz54R
	ZmriU7M1cRin5gY5Sko7jAWkQACCiY1BrekIHa0kUNIA0y+gi3UpXgFxnIRzZFqY
	9uCyjqLcDiQr3heu9v1+Jy1JucpRm5aPG5GT6YZOlSpWIVUxGB8DoBmtf1v63Hn8
	J/oIoD+lCzG5L/jRkJgt4BMNaPxEr/CTUtGQjDqP3OjqdNB3R4VJrrbDgou26dkl
	objG50RllRq/06DWS4hoRPFe0Jm2Qz8AlFX6sxc+BOd6aUQCtp2xp2qVR8jh2Jai
	Zp1eIg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uscv3mra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 03 Sep 2025 11:48:35 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b4e1675ba95so791942a12.1
        for <linux-mmc@vger.kernel.org>; Wed, 03 Sep 2025 04:48:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756900114; x=1757504914;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QI9++NezeeQHxyb4K/k5RMtpPMwIn4t3wPgvkRjOclg=;
        b=KpMeTRtY4LeBNUFwR23qKnAKv577kfKbKeLZ/rgpTy0gE6PKPdIssWDuCQjO9Lz4IX
         pKrPjgqr0VrIZrxrjoxag0VKEgO8/H34zI8UYo1H2h7U+0xtdQD8pFACdZPFUDTX0CGV
         6t2qb+H+kxRSv/J3p8pFfeS4xsouPxqZ3aiFb8wAK06aO4n3UyWvXJ7JByBEYcYEsdtf
         xi9F9jU7RSgyVUnpgz9LtdvegMYKStX4fO/OeBKHLN7fIdVxBxYKVW8qsT7vKQmjG3rx
         4bzhMtrW39ccWf2XIbm2589QgPqjnZJNnWGbEKTi58eOU+5oIeMuF0wtjp+gJesgPayp
         dYPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUswpWP1aK87qiwMjvb26+4jFp8TeIFH1K9DZVczBH+Y+5dxTkk/bZwV2P1N17gUDVTEls6TZjNK6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsAEQ1qrdySQnl29GkfC26Ft/NoEoUMtHSXsR86gLsFVYY4HJ5
	aM5ulUZRboMhshOjZ1R9skH6SGGJq1yExgzes7bw8bzmkg+qGtTl5OxZ1sWgn/dldi2h7hhS2ul
	FIRNTKsa07lwT+eRTGqiozYiP94qaPwh1vx0zCZ4A9ya17gvLHEelPu9kG+Kvgs7lRlTeab8=
X-Gm-Gg: ASbGncu0aC9FXZLkjl9NcEITJGG/6H+4cXnEwpJVLLX4px4u4YsFtOy0lZZuyTJ22Wp
	OTxpkOBlmJBFzbhfgsWoqxP/KWF3ZSkidTcI44E1UmJQ3DiwBFb/ceKOPVpwfuPyUDJyuKUz+Si
	6H0PDUeY4tZlfQNR88Pe4PNXLp16Gs3hfm6L3ULFQ3OoToJAt0l4wo9bcMuGgM9Y6gD50Eq7mQp
	XRagLngOE8d64w67Z2lxQ3S5Ry6Rb9CuLT+/IET/IGFCaT4uAWscmVmORBgBG67Eb2JNHiLIv+y
	N/5Lx+jOABfoBMIEAJ3xAcqXK2O7su49qGGHEPJ8pWnhYLvXKFAhj0lll12Ub4CqWYWS
X-Received: by 2002:a05:6a21:32a6:b0:247:55a7:695a with SMTP id adf61e73a8af0-24755a77066mr3480263637.15.1756900114145;
        Wed, 03 Sep 2025 04:48:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3NjxqXFYsOho+XHvlskDWQdVStPAKzQQGePA4tis9XWfYdQEn5D+B3PKJy3PtGYOByW+HNA==
X-Received: by 2002:a05:6a21:32a6:b0:247:55a7:695a with SMTP id adf61e73a8af0-24755a77066mr3480224637.15.1756900113649;
        Wed, 03 Sep 2025 04:48:33 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4f8a0a2851sm6584074a12.37.2025.09.03.04.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 04:48:33 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Wed, 03 Sep 2025 17:17:14 +0530
Subject: [PATCH v2 13/13] arm64: dts: qcom: lemans-evk: Add sound card
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-lemans-evk-bu-v2-13-bfa381bf8ba2@oss.qualcomm.com>
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
        Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756900050; l=3115;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=rsQ70XuuzikTEL//lunyv8DprTTtt6yK/Y2Nh5U3LqY=;
 b=Bi1icvmEuhZPp4acn7G3T11pofXg0hfMgKG2V8vfOCqLQ3al20o4FihRTpNycjFQw0mE2l+mq
 v0HawdkxcZBAzqiiRqxbue21LsgiJbQRXaPmfeZK6370Qm18IuGpWJq
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfXxH7sl9GZ3CHb
 mEzDG15KUZF5uI1h+PI77tadDdOme6D3ydjE51bTXWiJAfpMSFG9JTP8DUIvgHp/BfJeHdUXrdT
 0Qg/tgmK/6V7WoqZU53bm1VO14i0bj0gqKCQqu6J25jlDI/AxetD0tIlwvdGptpS7nCY4A1Tb35
 2xHV7PZQ8rWebGKYsNJfbGCC6FJ4GUMEfCsLFaRuySMHdoQulSOqdHzOgTY4SNPRfYaBa+NN1B1
 DzkY7syg/Rzlhs6h/RzR3M8jYz7k7/D0nWg9IldQz67Zpr5KSaHBWBbiRfrvoInutr9GqMEEzDy
 2phh/3usxFyKKiO623enQfRd9lbLWn47HOIGZ+XwnIJAM6MiAmzmK5PQMuRgHLIfoN9TbIKCDqN
 G6S06lv/
X-Authority-Analysis: v=2.4 cv=A8xsP7WG c=1 sm=1 tr=0 ts=68b82b13 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=WTMWP25ZRELiBA-utRQA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: E9d5x3GasaVshSdzr37tQlysuquGn62J
X-Proofpoint-GUID: E9d5x3GasaVshSdzr37tQlysuquGn62J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300031

From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>

Add the sound card for Lemans-Evk board and verified playback
functionality using the max98357a I2S speaker amplifier and I2S
microphones. The max98357a speaker amplifier is connected via
High-Speed MI2S HS0 interface, while the microphones utilize the
HS2 interface. This patch also introduces pin control support
for the High-Speed I2S interfaces.

Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 52 +++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/lemans.dtsi    | 14 +++++++++
 2 files changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 69ce6a60361a..7802fd830aa0 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -7,6 +7,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include <dt-bindings/sound/qcom,q6afe.h>
 
 #include "lemans.dtsi"
 #include "lemans-pmics.dtsi"
@@ -25,6 +26,17 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	dmic: audio-codec-0 {
+		compatible = "dmic-codec";
+		#sound-dai-cells = <0>;
+		num-channels = <1>;
+	};
+
+	max98357a: audio-codec-1 {
+		compatible = "maxim,max98357a";
+		#sound-dai-cells = <0>;
+	};
+
 	edp0-connector {
 		compatible = "dp-connector";
 		label = "EDP0";
@@ -70,6 +82,46 @@ vreg_sdc: regulator-vreg-sdc {
 
 		startup-delay-us = <100>;
 	};
+
+	sound {
+		compatible = "qcom,qcs9100-sndcard";
+		model = "LEMANS-EVK";
+
+		pinctrl-0 = <&hs0_mi2s_active>, <&hs2_mi2s_active>;
+		pinctrl-names = "default";
+
+		hs0-mi2s-playback-dai-link {
+			link-name = "HS0 MI2S Playback";
+
+			codec {
+				sound-dai = <&max98357a>;
+			};
+
+			cpu {
+				sound-dai = <&q6apmbedai PRIMARY_MI2S_RX>;
+			};
+
+			platform {
+				sound-dai = <&q6apm>;
+			};
+		};
+
+		hs2-mi2s-capture-dai-link {
+			link-name = "HS2 MI2S Capture";
+
+			codec {
+				sound-dai = <&dmic>;
+			};
+
+			cpu {
+				sound-dai = <&q6apmbedai TERTIARY_MI2S_TX>;
+			};
+
+			platform {
+				sound-dai = <&q6apm>;
+			};
+		};
+	};
 };
 
 &apps_rsc {
diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index 41003d8878f0..de8f5d78d0d2 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -5068,6 +5068,20 @@ dp1_hot_plug_det: dp1-hot-plug-det-state {
 				bias-disable;
 			};
 
+			hs0_mi2s_active: hs0-mi2s-active-state {
+				pins = "gpio114", "gpio115", "gpio116", "gpio117";
+				function = "hs0_mi2s";
+				drive-strength = <8>;
+				bias-disable;
+			};
+
+			hs2_mi2s_active: hs2-mi2s-active-state {
+				pins = "gpio122", "gpio123", "gpio124", "gpio125";
+				function = "hs2_mi2s";
+				drive-strength = <8>;
+				bias-disable;
+			};
+
 			qup_i2c0_default: qup-i2c0-state {
 				pins = "gpio20", "gpio21";
 				function = "qup0_se0";

-- 
2.51.0

