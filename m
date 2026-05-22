Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A79368D7B
	for <linux-mmc@vger.kernel.org>; Fri, 22 May 2026 18:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779472985; cv=none; b=liE++nT17fJgOxC99E06myb4xSHn/OoOVpBaurWz9gykpYXYhQNQGLOTqJ9CMk8wjSdgid6+msnTa7KLOpLkdfPhmSiAozITD0Wobcy/PsZq8Zx7rqL3/FkwLJbn7U2DRHuHuDFSGj37WysLfKcD2dF/ie12x3Pu3RNRVtYzh3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779472985; c=relaxed/simple;
	bh=ODfMe8YwpE9zm6WOKy1yvRuBsZs9KnzIUkMMO4tFT3E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B4+1RRa7hcT/TfX3lJzyepf7Wl/GlL4Dd89XupBxSx//SABnkBPUpa3eQUtKIAan8G1SDcr9TVBRBSPkFM7XgeZRJh8DEVL/3AmbOJr8riGS0QUhhpTxTK1SpwwJ4eP9b/CtgaAXuFjVDtUMiiMAtueLUx2LEuYzejR3FkxMqYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fPQpNPse; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XOabe8SB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fPQpNPse";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XOabe8SB"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64MFikR51816091
	for <linux-mmc@vger.kernel.org>; Fri, 22 May 2026 18:03:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IlhEybdLwbReB9UAd0lx67zdA/XyQhjGmwbRzt5Ttzg=; b=fPQpNPseu/T78jvD
	0yn6iOPXMQufvBZZdgGzPqz4s3BU9EbcM8mXoJO/Ur/GyH56vgM6xigpTD/Fo1t2
	+4ewgfq6aCjYm6/U31NroVELaaE0pspoOVMOdhfVjjvul8SBi4eFgOjMqM+4mtUw
	5kV0ky/kF1sxujWsvEbFvOXf5eRHUhWrsN9DeT+I0KWi8MSPUsnp4flsg0N1mFYD
	jWYdnpz60meKNUOojMHzywlSjc9Q9x74KWMZFZ1P2zLEYA93E2vIOqQivKjI650I
	tU+LTslg3EWjFleE91wgsSpOfUMHpm7Wt4wMEZ9w6j8EN/LuGzJz5SJC+sXCqcEE
	qdhSAQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eafrm38mh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 22 May 2026 18:03:00 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b2ecc96a9aso85202515ad.1
        for <linux-mmc@vger.kernel.org>; Fri, 22 May 2026 11:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779472979; x=1780077779; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IlhEybdLwbReB9UAd0lx67zdA/XyQhjGmwbRzt5Ttzg=;
        b=XOabe8SBl6at3XeJUxiOiIUOV7ygKoB9opIu8i9ai/4zMW0IMzf9KCXp+jn943+q+t
         cXIoOsL8FDypawvzguDPDU49CDzLmi9DriENfyvdryC1UOwPstwQzspTBpG7J3oqgvRY
         eFfie1hZH5VuWpfyGcd158cRgoLr/0+HcGhlpUwqk1ZiTtDqcMgZnxZY1YmH468n76sL
         s70Z3FmO+qxankjuCWUD6BvFoYfGi18heyCfjxYQSLqqISEkH4DpUnHUs5IqKCXJURso
         vJ6GUsfahseml2+7UWwrvzWmS/hfSZjfaUeNTfLZM7lfsi+oHm9XZV7AlpTeekZwO0H8
         YR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779472979; x=1780077779;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IlhEybdLwbReB9UAd0lx67zdA/XyQhjGmwbRzt5Ttzg=;
        b=X6ZPZpJJ3RM951Hw6NsqODvpAXRhVCYQBAUPBeRKipywtFNJuQ8NOsiewXrdfk1lJ8
         CqFlyFwkHo6UaiEqHh9lBNMESmbJPTIgBRMwi4/rYrLKX1s6WBucHKGP623OsuzjGRss
         h0c5+bD8GlPPLZog+iH/gI3tCq9d2ad8SEggEH+u12cpNKr9bhABFivW967gpUr6e0wy
         OU0nT/Ybr610Lvl25DHuNeAFqI9Os0qcEiV/cwaWtNzFRtnE7j7kLqHs8nuC9PBArXf3
         FXIl5ZwGlnuh7jqOcYAYURTzKittkb6K2vt08JW5xs1S65sbvZFBVoicaeyvfA5XHWWI
         hOHQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Y64ykz7usRvNvoNbf4qJMxJQe/GMFMApwnxRNdfZcnPZm8CdMNNB/fm1FToGxkGkY7MraL46lOHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDlolJlRS4QtCoi2jJo5/Twgym8TdrvQr7BTPJmSjwpgVkAQxV
	Sa2af6vqZdhXSokHKmsMRLImbgA87IaBWrycwpDz3qBs+41Q0nb+9GUPfSk0Yye25UItV9Jo0PV
	ZC5gm6FfgfDZmswg1tpean+RRcUOwYNHpAz+9xDewEAhpqkdq5diAVl59oR0wTYQ=
