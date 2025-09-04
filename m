Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC6A23D7C7
	for <linux-mmc@vger.kernel.org>; Thu,  4 Sep 2025 16:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003965; cv=none; b=Nm2fQ5DtcE0KC3Jaj0T0vBCRj5Q9mYacW1rY/lP7+15LGKKWEEgHGxmHIL1hzFEKRy1zhyyS7WpZcNoVr6cw5TCjJ1J7rlTbwa3hIH+1tXv2OxXtX7+5yvGm//S27JjnS6GzqFsB7ryjh2ZOnPTlLFUsFAA3aVI4pSUZe0IqZZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003965; c=relaxed/simple;
	bh=GpD8BNFg396KGkNiIgm2sGFzaEIO7uHRIjt6IC/agYg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hk/BZxM6QGF8cuNNeggegOSnTl5GOwkvHEd1iA61UQRYMnHmWC5AIATZ6AMWJYGCqtl272gv8qmEv0gVwI6N7bhtQQ9Oz43vTeGSnoZG3lmipevKo9ig+GqWtlT09mPutVRnBVwrk4lAy4aeGhzeooxzKTCQJ457DALNa4nBejk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S0mDsHyE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S0mDsHyE"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849X7Sc003771
	for <linux-mmc@vger.kernel.org>; Thu, 4 Sep 2025 16:39:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=MNSbbZpCQsAdgAsVO32TmZ
	c29SrY2CxEjrNrN62kiYk=; b=S0mDsHyE5AMM8Qa8wWRHJL71l1yQ0FuWh/Zh1P
	8s/iCZpmz9HsbtSGpNX9huIp/G1s9uhoUH098Vq3QZaV6XzbaTdAhJYb/WKQdQP5
	RS4f+8PJNUxMUI6ZQjQ/Qr2GM7gzKedDUnkFL2hdBfuZpaihxMfGbvOlDTbKgAiA
	NxhrdADaH7/gMxoArh1I8/kM5UIwrrtWd/1xYQputVHiRIvwV5/XbWr7PUeti8P9
	dtTTtllC5b/Iv7t9UEtDpnswiik7JwwpacYAJ7qXKZXlcFe7F8yKw1v8trW97ccv
	RIRMp6mmVff1xzao7F6duS9cCAddoa8B8Zswu1XhLR41QyRA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8s88f4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 04 Sep 2025 16:39:22 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-76e395107e2so1255514b3a.3
        for <linux-mmc@vger.kernel.org>; Thu, 04 Sep 2025 09:39:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757003962; x=1757608762;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MNSbbZpCQsAdgAsVO32TmZc29SrY2CxEjrNrN62kiYk=;
        b=PX4v0lCXtVJB7l6S03Yo0tATB1tqciLDMkAjnFKBAwLI2ORfPKSXCn+ZcIvTXkQk+x
         WtC94hiyoI/mrk2WvGHHyRG0W8ptWO/ePLC7ObeU7vwWNd+X177hWEHPAX8wDhLLLc4D
         LCX8xsf6oymoR23LcEBQTkSLrn6sJ9Ih/xIrcTuTyAgglvESHyn9thwUjsh6mkaV8N1J
         +mZW7ZfMTH9X4kVDFbfCm10rJowAYKw2Em/1lPru3EQdm0I0j/DloFYAeX6Um7bhJtqA
         puLHH9d5UuoJGLhWBStmvpfQeTfNq9AqPAIh1loGlJ/PNw1kU85qXXezMX2C5Ja5kwt4
         nxrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhR9x3cC0mzFz+Wqhnq0Bnwvrz/3+t88e8P1NEvR82WMAw4+9o7p5mdAQ7KBK674aQe/b0QmG3hQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/JEmRVdxFr+dzNuY9RnyoM9xe5gchKX90/CQEElfCPFDNDpcp
	XwBL2slzUkESSiE02R0h7oEw+huJEnIDUXEUuEmFr29YoKKZfPbF7vw3tc58Rkivfe0xxu7RL+2
	XDyZtsO/MNbAWEW6wuA4XGSBnXfWVCAXfDcqDdclrEXDZFgbw8ZxWHsBO/6TcnOU=
X-Gm-Gg: ASbGncu4HzMmM/itJ6aAI6dmOLDmLXZtQzSLSqUAH8uCfYNNGDG2RdE/46IXi7dFzPS
	9XneY9gQLmYI7xA5bxiOaHOfXCVBy+ghVudTR45Peks43/wG+Fo38t+eWkpYO5oXVUOoxPsxL3P
	scjS79TMe8A3gy5EocmjRskPVDUqEfmkF2NEcvTYpLZPstO2TS1JXGYn29w4d1JOvqb34LHXTo+
	388YhLrv/WPeR9MSORcRIKMPpeuIsG1fzgLLTIDJNjtwTVuiuE41jfx+HdVQzrb0a9qmPLzSMHJ
	ZsFTQpPD+O1hG2IYwz7Uaijk9Lj3w88WQ9/+z3nanMALCxamRlf2jYOfejJ7uQdC/xlO
