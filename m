Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09302405C45
	for <linux-mmc@vger.kernel.org>; Fri, 12 Jun 2026 17:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781285290; cv=none; b=ZToIkvLEJ97MK936Vi07JsZkB5jBnEhdAMKTQlproMoV09lSnXQe7rHOMHraTXBFAlzBRwEBLhbS+iMz/0Kdn0pXPPeoTk81OYVxDssxWNf1DPb2VliJIDe+hQq+9SPKGKUTBbW9gyUHZe2IiP0XrMSXH9d43ZG1h9T+V2IEvWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781285290; c=relaxed/simple;
	bh=eslOA9Cm586MnIpbe4Ehxfiu6FCtCf33ffQvBFXd7Sw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jjOC5PuRCw3t1fZIk33niYYTGfEV0XwFr4bbJmHNhfV2t+P8rmfJRcqnZGIz+gYTYE8KHjjdpNlqVAjOJZaT2IweX3nd+Q9KpfhDqQHI9ozjkQF6yaUGL73+RK3MjuFS+P+i8bs/LIKvI0Nvf7uulnFtoZf/zM0v6aBbu5yNl5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EAvhOre3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XUraVFYo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EAvhOre3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XUraVFYo"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65CGVemD4112808
	for <linux-mmc@vger.kernel.org>; Fri, 12 Jun 2026 17:28:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GFFH/l4yzzszeD6f98GXq04InE6HvyOJJIVeeITfwk4=; b=EAvhOre3Q7CCEsa1
	2DPq5tVrOWgRi/uvGABZTdGo1GeIinbfNrIm4WwRrsFulv3At+ZpwDldSeXJp5ie
	BDTZytENTGORf7HYXmIls2xQ2b6EW9/sqbHgLPIDCEoPolyzKFSXYwi75fCea7FE
	GPNj8k5DCkNPC6zL/jjQOXLAww74kj7TCS148zX23B+isP+FUjvVT1JkvOIOjfjl
	CVQ7JYWd3PthPa111EqzKxMFG8fgiwgVEfUPC5jZToX8iqmZGVPQUsfzscFqagQ6
	l6ZrlbwUUIzz+Fns9EGAtrPTI13H5PvEHRLcH0W8KncS5BjChgdDWYkFCWczIWbi
	3lqbyg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er30gbuwk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 12 Jun 2026 17:28:07 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2beff6b6e74so16359725ad.1
        for <linux-mmc@vger.kernel.org>; Fri, 12 Jun 2026 10:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781285287; x=1781890087; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GFFH/l4yzzszeD6f98GXq04InE6HvyOJJIVeeITfwk4=;
        b=XUraVFYoVng1FO0RGedd0O9hn3pdrnPsN//+DVFd5EZWvBk4d1aq05Xsjsg4rcFXC+
         cI5GnF2i9bctR63KBy2CsbEbqVkyTNNIkniiFEvfTtG/fP8ALILGAqOapy9V8ir4KAVh
         xRl2ESQNoQEi4j1jASqZZRlDAIxUN9KD2G2ywoqLKFLCJpoxWtPtt3oJTFmRRZlX8zBC
         QSp3JFAsx+QHzmAYxYRo50JKGt0Fuzlmf2oHr4GG63vETBqeNumqMB3c/8yCIHO00HMH
         pbGx6Wjx2C9W34nh3vtrBIwYiYTwAEYCzyeAmfa+VEg1mSNViVbV8tw7XzQZQWZM1FKS
         Hgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781285287; x=1781890087;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GFFH/l4yzzszeD6f98GXq04InE6HvyOJJIVeeITfwk4=;
        b=jTZfUTP+ve+5fxkuIbLNPa3RcNYhSGAPtAKPEMsDA3qhHl1HwDK4JKGzAtELjH5Nru
         DXWw9nm4euWcynrhZIVZ2xx1VzzVsyJzRQrshsD4pR5LT+7dGO81QSWdLXst9r6n82US
         ChggttdONRVy16TUY9N2bBhOBWB9rmkZEwsLXE8i3IC31mw5KhtOKioV810QW6RKV+mQ
         ZcYpZl5QdUHbvJ99p/bZuAvrKGzAMBJa0RnaAjmt5O9FC6cb48E327o2tSdEucnH+tK3
         0NX0wmy4FT6AXZIUyS46FCUdVATK3w+QfUmNwDL9Jrl57u+B2o+q0eYeZ7kcjUXvoiH3
         e+Xg==
