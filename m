Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0933430CD9A
	for <linux-mmc@vger.kernel.org>; Thu,  4 Sep 2025 16:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757004037; cv=none; b=HK5zNz+8rshHVad5aYhfhgMVwjOLUbIahL/OyLN73jnKnOkx3NjyzGcu5gHgcA0qbPhevbWkMWNDJxNcrWmmTalGOysMntkkavwgCWgbFWDKUe0a6Omoi5AzX2B56HAol3KfaWQZ75143uYL9enAVbvYGhIiQJtQMAZOuy0Nj6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757004037; c=relaxed/simple;
	bh=5nL+OYF0Sx59okl+bF2CZ10eU3EdgP0WxoB+Um7eJG0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JtcJOgOAn1AeLXGCaFmu6HJw7ALK9sL8nCsrti4bSAOwwZ8/Nh1uXccUM3iNgiLXTvyyJABFmitBeqpKgHX0yoiAsJniVy5/sPF8A3KKOzecQ+k1KF1Bq7Cr2ShTe4H48S3lYtth8ScNxwpeQRRmkWG3eUBAx0wudFtQn1DOjGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jw1wpIEy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jw1wpIEy"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849XHuF022433
	for <linux-mmc@vger.kernel.org>; Thu, 4 Sep 2025 16:40:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5iUt4qPcCisGUFMMbH7XSVXi/o4ocrCKh/ulIa/4zgU=; b=jw1wpIEy7C1n7Rnb
	146BwIzAZuP34RxdzUF96RDgEw7w452ii+cJZynq+Hn9W6gpNxdkCfzJdYV+9XNg
	4bGVUuJH8GYKDL5RVs03lcB2FFw9jIPKypjs5iQs1Y2qo3VmDM4UiEUpYfDkCSsf
	q8n1lvaE0/t2/WFEYs5FABEiRSYqRS06mD8e3Pj46+FHq1x/OTE0w1Pbh8J+GqfY
	6QS47/jKC+22/7VRzWUi7qrD3xTUbgZfM31v8uMpdCwQtlHU7JBAm6VMRPTFZH8E
	AAIhRG1NRzIadEpkqyy5mCi9kHC9qtSCdTwNt7z4gKgVilYt17Bhlcd9Onul5rEy
	G3cwbQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk981j3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 04 Sep 2025 16:40:35 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7724877cd7cso1387782b3a.1
        for <linux-mmc@vger.kernel.org>; Thu, 04 Sep 2025 09:40:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757004034; x=1757608834;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5iUt4qPcCisGUFMMbH7XSVXi/o4ocrCKh/ulIa/4zgU=;
        b=J9R/RuQmbXoOFyQSuD5hgK3pGO0PkssT+6138hRjB9aAVC13wpW8w3ARGBzv+e8ji9
         UcSX6lMpniqWa46Z1jfJdHja9SsV9kS+t/l2UzWYnVbzZr7I3Y77MRMWhhAx4NPHm9VR
         0z+MFUrFEsSBKCfvYVpuv1MwLCFutfBijYy3I5OF6EdbMuo4oQep3Xm8kDoo9FP/mDef
         Xd98CB1BIiaQbhwtdce5OckxeKH2KTXjq3uLsXuQFReut7dCyliWebn4ZK4x+4+w13Ro
         4/gX/7G72ZX76sbIntLQ1sEM4MmG46OZiKqHoLr//9nlg5sumxfBv8N6V4xnf0t2oQz0
         ZZdA==
X-Forwarded-Encrypted: i=1; AJvYcCXTDkCbi864lKb4km1suwNxhrN9h4lLKQa2hwUDuEQyXbvtlsOr3sqvAf/9GTHqvUVXyqBjH7Mwwy4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3kU25/HDSHtXUazYWta538nAHfvFbr6MvhXJuwemaER0P4YUx
	QWlI/sAFcea21DKuIAe3vs5f7A+Y80naUjlQnxhFV1tMbPOZZRyA5Scsw7Vhp268lbzTNb8B4Lp
	yEhKvL/JVrfA+hcQfRrnC3hpU21/rik6HxKDpAIdfjgWBZL9ODtK2RLuW2ehdkzE=
