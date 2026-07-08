Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3454C43E4B5
	for <linux-mmc@vger.kernel.org>; Wed,  8 Jul 2026 12:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783513088; cv=none; b=kX+IfBfhxrSFz0JPL1FJkCEa3eK7Sf5jF1JyAVB8wKp1NKiUMCGQ0XFPSP+6Xo4yt1fPlFrN6353JXSNwnldLvEx3Tk6FNd/H0+Y/yAc3YoufI31KDcMNwDPDdsofTENYtwe30w/vEVwlTgTn3WHUcA5Vus2Yhk7tFaaPerghkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783513088; c=relaxed/simple;
	bh=2+T3//RkEzgk5/MnGTs6J4ytHBN70iZHVgNVdIr24Oo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uVUQu8l9NummYZY/w6NEvVEpUn7s2Agaifa4MmkhEdLElP4jUlX19XLiXp7izGXe0JxxZRg2LOPrSs+x1zStczPfEomGUdx7SKL4xMXjS0D4zgXjY9MPgFIZQX0MB9uKpfKPhXVCVfw5DXmOp3Ahf74MYkHDPjAZRg05oxzZzlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F/nyxWqA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DizpeovS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F/nyxWqA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DizpeovS"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668C3D0S2792090
	for <linux-mmc@vger.kernel.org>; Wed, 8 Jul 2026 12:18:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Rbr3DHNWkoFlkU1mt2/bnOyZPiDytRF3snlyP313oIw=; b=F/nyxWqAFEuFMyzf
	m46Vvyrkq5P0iH5pv7wZRpd59wBnIjMcBdJqS/uinPeXX7zyc4Kgy6YkrUAw8PjM
	t7WRlUVHxQClzH6MH2Avf183oqCJNetYOHZcqzzOGF1qak+0VQ/Drmx2WgId9aV3
	Kkq+fyKZ5m81Woqi1R4J8+isJQboNUnU0zUgDP2ED7bzJgV5nVlqXH+8dMmWSR5m
	RRGrWudEsKJ4oCoCNoYNGTCB/Gh7qAyEV+d5EHZjZmDv+URS7mSKixDrcxb60s6a
	RWJ/F/lXDUU3XNm1kofnXp5m37oOcwYfIGeASCzRUN8NPgVybc/vdwv3PzYnUOdS
	m4uCeQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9cswaa2c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 08 Jul 2026 12:18:05 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8478ff5d801so1324095b3a.2
        for <linux-mmc@vger.kernel.org>; Wed, 08 Jul 2026 05:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783513085; x=1784117885; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rbr3DHNWkoFlkU1mt2/bnOyZPiDytRF3snlyP313oIw=;
        b=DizpeovS/tbuBxaDCX6zgICqeNzrUpAohM5SGIyH7wha4hQsvn2psjNSyPkOqcl8Bb
         zkKd3XLQzbNni5N1NYbM37xcED2gDm1aRtuJOcfVnG5wJ4htC5ywh3/GWgoS1xr2m6up
         wgDLxPhudr8SQXZNIkxV4aYfLzrPEO5k3O+mP0WVUFQp0DE0yx7wGRH/feI38phBt5OA
         QeF+8lao+YwWgV44a7/7gHQckJNUhC0vj8vMfle43dB+KbCFLz3JMv3wYwHImvnIEsBd
         Qn2PRaFwmkgG529/H4Ldw8/NstjXlsH4h9w+JAni4LndKqoSiemiaND7MSiSmlWu479+
         MWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783513085; x=1784117885;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rbr3DHNWkoFlkU1mt2/bnOyZPiDytRF3snlyP313oIw=;
        b=GjGEpumorEYMcHdpx+NuX1aOvt1UuYyYmaDBCrAUsmdpe5o/43Oc6qgkVMwKu/s3EI
         ttkhpWGhUrRjGVPfEpuvcpPkJBZcXI9HK3XxyZkVXCd1hAKWhea5G71gQHukrdA3PtLT
         K/SjhnOsur/j1bewxYL3T305D3dPLkdFpId5Hr+ad0RYPE7TwmNOwyy+Wp2qawJuU+PF
         EN1sgfmKQWke98SDgyKyLFpTuF73SAc5aNVlRLoG8MBOPhwFJgfQncU9sxeLlF75Iv7F
         dq+9zgdlmC5x5r6F0s4VYoDqDsd+XcXlo1ofNmJALgzqTGUIj4ipqQ5mHVitKPRjHv95
         dqUw==
