Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7D63CAA31
	for <linux-mmc@vger.kernel.org>; Thu, 11 Jun 2026 10:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781172649; cv=none; b=MhsB9AkXH1b0oDAveQOe6jgCZJ25tF6Sk5GGSIbsBtnXNQcB01VaEUHICLVwhIJfTblZYeMWCbRhZSlGGIlR+fXeBDhjfGmUXm67pQXCgTp/JtLyKrBBITPoxTlsM+K5HOt28y/gq36X31h7BJBJcgL3tO6hlHXnU4cvy0oneoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781172649; c=relaxed/simple;
	bh=ODfMe8YwpE9zm6WOKy1yvRuBsZs9KnzIUkMMO4tFT3E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YD+6t4lOhJZ3BPtgzqKGdeNWXPGfqOxTZmq6bCG9o50O5zeGXaUfkcDL6EdHNusXBdzz7fjaD73PneOh/PUDxmi91fnqdMujyDUZdVoI7ENFD12u/kdQQVTFW4RSMu8FsYOBXzmtX3tDcbZ5E/DOL/LlHwWkVETrq+8jpfwE+io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EoOO/R5R; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kf87Ohn+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EoOO/R5R";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kf87Ohn+"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BA0xTq299615
	for <linux-mmc@vger.kernel.org>; Thu, 11 Jun 2026 10:10:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IlhEybdLwbReB9UAd0lx67zdA/XyQhjGmwbRzt5Ttzg=; b=EoOO/R5RnvBtfg1n
	QXzYmMvB027F4rAa5DkSbBDUMbliK3XkfpH/do0Ke112SQyqpw9dBj88gDpGT9RH
	W4PfDb8/Lopd3C+cRyx6ypfNkfknhyVPIoysu1kOtNJyd3YeSP0GnrHSgweH+VW6
	ZgnfyQ0uXTl1B/xiC5iopePT4kjcWVEIPoZa6wR0dB1Ye+ydb1lO6/rN/xTkEEL5
	Z07XbTkoEDGFddR0fDqCBrM6szDbq38WngiljN/LgGbVuzBX83bcbprDXry/eh+e
	ygo8XRmDoHPofMGhuNlG1AFhmunoCXOmt2FwH/YYBb7CnTIQpAJlTkjy6gNRfgJm
	2G4ehw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe702u9s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 11 Jun 2026 10:10:46 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c85d9f0ace9so7482583a12.1
        for <linux-mmc@vger.kernel.org>; Thu, 11 Jun 2026 03:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781172645; x=1781777445; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IlhEybdLwbReB9UAd0lx67zdA/XyQhjGmwbRzt5Ttzg=;
        b=kf87Ohn+aBD/RLlj/WD0Your/Hfd7uUrRwH4+qmNy/3rYYFVKtkQXlU1EINHP1pHp4
         h45kDHz/Hx1wjRTRz4kwWbvXzAMJsLuUx7Ikkf6pkVkaiew9Smij1DqP2OibTs8dabwz
         v21CPyBaUPD41Vi8bIe3Kbj/0o7Rrwb4h3GiZHETkqBaMMfyGdryXJlgG5+JEX8IeQtW
         hwLQxO+Rp2LzLaVGH9IEJAq2snud6foRYCRWRAtAYPe4BcsOVoA1JkFZu4/dOAbnb2e1
         swBez4mWt1cfoE+oS8lKOHSrrIcANMBtVXX3sgRoOU9P58rHkZq9YyY88K6wOaT8WfBk
         LTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781172645; x=1781777445;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IlhEybdLwbReB9UAd0lx67zdA/XyQhjGmwbRzt5Ttzg=;
        b=gyDwoLGgjVXyw3Q49D5DmRGW7+fNGFj4cNIVJLDgAj6ZV9jPpNE5zraKgi9gLg2UVW
         uaRTcGpmYhVSrgA49wBK39SCEfxV7hFcNxn81QGl8ZPodjE+ia2hFbYKU6Tap9XfO33X
         LPKQsVwS84ntmjrgno7LLMXwK4D/CXd5L+AlZj19zdazPvJWDscBdIBM/5+7z4otqXNL
         ke1lwh7kWAi3axR2DPplvPC2EN+nN+LeIn5DvTI17/lu7ILw8fosh2sjEng8ffkXTznO
         Wm+tvR7OE2iYMHXoMf3M+id2LYqkN+T6r99YXUyoi7/GN9DNV2hSB2YsEbXXfle6rY1P
         /TTw==
X-Forwarded-Encrypted: i=1; AFNElJ+KMe3i61mzeJMPccuAFwI1JZwbYHh3V6CjB7qlrc685ax+JaJih0ccqRArK6owE8OY5zKwVKvI8HE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/WKWZzgv649zxXFE85fk0PnExLeJHGvzFWkqMk9qGEJJ9SYsu
	bfRYYP4EgDf1fO5V5j696Mz6iuCJKxga8R5G5XoE3AQGAA9Lc2LtW/jXdZQwc6f3ba2sMXGGA22
	9qq7T9MS6tpCOAD+SN4tUsAkhxRePitlv++WteWQmMctk0By8wwSv/Tk+agIDGQ8=
