Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EA33822BE
	for <linux-mmc@vger.kernel.org>; Wed, 27 May 2026 15:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779897355; cv=none; b=TI2vZegzb4UE/7bT0DeCOFxhP/nFzfQz4kALm7YORE6u+yWM1pixy1EPebHtYzqGBj8Nm8n97BWVh317JfyhE4+JFGdYJWV9cXAu8O4oqKcyuQNIEy5qvly3SkAziE06UVBopAjnz5dSfU9QaGkzs0xrwOgXCa3mPXLYgSFMe14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779897355; c=relaxed/simple;
	bh=HvHWQtODvdkbR5OShoXL2Hw/tCjBTmKQUX2DDJxZoEw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IDIQIdYFB1z1Tl/MIG+QhvFHJYWTh5pY0geLtnZP5KgScQZKNJ5GyRab5KXavjLgkLQzJ+FdAExHzfcBoZT0tN0/qb7pOAwrkSrYllXdcyG9xU0cDD2ivepiX+4fKCNLKwVA3y6E+8E3SCoDMELOLy+rf+Pg1IbM2kdOSuRnVCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AZtKcxlE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dXbUQ0h2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AZtKcxlE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dXbUQ0h2"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RFgQfE1176693
	for <linux-mmc@vger.kernel.org>; Wed, 27 May 2026 15:55:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A4kQsxb/SwdSnGsDD4VNnccmJf5zbiuW9tHo31lzG8o=; b=AZtKcxlEuoJwI5wd
	jms0730lfxqaT4+HB3j+oIaNOcZAGFDI2v7aWXU/sHDypmHp8MaSLou958mdrEOu
	PewFGxBArtWcyrGCXafUwIx86gXqqe/claY9Do0GqHqMfYFx8FgZBQ4mrwX+8SNT
	JyZ6aOm0vPBo0+V0UlBAL1I3AkSAb4RGF5Kv0CBIVgb/T5tm3EpXnJ7WCmt3SUih
	GCo3Cw6+K6cP1VRTFQgdscAsGnGIRcX+G7MvWwc5GYWM3ikREKoC/h5IPFDER55p
	6pKSsHtLEAFhYyCxFAucr/MsbRhffLO4OuGP/5+fk+8/S0/hsAe2LutPKQG/HZu3
	jKRJpg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edndnka3h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 27 May 2026 15:55:52 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ba054e0304so103290875ad.0
        for <linux-mmc@vger.kernel.org>; Wed, 27 May 2026 08:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779897351; x=1780502151; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A4kQsxb/SwdSnGsDD4VNnccmJf5zbiuW9tHo31lzG8o=;
        b=dXbUQ0h2MJ1mPCoBNlcdt7yqSWTtLjVw2xpplj3qZoruT1bBsUNK+cicqT6U3Igy36
         0J47ykp0kjMDSgNZP/KWoT83km6SSvMa8pk7a1PPPe6tYO6DnkRJmSEoDwvJuSetZ/8U
         l5vhl/F3aN1g3j8aYgNCANtgSPT0mz517xx58DnXl7yQ6scp844P2Wy6tnI0dqZ0F5do
         GufV1RUaSvk2jJolv5Lk76ngzBLxpKFzrGzss7oxp/JHvzjKhN1lBGZcyaMthi9FobIu
         w1cZCSSw2/SY4xkL/cL7g1Z9jJBe4GIMvR6LgCKD2m5m18DV5fYGGttIcKYL022kDhzF
         R5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779897351; x=1780502151;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A4kQsxb/SwdSnGsDD4VNnccmJf5zbiuW9tHo31lzG8o=;
        b=NoCgqWv6KbkjyQNv6NSxyFXahkIsjgoEgW8KkjWoC/GJvT/RdIDOvgGsFDUxmxmZBY
         6YUoNRYLH322J2Df4Bq/1JHzZNjihvjUbuwAikhYno32xoW1rozVbl2AnW6Wlyhe7gD6
         GJCy8a3+OlMn319e6akOkuOAc4FeKxfBU1b2SnDihcu6HxdpzQiegLdMpTlvDB50je5c
         Zm4ukm0EuTaQzK3xGFqFZoEWAMzMS4glomY401LL/TklNs0pL087bgdvOLkC2XKq53M6
         qCNbzq12wCeQQY/bU3dKwOjuCKboQKFReyM43FSzCYcnAQw9sgP78YiOclcYM6BSzVSr
         MkbQ==
