Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B491372888
	for <linux-mmc@vger.kernel.org>; Tue, 26 Aug 2025 18:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756232511; cv=none; b=XbLGR/wmVPPCKXYWV4x5XYrpunGNDNqbpngodcDsU3XNVnH6viLq2fFJhP/wgJYWIm6CLEY1iPwobMHPfILxM8MS4yKswS+ttchcnrN+pg15c8ItfIR9c5Y08x237i0L3Qe4s5/IVXtbQoWCi9IaNMeVY1ouI3oa7BuZPf9iVZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756232511; c=relaxed/simple;
	bh=611L3O+47ctGIN5esrQ9A5H4Oub7w7q3hEDu5ciaR7M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K8tt4dE+G94Rf5ydM3VEogUcBoC5Y/+XVbTxgFK22jsTxNv5is2DDsqIBzgX2LP+sgWHSEXLHAWoWe/rH/RhvSnH6qS9mgBTwsaDakXNNAZOb2QLM5z/3hr4oOD1X31Y3ggmHqJk8rDPt92DQaoKeXweOZ1JpmIYN6S7KgHH/Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ef7EOomc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ef7EOomc"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QHLGBk027994
	for <linux-mmc@vger.kernel.org>; Tue, 26 Aug 2025 18:21:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uHo1gjefBDo7Rz4UcCwYzZ4ege4oDD7nzc30CiMEuYw=; b=Ef7EOomclIE0NqMt
	u2pygFc2Tnw1cYmgZdOprkOU+vhXdWC+ovShZFd8GHsw0K6Ag3v1HVAGEi3GvkB1
	E+PVgfXslUljEFoRsob1Vx2jmYw9/zj3pxwevIJniqO1uDE4yOHJRI/xYBzHlH7W
	/EBXbM7rJRja34lc1PwIPF2PXlqK50lWdLfTxBejuHFvCisA84ekzAdNIDZMwLY8
	o+PRIh7NK10gKVKV47kauwLpyroXDOzXPkWUWvsuMU2K8PQqM0U/8vZ+/t8GHrYz
	UY5+kXE6+WJXCcyb63SYzJTumyviYibu1UoGgpjfhE3A28gJ2L62Uh+YJK39u+fB
	afuT9A==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48sh8ag6ch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 26 Aug 2025 18:21:49 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b4c35c679c7so509860a12.3
        for <linux-mmc@vger.kernel.org>; Tue, 26 Aug 2025 11:21:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756232509; x=1756837309;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uHo1gjefBDo7Rz4UcCwYzZ4ege4oDD7nzc30CiMEuYw=;
        b=EjNGFGBPGcFmapGY9n2ZJPyPKQMpud/fYLX/6w+vwMUNd7MnLa9LaNRPA/a21zyLD9
         NTTD/IWeyp5kmb38uELGoaCgiqG86QqF/etS5UkuQmUSL7wn9R+HpvhF4umc+x0S9hRd
         39AFo0Y+eqX3vQsPa1BwQz4pmPhxrSEE+i8Chu/nLjzoiBrNAjeyqYcv1cwgnUh47mI1
         SXWifAq+odFWwYfP3c+X05GNk+aAR5bLiTbDZTTATSoeNz5u0E6qVYhw3TTJh+jOd/n6
         RvwA5J+7oKcP8vgZVLLncpWVJorMsDOnIUP0AJA7t47ZRGPAmwPanML+u0H7+WxHqR9W
         Wn1Q==
X-Forwarded-Encrypted: i=1; AJvYcCX5CwBwpasH12DC7cyDTEHcXY63IX1CEyl/aoRgnwdCkE9LY8obcEXjykotI9ADA2eaVAGRoqnmBkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ8Ln8ZnDR79RCxC3CnDb95Iwzcpx/IFTbMi9PUcZciq48a+Lv
	gLcBxVXQImUunXypC4eu3rLO49n/E6hbv36OPykgiLKN6BLV5nHKEXoX7w2aU+f75avedXpHaWN
	5QYcyWx6YCSB4fR8arZ0F3jhhHi0ou0CHzIzfi5fTd5S//41xKHaDCo9maixewYM=
