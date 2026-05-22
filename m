Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6C450276
	for <linux-mmc@vger.kernel.org>; Fri, 22 May 2026 18:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779472981; cv=none; b=irVZvbyI6XpAVVPtd49uNjqsaS0DECrqGa5NW86CqvOo3nOTe/NC0LxwuTEpxQMh/cb80y8N4B8bXelisy0XPvPFVwq8QKIerAxd6ccUy0XVPZ1770SGONXaPmeOD4Fg8aOKhvW9gj+7xn4azpgR8gGZ294Bg8QaK2KRqctUPLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779472981; c=relaxed/simple;
	bh=gyY1XiTKArO3gJDJCSJfjS7xSgApxMt112/xnTGtpAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LHQDbsLgA9Sjlf52oldwV03oJ0by7Q9rychkmVEEyZjTaAGMut4DnKISk/fJeNq+6j+mk+U3JpeaWOPITgrJrv+cmWbtNyFlEFT0D0N0mdbKrUCbdN6OZl3isJs2mKA/2v05+X5wwRc6aPOKsQOZX9Ix+s+gTSKzgUI/8PrP0Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Kbf/6Gs5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IpHAVk8V; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Kbf/6Gs5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IpHAVk8V"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64MHQqRM3947382
	for <linux-mmc@vger.kernel.org>; Fri, 22 May 2026 18:02:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LYbCyoSrxp2f0yxvAlcjf3VHWtL27L0/ddWablgzkzk=; b=Kbf/6Gs5EBaOfZpY
	e42nxdQPhPyuAqLIxy2J9TipfdTHdsLkg2bRpgxKX5/AcbOid0ZacorUyQIaBBzG
	H7ndCf//zV3X3gQgMxJ06BGwUv2kEtQMQzuH2aieXYeQJeWtXSD56D7tMcbH4GI1
	OKaVAkJUT1MEEOqRsatYpWH2zB+2dei9OysI1i0Nsb3DPgwy6bfKN8VTg9cNHbQi
	SVWU7qMkfoXKq3xcGep/TMx6g+ci8zU/QgEjHzyUe9+P5txlir0rP1BGYdrsfDr+
	0LeambT3s81BS53Bw+fiqa5jZryOTsDDKZhRqu6qoul2oVjVux43tiySRp5P13eb
	w3xMjg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ean2nhvkn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 22 May 2026 18:02:54 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b2ecc96a9aso85198085ad.1
        for <linux-mmc@vger.kernel.org>; Fri, 22 May 2026 11:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779472974; x=1780077774; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LYbCyoSrxp2f0yxvAlcjf3VHWtL27L0/ddWablgzkzk=;
        b=IpHAVk8Vy6BAZNQp8SiU+K1nqor2wj3IFZstqNkGu/TuQC+42Ek2B3wRmtieNnMTU3
         0uKGYGvJJfbn4HHpnZ6qUGXuY5J1edHb+DTm/yuJhwGSsZyUBvuo3babQnQpp4NZqsnY
         x+FTo7js+rubKc8OnXQxRMzPVYv5Ra5RVY3xwIjUJWkH4Vw9HTyuC0Ush6mvSfv42w0B
         L5PEBRWSpyGpePbVCcX2Ef2M9qBkwffByzKJ9ibs0WTroVsdZxcJaqBARcf4eeKSFg8D
         06is6EhAXHoLbW1OrWs8mbnwCLSE2o1NPgBlti5V0wl4SPVQKbR0H/IiOqBi3/4z0CNd
         yq7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779472974; x=1780077774;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LYbCyoSrxp2f0yxvAlcjf3VHWtL27L0/ddWablgzkzk=;
        b=BZMFXRZTvIVPsX6cXloPp4iyKuSce6dENbUI9cFTjzP0MjAnH6HgQ48HYqznADfPyt
         ZxQaz0HNrdhwZLG8TQjS43x+pkkbk8ScpHu+QCGFGsHgTZwm3qLw88f7L97sjT5lrurh
         tqWhlJct0CyMAvunqHiIUfozal+O0QKoX1qJBsjzlu0aktWCeU7jYKtJrd2yhe2tZjIF
         wVvuHjl4Dzdx8+guMBiWCN0gnBrPHo4/hHUXyIYe8uSTlAC/suMaetT9g2mz0udOWkSV
         b7rNxdfC8TwPGS7UXmNcGes3gtcrCBAoRN5mmQ4mHqIErqpJULSGL6x8Q95dqXuXBj/5
         oWvQ==
X-Forwarded-Encrypted: i=1; AFNElJ/wgESJgrc4+NJ14c6Qa/AnyIzcfZy6FjMFmZY/EULmnqr7yP/dZM5dvmmeRAoM06GD+vTmA3hJq7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUlN+flwZHy1EzvNUA6zqntAxy4hJ6aDiyPaUKVJOgROA63c96
	m7KuUxiqSgqtS6ijtbWxdCfm+Xh5GDBG/oW4i7+iu6+Wvyhzu4e8o/uiydF+KYsrnZQPYNzCv+q
	mMnmWOIexo7Fckyxj+io+Pj18/7070luX1go27pBAtaJeZBPwe9z3PX6jBbzs7HiCz1gmTvs=
