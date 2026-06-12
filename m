Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E832F222582
	for <linux-mmc@vger.kernel.org>; Fri, 12 Jun 2026 17:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781285272; cv=none; b=CRZ8Q6oBdbO+MDLqK+5qjA1WbeYkOUzKff1xj8ouesheTuEePDF8Mfa0eomzP2iqo8kjuKyCNvQiqm+Axq/qom3+TXpy6Op5ePEvDNN32ZwWH0gwHEIjf0ayHqXGlyPcYen2T5noCtG5BAXO8V4Tf1DjjPV6rOPEAhsAEAG6kiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781285272; c=relaxed/simple;
	bh=IigjJZAFdWHStKnJ7CJ8gw0Pf0NlG9F/hHW8w4b4TNk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ejdwiX/xtkttJPCCuYOU1usqf++wFUIxmeIj9SVuPojMzBmo6XsCL0OF5h0ZVe1o8G1KNPiak4U011hW4m4uy1I/4nfpzQw7Am3dcuYwjZOxskWRb+CxJUZxhJhiOpX+xQzbaUri9lOBrYNCVJZ0h4BWR1MPXVOMDRtUlfpeBPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bskGhUC5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hnVGlTGj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bskGhUC5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hnVGlTGj"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65CGUkBu4153136
	for <linux-mmc@vger.kernel.org>; Fri, 12 Jun 2026 17:27:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=w3i56TI7mNwfwXG/PMPS15
	fVc859gVGWKF4I3GdodHQ=; b=bskGhUC5ZS1id+7t8VapWA0GdAhdFr3pIEWrB4
	90CuBTLBN34ESIvwq7B2yxkH1rpzGiLse4KMcUAUi22d67Yz6gMd+wydG8EVrMmZ
	IWplyXzLwEfnGi41GE8VYItzDCEPw5OqmhcudVMO+uJ3fhR3Qhoh6txTS9ViN6xi
	vQU2EmoMGIFXsUsw1wLolOX/Hvw/AbNR42y02PIBI2fBZootPjNNMwy/r+P7FiuB
	7IWe65r2DbY+Prlm6GRqThaVep6ZgaUX73WYwXC2Nq1DDj6t6U9iQ3HEnTR2HfKS
	vXs6lz7SZfJBVYFDSakydCf2F3yA/KmrRdOpedF8AhzuvmSQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er1xcm331-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 12 Jun 2026 17:27:49 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c0a81c1738so8339805ad.2
        for <linux-mmc@vger.kernel.org>; Fri, 12 Jun 2026 10:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781285269; x=1781890069; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w3i56TI7mNwfwXG/PMPS15fVc859gVGWKF4I3GdodHQ=;
        b=hnVGlTGjgiH6T2h8A4umjsijhtl+Ncdvkih2r6Y60gOKGnwCMfc2WmeXKZsWOiKvqL
         Xdfpo6hCqg+PvuswLHtcYI7JRlxa3d2B76Mwi+3D3nPv8QHgCTSmTZIjRUFm5/ilShUf
         pfnkFHDxpHOC7YnSAVMuAiuyZ/X0aFDT9Kqa+D159O7TmlNnIXZ8pMN1ZuORL0eQlk5f
         6o6ou0EP+c5vauqPpLWmn+GO645I20q9GDeNTqHW/Zqn9h7DKOJW4m9UBAmEmhBJS0Lq
         tDnqLRU8A5/k0pPF1/6FsmhVFUiJdtWm4pg9AukNg/IFa5aRR1abRinnI0wwx1DfJcTc
         oivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781285269; x=1781890069;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3i56TI7mNwfwXG/PMPS15fVc859gVGWKF4I3GdodHQ=;
        b=o2h/JiCHhirdUzbHW+W4UZpjBcT2ZAidIO6/JK11gYD3ggmbh5T54aDJMvL6YCcubF
         Yol6KSmJKEgAV5nGazG0tJgxyaDhMNqFbaDZuTwK71pKyznMgTMgbThnesyNcdxDLDD8
         YbBCmgFqPLFew+zO6ru2ARhO0aNEaQseNwxguly86s3Fut+D+XuxPt16NxVLJ3M6A2A4
         nUSSDKLjnpckA6gqsnsTR74VFxf/j5NQ+gf1ZJWgtBto04mXVB2cMikeXG7VWvHMQRl9
         mfG8llZILzms2jGWFbLkQyLnnAWRF/5CJN+g5dpfWpDBW0etqah4EMruJfyEmoMmgrjO
         LRhA==
