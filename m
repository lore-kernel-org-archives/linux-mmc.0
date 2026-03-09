Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A103C3BF1;
	Mon,  9 Mar 2026 21:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773090843; cv=none; b=LwCOJpIsDqGnVvtK4vtHnb8ANFdUtP1imxEBjSOiTreD48bJmuIvNQJDv08cQ6XmqJmdMW6RNHc8N/24tto4p+8OypH+B8XhhAYSLaSLpc/cKnTJ6IJiHixec15y0JFJvAkg8lCoP/GCWJPWjf9m3O7cZ+J46x0KRSlWt9GGH/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773090843; c=relaxed/simple;
	bh=teYZU6LdnxU+I5ZUvuUfNdyxcYYHAZaS9ZpNzDXd9Ac=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=haLt1RFo1lWFMnIXOLadaSwPAOVQZQAGRgCWkO+NtAMqfo/b6sUWry8pNnSYl7i8oWi58CObhw391T1KR2hJlvJeLvsZ2aPd6q0y5v+1qEgOZNCd/WMTamY74hRYyPZgStQwG+CGcehii5oeoOKPVEGwrDxfk9X7btQpbsQVduY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=Uzm2w9B2; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="Uzm2w9B2"
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629IB61a2067371;
	Mon, 9 Mar 2026 21:13:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pps0720; bh=2qHkBKOryc1V6CZA0gnY5uJLBVYQe6FvA+tCd
	A/f+Ws=; b=Uzm2w9B2saoStbOyjw6zlQ4Wii7cKU80KTL+Cgyg2hWt/q+6xCEDa
	H06beiH1k4Up/OZpQRrhEk+DXgOrhkbU7jlqkLnHiRyUR1coK4+vVDRMfM8KUJxG
	7sph1dPPT/IRGkE9fp90ZggIxN2uoVmbF8PxhpXmKcP9QV0MKiNAfyMXvSUEuClp
	eUjeyHulg53Sl6haAYe2kwi+p3NUhNC56UvN2N+dMDaGZMuAD1MVQWOm0rOPZxVz
	JAo8IyCOih3kGS/Jtk1/Y0VDeADcDvP/HHGYBYO2GFT6dFnYAEzChUwz0FTKbkbD
	GAwglf6Alfw8EvFuibVXytIUZYswK2t8A==
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4ct38ta0c4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 21:13:43 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 6815A80160B;
	Mon,  9 Mar 2026 21:13:42 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id AE214806B32;
	Mon,  9 Mar 2026 21:13:41 +0000 (UTC)
From: nick.hawkins@hpe.com
To: ulf.hansson@linaro.org, adrian.hunter@intel.com, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: jszhang@kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nick Hawkins <nick.hawkins@hpe.com>
Subject: [PATCH v2 0/2] mmc: sdhci-of-dwcmshc: Add HPE GSC eMMC support
Date: Mon,  9 Mar 2026 16:13:31 -0500
Message-Id: <20260309211333.977919-1-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDE4OCBTYWx0ZWRfX84GtPIsl/MLw
 r9FWn/PEmm+PEVCVw1mnEIJdh1bDr437AcLxuJr0gEkTvuVGG7LRJjnMZ9mwJzu8NrZOC57EjTK
 XaKto8ismwpTrFGdW/vnUQbyPi1lo+U0nXMYNhy3m7l3PgxyYfBFQOp3rb8vsxuHu6rUSms2Fl7
 C2M3q7qv1GXBWb2E9QnyQy6MgsAlUsNq7ZylU7AEPhDYK2aCdXE9RVxH9eKz0eJTUeX7WsWgy1w
 G0cI9PnIR1XeSimfUdzgdcooozUaKrGKLlVDoJ3dvIIn2nJ96Gw4aOzZYCEggKz8dT2Y/ha1Bc/
 kdzh950GdyfMADT6vEnL8OTl9RP3Z3YbnGbzYDIfyDoDCYjAH0N+/6sO6Ov2zj+YwEzzPF/QANd
 Rv49zm/8k9T2VNRzOXbteq5jxsI/+h2EmqJ0xtKaFTpfWhOqFs+iiK2mfmEIH7PnSyPM9vFuNhO
 WjEG8XSVewtIeA1G6nw==
