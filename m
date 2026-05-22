Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285793672B5
	for <linux-mmc@vger.kernel.org>; Fri, 22 May 2026 18:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779472994; cv=none; b=o0Mdc/LUAydCfSkXrX0v04JB2LNiyCDeUj7iqidFiwBD4/YaXnQ6asS8wcTJp+RN8+Szdy5lJJu9u6blnBLGAgMkrsD2nRS5PHnKo/06pPSZ5WgRl8YiiUGpn6jLItDMFdL2rSYaWES6mKdxmcBD74rYViuuPx2tKqmzylHR/2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779472994; c=relaxed/simple;
	bh=PKxMIccKL5eOiE/ruMWQn2ee4hu9/pEmn9dglntmZTo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oYTvxwjMnv8vLPuy6isI3k/jqH6eih87WXMWVa3vg3XgED8MLkzeT8z26HfwuStsfM6PeTHxyUK0Rzo4WvIQrl02Iz3o/q2HKGaxOfwJZIY+a0drJjGz8xXukcmQ64CvQwdz9r50CpXwpfmDrQT53/OPLOmzG0y5ropojV7hOXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZbcQLJCS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DlSpEUce; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZbcQLJCS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DlSpEUce"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64MC3x3d1959419
	for <linux-mmc@vger.kernel.org>; Fri, 22 May 2026 18:03:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ru4fi2wAmy8Cr0jc1TBocdiFWPiW/okyLoP0Q2YQUjo=; b=ZbcQLJCSRcDvBGDF
	JhmRzuQFcsBOOQy1WljJafx53vnFl8JljSKbNKNkz83A/vpz66ZQxBX4qXrDkWyw
	Rs5DrBZmEwJnrlyKM7+TQikeXCdxdCpMrfjmgDQNw8OfcNF6aQ03wITuPQujJZql
	MaOvozG4PR7Jut6OfvIUIIqbqTlIw1hRd0R2yBQPah0kUoRj4vgULW5sSgfoWU50
	xFVtVowIMh+E9T+xQwmTUwH6Hv1mFIrcb+wegnzHIwZer3rjRoca9P4JjC4r072C
	W7Rg34lWC+ZVzsLJvNatP2dt9zGJseWk5/TyidELctfwNmQ7Bif7YPw3KnuwdUBJ
	NhrCfw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eahxets27-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 22 May 2026 18:03:07 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2beb9002a00so5421915ad.0
        for <linux-mmc@vger.kernel.org>; Fri, 22 May 2026 11:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779472986; x=1780077786; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ru4fi2wAmy8Cr0jc1TBocdiFWPiW/okyLoP0Q2YQUjo=;
        b=DlSpEUceUQ7ZI6oKgYnVk+u+imMhGViaRnksm01FTo0z/TLIq73BryaS6PpDzxsxIC
         p9lDPSzW2tbi7GVMzkeXo66LqQZkmbLl6KiobcbVNafJJofaBBq/veLabThUT5x+dsU6
         m+oxiDQNoLP4VzNQCfK+JxBo1757PpIgQH+qW9c82Z4EjZaXLaffoTeEcYpkaqBEpTrp
         MKoaa2f7QOxg5Mdmuvnl6vqb5ZiXXG1zmf4QIVzZhPCdCfouF1XQ0dLHB0XSnt9raNqv
         PmRkkyBoCECsMkYCbe126mdf9fvDdWOzKV0hFgB8cbZsyf6Edj7g6dDX+B+v2eoMd/GL
         +XLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779472986; x=1780077786;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ru4fi2wAmy8Cr0jc1TBocdiFWPiW/okyLoP0Q2YQUjo=;
        b=L/55pYjueGXreQFxfYN/2A855NKnV6IRaHVoFLxa17Qu4/dtf+ItCdFse9dKo59rCL
         RoElt4mA5OZCiabYdD2a1tf68xGO8xewUMsuA3MwVufCskuXzb9EkBjRlNnaepm0XSj4
         AauwddMbiA0xSYLTiQtCqDh1wOCj3kS6FRdtDfq2IcJZ7ZzxLLp3GeCh6XGnnsWj5V6A
         GK58TcSYWlyO0mFjzJQ2bzAvou3fhq6XWmRtyQP0eLSSeZhnLV3qvzfMR0QE2dbjGJaM
         gdKlEzjXJIpg0YakO3e33+pteRLcdOtPFTyi+8c1jKXNk4SechONXvDtBeogcWqejCZ8
         WcUA==
X-Forwarded-Encrypted: i=1; AFNElJ9rixpieE0vkZcVbqeiNiGjx+i9HBYdTFcf2TIm+sCJfyOHXh9AyPFlLDU0U0AK3HAh12qXDAybMNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP9uKzYqL1Uf9uwjo3EOevXnzhg9aStJM4J9ZT/f0Skdfzaig/
	m1ht/Zk2IoCFg3ACHnQFq6NQ5S0FEXzWZwH0tbCKsb7samDjVRw1e3/Rqvgqnid/vMtLUWsH/Ga
	tjsVjs+uyEusM6/ZrYrVA6qMY2zQ2cnFDHKARuk68WB7XLrx282cKMz7MZY9CR8U=