X-Forwarded-Encrypted: i=1; AFNElJ+w5FHu/YgIkgcHxqDHxndW3elivIcJ2MhgmHi9o82amNcfmzpqwaC5VmIyDvZFc+VBjgRwBx/t/Tg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVKbq8VTWdOdWeuXsuNsKoJfZDpDQsHUkxBcdt9YW4AYvCHvza
	4POxlkQdOz2bFRNT8zC1KFdyHZ1hurHa27BPfwUq0IkKSGguULVbfyKqU1Mb4ooOKgpaUtLz8QL
	sigZhx6EmKqSSkPTa+fRQChshlqLriKVyzKToaiYu1EWUYxTbSK8n4aPRREg5aJM=
X-Gm-Gg: Acq92OEZAU8Dlsav55BG0BIzIehfoMH8YPPXZ4xpQnwwUB32h0jYLwtq9OUBudF0GiN
	i6zRteVEfUKMV0ZY32li04E2zeV2F7BkuwW36b3EEYlHcMvlkU7Y2yYZaV3zuZl0roo//Yvfim7
	UrmzczOPm84Oc9F6r6o52tkpIyt3yj0I6lLr7LOQvnRIagouBPHvvvitRrFb0lgmyJVfLMFchDg
	aRz+2k4nULUWx6WEkg/1DrCTvRL29Xkt5C+U2kwcXl++DWV1zgIBWEpQbr0SHiDjoZvA4wDVTKy
	NosasxTGNGyV+Lw9AfBVpp6MFPT2d18xSqtaQcURd0qmCiztVmMP8iLmfd+dAqdI5efoO8HNaRN
	EGUc2h8/uwUNJ6N+ab3+LEqeqyZRscMai7WdJ
X-Received: by 2002:a17:902:e545:b0:2c0:b9a1:6493 with SMTP id d9443c01a7336-2c41178c6femr40192745ad.10.1781285268635;
        Fri, 12 Jun 2026 10:27:48 -0700 (PDT)
X-Received: by 2002:a17:902:e545:b0:2c0:b9a1:6493 with SMTP id d9443c01a7336-2c41178c6femr40192365ad.10.1781285268183;
        Fri, 12 Jun 2026 10:27:48 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327acae2sm24278105ad.52.2026.06.12.10.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 10:27:47 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Subject: [PATCH v6 0/5] arm64: dts: qcom: Add initial device tree support
 for Shikra
Date: Fri, 12 Jun 2026 22:57:36 +0530
Message-Id: <20260612-shikra-dt-v6-0-6b6cb58db477@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIlBLGoC/43S22rjMBAG4FcJvq7K6GjJV32PpYTRKRGN7dRyT
 ZeSd185h1ZlG+iNYIz+zyONPpocphRy020+miksKadxKIV62DRuj8MukORL3TBgCiSlJO/Ty4T
 Ez8S30ptWSKGEasr+4xRiej9bf54v9RRe3wo5Xz5+id3m7Almbt7OOTId+7K6w0smDIwIPsbIL
 XSLXPk+5Ix1WoK+prc9poMd37c4+G1RtpcfZbJwQokyOuogo+XcPI05P76+4cGNff9YlqY+6K0
 tDre2Uh96YtPg07Aj2FprPItUedYt9KeohM8byq5OxigjWg/xF8nZ5ekzWu6AKm2CANNeoxZzI
 OsB0txtggNuKFO2jehE4Bi5DNY5xNapaKzSrbSoabOOZJ/yPE5/z9Mu1jqT62BZNdiFEiAtVYJ
 rzsF7+P/WVmxhNWBqgBXAAbUGohXcyDsArwD2rQNeAA0x+qCReyfuAKIG2hoQBbDSIY0Ilht2B
 5BfgPr2uBdZAAo8eKZQS/bDy3k+nU7/APrlR7VAAwAA