X-Forwarded-Encrypted: i=1; AFNElJ/5NZMKfYS0K0CSsCBSnk7Db0to6qDg57E9kxEEsltQrBSKce1EpG6XCW7jDHXn9kydfXH6wxDWFRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAzydROlCSLsx/HISf2IruiI7YQdGih8l8VoQKh9oltJD1IbUH
	rgwzsDhhfFMCjY0A7/KJmCGRnV1pJaL0O19A4cnM0DIyhif15FFox+6Y3fq+SiDgyOgszpad9Wt
	BKKqC/3nt3XTyTpEIwrDBy7IUTaFG4OIaVGS5g0IzvPBFNbJeUwA/4UdRxRPG/kE=
X-Gm-Gg: Acq92OG4QPPIzimSHw8NvRB/lVxPj7EeuvjbzVWCKEII/Ih+ayZ/oIH6cKFgxcpyyCU
	UViFnmnwEpPIWQpRzXnSodNNY/7h4a66095l8Peceq6hxNBTF3CtQru4kAs14SFXRhQrqtu47Cq
	IEbFwOVqnfS9dTkMh3LRYkEnDryGEt+6/QDSxD03348eX7TE4EBqN8EohteFI1DDzS8LuDHH2R5
	CEbSCiNmmSwhAFOV1UlOO9Y4Qu72vgHftX3jzzvJK7KohtfoitA9uqew3USPauM55Wsece4pzjx
	WfF10vK9sXHX67HPyy7IeBmDfUXM9NWaeIeKnhzNpTlh7uxhWVOiint3POoI9th8+WWrs0lSMUz
	AD3KzfAVTwyykUYtaPXHmp4X+nuY/sckKQYXeHrr3Fdk4imY=
X-Received: by 2002:a17:902:cecc:b0:2b4:5bf8:a7e1 with SMTP id d9443c01a7336-2beb07db515mr213933175ad.6.1779897350953;
        Wed, 27 May 2026 08:55:50 -0700 (PDT)
X-Received: by 2002:a17:902:cecc:b0:2b4:5bf8:a7e1 with SMTP id d9443c01a7336-2beb07db515mr213932705ad.6.1779897350399;
        Wed, 27 May 2026 08:55:50 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beff36894dsm1264135ad.37.2026.05.27.08.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 08:55:49 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Wed, 27 May 2026 21:23:55 +0530
Subject: [PATCH v4 5/5] arm64: dts: qcom: Add Shikra EVK boards
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-shikra-dt-v4-5-b5ca1fa0b392@oss.qualcomm.com>
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
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Monish Chunara <quic_mchunara@quicinc.com>,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Sneh Mankad <sneh.mankad@oss.qualcomm.com>,
        Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>,
        Xueyao An <xueyao.an@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779897312; l=6252;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=HvHWQtODvdkbR5OShoXL2Hw/tCjBTmKQUX2DDJxZoEw=;
 b=9aVwEfhHsc3GCcWm2nE5kJZ9zjUyeZFFN7qlfys63SIT/1ta8//sEJXOY5+Id1QTyy1QHiQhr
 b3fH5CI16OMAEfviUkShkfmILVkrnbqq9R2n4vMNGn8K840Wlo0CMwR
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Authority-Analysis: v=2.4 cv=PpSjqQM3 c=1 sm=1 tr=0 ts=6a171408 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=TizygBHPM-tQ0bhc_XQA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: BAAVAmQLDxfxSYTTQ_6aGM2OLM-XKoN1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDE1OSBTYWx0ZWRfX82w6vJ9twQD3
 UFcVIFD3i5j1zPQVb/OlLHooXGmGFPJwDmTtC1glMMJ3O7Io7QEKdpHgCqQnljtVO0kKpCT7UZz
 3yslY7WqNst8JbEou+VjwqJ0O/5/C6KU+rH5zwkBK5vW64WYG/h32blftz95ybnoeGloNsaBi1L
 jYPX3M0/5+ft1ElUweAVpUi/Flanw18yaO0peKb+dqgvUsBchHjpcnbAgsecAk/abEjcicGhnMn
 ZTqJe+UXNgKG2/cPPXpf3mjit4odC8O741K+z+vGN2HXkBb2p/1lXBagzPKYmQFK7foP7qJk+2D
 /tMpJEVZc5PepFsWjfdhgfDDxCImOcbDopf2qSgEoLO3hiobLhlzMRrhZure2nNKfFn4nqb8r2b
 zllpRuMxnhEUoPzMQnHXroF9gXMlTu4Vo+sVvcNbSABdX++P3x0u6EDoRXdvz+GXMcYcJ/IHGLn
 4yoL2ZMNMrpuwKqS0Sg==
