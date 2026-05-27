Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A973B3815FB
	for <linux-mmc@vger.kernel.org>; Wed, 27 May 2026 15:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779897338; cv=none; b=UIGs72tJ38+5fxkw+8svgM+7/ZSg6w07UFrtf3e0/m3B8d82s9e3SBsfrEThOBNXx1U8g9Aejy6kd5MoQExfgB20PP84AlKOgJ2MXS12xl+ZaRxoQs5vIhE00brGwyaAzPZGCWEpxoGy4kPcWcF8fZmhGYrbg2lu6gE1kZskMac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779897338; c=relaxed/simple;
	bh=vcW6Z4ur1dlxVBQ2zewv/zyZVjIg7iq/rKhLQk1OD+Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OgfV+gpKivktx8fjtbtcHn4tvAS+0eg3hbw2qniphGPIvtrKyUdwGYobJkmBUyMS/5/pdxMduL8jRja6KY3jVoUDouEy4HjxVWfVf8LIMWE3efkgfYB1f++AArJpXEjglzSP2bvrDmECCWh1wy/HicQlXx97S/2nvRXqGEbnHu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PCkIk4Zu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LuMKwbp6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PCkIk4Zu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LuMKwbp6"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RFLg4f879288
	for <linux-mmc@vger.kernel.org>; Wed, 27 May 2026 15:55:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YeClXccKdw84tNocFQeSeTBL4QpqwKdx6WFnotIEFs4=; b=PCkIk4ZuHLbP3ouF
	4t5ilqZwj9PmhK0JIy4RRrzxd3vcMesxiV43jqZ3vYNi+L47bNFmpoRyGU9EccbF
	yc2v4kqYPmoiXEEaPhqqya5nPPkLQe42ZxQ0av3MdI8m/LllgaDfKj9FWLSC3KAw
	9Tz9bpOrolXpXpzL7l0fbsRTpIYKnd+52o+XXkAfobnoGbSATQHZPlxnObKWXgM0
	1KgsYMlDgeqHMzz9rlDZAkRIBx3yNChEI41wo9HyfLJRgGTJy6hMo5T+aKCI7bGz
	oHMfcn4N/iofMqJsdHdWarnfdzPE47PC5F9Az9RFYOVMp4o+t1Jid/rq+CDKWfDI
	ndvbhw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edvvqst3h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 27 May 2026 15:55:34 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-368edd5fec4so12853576a91.0
        for <linux-mmc@vger.kernel.org>; Wed, 27 May 2026 08:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779897333; x=1780502133; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YeClXccKdw84tNocFQeSeTBL4QpqwKdx6WFnotIEFs4=;
        b=LuMKwbp6jdfjgkzIJVL+5rr5OmNM/5toupeYeqPj9KHtZTqjQ5BvyiFGxbQ4t65C93
         PaiNUBCevZ4O4e0upgQrnfZao9NY6sMEBTCLSozBknc2VvrAWRGvF65yLzuUSzGYY5eg
         BunhOT7CxYB6Vkb8CIIUYvPLa2qYE+KHfwouY2awHuzOe6dGkXKrFOjT4lGdSvR52BVV
         dTe5Cc6ZgIlL0ZNlbfjJOQ6FE0GulhiTs4c6ohNIJOwVX99mLNctPwPekCme7cSoRV3r
         p7oXZpQUzBV8Cg2F+K4VCtndnxEP9T5ZkVziEGThJN5qGDjgOzGqvzGP1pMRzGOh1PGQ
         fWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779897333; x=1780502133;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YeClXccKdw84tNocFQeSeTBL4QpqwKdx6WFnotIEFs4=;
        b=pqgiFf2hdyZLIaNPxd1kLJei2amFsjbV1/i9XpR0dqWt72Y/VOqpVRTUiScJVYc3G7
         oJoeN6YALwWY44g4H+EnBrX42joYakkYE1elL4g15OAtHryCzw+3vJzH2B0EwAVOiinE
         zrP99q8QCuQBox3w6pHce/5PmUcNhiabM+BS0JOJajAwDVK3zQ2qfyp9EmiN1RsFuh/v
         +5NqrZy5dCuIono8sCyAdpR5QmX9HS1irshA4suJLNJ5Wz+mGgwvW6Wwf3nWSo5az9vq
         6QTdAFsawM5aB/PEFdaXrJQ0zEaAzSmoNnGXhhkwkOaAjFONWRbYZ7laC4SnliEV1Ufs
         Lt/w==
