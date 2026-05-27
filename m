Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0C63815F3
	for <linux-mmc@vger.kernel.org>; Wed, 27 May 2026 15:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779897326; cv=none; b=mO2REDvSniaJ51HSJt5hqEGM70+D7hGBUNc4BBFUSyRxFncG89VtmuzrLeGF5jxjBnTKcr+zRH+ZTJf766aZt9+iwO27KiFrzwOEIL3Yy6+QphGphsZe97HAqabfQoAUeFPBLA7X29BZA+jyQkLr0DI2TdZTygPtO6apV4BLZTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779897326; c=relaxed/simple;
	bh=7wuGwmXx2KoNcvbJnBXxehxytnVyMizpVloVEOeaw4U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lLftEE3H1RyQ3SvqIhdvJg9VF2E9IlAmLb2RmTBhYhaktMJLVCNSjuCreUiygs8k8Lo1hn/E7lyRu9bc+//bq1CqPT+MdoIS7LjlFlEKqIZq727AXbmz2/5sE+4yOprN1DjETwhqD1CVizf8++PWrUFbRpI8jUhQklSotuGyvJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TuacGxhs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E7rVovZ7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TuacGxhs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E7rVovZ7"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RFOFbR2282516
	for <linux-mmc@vger.kernel.org>; Wed, 27 May 2026 15:55:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=nUctDAnyRjXY49YDtCeo3a
	wpQsBKh5fh4zGJjkt24Xo=; b=TuacGxhsxv7p5Y41SPaTxMf20/9LyPkoFsH+bI
	L3mfp3LoHjzAjmwTnaQ7MqHoJ+i1nD82pJuyPO/lHl/Do2fNST2qYO/3zbPE3AN2
	35KWkXOU5HJoy7ImbLgaWbfiLEqwiDXZ9DhZc5f7wFLb7aqq5Tt5RSuw931uj2sQ
	lrtCvwlHX5c8NKno1Bt1mZ/K/U2UGvTBcfJYAn/8EpHiwAFeKNVPt/Uy3YhYyuXn
	kd/BcbjF3hZGAz8iNXC3dUzq4yQysCCJEP5XKIfYWs5hApWvfslILA83TDyDIsdt
	aSL3x3YAcrLsQLPwYkbk1RliuCShtYxAKj39vY/txYfwJMag==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edtvct9bq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 27 May 2026 15:55:21 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2bd00a65673so91499435ad.1
        for <linux-mmc@vger.kernel.org>; Wed, 27 May 2026 08:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779897320; x=1780502120; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nUctDAnyRjXY49YDtCeo3awpQsBKh5fh4zGJjkt24Xo=;
        b=E7rVovZ7Ny89+ffbuEEjB5FIPaifJ3Lo2OO7q0ENuVa8LUkV/izEh6Vg/XRsE8wxVn
         tm4ULiKmTCFCogC1lzYWeDSR8oBxCT7XIhf7W6jvzJyzWJnP2A9i2P7LXwcV8OYJWu8T
         ACDS2nisNX9OY//OBQ5AcBm1WEGfmQZLG81HkB+hWBjjRBoDnKllqIRe7cI97zJ6W4vp
         /svd+wJ9hRHwRpHxf/HB2qdtk4vqviNN0xCzLkvCeUa8L9ZcB2OabIQAkMv8DnlIvNv0
         IquBlz5pBuh6iZfrRGaHiizmKIsnbPKSYY0D4mO0TLV0o7l7OAt45OZwpuQc6EyYmUgn
         r45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779897320; x=1780502120;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUctDAnyRjXY49YDtCeo3awpQsBKh5fh4zGJjkt24Xo=;
        b=AY6mQZZ6p2Xw7C28VLjCnRpv/+AbVcusvr9A1TptQQse4wVNXbg0c5oiTc0Zk6c9OK
         gxzYIJDJVX2KpfdLCsX4TddWrSp1oHNU76hdW4Q025DF3rMNXVA1MuDcFU0xaHBbgCJi
         iEOkm75+YPh1FfF3Or50v0PS+BDkdC6Z3ICDGDJrzPDV0gWw0lNKAZVY8vbgLVAFtZiK
         3stTFklsC2rSmlJ1h/X1JePFcVN6Te9Xup+jHBiGqyvD3xfjKk4JNchx5SHOoutY1q+G
         KKL0vSYcruPp++IleAd+EuBvzfq9OJ7BvXkCyMBSG1wH/vGHqTc4Cy0EomVcUFo0wGhF
         lVBw==
X-Forwarded-Encrypted: i=1; AFNElJ+V9JfCfmE3IVIVH66HrdkpYM0awgSTb/+te6Uu3I3x40cdivsrWRji2EyUrgUraBXVnVq2LLHklPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRMbot30VQZpGpnLVkCwDacqJB3nzLqh6zDIFM37/rYe0aqV/G
	B61+RWiPcDL3UsRRUMjA9LA6JNR+CmDzYB3KbMhNJFd2Bvr/5wswi7+jIWU2/N6HxnkLm+izBMJ
	h09v+VyHu+bS4mfN/YhMWgSxAFcUZ1hpZF/M5O4CgeJquMpem25aJWbUYD/smcRA=