X-Received: by 2002:a05:6a20:4303:b0:24e:84c9:e98f with SMTP id adf61e73a8af0-24e84c9ebf4mr415459637.59.1757003961819;
        Thu, 04 Sep 2025 09:39:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENfHKOfMUlhg5WU9p/8Sk77cSDyMNV/t6TSuChQ6ApcsAK5PWqLjiRWeH9hsnd1eiAaGZG1w==
X-Received: by 2002:a05:6a20:4303:b0:24e:84c9:e98f with SMTP id adf61e73a8af0-24e84c9ebf4mr415330637.59.1757003960584;
        Thu, 04 Sep 2025 09:39:20 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd006e2c6sm17346371a12.2.2025.09.04.09.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 09:39:19 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Subject: [PATCH v3 00/14] arm64: dts: qcom: lemans-evk: Extend board
 support for additional peripherals
Date: Thu, 04 Sep 2025 22:08:56 +0530
Message-Id: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKDAuWgC/23M0QqCMBTG8VeRXTc521RWV71HdLHNY47U2ZajE
 N+9KUEg3Rz4H/h+MwnoLQZyymbiMdpg3ZBCHDJiWjXckNo6NeHAS5CsoB32aggU453qiaIBVho
 sQAKStBk9Nva1eZdr6taGp/PvjY9s/X4lXu2kyCjQxLAKoRYGy7MLIX9MqjOu7/N0yApG/kOOI
 PYIT4hulJBMN1Ir/gdZluUD9J8OkvYAAAA=
X-Change-ID: 20250814-lemans-evk-bu-ec015ce4080e
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-i2c@vger.kernel.org, Monish Chunara <quic_mchunara@quicinc.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>,
        Sushrut Shree Trivedi <quic_sushruts@quicinc.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>,
        Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757003953; l=4648;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=GpD8BNFg396KGkNiIgm2sGFzaEIO7uHRIjt6IC/agYg=;
 b=2CMcvZ4DfkFj/djWAIguElhQ7xU1SjResWfi0MSzltJRxTory6Sq+cgPwGMH4eiSSWEzFAaWJ
 BF63OoT1E09BGtdC9EOIJ4+vllZmGPr/UcswbqnaemOFuOVRX0XZzJu
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfX6IlL670EqIlx
 H5BL0pXiK0VVBPMPAlWVSKnba5tnNddfC2dM3ZJ6Evb9rbxl48Z+2E3HnrOh7oIqL+Xk0b578Pa
 nFuKQsdgrhhFYGgV1I6EF1XstlTYU3+mUQpFd6ca82s+9rg3DZxxXQtSuNN5uPZ73CMNnDlgzAK
 If73Fh6w+7RoPKlHJBtGqnPi/irFjayMGLWzubDmN+9XIQno2vh+8tJ3aXmDx5Ye3WO7dnplQxN
 EYvEeinQfFvfgCSptAoPrHgKeZwRgGlciAnuQOLEakvoOVxo44qY8eu61Qv0r4RP1Sfz0DCorVM
 vNxn5PfGOCF0N2Y73LMlPbYZxf+aUXTvt3fK7Qe5We3FW6hisdiXxoOWEzxUvCb3rqF818pYjU+
 q05/AC2C
X-Proofpoint-GUID: s9tOdOy9jF7mkO9oE819AlYgnF6XXyFT
X-Proofpoint-ORIG-GUID: s9tOdOy9jF7mkO9oE819AlYgnF6XXyFT
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68b9c0ba cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=UzDb-niT3-dnCAiDllkA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019

This series extend support for additional peripherals on the Qualcomm
Lemans EVK board to enhance overall hardware functionality.

It includes:
  - New peripherals like:
    - I2C based devices like GPIO I/O expander and EEPROM.
    - GPI (Generic Peripheral Interface) DMA controllers and QUPv3 controllers
      for peripheral communication.
    - PCIe HW with required regulators and PHYs.
    - Remoteproc subsystems for supported DSPs.
    - Iris video codec.
    - First USB controller in device mode.
    - SD card support on SDHC v5.
    - Qca8081 2.5G Ethernet PHY.
  - Audio change [1] to support capture and playback on I2S.