X-Forwarded-Encrypted: i=1; AFNElJ9pGG7+bizJcYuztY47gai2ncdKcstoJ/K4i9QAZyzy51XC5x/rWrPnrDSML68QfF+EpM5jFWdeRsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqGL3lPQSeAv5jDkF4ibGl/Hu4yi2c3DHJ7FJtqLe3LfVWrWgo
	bV2d6MK+jtVPpd9uBxHdnhAdC8hBCOwoDPF0vOzuxV17wL5aWkQSlcH8blxpBbTLr/G+gZ9UbbJ
	frtvEoAmNNx0tfqQnXPwch7Yu8+sJeUwntnl69YxM/EG/1yk0gX512wDVO4A51YM=
X-Gm-Gg: Acq92OFtGJWjDomeaKghJnDt12rkvEmUzQitd3bSwqnELXqW4cOignWQjqIqRn5j1pJ
	1E/DAXjQnNQtTaN7GQE5jZxleNZkpPodgPMEWMJ8/pe1BrI1VPHFH2evksIb9qBTZLtrz8Gzadc
	HNsIlfzGHvI71VtdJXhi2Ge0w7tOYCl9hHO57p0VU7Lq4l8mZSpkPBxxVs2ZG81F05Q6asn7+Ts
	nT2E7LBOr1u3sjbgwU+U/8Ps431vqDsqDGNABH5EP29W/+tQkWRLpRL9OhXQ5BuRyuX71YO8LG+
	Jt4Z4vRZZTuIg9jFPRPC6aavdJm7W2xcPwL6zYXDfWMEL96jzniIWQ0jk0rOAmutA7rxsUtU6pp
	AH+8sKTwLSpXQextrD5nVkgMgcuaq5am74GiB
X-Received: by 2002:a17:902:e78e:b0:2c4:358:db32 with SMTP id d9443c01a7336-2c4111aea32mr45052505ad.13.1781285286931;
        Fri, 12 Jun 2026 10:28:06 -0700 (PDT)
X-Received: by 2002:a17:902:e78e:b0:2c4:358:db32 with SMTP id d9443c01a7336-2c4111aea32mr45051855ad.13.1781285286365;
        Fri, 12 Jun 2026 10:28:06 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327acae2sm24278105ad.52.2026.06.12.10.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 10:28:06 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 22:57:39 +0530
Subject: [PATCH v6 3/5] arm64: dts: qcom: Add Shikra CQ2390M SoM platform
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-shikra-dt-v6-3-6b6cb58db477@oss.qualcomm.com>
References: <20260612-shikra-dt-v6-0-6b6cb58db477@oss.qualcomm.com>
In-Reply-To: <20260612-shikra-dt-v6-0-6b6cb58db477@oss.qualcomm.com>
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
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781285260; l=4516;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=eslOA9Cm586MnIpbe4Ehxfiu6FCtCf33ffQvBFXd7Sw=;
 b=xwgP40emI6oahWjbQJWv/JXBJtcRbdjGZ2sszGEteya9vySe5zQOOQc63QM/VY+oYuHLlmieK
 anrNSERpBVnBn230Y3g7i1ojdqopFFPXNaL73IdMuY0juxBfTX2LNiG
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDE2MyBTYWx0ZWRfX+A1NwQYc9Ugv
 RJwpBBQE5KxgLJ0s+aWGqz5J84FPEcI9/ntg5tE4pNK9hbvX3BfsbWrsLiGi7P1NCmOprruXl6R
 kAB2V9XZgk0qNB2ls7XgZl5WzbGDMb0=
X-Proofpoint-GUID: IUnqS7Ga-JcV73yyaG5VzZoGCRgKWw5n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDE2MyBTYWx0ZWRfXzzjej3Ssi250
 s5SAlXPyj1IjcCsRr5GQI6qTvgTIJj8FxfwE48oDzr1CdGu3I8tXA2FDCM1OzUmacgNBI4KJKzL
 jZUIcY/8G/EpGMDWSGhx6rm2WhFUulllllPh+UCthxXP83FMzrn+fXiczB+Yfc487NzHELNSsFq
 J0+GXoqL0hJKw3bnMi9Uy/XPqxtboZT4AHg/LmXQsVfICMJNXKGTrS6vEAPo2pWC3Vw/p4EYUxl
 WpXkGTqAIjdZNkf8i6mxEBOlfQhcLuNot/mr/1TWoq0P2E23b55AU7xz7EyyUgfv5DOkSpH8qE4
 kR+9sGjDCqDpNjNMDrPM/697DnEbadrWk8DwPAbMpDHOvab6IulxM/0VW94gTiJArFSyw4EuZtf
 INbMg+BzOPefkhCAnYHyYOLAh8VpfLXtZbT5MxhmKhovhbU5PLIkhlg68BOBpoEaIDTIgY38llV
 Mo0SX/10ohqTi4/3M5A==