X-Authority-Analysis: v=2.4 cv=dNWrWeZb c=1 sm=1 tr=0 ts=69af3807 cx=c_pps
 a=A+SOMQ4XYIH4HgQ50p3F5Q==:117 a=A+SOMQ4XYIH4HgQ50p3F5Q==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22
 a=NCWKwCw8Xy9Og0ibBRsL:22 a=MvuuwTCpAAAA:8 a=XbkwoOjMWocvkfcq9GYA:9
X-Proofpoint-GUID: oBuJtbJzi7Mf8igKZXapcItsHnv3pXrd
X-Proofpoint-ORIG-GUID: oBuJtbJzi7Mf8igKZXapcItsHnv3pXrd
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_06,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0
 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090188

From: Nick Hawkins <nick.hawkins@hpe.com>

The HPE GSC is an ARM64 (Cortex-A53) BMC SoC used on HPE ProLiant
servers.  Its eMMC controller is based on the DesignWare Cores MSHC IP
(snps,dwcmshc) but requires a small set of platform-specific quirks
that cannot be expressed through the existing generic dwcmshc code
paths.

This series adds support for the 'hpe,gsc-dwcmshc' compatible:

Patch 1 extends the snps,dwcmshc-sdhci.yaml binding to document the
new compatible and the mandatory 'hpe,gxp-sysreg' syscon phandle for
MSHCCS register access.  The HPE GSC exposes only a single 'core'
clock, so the clocks/clock-names properties are constrained to
maxItems: 1 for this compatible.

Patch 2 adds the HPE-specific driver code in sdhci-of-dwcmshc.c:

  * dwcmshc_hpe_set_clock(): SDHCI_CLOCK_CONTROL.freq_sel is wired to
    a clock mux on the GSC SoC, not a divider.  When running at
    200 MHz (HS200) freq_sel must be forced to 1 to select the correct
    high-frequency source.

  * dwcmshc_hpe_vendor_specific(): disables the command-conflict check
    and programs ATCTRL = 0x021f0005 for reliable HS200 signal integrity
    on the GSC board topology (auto-tuning enable, centre-phase mode,
    tune-clock-stop, pre/post-change delays = 3).

  * dwcmshc_hpe_reset(): calls sdhci_reset(), re-applies vendor config,
    and unconditionally re-sets CARD_IS_EMMC.  The controller clears this
    bit on every reset; leaving it clear causes card-detect
    misidentification on the eMMC-only slot.

  * dwcmshc_hpe_set_uhs_signaling(): mirrors upstream
    dwcmshc_set_uhs_signaling() but always asserts CARD_IS_EMMC.

  * dwcmshc_hpe_gsc_init(): obtains the SoC register block via the
    'hpe,gxp-sysreg' syscon phandle and sets SCGSyncDis (BIT(18)) in
    MSHCCS (offset 0x110) to allow the HS200 RX delay lines to settle
    while the card clock is stopped.  Enables SDHCI v4 mode.

  * sdhci_dwcmshc_hpe_gsc_pdata sets SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN
    (base clock not in capabilities) and SDHCI_QUIRK2_PRESET_VALUE_BROKEN
    (preset-value registers not populated in GSC ROM).

All new symbols are exclusively selected by the 'hpe,gsc-dwcmshc' OF
match entry.  No existing platform (Rockchip, T-Head, sg2042, Sophgo,
etc.) has any code path change.

Note: the DTS node for 'hpe,gsc-dwcmshc' will be submitted separately
as part of the HPE GSC base platform series (arch/arm64/boot/dts/hpe/).

Changes since v1:
  - Replaced the second reg entry for MSHCCS with an 'hpe,gxp-sysreg'
    syscon phandle + regmap access, as suggested by Conor Dooley.
  - Driver now uses syscon_regmap_lookup_by_phandle() and
    regmap_update_bits() instead of devm_platform_ioremap_resource().

Nick Hawkins (2):
  dt-bindings: mmc: snps,dwcmshc-sdhci: add HPE GSC dwcmshc compatible
  mmc: sdhci-of-dwcmshc: Add HPE GSC eMMC support

 .../bindings/mmc/snps,dwcmshc-sdhci.yaml      |  38 ++++
 drivers/mmc/host/sdhci-of-dwcmshc.c           | 173 ++++++++++++++++++
 2 files changed, 211 insertions(+)

-- 
2.34.1