X-Proofpoint-GUID: BAAVAmQLDxfxSYTTQ_6aGM2OLM-XKoN1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_02,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015
 adultscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270159

Add device trees for the Shikra EVK platform, which combines each
of Shikra SoM variant with a common carrier board.

Three EVK boards are introduced:
  - shikra-cqm-evk.dts: pairs with CQ2390M SoM (retail, with modem)
  - shikra-cqs-evk.dts: pairs with CQ2390S SoM (retail, without modem)
  - shikra-iqs-evk.dts: pairs with IQ2390S SoM (industrial, without modem)

Also add shikra-evk.dtsi, it represents the common carrier-board and
daughter-card configuration shared across all Shikra EVK variants.

Co-developed-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
Co-developed-by: Monish Chunara <quic_mchunara@quicinc.com>
Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
Co-developed-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Co-developed-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Co-developed-by: Sneh Mankad <sneh.mankad@oss.qualcomm.com>
Signed-off-by: Sneh Mankad <sneh.mankad@oss.qualcomm.com>
Co-developed-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
Signed-off-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
Co-developed-by: Xueyao An <xueyao.an@oss.qualcomm.com>
Signed-off-by: Xueyao An <xueyao.an@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/Makefile           |  3 +++
 arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 40 +++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 40 +++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/shikra-evk.dtsi    | 15 +++++++++++
 arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 40 +++++++++++++++++++++++++++++
 5 files changed, 138 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 795cee4757ab..3801f280c8cc 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -333,6 +333,9 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-huawei-matebook-e-2019.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-lenovo-yoga-c630.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-samsung-w737.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdx75-idp.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= shikra-cqm-evk.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= shikra-cqs-evk.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= shikra-iqs-evk.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm4250-oneplus-billie2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm4450-qrd.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm6115-fxtec-pro1x.dtb
diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
new file mode 100644
index 000000000000..0a52ab9b7a4c
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+/dts-v1/;
+
+#include "shikra-cqm-som.dtsi"
+#include "shikra-evk.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. Shikra CQM EVK";
+	compatible = "qcom,shikra-cqm-evk", "qcom,shikra-cqm-som", "qcom,shikra";
+	chassis-type = "embedded";
+
+	aliases {
+		mmc0 = &sdhc_1;
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&sdhc_1 {
+	vmmc-supply = <&pm4125_l20>;
+	vqmmc-supply = <&pm4125_l14>;
+
+	pinctrl-0 = <&sdc1_state_on>;
+	pinctrl-1 = <&sdc1_state_off>;
+	pinctrl-names = "default", "sleep";
+
+	non-removable;
+	supports-cqe;
+	no-sdio;
+	no-sd;
+
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
new file mode 100644
index 000000000000..b3f19a64d7ae
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+/dts-v1/;
+
+#include "shikra-cqm-som.dtsi"
+#include "shikra-evk.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. Shikra CQS EVK";
+	compatible = "qcom,shikra-cqs-evk", "qcom,shikra-cqs-som", "qcom,shikra";
+	chassis-type = "embedded";
+
+	aliases {
+		mmc0 = &sdhc_1;
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&sdhc_1 {
+	vmmc-supply = <&pm4125_l20>;
+	vqmmc-supply = <&pm4125_l14>;
+
+	pinctrl-0 = <&sdc1_state_on>;
+	pinctrl-1 = <&sdc1_state_off>;
+	pinctrl-names = "default", "sleep";
+
+	non-removable;
+	supports-cqe;
+	no-sdio;
+	no-sd;
+
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/shikra-evk.dtsi b/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
new file mode 100644
index 000000000000..d0c48bad704c
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+&qupv3_0 {
+	firmware-name = "qcom/shikra/qupv3fw.elf";
+
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
+
diff --git a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
new file mode 100644
index 000000000000..3003a47bd759
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+/dts-v1/;
+
+#include "shikra-iqs-som.dtsi"
+#include "shikra-evk.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. Shikra IQS EVK";
+	compatible = "qcom,shikra-iqs-evk", "qcom,shikra-iqs-som", "qcom,shikra";
+	chassis-type = "embedded";
+
+	aliases {
+		mmc0 = &sdhc_1;
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&sdhc_1 {
+	vmmc-supply = <&pm8150_l17>;
+	vqmmc-supply = <&pm8150_s4>;
+
+	pinctrl-0 = <&sdc1_state_on>;
+	pinctrl-1 = <&sdc1_state_off>;
+	pinctrl-names = "default", "sleep";
+
+	non-removable;
+	supports-cqe;
+	no-sdio;
+	no-sd;
+
+	status = "okay";
+};

-- 
2.34.1

