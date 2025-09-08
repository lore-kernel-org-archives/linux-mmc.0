Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE202EACFE
	for <linux-mmc@vger.kernel.org>; Mon,  8 Sep 2025 08:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757319621; cv=none; b=hhuLPPYGlhedXGDcm0fWM+HNGaFZaNZjuQBoPJ9szwnKupN8VDdO92CTyhd9zLszcjZGadTD9amgt14plRpXZ30/xd+gNi/KRvghhwze8zlZwMEt4M+oH1r68XLUYpQLb/nHKaIiDrNUgE8B1jzxlqy4JAPLJUzH9gGszBh+Kts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757319621; c=relaxed/simple;
	bh=cEKPlNzxkTSt3zsN+KRunKsxcQSskZfknNDUgN0JKdc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aTJaeNI2oG73EvLNwszeHVNIyJokBJcXjsFtfUGhwPfYEOmDE+vf0lPwu0XblRI3+l7i8zwtYfU5AVIb1Z5aiuptGqzGmKfDW5G2ub9ScPsOLKoXCo5MkIymtvDJ0AaRF90TvMmgK0pRvUS2fdv0E1vtA/sh53sTAVRjj4gUBVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CNSesp2B; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CNSesp2B"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5880Urt0007791
	for <linux-mmc@vger.kernel.org>; Mon, 8 Sep 2025 08:20:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=2ZnZy56MeIzokdnX+SHMNH
	c5aw/LndrUrClvuDaYfBY=; b=CNSesp2B8a5+n2WMlv1MRsiA+bfX0lOHNIEHxT
	Ini9A+B4eawAXEYB3q0O0nhCTcSdec5kj0LHS7K8RMAi8xLRiO6IrOJWoz3QE4Us
	pOcrCLy/oyhIFu3av5aj4HGZvWdrCZxpWjJyhdNiYR4v0+w8l/G5+5aLc+fDJg/H
	YRKP3qYcdtH1Qg1wsGOdtamNRCQQk/cFXuXOUMQMOKkZQs4nAfOGvBfF/nebmx6J
	jbpeiHAd00Dg2u9m/ELsNvGZnSfPJ3GNd1a2HluflotGxTsE8YTup0LoyFHb3Q+t
	E37Tryy1X3jgAjmOvnfxsagkLyNup74P8BjFQo5BFoe+Zhsg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490db8bsvq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 08 Sep 2025 08:20:17 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24ca417fb41so49292975ad.1
        for <linux-mmc@vger.kernel.org>; Mon, 08 Sep 2025 01:20:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757319610; x=1757924410;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ZnZy56MeIzokdnX+SHMNHc5aw/LndrUrClvuDaYfBY=;
        b=HdZDszjNvcUHtWdACwTn0/xqmI4glRskRmhRux35q4r3hVMlJ6TJmReiv9pthS1gpj
         grLryPzN1KytDn/5mCptQVZf8oNgPFEWbaQabwv0XsUqBdB0/djsPkSfLGIglHHYuoTh
         v4JLpCtSR3w+v/F2SWdXcHemxyVwid9Qb2wJr0bQ9ERYlVc23ZW/fkM+1xxCZt72x3ge
         6vRzO/pu7Lyvdzt9K16J6rQio1Rl5d3ED+9XP0CaNEO9mFY0GqnuqpqnxBHiScRQsnIj
         9wzgRi0K9UGW+PUUKSIvYdAHKqGZGDv4Eiy8UalBswagF1/afpw3XDd05VdCmSnjhCfE
         1ECQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOlfDYvaXyMwNpfUrdh3b714o2CW85mpHvuHXVTQviXSX4agetEHbnhslB/WAowPvfpqAOMPImd5w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjrl6BhZg25hlNRwX1kDLLtkNonXzGywdEvgrqkkWFFXt4E/jj
	u/YEG4ROejnzg0WukoTJKQory8HpzOPxIsczzD/htxy02Z/tcgaj0CX8YpPXJmaHmYXCKUqFvTF
	S6j9OZCsZ014CwUZNA5CVqVkafYWAPoRcp2qD1LEdbazD3FPDhgmKXBqufvlO6pc=
X-Gm-Gg: ASbGnctjRLbDmlye3tb80Wt4FCVha1oXZE4Qp2dqeygAQzO1r10QqYcDDmUBrLr0Qrx
	AC5ZosuREbDPHp0LPg0m4r7Cazo6RJ35mzS1KHLqlG4BZgoVVbdgfPe6EuCVAqTl6+WagVszk20
	pH/6FpbIP/lynQ59Z3cpnfawQTGZee6e4OleGyAkwHQDMcTmCVI9u6DjlaeVSZ3mB/ThC3mBGR9
	bmm5R8FK+VpnmZ8menqKMtfmk8lpjnkdLWMyV6DUYfhglIuAyvPApEglcMRvSQHtF+JegF3ieE7
	PbiMxh+AkwaWk7eLlDvufyADZsodiF038pzQJ79oAbvvyllYTrtxm2HH66eXGMcsOluw