X-Gm-Gg: Acq92OEKfHzOUIMKRwOErJgSvwbtYd49jW9Hr3Ikb3DMk+wW89y32dRujysbNvSZdo2
	AklGrLKJ9/kYfYh7jjILXruQ9PF9aGqmjHZm3yhX73wCbvGxXspsYrSl9GEf/i7N/NNApCz8+qG
	F1qLjYc9fh3YkmukgXIvM/zwE9nGxtShCwG2MQ6VpyE8STbWLLOdTkZs0fiyVFwN3u3AuOJR0gy
	cDGJpxOHPVLPwWpTS41C8F402xI2CHrbXqp9XAsPBkXaK9OXQl3Vl9xMldnSKDMexMxLYwpbuR7
	JBhcES1TkowqcIXPSWw9HrziIhOW4vtPig0cAdEAEQ1kaoAfCliewYp+LiacXft/qHMcpNlGZ/D
	5h/8yukioLkWMtKq6yCEeDJPSWq9Y4a98HhH0RaFXfsDC6hM=
X-Received: by 2002:a05:6a20:9f46:b0:398:89b6:1b41 with SMTP id adf61e73a8af0-3b5e33a3a05mr2479890637.32.1781172645554;
        Thu, 11 Jun 2026 03:10:45 -0700 (PDT)
X-Received: by 2002:a05:6a20:9f46:b0:398:89b6:1b41 with SMTP id adf61e73a8af0-3b5e33a3a05mr2479842637.32.1781172645121;
        Thu, 11 Jun 2026 03:10:45 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c865860f3d4sm1279646a12.19.2026.06.11.03.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 03:10:44 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 15:40:11 +0530
Subject: [PATCH v5 4/5] arm64: dts: qcom: Add Shikra IQ2390S SoM platform
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-shikra-dt-v5-4-103ed26a8529@oss.qualcomm.com>
References: <20260611-shikra-dt-v5-0-103ed26a8529@oss.qualcomm.com>
In-Reply-To: <20260611-shikra-dt-v5-0-103ed26a8529@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781172612; l=4539;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=ODfMe8YwpE9zm6WOKy1yvRuBsZs9KnzIUkMMO4tFT3E=;
 b=H7Hx3kKkmjdEfTng4u6WtvNRij8kmTccmMfcIe9Mwde5R36N4hRU22QeBBeGc05uBLniO8l3D
 h0jkcbjNRvFCYME/XH8xkIvBxqrSVfBSJzzRrwVcKafu00YSsnL/F/m
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-GUID: EsyJgJ9rw45MpZ0ACLRKN-MKhqgFMHIp
X-Authority-Analysis: v=2.4 cv=B9eJFutM c=1 sm=1 tr=0 ts=6a2a89a6 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=IZjsGcCFCfEoDLf82CEA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDEwMSBTYWx0ZWRfXy5bPTgGt5gSK
 5nNNrpJsB9ku3XvYP9Jc4upFAPvr+O3IIdNGyFH5JUVeZiL63yxz8KR40L3hq0HRO0e/B8EHG3v
 GTFu9lY5HjvqKnXRY09N+6+XGPdlkXFzzqhnviqeY7rMsWlE9gvqhTljSPR3sGNsNZpRniDnIoQ
 npBkAfobiO6rxc4HzW3vRICGDacmTkjFmWOvyMk0xb4Ug0SgDvJ7mrtmTf+z/EtxfSrjw9nqY4k
 t5j72VXD++vUqTHNCiFDEzHHEnxuvG82osiO1jJWBQsbHRVBLgLJlfSuNmd2YivbS4LqnoZIZ0o
 ErYwn4ihwVzcHhisQVmhnyjXkwgeKR8BJAKggYQ1GV15cxeh6mkNyqNplUiTOfwM7kkDGpR7xqz
 jdLOt4pQ/Eo5irB0jsz5Gv9zqfPRORnpZgqjLf6PJb1lM0uup7lnUGkZWr/A9zq1Cw1wJsY1fgk
 6WpTX2ZiqvlZkobcpZQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDEwMSBTYWx0ZWRfXyOB1ygC/QaYf
 7/PQim3NH74mGlxwIieTsfiSqVa+AFTxeVEZdn2/Metq1lBGz9od+N6u/ydGiamBMvJvsIcO+bz
 6pqhPw6tkrRUdxE4JU1X6pT/jdgr8SA=
X-Proofpoint-ORIG-GUID: EsyJgJ9rw45MpZ0ACLRKN-MKhqgFMHIp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110101

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