X-Forwarded-Encrypted: i=1; AHgh+Rrwgq2kheVWz9NJkJ019f25eOfVaqWdnUK5WHs7qcb7atthMRJ+Q19ni5/LcAyRDLSGjwgbIuclHIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YycCNCpR9g6Z2xTJmmMqsiW/6ZYmwBDfe6Q2tdUUeqkX8S8oIT7
	qNmI7t7UwhfkMQ/TpseOJPbJOQZQKnkduslxwGLUfif9bWfcjC96sox7B1hpEnYR2MePBTyn3tg
	NRfpj0u/SluszDrjNAu9fMCl5kUbWWP2vegF6DuPNOOtExR20pvkecUd9OOeYqIM=
X-Gm-Gg: AfdE7ckoy2ntntjHs99EmYXOJD1x9ccNQ7dXDjarOhU/ccqHTNkL3zSYPKaBAXJHFoi
	dodkIZovmpWMmwbw3k96nVnKcQKDdO2RF/VwO7dTNXtaQNKZywWldSz8GmecYHFjGwGJN51FTXk
	l67YEmOLiLp3rf+LQ3kUYWH5xFn1eMSY+m6NpnyrCQubddTv3W2DjkYIWTGKAfTDese1gZh0q6K
	ORpzznqMzz5YIniUsYJaclTguDE4DC/5PoRbnD11brfDKUCtyiLylvZW7VZGfVHo7d7a3zDQkAc
	3AqDgVi+vqu6ecPN40VsYKdacsuMStmHF1U5MOoj5sztCWp6Jy2y7TsmvV9Bw9g36AIA9V15nHK
	WcF20p450XM/WUwYLMd/5vFDGpg==
X-Received: by 2002:a05:6a00:94ed:b0:847:8c4e:1d5e with SMTP id d2e1a72fcca58-8484344e473mr2230808b3a.56.1783513084780;
        Wed, 08 Jul 2026 05:18:04 -0700 (PDT)
X-Received: by 2002:a05:6a00:94ed:b0:847:8c4e:1d5e with SMTP id d2e1a72fcca58-8484344e473mr2230778b3a.56.1783513084292;
        Wed, 08 Jul 2026 05:18:04 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-848337d12ccsm2367474b3a.48.2026.07.08.05.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 05:18:03 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Wed, 08 Jul 2026 17:47:32 +0530
Subject: [PATCH v7 3/5] arm64: dts: qcom: Add Shikra CQ2390M SoM platform
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-shikra-dt-v7-3-977b65a300c1@oss.qualcomm.com>
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
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783513058; l=4577;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=2+T3//RkEzgk5/MnGTs6J4ytHBN70iZHVgNVdIr24Oo=;
 b=OOv4AiabeVE2flsoUuzCizOjiHH1s5lY7jrgD2PR22FTRPGQXsY9zvh90m851nq5W+DTCD42Y
 KjFcCAvXBnPAZeW2dtiMytCceWkt7U0QO0PO0sCbI/g0TgRwhiiafrF
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-ORIG-GUID: _o6iLxaE4AQ7RVppf5cEm3C-8X_U_DhV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDEyMCBTYWx0ZWRfX+yF5IrMIAGn9
 aXvxjVjRnopHmjDfT4DjQ8+Ancuck58XnVGnvWPaUQQ36kmv96o4Zgeni9w4Nj/Yq31Z9bJ2xEV
 R08BBVr7y9qwpVn58mHOnZtvG+jonqc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDEyMCBTYWx0ZWRfX9PveLkPq79+R
 iayCjAjRmrTPop2MpLquBpZ163Pk53wASsK5DI5pZ82xdlw6oXUR/Xujk4Mn924dh5dXYO3p/A7
 az+sPxlT6LOeikd249/Os5MfIuFHRbmV9+ZSZbVMqIy2J06VUTEE+UX3Mj1cZp1zs05yFcMSTjQ
 h6XPPwLpsepT0+qnIvMeHEbWlxO8vCqFs7+zv0dIhcUfDGBqlR5+dkoLhBmse1WLJhX1PweQDpr
 xv0o4k3Q5SIzo3sjrWWWkX9JXF4+9C5VobBmmpNksG7jYLFsToKfeXqIDW6VvwwS1iLONurBJ89
 YVTI8d+OkjQHs5c3CpB7G+jezs24HSUPeSssl17vfnhUPhRdQKajPAgkPu2MY5r6ldxCGvkYuFn
 ZHv2qfWBPhnYkc39fsU/WDIpLZc1Bbd3ZGgxptfvHX7YJTjkvM2gOvlhlkUAAn5rE47/H3g+LpW
 geBIVQcRe4iiFAm978A==
X-Authority-Analysis: v=2.4 cv=HaYkiCE8 c=1 sm=1 tr=0 ts=6a4e3ffd cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=s31jhp6hv9j5UOuNascA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: _o6iLxaE4AQ7RVppf5cEm3C-8X_U_DhV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080120

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
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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