X-Change-ID: 20260511-shikra-dt-d75d97454646
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
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Monish Chunara <quic_mchunara@quicinc.com>,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Sneh Mankad <sneh.mankad@oss.qualcomm.com>,
        Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>,
        Xueyao An <xueyao.an@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781285260; l=4578;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=IigjJZAFdWHStKnJ7CJ8gw0Pf0NlG9F/hHW8w4b4TNk=;
 b=8paggs4TP07URFHVkDTNL+yxMhHR2xjlmOPiLSkEr627GHxsrQ/rlqrSFd7PSaCvuvuLxTh0t
 733e+YypTmXD+LroAuovCik68JnSfIQTeKYY+lPHWgCPqai44NzdZ61
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDE2MiBTYWx0ZWRfX6ufUC0K2bvL6
 dTJCg3RcESdYhmd9UZ94ZWaRBmdqITPLzRYIU4Y32v1xQVrzDn1JYKfFqQUdhnV+FTuwAUolGND
 LQ07JHrMCrJYup08y0n8HbwvcoOXaBQLF0/yPOuXw/0dZ900K0WFD7Y8ahxhMalYoozWR6UwSlZ
 zm/pd2d/4321AfTz88ZJw1X7zk6ski4FQR+TnxqW6TK7vZi1h20dPI9+63C69oK4SBy+n6cVUrf
 /mjRKeeQbABeBEVyBXIPm3b3zHwRXeqN+LXepxdIisznLJ1fZBE8TrDY44ZlZ4sSne7CbByMFAi
 fXVdOer2pD2MoA7ED5eLG4FIoJSFUAEOZf+REJPoLwDHkRP7s2qlwOQvf/GZS6iV5ly3sj8SmhM
 3OR6P2vWzdN/CxDXoEDPDMokU+dARpM/O9Hstzy83Q4FpQxgC7MAA8tSCwYjnHOoS/W9m1c5RDp
 y84qFIUPbwDXOqPy3FA==
X-Proofpoint-GUID: ZUG79dSvAUmZS1nuVJP6P8VfpegHfmu_
X-Proofpoint-ORIG-GUID: ZUG79dSvAUmZS1nuVJP6P8VfpegHfmu_
X-Authority-Analysis: v=2.4 cv=NZPWEWD4 c=1 sm=1 tr=0 ts=6a2c4195 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=9a9G3XpPGFzrMXkSwxIA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDE2MiBTYWx0ZWRfX5SWCCAt6m3Af
 rHBKY6uqLPuPD0nvVjSAGzaNHlhYJZxzFy9gBQxwrwalWZFFXqPpBBDFGDVRTA3NETu9pcpJ1u9
 N4okTo6G+wk1lA5JC8MFcYTbapkwuOo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120162

Add initial device tree support for the Qualcomm Shikra SoC.
Shikra ships in a SoM form factor; this series covers the CQ2390M,
CQ2390S and IQ2390S SoM variants and their EVK boards.
The series adds:
- dt-bindings for the Shikra SoC, CQ2390M/CQ2390S/IQ2390S EVK boards
- SoC base DTSI
- CQ2390M SoM DTSI with PM4125 and PM8005 PMIC regulator definitions
- IQ2390S SoM DTSI with PM8150 PMIC regulator definitions
- EVK DTS files enabling UART and eMMC on the carrier board

Note: USB support is intentionally dropped from this series. It will be
sent separately once the USB driver changes for Shikra are concluded.

Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>

---
Changes in v6:
- Collect Reviewed-by tags (Krzysztof, Dmitry)
- Fix ranges value and interconnects alignment in sdhc node in shikra.dtsi (Dmitry)
- Link to v5: https://lore.kernel.org/r/20260611-shikra-dt-v5-0-103ed26a8529@oss.qualcomm.com

Changes in v5:
- Add qcom,rpmcc-qcm2290 fallback compatible to rpmcc node in shikra.dtsi
- Link to v4: https://lore.kernel.org/r/20260527-shikra-dt-v4-0-b5ca1fa0b392@oss.qualcomm.com

Changes in v4:
- Updated commit message for 1/5 and 3/5 (Krzysztof, Konrad)
- Incorporated Konrad's comment
- Collected Reviewed-By tags
- Link to v3: https://lore.kernel.org/r/20260522-shikra-dt-v3-0-80ffde8a3dc4@oss.qualcomm.com