X-Gm-Gg: Acq92OG8h+QLi32Bewfz5Dyc2ztobrrQR2/QNZw72U9AaK1iV+ZASRJVe75ZSD0Z3Re
	3Rm7zIubFH7K5h1QkDBJVCdQ9biJ45fzWy2ug61dEcIfECzyjgVMSO+x1AwA2CuS41y45uY4TlU
	zK890Kv0MRwgKKje+YrgyjIaseAk+G/yfwbXl07HzLSMIBlvUOxHcf4XCqDMKicWdLTVe8upN/s
	mlDtrbTcFl3RvVpAdO+gddARbzOtCxEYA062i6b5Nabs8fawqvjCAmQRu0zpf5a/wLfd9KWFTbv
	amkJkIejPfYkRbkljWiEZ0LDWzHacNxZCVjVA6MPBv7AtUFGEph7Tj1Jbr7d4YkPgZG1qKpFmot
	bSfTlywxA5gDye8MvF22KlxaJFCsaVePt1QmjFZW6gsikB8Y=
X-Received: by 2002:a17:903:1a84:b0:2b2:4fc1:f653 with SMTP id d9443c01a7336-2beb07930c8mr198997795ad.3.1779897320262;
        Wed, 27 May 2026 08:55:20 -0700 (PDT)
X-Received: by 2002:a17:903:1a84:b0:2b2:4fc1:f653 with SMTP id d9443c01a7336-2beb07930c8mr198997565ad.3.1779897319768;
        Wed, 27 May 2026 08:55:19 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beff36894dsm1264135ad.37.2026.05.27.08.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 08:55:19 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Subject: [PATCH v4 0/5] arm64: dts: qcom: Add initial device tree support
 for Shikra
Date: Wed, 27 May 2026 21:23:50 +0530
Message-Id: <20260527-shikra-dt-v4-0-b5ca1fa0b392@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJMTF2oC/42T2W5aMRCGXwWd6xp5X7jKe1QV8jIDVs4Cx0BTR
 bx7fdijhqQ3lmz5+/zb43lvCowZSrOYvTcjHHLJQ18n8sesiWvfr4DkVOcNp1xTxRgp6/w6epJ
 2JBmVnJFKaqmbun8zAua3k+vnr/N8hO2+KnfnxbtxMTv5JHdX3yb3cTe2BJNhPmiISePiIJvHH
 BdKcHqhljlGEhhGQKkY52lxEJ8R0zk+peWms0zR5Qirfet3w1iIF0agEhCkrcexr+Bx023S8hI
 XlbFGBI7exC8Ovexe1ZgVr2NsXwvh1ElIiCgCXRz4p7C43bHzuQ3D29L3pwzL89ZqSWAQLDgt8
 VmEm4WUrtuTkPuU+xUxARCkgojcP7v1Hc0ddDfUmxBc4sh04k9QRW+/pMRHElGhD4nif5C7WMY
 bWp+KaetAUme+R3+nYXVDhah1ShG9Zfg9usXNONwjR65rhVl9YeqfFEpRfoXbdvqN1ye2ggcuA
 Y28nttBKf4jaxllSsq5EVowQxjphj6X9Tyu970f/ctQyny7920cum5eh0kTfAEyLeTdYhYZxMC
 FQy+k0oo7LzhXSiiH0digHdRqWWmaqSHXudRP/+fU6zXS1JGXtuYPbX1ghBLDtBRWCJoS/TfFJ
 KvP8SBwjwJeBZGy4CgGKZx6IhAPAv4hgagCSxETWF+LJz8RHI/HvxdTMOG8BAAA
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
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Monish Chunara <quic_mchunara@quicinc.com>,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Sneh Mankad <sneh.mankad@oss.qualcomm.com>,
        Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>,
        Xueyao An <xueyao.an@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779897312; l=5598;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=7wuGwmXx2KoNcvbJnBXxehxytnVyMizpVloVEOeaw4U=;
 b=2muxhnu8WuwSFGzqOBf277fIzOja0GjY8PY8bOtZCS8dkovZl28zZ4lqYM+QKGRINF1Ap8WOu
 ANpKx6CZSgSCKyDrCUMKr96jg9x2FEtLHdGgdzuM1I+8IrK5wzDLciH
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-GUID: JwhTYrmV1DTfwZGG_5rZrgWSb-8JVkQN
X-Authority-Analysis: v=2.4 cv=CY84Irrl c=1 sm=1 tr=0 ts=6a1713e9 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=j-BhbVR-bgdRnPYsS8kA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDE1OSBTYWx0ZWRfX6fdSSzWJXi/r
 W2t+cYcrw8/+6P9zNZ1u8q2BqN6gm2SVv9YK9vXFm3ZSQ6bNrZ3QcVPqMJjjXYh+MTMlCbvW9bw
 8TVBqC+Hq5Em3HEheANCf9R7WyFVOaXD61/NygQZF0lkhmsRtrEBZTaLFO8yF4q0J5X3Tocweoo
 FNZgLCCvAW7PY87/SbIPdvKALxzlLdLoPCNf10+5CvXZiXZrMLcZFKyBWC8oHmcKrdTtSi1dgEi
 FdHHd530mE4ZGabHhKffMIK2E8SIZyepf249+PxOLGmE4NKLnRzbBNzuKAUeCoJQLv0J9mooQw1
 qqUzfVg7PjrEejOxB/AbR6Ms5qfT6Q52IWYRMfhYVpare7JjUWMxU7F4Ulbx3mERWKav8krv+Ib
 vq2Xm99LKh3v/XqDMrZUK0SnQ85a1PeKJSlgwGu7E9zuOdyC5sLNYHsl6IivH8OX1ugM7jiegA2
 TkviSnTUuQG3Mcvwp5Q==