X-Gm-Gg: ASbGncsHFN65xKVNJ32TJJwrL3laRfvgaPG4zYNYpKrgvsoiI59AWRaGBGv5yky2HRc
	BF+x7ioVf+PQ3F3STljVk4rq+jGlUDYQYQiJJX6nxHwTk1Cnu8sgu7t2NvGdO5jZ8R8XLkAnVTM
	FEEKa6ZkjTUJaXyfvAvY40rcSUMIZXj3D1y4kHJ2s7UyYFc0VU8fJGLK+3csKSAb1p0PVYP20jF
	2GZJk5u1F66B1W//ippWYw8Vuh5rP09oJuaHhpHVOOLP1Vwl4roLvRqyENrImBZlRe25HIi4BHj
	Ih1XnLV/Ju3B9vHb9JfrU/9+lz0LG7SSgwVASyohod1u9Vu0f0A9YtzkBneroeyMO6UZ
X-Received: by 2002:a05:6a20:a126:b0:24a:6bef:bdd5 with SMTP id adf61e73a8af0-24a6befc008mr6136276637.41.1757004034478;
        Thu, 04 Sep 2025 09:40:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmo+ugvp1lemWmsL32dxfoUlxaq9NEcSMR/oo8aSYbaa/wv+gnrkssQj+zSbLAEQvSe2fdKw==
X-Received: by 2002:a05:6a20:a126:b0:24a:6bef:bdd5 with SMTP id adf61e73a8af0-24a6befc008mr6136242637.41.1757004033976;
        Thu, 04 Sep 2025 09:40:33 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd006e2c6sm17346371a12.2.2025.09.04.09.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 09:40:33 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Thu, 04 Sep 2025 22:09:10 +0530
Subject: [PATCH v3 14/14] arm64: dts: qcom: lemans-evk: Add sound card
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-lemans-evk-bu-v3-14-8bbaac1f25e8@oss.qualcomm.com>
References: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
In-Reply-To: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
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
        Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757003953; l=3176;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=SujxAbkN8XScTDon5muk4g4z+SXLxLTTm/h2xnMnz+Q=;
 b=+uMJ8s2h7Nlka1B2j3+N5dq2JFMljzN/8FyDN+am0P0sNAoqJ4+DY/9Gga9TA9J+3+6RlBnee
 c2oP8Sf1QXGASjHVyK8vxgh+4YwJlXhRRtyYSTp2jpL+RQ+p3+saniK
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-GUID: MzyrzvS2qp0StqmZKtDXcKtcCf1DtvWe
X-Proofpoint-ORIG-GUID: MzyrzvS2qp0StqmZKtDXcKtcCf1DtvWe
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68b9c103 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=WTMWP25ZRELiBA-utRQA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfX0sCIOXxU5eKg
 c3EKgiAyLpvHZXu/7k9VYCAih5m9L+T4ROa8zLzgvaaIpmwujt1QUgPKWhjjzBSgmwD1Jo13UBQ
 cYuuyAaSu8Fn1Vch9gEtIS1n/10Iil+gRgKyQFlgCz7QKJ4yaHyRhUIkon5yC/bYFELxCsjKVbv
 xaB4WMpwpsaJ20jMIdTn4y2tkoDYhVT7+zG4EMvifvXjzBBeazDgp9wrevqXF+mmu2WjNqhX2YO
 IWuXZ4X2PM6FU3xxXk+7GwjucMMMl69bsMeDJSaMed2m+SPIQ+eagPzk249l7PkVBZL/TDiecBg
 5EnJVHortGfTmGkbOdsk/mBt3ckQ8avh+MlW9NB9LJexOhQKhG9nujJwP6PggefvSw8xW54aWhq
 vBqZ2FKR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300042

From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>

Add the sound card for Lemans-Evk board and verified playback
functionality using the max98357a I2S speaker amplifier and I2S
microphones. The max98357a speaker amplifier is connected via
High-Speed MI2S HS0 interface, while the microphones utilize the
HS2 interface. This patch also introduces pin control support
for the High-Speed I2S interfaces.

Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 52 +++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/lemans.dtsi    | 14 +++++++++
 2 files changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 9abdc8c9f2e9..e87afe0144f8 100644
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
index f3a4deee383d..3cb251a96898 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -5070,6 +5070,20 @@ dp1_hot_plug_det: dp1-hot-plug-det-state {
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