Changes in v3:
- Drop USB nodes from this series; will be sent separately pending
  conclusion of USB driver changes for Shikra
- Fix memory base (0xa0000000 -> 0x80000000) (sashiko-bot)
- Fix power-domain macro: QCM2290_VDDCX -> RPMPD_VDDCX for sdhc (sashiko-bot)
- Fix INTC GIC_PPI number from 8 to GIC_PPI 9 (sashiko-bot)
- Rename SoM variant CQ7790M to CQ2390M (Konrad)
- Add PMIC DTSI includes to CQ2390M and IQ2390S SoM
- Link to v2: https://lore.kernel.org/r/20260519-shikra-dt-v2-0-c01b90fb4395@oss.qualcomm.com

Changes in v2:
- Update SoM/EVK combination bindings (Krzysztof)
- Add per-CPU-type PMU nodes with PPI partitions for the heterogeneous
  cluster (Cortex-A55 + Cortex-A78C) (Konrad)
- Use full product names CQ2390M/CQ2390S in commit messages (Krzysztof)
- Update RPM interconnect tags and power-domain to RPMPD for sdhc (sashiko-bot)
- Update to use MPM for ss_phy_irq instead of direct GIC for usb (sashiko-bot)
- Add IQ2390S SoM (PM8150 PMIC) and IQS EVK board support
- Link to v1: https://lore.kernel.org/r/20260512-shikra-dt-v1-0-716438330dd0@oss.qualcomm.com

---
Komal Bajaj (5):
      dt-bindings: arm: qcom: Document Shikra and its EVK boards
      arm64: dts: qcom: Introduce Shikra SoC base dtsi
      arm64: dts: qcom: Add Shikra CQ2390M SoM platform
      arm64: dts: qcom: Add Shikra IQ2390S SoM platform
      arm64: dts: qcom: Add Shikra EVK boards

 Documentation/devicetree/bindings/arm/qcom.yaml |  18 +
 arch/arm64/boot/dts/qcom/Makefile               |   3 +
 arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts     |  40 ++
 arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi    | 156 +++++
 arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts     |  40 ++
 arch/arm64/boot/dts/qcom/shikra-evk.dtsi        |  15 +
 arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts     |  40 ++
 arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi    | 170 +++++
 arch/arm64/boot/dts/qcom/shikra.dtsi            | 842 ++++++++++++++++++++++++
 9 files changed, 1324 insertions(+)
---
base-commit: ec039126b7fac4e3af35ebccaa7c6f9b6875ba81
change-id: 20260511-shikra-dt-d75d97454646
prerequisite-change-id: 20260429-shikra-gcc-rpmcc-clks-2094edfff3b0:v5
prerequisite-patch-id: 59bb0a7828e41f546f734f127d81da83c0adcda9
prerequisite-patch-id: 197da6bcb15cadc47869dba88c8020987b25c335
prerequisite-patch-id: 8ec9c1eb03f052ae232ed54117abed38672c23f6
prerequisite-patch-id: 350db4f4bcdfc0fad9ed57cd5b1723f85ad44f5d
prerequisite-message-id: 20260508-shikra_mailbox_and_rpm_changes-v3-1-698f8e5fb339@oss.qualcomm.com
prerequisite-patch-id: e80ea7940b9817449cec21afa6e9e443e007166f
prerequisite-patch-id: 2526e0507d3b5c065eafd75a657d7f903af8488f
prerequisite-patch-id: c3b7e18cd60d1f779b88ace2fae1227d3d37d83e
prerequisite-change-id: 20260430-shikra-imem-binding-a7bb9d2f16d2:v1
prerequisite-patch-id: 80d8ab865b7b0663c5b2878b45b55e2e4fde9c19
prerequisite-change-id: 20260501-shikra-scm-binding-a7ff5fabd0f2:v1
prerequisite-patch-id: 8e645e1c6ad6182de4813a726c293654324de1df
prerequisite-change-id: 20260501-shikra-tcsr-binding-fff1689e4097:v1
prerequisite-patch-id: f6781d2cf0829ccb32f1400623c95739972f2ee2

Best regards,
-- 
Komal Bajaj <komal.bajaj@oss.qualcomm.com>