X-Forwarded-Encrypted: i=1; AFNElJ98sbISBtc+a4gMGJwpKn4fafy3jWtQSb3CRqc8fT1lcBIGBHIvZMXYalyc6VwRTFO4f0GJ93GRFq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU9l/6zuUqMXHu9Vc6OtKhE9NHLHnAB8VGjwPqlHLb3so18xG+
	MyJII+/nZ5j1bzjvJ8a+hY5DP7lmEx3qTlGstspxFo7AeVgBkf7dGXAd3pLH1ewXzMDLH6WFSE5
	RtLttR+smggwW3npu9gmbYTICqGkLtvnmjHQT271iNuJOEBJj/ZXNhJvdAMDcHwc=
X-Gm-Gg: Acq92OELtAF66Yyi2m1Jmr8wsRiQfcA4+0m183G0UfTZ36cDC09ZIZPY9mHO/3Kn5WW
	Qwpd+jkFHIATkGAD32TjGWsF5HfKtZZcmsLKu+hBZJBYvvoy5HyGqQvyhf9PbXOuwDL5so4uoe9
	fVQEmq0PjhCcQnFcyRkGEVvN8PvsgKcZf1qmH6G8Ht+q9ON/fXrHw+VwUebMld8c4olj29DhUK0
	cQBywskWsUEtYI0pxI64DMnNKrC15vuPQbiiNpPTmB5dOdYs4S2+qv+XBsrvKVNT3gZASMowNXx
	kHGtBj/arqXt4/6HRoep7hN+FuHLxqT5nBhA9+fUKZNN2zsgr0dp40by2ojCW20OUBHRJAPDNS2
	u8YdtGc0coIYkW8sH56QG+KhUyiQpNWG790l98RFZux/b2jw=
X-Received: by 2002:a17:902:ea0e:b0:2bc:dc18:35a2 with SMTP id d9443c01a7336-2beb05e48b8mr281070025ad.26.1779897332938;
        Wed, 27 May 2026 08:55:32 -0700 (PDT)
X-Received: by 2002:a17:902:ea0e:b0:2bc:dc18:35a2 with SMTP id d9443c01a7336-2beb05e48b8mr281069625ad.26.1779897332276;
        Wed, 27 May 2026 08:55:32 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beff36894dsm1264135ad.37.2026.05.27.08.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 08:55:31 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Wed, 27 May 2026 21:23:52 +0530
Subject: [PATCH v4 2/5] arm64: dts: qcom: Introduce Shikra SoC base dtsi
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-shikra-dt-v4-2-b5ca1fa0b392@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779897312; l=23603;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=vcW6Z4ur1dlxVBQ2zewv/zyZVjIg7iq/rKhLQk1OD+Q=;
 b=frsy8UfFVJkFB3yxxwT/0oYj/tPgh3dyZ5UsnRZD7zsCVATe/+iP0oFsoS7/O+fvH5RuNQ7j4
 tcbz8M2daeyAEtcubZ6F7lNh+IqeGgTtoepiil7/cJo3zlQP7lyYiM7
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDE1OSBTYWx0ZWRfX7TRZBklBMlI3
 KIGTbiPYe3MGJtDPNa18UMVzcG2r4tBY1genXxlk1rMfssl82H8DVqcg2HkyjUHAD56Ac/k3Oa4
 UF1zRkfVRFdIop0pwFxztwMMoGWwSKZD5kXByMVVPryU8ghd47exwe/jIqGAbZrK79fB6PHYpCU
 +gauKLsbrhm9ZuwhkeRWNUzxOrPB20Pa8kXStpBdZfclHdgmDzKBGAzB1da1bmXRZvQjmvymzeJ
 NAmzfdXtY+rPpu1rNa3eihs5YTpbO442wndIZO6jN8k6Nu89T3+hktzAOTjS2JX55i1aLtyUyAp
 TC8y188XXQFAmD59oLBNKV35l8dV8/40L1cnW345bIZiGgAYhesfaOB1LG5YBsprHhdcyCzzdY3
 +1dQOMrsJrb7mOXmVGjvg8rZssdCnX1sOJe3XesVtdu+Yi+PyENHrP4ffiO3eijft8/dfIqMHk/
 0FANbJR9UzZ87klmHMA==