X-Gm-Gg: ASbGncvjVzt7SgIKuI+4KXHwBt7mDN9RgV4KZQwWjuwKgEQjB0mnhgyL++oiWKZVr3o
	c/3elz1NoObxtSBZqy1hrrisgfpAvG6NGygxtflU22CyW2aDW0D4aNfSVTKlMviNgV+O5mS3wVw
	zqm1aOtcHrfK4lZQeUfjVpZA+W/p4tkE/eqnOn30347YJWoS5LJ5A9jSJ7BLpudSCTsZDx+ea4T
	eQ87dGWXPC9tITujhAzdbWMUMwaJDj0NzyCcksqKsJ3HF17uSp+4rSCGM5oqb7sjiS62CTbdJmg
	aDvkVfqsWwPtwtaqr1JLBiJxurzVQci3jIfx6vsPqjtlilMMulJ//z7AaJFWWCNzSjyD
X-Received: by 2002:a05:6a20:a10c:b0:23d:54cb:2df6 with SMTP id adf61e73a8af0-24340ad1f86mr25124336637.3.1756232508570;
        Tue, 26 Aug 2025 11:21:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7ijJ29Va7yrV4zp5p8NjWdZ782LaBYYQF/4cU8PsHszSgbxWHP1GGb2H0frlcDXBmyhlLlA==
X-Received: by 2002:a05:6a20:a10c:b0:23d:54cb:2df6 with SMTP id adf61e73a8af0-24340ad1f86mr25124289637.3.1756232508052;
        Tue, 26 Aug 2025 11:21:48 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77048989fe6sm9881803b3a.51.2025.08.26.11.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 11:21:47 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Tue, 26 Aug 2025 23:51:04 +0530
Subject: [PATCH 5/5] arm64: dts: qcom: lemans-evk: Add sound card
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-lemans-evk-bu-v1-5-08016e0d3ce5@oss.qualcomm.com>
References: <20250826-lemans-evk-bu-v1-0-08016e0d3ce5@oss.qualcomm.com>
In-Reply-To: <20250826-lemans-evk-bu-v1-0-08016e0d3ce5@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756232476; l=3032;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=UMnWnX+QTp0SrMk1v6WQGdCaQDzxYKHt7lrDS4z1rOc=;
 b=vvOwPlUHfYZYBlh0B2Im01YpZHJDFfRJ5ZkGHfDe3nN4FX3P1X2ntIbChYdre22CGaot++nfI
 /ezJDoCRq3uCO9DepaefrgxOKiQuc5ngAhs497ny0q5LZGpYX95mE1y
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Authority-Analysis: v=2.4 cv=cLDgskeN c=1 sm=1 tr=0 ts=68adfb3d cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=gcRert6Kt2c8YO7gZrEA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDE1MyBTYWx0ZWRfXyP6tlKQT7xTU
 MqnxhfDSIcOCg1/LMLGjbe3/yqjF5g0LhlWfXw5aHKSvuB7+YLwHsS4ZdQYpRI85lSXqGvSiu3g
 npKhxmM3jtvMy9bCIZwAqqyde6cAXfD25e89tqjM87G4k92DVpNJ9koXvJThfqEKsQSVDzb9wDN
 /xeB/J40VHe1R2kKsxyOaZTzDLqAC7hcjoQcJfkSS8BXhw9QpeTEApTRgwE44twRwGOUGlSlA5S
 8YWWfeIrlaSw0nopWdvzLy4Bba1SfvBHWYKTUnbjT8RGKRd81SUsiKaISdAud2RbtjsGj+s+lEG
 PsB4xQRXMZG24m7yzkfI4BzajyyPIF13D+AoX4nU17wXk5jWp5KcSpkx4P9W1WtRvq8vM419Pdd
 B6VJ+N9s
X-Proofpoint-GUID: Jdqb132LiW4pHgcvLc80Gkpv2R5LGbyn
X-Proofpoint-ORIG-GUID: Jdqb132LiW4pHgcvLc80Gkpv2R5LGbyn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0 adultscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508260153

From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>

Add the sound card node with tested playback over max98357a
I2S speakers amplifier and I2S mic.

Introduce HS (High-Speed) MI2S pin control support.
The I2S max98357a speaker amplifier is connected via HS0 and I2S
microphones utilize the HS2 interface.

Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 52 +++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/lemans.dtsi    | 14 +++++++++
 2 files changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 642b66c4ad1e..4adf0f956580 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -7,6 +7,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include <dt-bindings/sound/qcom,q6afe.h>
 
 #include "lemans.dtsi"
 #include "lemans-pmics.dtsi"
@@ -26,6 +27,17 @@ chosen {
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
@@ -73,6 +85,46 @@ vreg_sdc: regulator-vreg-sdc {
 		states = <1800000 0x1
 			  2950000 0x0>;
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
index 28f0976ab526..c8e6246b6062 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -5047,6 +5047,20 @@ dp1_hot_plug_det: dp1-hot-plug-det-state {
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