X-Gm-Gg: Acq92OGIaW6SAtbMBCmPTxuUkhd0/NdxPbZuYxltQ8UPEp8PJMgWQnapeowWXB91Gkh
	yBEWEcAl7pOAWzKqbCxVQn4BW96j0aXOjbz53HiWYoA0bxLq3VBTW/3hrdqVNec3GLCBqhlI2QW
	lslC5LJDxuvvdgXd42gMRZkw2qzl0+6F3hEZa/znj1wHSg217T69Jk0rU1MyGnj+3rn9edl29cf
	lG3uli+yoer0nmAi60HKUhk5fBlaIsd6/ngBszNI8vOYWJw+VTv/tO13B+MIE2kYpLWNoss1hIU
	8ODAVZNE8FVtSsOUqih8L41mN6Drxx6JaHGLRGHxYF8trvZrvARGjCDW06bzS2N3wxX6MDOCTqy
	64WyISOhKQ8IfqCe97BJB2BpCQjs1xFMZ6+Il
X-Received: by 2002:a17:903:f8b:b0:2b2:5503:1b8c with SMTP id d9443c01a7336-2beb06c4f36mr48802945ad.11.1779472986333;
        Fri, 22 May 2026 11:03:06 -0700 (PDT)
X-Received: by 2002:a17:903:f8b:b0:2b2:5503:1b8c with SMTP id d9443c01a7336-2beb06c4f36mr48802245ad.11.1779472985718;
        Fri, 22 May 2026 11:03:05 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58ff106sm21193645ad.74.2026.05.22.11.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 11:03:05 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Fri, 22 May 2026 23:32:28 +0530
Subject: [PATCH v3 5/5] arm64: dts: qcom: Add Shikra EVK boards
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-shikra-dt-v3-5-80ffde8a3dc4@oss.qualcomm.com>
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
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Monish Chunara <quic_mchunara@quicinc.com>,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Sneh Mankad <sneh.mankad@oss.qualcomm.com>,
        Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>,
        Xueyao An <xueyao.an@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779472947; l=6187;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=PKxMIccKL5eOiE/ruMWQn2ee4hu9/pEmn9dglntmZTo=;
 b=eeP1CuXgJm4EnxS5uEZe8Tiz6ULuop627FHXTkgKyi/znA3m/T1A5GqXkJUMu/nArB/fxR6F+
 0L1ipdLcM4lAHrCln+lQrSyh1atuEEc+VKjoOmsmWkdccqHdgVA7BG8
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE4MCBTYWx0ZWRfX+dVSk/L/vIjs
 Csvsou9SwXcr0bSqxhR7d5K39CuCkS/GTIzfUN8USqqBjjaTyVAOMfAy5r8fEDJNmfnBOcFt8+t
 H7GANbLR8M2ccrvsSwQu8nAt0yeYdWKbBAZQMZmjjqr2lIvYKwLTcGf8bZyAJhsgvMKwwSX7Mfs
 uH2gCciz8rtpEcuGVMyr37SEMSe0atViZyGg/TrUeLmK+MJH2KF/Ybh84vQikjI1pN2XsJkyH5/
 CkasJlsvA4UObkG/KmZkvEHi0vhTuMCJDXlAQhtbq+lVOeGahn6tA+9x/iPL7U3f4pmskjsDveC
 3yKpMiK5rSBkWbjK6zYOfuCU3IteAX8GZIuHTWey9yivZ3ihHNzKHdLaXXMXdvNJE2nTsrYdVPJ
 /Sk6QilLQ4a13YfPJttIi3QcCaUhRyBUua15+5x40Q16gBfqGF8OYPzzXHPD/0rVKPB9cTIG0dc
 loeDX6pLPYNC3tb2S+g==
X-Proofpoint-GUID: kESijg91B5pctc0d9R644rjIc2gjMXEW
X-Proofpoint-ORIG-GUID: kESijg91B5pctc0d9R644rjIc2gjMXEW
X-Authority-Analysis: v=2.4 cv=ar2CzyZV c=1 sm=1 tr=0 ts=6a109a5b cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=vDQBCZ3ZoHl_64TEIpcA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220180

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
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/Makefile           |  3 +++
 arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 40 +++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 40 +++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/shikra-evk.dtsi    | 14 ++++++++++
 arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 40 +++++++++++++++++++++++++++++
 5 files changed, 137 insertions(+)

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
index 000000000000..8b03d4eafa6d
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+&qupv3_0 {
+	firmware-name = "qcom/shikra/qupv3fw.elf";
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