X-Proofpoint-ORIG-GUID: JwhTYrmV1DTfwZGG_5rZrgWSb-8JVkQN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_02,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270159

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
base-commit: c1ecb239fa3456529a32255359fc78b69eb9d847
change-id: 20260511-shikra-dt-d75d97454646
prerequisite-change-id: 20260429-shikra-pinctrl-fd71ab6ecd6f:v4
prerequisite-patch-id: d84e0b4c2788ab6cfcefc9806e7a6011eef8f91d
prerequisite-patch-id: c92359b721d8c28f4a62887052d0fbb2cb64480a
prerequisite-change-id: 20260320-shikra_icc-b1fcef45122d:v3
prerequisite-patch-id: d36ec191324b7992a56c463a15ff09bacd8d7ba1
prerequisite-patch-id: c6edf2e05d1409667c9674b765dbd0917401a903
prerequisite-change-id: 20260429-add_pm8150_regulators-a373f53eb48f:v1
prerequisite-patch-id: b312905695c635bf1e3deab87b718c92adf07f54
prerequisite-patch-id: 390dee07914f18c7df08c57b3c59c25d1588b62f
prerequisite-change-id: 20260429-add_rpmpd_shikra-f57873b2fa7c:v3
prerequisite-patch-id: 2aab0b42cafb535b31c5154002c12f381a52be9a
prerequisite-patch-id: 599ed97f57ef0783f69d4c22384e91e66a2888f6
prerequisite-change-id: 20260429-shikra-gcc-rpmcc-clks-2094edfff3b0:v2
prerequisite-patch-id: 5a0fbdd458785da2d0e850c851a05046672ecadf
prerequisite-patch-id: 1f98e515a52bbeb25e2a960a804afe16c6a472a1
prerequisite-patch-id: a64476b2ba6e0f2a55928baf72ec32672ee0123c
prerequisite-patch-id: d0c8651205232862b40f942929e1efdaa3084eb3
prerequisite-change-id: 20260430-shikra_mailbox_and_rpm_changes-2de7fe8e964f:v3
prerequisite-patch-id: e80ea7940b9817449cec21afa6e9e443e007166f
prerequisite-patch-id: 2526e0507d3b5c065eafd75a657d7f903af8488f
prerequisite-patch-id: c3b7e18cd60d1f779b88ace2fae1227d3d37d83e
prerequisite-change-id: 20260430-shikra-smmu-binding-7befe45ecf2a:v1
prerequisite-patch-id: 657d2fa91247aa0c222b595c41328087f04f01a2
prerequisite-change-id: 20260430-shikra-imem-binding-a7bb9d2f16d2:v1
prerequisite-patch-id: 80d8ab865b7b0663c5b2878b45b55e2e4fde9c19
prerequisite-change-id: 20260501-shikra-scm-binding-a7ff5fabd0f2:v1
prerequisite-patch-id: 8e645e1c6ad6182de4813a726c293654324de1df
prerequisite-change-id: 20260501-shikra-tcsr-binding-fff1689e4097:v1
prerequisite-patch-id: f6781d2cf0829ccb32f1400623c95739972f2ee2
prerequisite-change-id: 20260501-shikra-wdog-binding-33873dcfa81f:v1
prerequisite-patch-id: de5184831054bcb48889fca16b2f4b5e95da9935
prerequisite-change-id: 20260501-shikra-qfprom-binding-c262fa19640a:v2
prerequisite-patch-id: f284f0dc01674ea0a78c8cf40ada72a7a1636463
prerequisite-change-id: 20260502-shikra-llcc-binding-7832b24ef74f:v1
prerequisite-patch-id: b9e53d2b5b494d4a957a691340fb2563f3dd681c
prerequisite-message-id: 20260508101544.736317-1-monish.chunara@oss.qualcomm.com
prerequisite-patch-id: 2a9d88175f19bfdb9495a704681ff0093da5566c

Best regards,
-- 
Komal Bajaj <komal.bajaj@oss.qualcomm.com>