X-Gm-Gg: Acq92OGc3M78wdpjZZm0zRQzoUIiflVI0om1t5SdP5ivnuokbskfAgCRAjvXKe3tpQA
	GzZ5xuGafzDP8HEgKs3iImRcCBA5fE9RULykZlbrpHJMNH3l0yIowWSd378lJl/l5t8wvWLpjnl
	TTYczbpw0buFwVbasS9RYkpsSl0cGa/RP+jDQS/al+2pgEilZb0RCgsb0FdD0VtS8i+BNe4juN+
	tBQh0vxc/Yz97iJ/U9AyucwM58EsTpOoXwLKBXj4Dz15SiRkAB8kBzHkYpc5mOs7WcLDuyzPJb4
	uoHYVJxmp1QJk/QTOLSTKC2jK0WaK1MXbsQGNOb1U3fCm/dmeVazDF2D3U8dHDsfBvqi6taVf2M
	Bo1kNcSTdG/PgeeuLBRUUoEp42UOhVm6yWtYfLW8BbhXe2Tw=
X-Received: by 2002:a17:903:41c2:b0:2b4:6d92:b002 with SMTP id d9443c01a7336-2beb07db743mr50570555ad.37.1779472979197;
        Fri, 22 May 2026 11:02:59 -0700 (PDT)
X-Received: by 2002:a17:903:41c2:b0:2b4:6d92:b002 with SMTP id d9443c01a7336-2beb07db743mr50569905ad.37.1779472978605;
        Fri, 22 May 2026 11:02:58 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58ff106sm21193645ad.74.2026.05.22.11.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 11:02:58 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Fri, 22 May 2026 23:32:27 +0530
Subject: [PATCH v3 4/5] arm64: dts: qcom: Add Shikra IQ2390S SoM platform
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-shikra-dt-v3-4-80ffde8a3dc4@oss.qualcomm.com>
References: <20260522-shikra-dt-v3-0-80ffde8a3dc4@oss.qualcomm.com>
In-Reply-To: <20260522-shikra-dt-v3-0-80ffde8a3dc4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779472947; l=4539;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=ODfMe8YwpE9zm6WOKy1yvRuBsZs9KnzIUkMMO4tFT3E=;
 b=KtKGO14IoZEn6XSmwkQjzh4RuB8D4vLo7VQiZcMsGVg9S8KCU8nTWc8JpyPOZ34BkgdurHD59
 ZFJAPGhlzEZCswyt7EKFSviffQ/DZ23ebGTm9J60w93SEh7BBnzHOsT
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-ORIG-GUID: -ngCLVPPmZPq1rjCO9s4sA6FgQT2lynu
X-Authority-Analysis: v=2.4 cv=Zekt8MVA c=1 sm=1 tr=0 ts=6a109a54 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=IZjsGcCFCfEoDLf82CEA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE4MCBTYWx0ZWRfX4wWg/7NfhFaY
 vlugjNGDl3twt2247vdEyerVyeWMfbJAXCUdErkyjdVmV8SR+GbPu+fAUWGxq51VTy7WQXilqCy
 NOlCkKqCe6dnbpEdngvYmMENQfBPAu0VSym/QoRuhlcHzHK8vkNGuD8eVyM1UI1F9iztoWpsUsG
 Psru3I11L2QI1foU2zHHB4GEVyo2YOJn9KdIhTBVCEWaWwy6B3JGUMEWIk6MnsQF5qOjUD8Q+46
 LUEcE9bUMKuyewLM8vTtknGThoXmIgxOOSXAiN86D0yqhAfIeu0t6vYBLqZ+RqSTLRTzg4MX2Rr
 VIo7zDxm6FyLZbCUQsldkky3VDq5D0axR5bbK0ELd5Xf0kMluq9iZo6gX2RywEu0UM042OJZFqC
 0NENf2jVsCgy9eP263Qy0OCaaFnOmjfXjbM4Km0f0331pVFuwENkynrGD+LN3ju4CXDbo+XDb+B
 kMyHMplBcfSX3GPEEFA==
X-Proofpoint-GUID: -ngCLVPPmZPq1rjCO9s4sA6FgQT2lynu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220180

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