X-Received: by 2002:a17:902:cf04:b0:250:1ba5:b207 with SMTP id d9443c01a7336-25175f6e7c9mr104967365ad.59.1757319609874;
        Mon, 08 Sep 2025 01:20:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVYfEofhMnkcc8CT8Uiba9p7RWZ3HLBMVrTrxwZuh41wyHysBPEj2XbHo64cRm7pu088AJiA==
X-Received: by 2002:a17:902:cf04:b0:250:1ba5:b207 with SMTP id d9443c01a7336-25175f6e7c9mr104966765ad.59.1757319609205;
        Mon, 08 Sep 2025 01:20:09 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ccfc7f988sm104852845ad.144.2025.09.08.01.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 01:20:08 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Subject: [PATCH v4 00/14] arm64: dts: qcom: lemans-evk: Extend board
 support for additional peripherals
Date: Mon, 08 Sep 2025 13:49:50 +0530
Message-Id: <20250908-lemans-evk-bu-v4-0-5c319c696a7d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKaRvmgC/3XPSwrCMBCA4auUrE3JoynRlfcQF0k6sUHbaGKDU
 np30yIoRTcD/8B8MCOKEBxEtCtGFCC56Hyfo9oUyLSqPwF2TW7ECBNE0gpfoFN9xJDOWA8YDKH
 CQEUkAZRvrgGseyze4Zi7dfHuw3PhE523b4nVKylRTHBmaA2k4QbE3sdY3gZ1Mb7ryjzQDCb2Q
 baErxGWEW0Vl1RbqRX7g/BvZP1T4hmRWitlqGUC5A9kmqYX9bsxazsBAAA=
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
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>,
        Sushrut Shree Trivedi <quic_sushruts@quicinc.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>,
        Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757319602; l=4998;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=cEKPlNzxkTSt3zsN+KRunKsxcQSskZfknNDUgN0JKdc=;
 b=zuB8bPeEAtHh8eakwllfoTkmQ7gWzveF2HIZ6sYDzOvBd36O4tWdtAXHUgncosP99cajSCcbW
 HaYYybfyd0yBpA/9NRR/01FwzBpMBfVYJI23xgMsB9NLs9AfvhOXajL
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzMSBTYWx0ZWRfXxsNBudx8Nc29
 3QQKPEoHkSWb5KxJ/fbznRFPRik9rlINuXZPTeL/pArJ5/OtXD0M+aYR/gH2VlhyHQ9R3HScihb
 x9lunXTiy1aBqsnE+dQnG5o+EQipRSWyNt8zY4I8Y4IQItsjOlsaScDb8hP5JZRCJjKvJgVf+VC
 BHL/Epzht3JXJ9ImLnDq64xnSYUSi0pDMq8szZAueOYmfNA3GcEeC3sfX+WpX9FbouXQ1oCVUqk
 FaZ9LiHHwZ86Td3I2T9X23PDQimTFw+ZgKDNwMa+yKwfXZv5jiuzOKrucwgauwOo2Vd4ElDuHz2
 foIL4wVwJ8MrDQHS/hcppv4uvimEYe7N40ENOkHj3APxLBj2uCYrBcIJPyNICCDLeoaG8JLb+2C
 CydbtCI4
X-Proofpoint-ORIG-GUID: JNq2TaOH36mzKmnp-fDWwoN-aSAqn_Ka
X-Proofpoint-GUID: JNq2TaOH36mzKmnp-fDWwoN-aSAqn_Ka
X-Authority-Analysis: v=2.4 cv=VIDdn8PX c=1 sm=1 tr=0 ts=68be91c1 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=UzDb-niT3-dnCAiDllkA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060031

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
Changes in v4:
- Move 'bus-width' property of SDHC to Board DT and also keep the width
  to 4 bits - Dmitry/Konrad.
- Update commit text of eeprom bindings to describe the reason for the
  change 05/14 (v3) - Dmitry.
- Bring all tags from v3.
- Link to v3: https://lore.kernel.org/r/20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com

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
 arch/arm64/boot/dts/qcom/lemans-evk.dts            | 417 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/lemans.dtsi               | 146 ++++++++
 4 files changed, 565 insertions(+)
---
base-commit: be5d4872e528796df9d7425f2bd9b3893eb3a42c
change-id: 20250814-lemans-evk-bu-ec015ce4080e

Best regards,
--  
Wasim Nazir <wasim.nazir@oss.qualcomm.com>