X-Gm-Gg: Acq92OFTOwpG/RZAcyixjLORJwYRmaEm2qcmKkeBmIZ2t3+tRYp5Lj9/XPJnMZaA44U
	7zEXMIKWmnyHbcz6h376XKT79FpYKHTGRNckuXaFgK0r4Hcn9k7kG+Fpg5Q2L2K/AGzwysDws5q
	S+VjFcrhAyC5de5F9oZKbiCqM9rl6xcgQyNmBL0GL/7LkBI9gJJV0O/cZHB2UOLhQJvevEM2eYp
	Q1+aqsaUlpUzrYuHlARGo1bGFy6EgeF6DzIJik4W8Y2LIMrKY9B6eqRRWuHMNJypvu5+0OFz4xN
	eYpDWnfdpx2vcTf9llWk/rtmj+h7nK4Ue+fB9NB0pxU9IYVFxbjIesPzXzmFbv+MQpvuYm/4gBx
	914VzdnTj4D6kXx98Ypy5NX3f+TXCOHJBa4x6
X-Received: by 2002:a17:903:1a10:b0:2bd:2430:eb7b with SMTP id d9443c01a7336-2beb06cbf6cmr53141165ad.12.1779472973786;
        Fri, 22 May 2026 11:02:53 -0700 (PDT)
X-Received: by 2002:a17:903:1a10:b0:2bd:2430:eb7b with SMTP id d9443c01a7336-2beb06cbf6cmr53140605ad.12.1779472973267;
        Fri, 22 May 2026 11:02:53 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58ff106sm21193645ad.74.2026.05.22.11.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 11:02:52 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Fri, 22 May 2026 23:32:26 +0530
Subject: [PATCH v3 3/5] arm64: dts: qcom: Add Shikra CQ2390M SoM platform
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-shikra-dt-v3-3-80ffde8a3dc4@oss.qualcomm.com>
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
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779472947; l=4361;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=gyY1XiTKArO3gJDJCSJfjS7xSgApxMt112/xnTGtpAM=;
 b=3hw0jq4U6PlOsygUfYiXLFHUOBdUHGipF5u5OsPsLZrj2E3lxCbBDryNt8DZzBw0Y9TPqVJOe
 cUBb9e7XfLRDkr6i4wecDON2DKyFAnSKvdbYj3ZGtiJSUZi4dvdzu7P
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Authority-Analysis: v=2.4 cv=XvDK/1F9 c=1 sm=1 tr=0 ts=6a109a4e cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=s31jhp6hv9j5UOuNascA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: jrGJLLzCUZTGWIxeVzgeVFxXrAziB6YI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE4MCBTYWx0ZWRfX8TV7S9aXLH2H
 P1PbqprLNaBPvoluTCYamwSL2ASQbyvKFl/Klc3YcPmqoqP9MxeZLN5LiNfAupU9+zwCdKM80Tj
 lK1ewP0oklaB0lrKsocpBTaqJl1Bdxneluc9boYVN61wgycx3s3L0UGQAg351m5dShQhWmWijai
 1NarWrohgkqXB60GQbdcjO6epV86pUvJ3xfH/DEEz36pzs5WdxXJuKv7/vKO/9Nu2WZjQm143OR
 r7svbRmrwMQn6I8CTG3Ww3pwNCMjPsTRNkq0D/pYYxuuMVJGiFSFP1c7eErAB7qhy2pkIWKIjji
 wJBXWpmEw7UIkaF3sq7oKfSzPmBSsWKM9AiQEIYCIhux2lEMHloCw0kV7Lcdq9BvY2SrtpSNboO
 EEYZqLkf7b6LA6T8Uc+stY+hSu7BStugVzfV/cL0+aVdULLFHGBllBBbHSdKTiuk742tjrsAF2J
 CIzVsC9OJM4iBLSfmLQ==
X-Proofpoint-ORIG-GUID: jrGJLLzCUZTGWIxeVzgeVFxXrAziB6YI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0
 impostorscore=0 adultscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220180

Add device tree include for the CQ2390M variant of the Shikra
System-on-Module, a compact compute module integrating the Shikra SoC
and PMIC for IoT applications, designed to mount on carrier boards.

  - shikra-cqm-som.dtsi: Retail SoM with modem (PM4125 and PM8005 PMIC)

The DTSI includes the common shikra.dtsi, adds PM4125 and PM8005 PMIC
regulator definitions specific to this variant.

Co-developed-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi | 156 +++++++++++++++++++++++++++
 1 file changed, 156 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi b/arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi
new file mode 100644
index 000000000000..97966cff8896
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
+	gpio-key {
+		compatible = "gpio-keys";
+		label = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&vol_up_n>;
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
+	status = "okay";
+};
+
+&pm8005_regulators {
+	status = "disabled";
+};
+
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