X-Proofpoint-GUID: P0zSY0c0bzWCOfe7jJwx09ZsmgE-6Xsi
X-Proofpoint-ORIG-GUID: P0zSY0c0bzWCOfe7jJwx09ZsmgE-6Xsi
X-Authority-Analysis: v=2.4 cv=fLMJG5ae c=1 sm=1 tr=0 ts=6a1713f6 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=6UBnnb2_QDgcJB-b6ocA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_02,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270159

Add initial device tree support for the Qualcomm Shikra SoC,
an IoT-focused platform built around a heterogeneous CPU cluster
(Cortex-A55 + Cortex-A78C) with RPM-based power and clock management.

Enable support for the following peripherals:
  - CPU nodes
  - Global Clock Controller (GCC)
  - RPM-based clock controller (RPMCC) and power domains (RPMPD)
  - Interrupt controller
  - Top Level Mode Multiplexer (TLMM)
  - Debug UART
  - eMMC host controller
  - System timer and watchdog

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
 arch/arm64/boot/dts/qcom/shikra.dtsi | 842 +++++++++++++++++++++++++++++++++++
 1 file changed, 842 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
new file mode 100644
index 000000000000..a4334d99c1f3
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -0,0 +1,842 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <dt-bindings/clock/qcom,rpmcc.h>
+#include <dt-bindings/clock/qcom,shikra-gcc.h>
+#include <dt-bindings/interconnect/qcom,icc.h>
+#include <dt-bindings/interconnect/qcom,rpm-icc.h>
+#include <dt-bindings/interconnect/qcom,shikra.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/power/qcom-rpmpd.h>
+
+/ {
+	interrupt-parent = <&intc>;
+
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	clocks {
+		xo_board: xo-board {
+			compatible = "fixed-clock";
+			clock-frequency = <38400000>;
+			#clock-cells = <0>;
+		};
+
+		sleep_clk: sleep-clk {
+			compatible = "fixed-clock";
+			clock-frequency = <32764>;
+			#clock-cells = <0>;
+		};
+	};
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+			next-level-cache = <&l3>;
+			capacity-dmips-mhz = <1024>;
+			dynamic-power-coefficient = <100>;
+		};
+
+		cpu1: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0 0x100>;
+			enable-method = "psci";
+			next-level-cache = <&l3>;
+			capacity-dmips-mhz = <1024>;
+			dynamic-power-coefficient = <100>;
+		};
+
+		cpu2: cpu@200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0 0x200>;
+			enable-method = "psci";
+			next-level-cache = <&l3>;
+			capacity-dmips-mhz = <1024>;
+			dynamic-power-coefficient = <100>;
+		};
+
+		cpu3: cpu@300 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a78c";
+			reg = <0x0 0x300>;
+			enable-method = "psci";
+			next-level-cache = <&l2_3>;
+			capacity-dmips-mhz = <1946>;
+			dynamic-power-coefficient = <489>;
+
+			l2_3: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
+				next-level-cache = <&l3>;
+				cache-size = <0x40000>;
+			};
+		};
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+
+				core1 {
+					cpu = <&cpu1>;
+				};
+
+				core2 {
+					cpu = <&cpu2>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&cpu3>;
+				};
+			};
+		};
+
+		l3: l3-cache {
+			compatible = "cache";
+			cache-level = <3>;
+			cache-unified;
+			cache-size = <0x80000>;
+		};
+	};
+
+	firmware {
+		scm {
+			compatible = "qcom,scm-shikra", "qcom,scm";
+			clocks = <&rpmcc RPM_SMD_CE1_CLK>;
+			clock-names = "core";
+			qcom,dload-mode = <&tcsr_regs 0x13000>;
+			#reset-cells = <1>;
+			interconnects = <&system_noc MASTER_CRYPTO_CORE0 RPM_ALWAYS_TAG
+					 &mc_virt SLAVE_EBI_CH0 RPM_ALWAYS_TAG>;
+		};
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		/* We expect the bootloader to fill in the size */
+		reg = <0x0 0x80000000 0x0 0x0>;
+	};
+
+	pmu-a55 {
+		compatible = "arm,cortex-a55-pmu";
+		interrupts = <GIC_PPI 5 IRQ_TYPE_LEVEL_HIGH &ppi_cluster0>;
+	};
+
+	pmu-a78c {
+		compatible = "arm,cortex-a78-pmu";
+		interrupts = <GIC_PPI 5 IRQ_TYPE_LEVEL_HIGH &ppi_cluster1>;
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	rpm: remoteproc {
+		compatible = "qcom,shikra-rpm-proc", "qcom,rpm-proc";
+
+		glink-edge {
+			compatible = "qcom,glink-rpm";
+			interrupts = <GIC_SPI 194 IRQ_TYPE_EDGE_RISING 0>;
+			qcom,rpm-msg-ram = <&rpm_msg_ram>;
+			mboxes = <&apcs_glb 0>;
+
+			rpm_requests: rpm-requests {
+				compatible = "qcom,rpm-shikra", "qcom,glink-smd-rpm";
+				qcom,glink-channels = "rpm_requests";
+
+				rpmcc: clock-controller {
+					compatible = "qcom,rpmcc-shikra", "qcom,rpmcc";
+					clocks = <&xo_board>;
+					clock-names = "xo";
+					#clock-cells = <1>;
+				};
+
+				rpmpd: power-controller {
+					compatible = "qcom,shikra-rpmpd";
+					#power-domain-cells = <1>;
+					operating-points-v2 = <&rpmpd_opp_table>;
+
+					rpmpd_opp_table: opp-table {
+						compatible = "operating-points-v2";
+
+						rpmpd_opp_min_svs: opp1 {
+							opp-level = <RPM_SMD_LEVEL_MIN_SVS>;
+						};
+
+						rpmpd_opp_low_svs: opp2 {
+							opp-level = <RPM_SMD_LEVEL_LOW_SVS>;
+						};
+
+						rpmpd_opp_svs: opp3 {
+							opp-level = <RPM_SMD_LEVEL_SVS>;
+						};
+
+						rpmpd_opp_svs_plus: opp4 {
+							opp-level = <RPM_SMD_LEVEL_SVS_PLUS>;
+						};
+
+						rpmpd_opp_nom: opp5 {
+							opp-level = <RPM_SMD_LEVEL_NOM>;
+						};
+
+						rpmpd_opp_nom_plus: opp6 {
+							opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
+						};
+
+						rpmpd_opp_turbo: opp7 {
+							opp-level = <RPM_SMD_LEVEL_TURBO>;
+						};
+
+						rpmpd_opp_turbo_plus: opp8 {
+							opp-level = <RPM_SMD_LEVEL_TURBO_NO_CPR>;
+						};
+					};
+				};
+			};
+		};
+
+		mpm: interrupt-controller {
+			compatible = "qcom,mpm";
+			qcom,rpm-msg-ram = <&apss_mpm>;
+			interrupts = <GIC_SPI 197 IRQ_TYPE_EDGE_RISING 0>;
+			mboxes = <&apcs_glb 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			#power-domain-cells = <0>;
+			interrupt-parent = <&intc>;
+			qcom,mpm-pin-count = <96>;
+			qcom,mpm-pin-map = <2 275>,  /* TSENS0 uplow */
+					   <12 422>, /* DWC3 ss_phy_irq */
+					   <58 272>, /* QUSB2_PHY dmse_hv_vddmx */
+					   <59 273>, /* QUSB2_PHY dpse_hv_vddmx */
+					   <86 183>, /* MPM wake, SPMI */
+					   <90 157>, /* QUSB2_PHY DM */
+					   <91 158>; /* QUSB2_PHY DP */
+		};
+	};
+
+	reserved_memory: reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		hyp_mem: hyp@80000000 {
+			reg = <0x0 0x80000000 0x0 0x1600000>;
+			no-map;
+		};
+
+		xblboot_mem: xblboot@85e00000 {
+			reg = <0x0 0x85e00000 0x0 0x100000>;
+			no-map;
+		};
+
+		secdata_apss_mem: secdata-apss@85fff000 {
+			reg = <0x0 0x85fff000 0x0 0x1000>;
+			no-map;
+		};
+
+		smem_mem: smem@86000000 {
+			compatible = "qcom,smem";
+			reg = <0x0 0x86000000 0x0 0x200000>;
+			no-map;
+
+			hwlocks = <&tcsr_mutex 3>;
+		};
+
+		audio_heap_mem: audio-heap@86200000 {
+			reg = <0x0 0x86200000 0x0 0x100000>;
+			no-map;
+		};
+
+		tz_stat_mem: tz-stat@a0000000 {
+			reg = <0x0 0xa0000000 0x0 0x100000>;
+			no-map;
+		};
+
+		qtee_mem: qtee@a1300000 {
+			reg = <0x0 0xa1300000 0x0 0x500000>;
+			no-map;
+		};
+
+		tz_apps_mem: tz-apps@a1800000 {
+			reg = <0x0 0xa1800000 0x0 0x2100000>;
+			no-map;
+		};
+
+		mpss_wlan_mem: mpss-wlan@ab000000 {
+			reg = <0x0 0xab000000 0x0 0x6e00000>;
+			no-map;
+		};
+
+		wlan_mem: wlan@b2300000 {
+			reg = <0x0 0xb2300000 0x0 0x100000>;
+			no-map;
+		};
+
+		cdsp_mem: cdsp@b2400000 {
+			reg = <0x0 0xb2400000 0x0 0x1900000>;
+			no-map;
+		};
+
+		gpu_micro_code_mem: gpu-micro-code@b3d00000 {
+			reg = <0x0 0xb3d00000 0x0 0x2000>;
+			no-map;
+		};
+
+		video_mem: video@b3d02000 {
+			reg = <0x0 0xb3d02000 0x0 0x700000>;
+			no-map;
+		};
+
+		lmcu_mem: lmcu@b4402000 {
+			reg = <0x0 0xb4402000 0x0 0x300000>;
+			no-map;
+		};
+
+		lmcu_dtb_mem: lmcu-dtb@b4702000 {
+			reg = <0x0 0xb4702000 0x0 0x40000>;
+			no-map;
+		};
+	};
+
+	soc: soc@0 {
+		compatible = "simple-bus";
+
+		#address-cells = <2>;
+		#size-cells = <2>;
+		dma-ranges = <0x0 0x0 0x0 0x0 0x10 0x0>;
+		ranges = <0x0 0x0 0x0 0x0 0x10 0x0>;
+
+		tcsr_mutex: syscon@340000 {
+			compatible = "qcom,tcsr-mutex";
+			reg = <0x0 0x00340000 0x0 0x20000>;
+			#hwlock-cells = <1>;
+		};
+
+		tcsr_regs: syscon@3c0000 {
+			compatible = "qcom,shikra-tcsr", "syscon";
+			reg = <0x0 0x003c0000 0x0 0x40000>;
+		};
+
+		tlmm: pinctrl@500000 {
+			compatible = "qcom,shikra-tlmm";
+			reg = <0x0 0x00500000 0x0 0x700000>;
+
+			interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH 0>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			gpio-ranges = <&tlmm 0 0 165>;
+			wakeup-parent = <&mpm>;
+
+			qup_uart0_default: qup-uart0-default-state {
+				pins = "gpio0", "gpio1";
+				function = "qup0_se0";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			sdc1_state_on: sdc1-on-state {
+				clk-pins {
+					pins = "sdc1_clk";
+					drive-strength = <6>;
+					bias-disable;
+				};
+
+				cmd-pins {
+					pins = "sdc1_cmd";
+					drive-strength = <6>;
+					bias-pull-up;
+				};
+
+				data-pins {
+					pins = "sdc1_data";
+					drive-strength = <6>;
+					bias-pull-up;
+				};
+
+				rclk-pins {
+					pins = "sdc1_rclk";
+					bias-pull-down;
+				};
+			};
+
+			sdc1_state_off: sdc1-off-state {
+				clk-pins {
+					pins = "sdc1_clk";
+					drive-strength = <2>;
+					bias-bus-hold;
+				};
+
+				cmd-pins {
+					pins = "sdc1_cmd";
+					drive-strength = <2>;
+					bias-bus-hold;
+				};
+
+				data-pins {
+					pins = "sdc1_data";
+					drive-strength = <2>;
+					bias-bus-hold;
+				};
+
+				rclk-pins {
+					pins = "sdc1_rclk";
+					bias-bus-hold;
+				};
+			};
+		};
+
+		mem_noc: interconnect@d00000 {
+			compatible = "qcom,shikra-mem-noc-core";
+			reg = <0x0 0x00d00000 0x0 0x43080>;
+			clocks = <&gcc GCC_DDRSS_GPU_AXI_CLK>;
+			clock-names = "gpu_axi";
+			#interconnect-cells = <2>;
+		};
+
+		llcc: system-cache-controller@e00000 {
+			compatible = "qcom,shikra-llcc";
+			reg = <0x0 0x00e00000 0x0 0x80000>,
+			      <0x0 0x00f00000 0x0 0x80000>,
+			      <0x0 0x01000000 0x0 0x80000>;
+			reg-names = "llcc0_base",
+				    "llcc1_base",
+				    "llcc_broadcast_base";
+			interrupts = <GIC_SPI 539 IRQ_TYPE_LEVEL_HIGH 0>;
+		};
+
+		gcc: clock-controller@1400000 {
+			compatible = "qcom,shikra-gcc";
+			reg = <0x0 0x01400000 0x0 0x1f0000>;
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
+				 <&sleep_clk>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>;
+			power-domains = <&rpmpd RPMPD_VDDCX>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
+		system_noc: interconnect@1880000 {
+			compatible = "qcom,shikra-sys-noc";
+			reg = <0x0 0x01880000 0x0 0x6a080>;
+			clocks = <&gcc GCC_EMAC0_AXI_SYS_NOC_CLK>,
+				 <&gcc GCC_EMAC1_AXI_SYS_NOC_CLK>,
+				 <&gcc GCC_SYS_NOC_USB2_PRIM_AXI_CLK>,
+				 <&gcc GCC_SYS_NOC_USB3_PRIM_AXI_CLK>;
+			clock-names = "emac0_axi",
+				      "emac1_axi",
+				      "usb2_axi",
+				      "usb3_axi";
+			#interconnect-cells = <2>;
+
+			clk_virt: interconnect-clk {
+				compatible = "qcom,shikra-clk-virt";
+				#interconnect-cells = <2>;
+			};
+
+			mc_virt: interconnect-mc {
+				compatible = "qcom,shikra-mc-virt";
+				#interconnect-cells = <2>;
+			};
+
+			mmrt_virt: interconnect-mmrt {
+				compatible = "qcom,shikra-mmrt-virt";
+				#interconnect-cells = <2>;
+			};
+
+			mmnrt_virt: interconnect-mmnrt {
+				compatible = "qcom,shikra-mmnrt-virt";
+				#interconnect-cells = <2>;
+			};
+		};
+
+		config_noc: interconnect@1900000 {
+			compatible = "qcom,shikra-config-noc";
+			reg = <0x0 0x01900000 0x0 0x8080>;
+			#interconnect-cells = <2>;
+		};
+
+		qfprom: efuse@1b44000 {
+			compatible = "qcom,shikra-qfprom", "qcom,qfprom";
+			reg = <0x0 0x01b44000 0x0 0x3000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			qusb2_hstx_trim_1: hstx-trim@25b {
+				reg = <0x25b 0x1>;
+				bits = <1 4>;
+			};
+
+			gpu_speed_bin: gpu-speed-bin@2006 {
+				reg = <0x2006 0x2>;
+				bits = <5 8>;
+			};
+		};
+
+		spmi_bus: spmi@1c40000 {
+			compatible = "qcom,spmi-pmic-arb";
+			reg = <0x0 0x01c40000 0x0 0x1100>,
+			      <0x0 0x01e00000 0x0 0x2000000>,
+			      <0x0 0x03e00000 0x0 0x100000>,
+			      <0x0 0x03f00000 0x0 0xa0000>,
+			      <0x0 0x01c0a000 0x0 0x26000>;
+			reg-names = "core",
+				    "chnls",
+				    "obsrvr",
+				    "intr",
+				    "cnfg";
+			interrupts-extended = <&mpm 86 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "periph_irq";
+			interrupt-controller;
+			#interrupt-cells = <4>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+			qcom,channel = <0>;
+			qcom,ee = <0>;
+		};
+
+		rpm_msg_ram: sram@45f0000 {
+			compatible = "qcom,rpm-msg-ram", "mmio-sram";
+			reg = <0x0 0x045f0000 0x0 0x7000>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x0 0x045f0000 0x7000>;
+
+			apss_mpm: sram@1b8 {
+				reg = <0x1b8 0x48>;
+			};
+		};
+
+		sram@4690000 {
+			compatible = "qcom,rpm-stats";
+			reg = <0x0 0x04690000 0x0 0x14000>;
+		};
+
+		sdhc_1: mmc@4744000 {
+			compatible = "qcom,shikra-sdhci", "qcom,sdhci-msm-v5";
+
+			reg = <0x0 0x04744000 0x0 0x1000>,
+			      <0x0 0x04745000 0x0 0x1000>;
+			reg-names = "hc",
+				    "cqhci";
+
+			iommus = <&apps_smmu 0xc0 0x0>;
+
+			interrupts = <GIC_SPI 348 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 352 IRQ_TYPE_LEVEL_HIGH 0>;
+			interrupt-names = "hc_irq",
+					  "pwr_irq";
+
+			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
+				 <&gcc GCC_SDCC1_APPS_CLK>,
+				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
+			clock-names = "iface",
+				      "core",
+				      "xo";
+
+			interconnects = <&system_noc MASTER_SDCC_1 RPM_ALWAYS_TAG
+					&mc_virt SLAVE_EBI_CH0 RPM_ALWAYS_TAG>,
+					<&mem_noc MASTER_AMPSS_M0 RPM_ACTIVE_TAG
+					&config_noc SLAVE_SDCC_1 RPM_ACTIVE_TAG>;
+			interconnect-names = "sdhc-ddr",
+					     "cpu-sdhc";
+
+			power-domains = <&rpmpd RPMPD_VDDCX>;
+			operating-points-v2 = <&sdhc1_opp_table>;
+
+			qcom,dll-config = <0x000f642c>;
+			qcom,ddr-config = <0x80040868>;
+
+			bus-width = <8>;
+
+			mmc-ddr-1_8v;
+			mmc-hs200-1_8v;
+			mmc-hs400-1_8v;
+			mmc-hs400-enhanced-strobe;
+
+			resets = <&gcc GCC_SDCC1_BCR>;
+
+			status = "disabled";
+
+			sdhc1_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-100000000 {
+					opp-hz = /bits/ 64 <100000000>;
+					required-opps = <&rpmpd_opp_low_svs>;
+					opp-peak-kBps = <250000 133320>;
+					opp-avg-kBps = <104000 0>;
+				};
+
+				opp-384000000 {
+					opp-hz = /bits/ 64 <384000000>;
+					required-opps = <&rpmpd_opp_nom>;
+					opp-peak-kBps = <800000 300000>;
+					opp-avg-kBps = <400000 0>;
+				};
+			};
+		};
+
+		qupv3_0: geniqup@4ac0000 {
+			compatible = "qcom,geni-se-qup";
+			reg = <0x0 0x04ac0000 0x0 0x2000>;
+
+			clocks = <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
+				 <&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
+			clock-names = "m-ahb",
+				      "s-ahb";
+
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			uart0: serial@4a80000 {
+				compatible = "qcom,geni-debug-uart";
+				reg = <0x0 0x04a80000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 527 IRQ_TYPE_LEVEL_HIGH 0>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
+				clock-names = "se";
+
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config";
+
+				pinctrl-0 = <&qup_uart0_default>;
+				pinctrl-names = "default";
+
+				status = "disabled";
+			};
+		};
+
+		sram@c11e000 {
+			compatible = "qcom,shikra-imem", "mmio-sram";
+			reg = <0x0 0x0c11e000 0x0 0x1000>;
+			ranges = <0x0 0x0 0x0c11e000 0x1000>;
+
+			no-memory-wc;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			pil-sram@94c {
+				compatible = "qcom,pil-reloc-info";
+				reg = <0x94c 0xc8>;
+			};
+		};
+
+		apps_smmu: iommu@c600000 {
+			compatible = "qcom,shikra-smmu-500", "qcom,smmu-500", "arm,mmu-500";
+			reg = <0x0 0x0c600000 0x0 0x80000>;
+			#iommu-cells = <2>;
+			#global-interrupts = <1>;
+
+			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH 0>;
+		};
+
+		intc: interrupt-controller@f200000 {
+			compatible = "arm,gic-v3";
+			reg = <0x0 0xf200000 0x0 0x10000>,
+			      <0x0 0xf240000 0x0 0x80000>;
+
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH 0>;
+
+			#interrupt-cells = <4>;
+			interrupt-controller;
+
+			#redistributor-regions = <1>;
+			redistributor-stride = <0x0 0x20000>;
+
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			ppi-partitions {
+				ppi_cluster0: interrupt-partition-0 {
+					affinity = <&cpu0 &cpu1 &cpu2>;
+				};
+
+				ppi_cluster1: interrupt-partition-1 {
+					affinity = <&cpu3>;
+				};
+			};
+		};
+
+		apcs_glb: mailbox@f400000 {
+			compatible = "qcom,shikra-apss-shared", "qcom,sdm845-apss-shared";
+			reg = <0x0 0x0f400000 0x0 0x1000>;
+			#mbox-cells = <1>;
+		};
+
+		watchdog@f410000 {
+			compatible = "qcom,apss-wdt-shikra", "qcom,kpss-wdt";
+			reg = <0x0 0x0f410000 0x0 0x1000>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&sleep_clk>;
+		};
+
+		timer@f420000 {
+			compatible = "arm,armv7-timer-mem";
+			reg = <0x0 0x0f420000  0x0 0x1000>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x0 0x0 0x10000000>;
+
+			frame@f421000 {
+				reg = <0x0f421000 0x1000>,
+				      <0x0f422000 0x1000>;
+				frame-number = <0>;
+				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH 0>,
+					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH 0>;
+			};
+
+			frame@f423000 {
+				reg = <0x0f423000 0x1000>;
+				frame-number = <1>;
+				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH 0>;
+				status = "disabled";
+			};
+
+			frame@f425000 {
+				reg = <0x0f425000 0x1000>;
+				frame-number = <2>;
+				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH 0>;
+				status = "disabled";
+			};
+
+			frame@f427000 {
+				reg = <0x0f427000 0x1000>;
+				frame-number = <3>;
+				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH 0>;
+				status = "disabled";
+			};
+
+			frame@f429000 {
+				reg = <0x0f429000 0x1000>;
+				frame-number = <4>;
+				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH 0>;
+				status = "disabled";
+			};
+
+			frame@f42b000 {
+				reg = <0x0f42b000 0x1000>;
+				frame-number = <5>;
+				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH 0>;
+				status = "disabled";
+			};
+
+			frame@f42d000 {
+				reg = <0x0f42d000 0x1000>;
+				frame-number = <6>;
+				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH 0>;
+				status = "disabled";
+			};
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+
+		interrupts = <GIC_PPI 1 IRQ_TYPE_LEVEL_LOW 0>,
+			     <GIC_PPI 2 IRQ_TYPE_LEVEL_LOW 0>,
+			     <GIC_PPI 3 IRQ_TYPE_LEVEL_LOW 0>,
+			     <GIC_PPI 0 IRQ_TYPE_LEVEL_LOW 0>;
+	};
+};

-- 
2.34.1