X-Authority-Analysis: v=2.4 cv=evnvCIpX c=1 sm=1 tr=0 ts=6a2c41a7 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=s31jhp6hv9j5UOuNascA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: IUnqS7Ga-JcV73yyaG5VzZoGCRgKWw5n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120163

Add device tree include for the CQ2390M variant of the Shikra
System-on-Module, a compact compute module integrating the Shikra SoC
and PMIC for IoT applications, designed to mount on carrier boards.

  - shikra-cqm-som.dtsi: Retail SoM with modem (PM4125 and PM8005 PMIC)

The DTSI includes the common shikra.dtsi, adds PM4125 and PM8005 PMIC
peripheral definitions specific to this variant. Since PM8005 regulators
are controlled by rpmpd, so disabling the pm8005 regulators.

Co-developed-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi | 156 +++++++++++++++++++++++++++
 1 file changed, 156 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi b/arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi
new file mode 100644
index 000000000000..dc3861489f64
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+
+#include "shikra.dtsi"
+#include "pm4125.dtsi"
+#include "pm8005.dtsi"
+
+/ {
+	gpio-keys {
+		compatible = "gpio-keys";
+		label = "gpio-keys";
+		pinctrl-0 = <&vol_up_n>;
+		pinctrl-names = "default";
+
+		key-volume-up {
+			label = "Volume Up";
+			gpios = <&pm4125_gpios 9 GPIO_ACTIVE_LOW>;
+			linux,input-type = <1>;
+			linux,code = <KEY_VOLUMEUP>;
+			wakeup-source;
+			debounce-interval = <15>;
+			linux,can-disable;
+		};
+	};
+};
+
+&pm4125_gpios {
+	vol_up_n: vol-up-n-state {
+		pins = "gpio9";
+		function = PMIC_GPIO_FUNC_NORMAL;
+		input-enable;
+		bias-pull-up;
+		power-source = <0>;
+	};
+};
+
+&pm4125_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+
+	status = "okay";
+};
+
+&pm8005_regulators {
+	status = "disabled";
+};
+
+&rpm_requests {
+	regulators {
+		compatible = "qcom,rpm-pm2250-regulators";
+
+		pm4125_s2: s2 {
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		pm4125_l3: l3 {
+			regulator-min-microvolt = <624000>;
+			regulator-max-microvolt = <650000>;
+		};
+
+		pm4125_l4: l4 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2960000>;
+		};
+
+		pm4125_l5: l5 {
+			regulator-min-microvolt = <1232000>;
+			regulator-max-microvolt = <1304000>;
+		};
+
+		pm4125_l6: l6 {
+			regulator-min-microvolt = <788000>;
+			regulator-max-microvolt = <1050000>;
+		};
+
+		pm4125_l7: l7 {
+			regulator-min-microvolt = <664000>;
+			regulator-max-microvolt = <664000>;
+		};
+
+		pm4125_l8: l8 {
+			regulator-min-microvolt = <928000>;
+			regulator-max-microvolt = <1000000>;
+		};
+
+		pm4125_l9: l9 {
+			regulator-min-microvolt = <875000>;
+			regulator-max-microvolt = <1000000>;
+		};
+
+		pm4125_l10: l10 {
+			regulator-min-microvolt = <1304000>;
+			regulator-max-microvolt = <1304000>;
+		};
+
+		pm4125_l12: l12 {
+			regulator-min-microvolt = <928000>;
+			regulator-max-microvolt = <975000>;
+		};
+
+		pm4125_l13: l13 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm4125_l14: l14 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm4125_l15: l15 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm4125_l16: l16 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm4125_l17: l17 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3544000>;
+		};
+
+		pm4125_l18: l18 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2960000>;
+		};
+
+		pm4125_l19: l19 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2960000>;
+		};
+
+		pm4125_l20: l20 {
+			regulator-min-microvolt = <2952000>;
+			regulator-max-microvolt = <2952000>;
+		};
+
+		pm4125_l21: l21 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3056000>;
+		};
+
+		pm4125_l22: l22 {
+			regulator-min-microvolt = <3304000>;
+			regulator-max-microvolt = <3304000>;
+		};
+	};
+};

-- 
2.34.1