Dependency:
  - The ethernet PHY QCA8081 depends on CONFIG_QCA808X_PHY, without
    which ethernet will not work.

[1] https://lore.kernel.org/linux-arm-msm/20250822131902.1848802-1-mohammad.rafi.shaik@oss.qualcomm.com/

---
Changes in v3:
- Re-order QUP patch 05/13 (v2) to not break i2c node enablement in patch
  03/13 (v2) - Dmitry.
- Update commit text for QUP patch to highlight which all clients each
  QUP is accessing.
- Add dedicated compatible for Giantec EEPROM, because usage of generic
  compatible "atmel,24c256" alone is not advised.
- Update commit text for EEPROM patch 04/13 (v2) to emphasize on EEPROM
  enablement - Konrad.
- Put 'reg' property after 'compatible' in Expander - Konrad.
- Put 'pinctrl-names' after 'pinctrl-n' in PCIe - Konrad.
- SDHC:
    - Update interconnect nodes with ICC_TAG macro - Konrad.
    - Put new lines for each entry in interrupt-names, clock-names,
      interconnect-names - Konrad.
    - Put bias properties below drive-strength for consistency in
      sdc-default-state - Konrad.
    - Move 'bus-width' property to SOC DT - Konrad.
    - Move 'no-mmc' and 'no-sdio' properties to board DT - Dmitry/Konrad.
- Add 'Reviewed-by' tag from Konrad [2] on Audio patch 13/13 (v2),
  although the commit text is changed now.
- Link to v2: [3]

[2] https://lore.kernel.org/linux-arm-msm/b4b6678b-46dd-4f57-9c26-ff0e4108bf79@oss.qualcomm.com/
[3] https://lore.kernel.org/r/20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com

Changes in v2:
- Split the patch 3/5 in v1 into separate patch per author - Bjorn.
- Use generic node names for expander - Krzysztof.
- Change video firmware to 16MB comapatible - Dmitry.
- SDHC:
    - Arrange SDHCI-compatible alphanumerically - Dmitry.
    - Move OPP table and power-domains to lemans.dtsi as these are
      part of SoC.
    - Move bus-width to board file - Dmitry.
    - Change 'states' property to array in vreg_sdc and also re-arrange
      the other properties.
- Remove the redundant snps,ps-speed property from the ethernet node as
  the MAC is actually relying on PCS auto-negotiation to set its speed
  (via ethqos_configure_sgmii called as part of mac_link_up).
- Refine commit text for audio patch - Bjorn.
- Link to v1: https://lore.kernel.org/r/20250826-lemans-evk-bu-v1-0-08016e0d3ce5@oss.qualcomm.com

---
Krishna Kurapati (1):
      arm64: dts: qcom: lemans-evk: Enable first USB controller in device mode

Mohammad Rafi Shaik (2):
      arm64: dts: qcom: lemans: Add gpr node
      arm64: dts: qcom: lemans-evk: Add sound card

Mohd Ayaan Anwar (1):
      arm64: dts: qcom: lemans-evk: Enable 2.5G Ethernet interface

Monish Chunara (4):
      dt-bindings: mmc: sdhci-msm: Document the Lemans compatible
      arm64: dts: qcom: lemans: Add SDHC controller and SDC pin configuration
      arm64: dts: qcom: lemans-evk: Add EEPROM and nvmem layout
      arm64: dts: qcom: lemans-evk: Enable SDHCI for SD Card

Nirmesh Kumar Singh (1):
      arm64: dts: qcom: lemans-evk: Add TCA9534 I/O expander

Sushrut Shree Trivedi (1):
      arm64: dts: qcom: lemans-evk: Enable PCIe support

Vikash Garodia (1):
      arm64: dts: qcom: lemans-evk: Enable Iris video codec support

Viken Dadhaniya (1):
      arm64: dts: qcom: lemans-evk: Enable GPI DMA and QUPv3 controllers

Wasim Nazir (2):
      dt-bindings: eeprom: at24: Add compatible for Giantec GT24C256C
      arm64: dts: qcom: lemans-evk: Enable remoteproc subsystems

 Documentation/devicetree/bindings/eeprom/at24.yaml |   1 +
 .../devicetree/bindings/mmc/sdhci-msm.yaml         |   1 +
 arch/arm64/boot/dts/qcom/lemans-evk.dts            | 416 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/lemans.dtsi               | 147 ++++++++
 4 files changed, 565 insertions(+)
---
base-commit: 5d50cf9f7cf20a17ac469c20a2e07c29c1f6aab7
change-id: 20250814-lemans-evk-bu-ec015ce4080e

Best regards,
--  
Wasim Nazir <wasim.nazir@oss.qualcomm.com>

