Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513943E275D;
	Wed, 11 Mar 2026 18:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773252691; cv=none; b=VYGCbheK1eSO0W/OkGYIvdvohDKQrx6aCu+3yvVpEm9IS7S+blka6q8DV+LnCOm4fB82jEXTTlNHTqfWQeSgxMqp8DJjIFzjpGwl/MhSJE+/M6UBxEPb0WGkg2kLOLZ9TJ1O0OkUgLpdjEsCAaE9pjt/Oxxm+YMZBJbPfmUdBeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773252691; c=relaxed/simple;
	bh=druWuJbSgrmlCK8p5SzMlVpcTpNEmDhIG1NdFo3BAnE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NRTslE1QeI5t5+3eQqWnu4wdsU0nL0OgVx7xHWuoMwmc2FRIhHpM/8RXWrR7wVtkrbDiQjkVUr+J8PKs9E8zMk+FZNc3Px5gGCyFPLGGznUau3w8Hza+Bjj7ndjjlB0jaM6raoTQigNP8CMvzPQXR6osGqYUnuQaHy9ZD2WqoZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=Owx6ISEY; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="Owx6ISEY"
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BDpGME2696904;
	Wed, 11 Mar 2026 18:11:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pps0720; bh=VTRXI3mz6jIXOjfNPa6YKzNS9GwFRfykMnAF2
	k/Q13s=; b=Owx6ISEYMCf82iKIXQ1t4J40UvdovWyPrzSBumBLOgKCkp4YVnkku
	sBAUZJsq+/g07uGqmWHr3p4HKj2VFO0R+ZZ1DJv/xU52A42BPVWpgNd8qg6YtgSt
	hjoRjIpqRQ/Q5syMAO1oOMnvjfIBs+2bKDX6U9+gaQKkTp1o2OJdfGi3ZlbeQXiX
	QBlK2+/kN/Sn1A4JP0T+KihO3h8AXZu75xwe7alnck8oe3UefpWLtX9zQw8r0djD
	MZv2EAqwhNMLNgelU6Ze+kWMFeJ35cimr8B3IX3f0KX4vHIrMaQejCyYl1w2Ttmx
	pDStA+wTR/OEITOYDt5j5XIfILl0taHvQ==
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 4cu8ercx5j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 18:11:19 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id BCEF1801620;
	Wed, 11 Mar 2026 18:11:18 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 1C8ED811A4E;
	Wed, 11 Mar 2026 18:11:18 +0000 (UTC)
From: nick.hawkins@hpe.com
To: ulf.hansson@linaro.org, adrian.hunter@intel.com, jszhang@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Hawkins <nick.hawkins@hpe.com>
Subject: [PATCH v3 0/2] mmc: sdhci-of-dwcmshc: Add HPE GSC eMMC support
Date: Wed, 11 Mar 2026 13:11:10 -0500
Message-Id: <20260311181112.1700667-1-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: HD8DTFXXYhuEixiFSslx6ag1Hz0puev2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDE1MyBTYWx0ZWRfX4HL/38SqjArt
 EWTogNuaI4Kb0A/8qWMbxfZAkRMJ5I1AC+hY6qqJMfKLjoNc5iQD233LLbVzbbZKFcSj28Pxt/Y
 abuhI5elGnaPEQQR8gZ0RPntjV77X+TuJ+VyEe/4eGZbs+TTf8EbJnGCJJ2WEmRP7KDdfptteqY
 NpHKT8e5LXfMld+KKplheE2i7SVtAJIlP66jlwmS2IpfsLRm/gUCTZ1YUJqWu7scaa06PLwlQwY
 H81o42lBlhcfTFefER1CbSY75+95DW9A+Esssr6+w7SA0dfzrjYVK3lZVpIhPgpSr3DJBgSurVy
 9SwW2ljcwwAYHgmxM2o81h8eZOnz2tJfAGmBZKRnTbBVz7r3DbCb8ZA2ExxQfeCf255CY8/g+sQ
 qlxDeWW+gsxSN9BLcghMgWo5o2jqw33j6XmlB02KwZAiFP0cfmjSqvMZxpFsUSrfLfnHoztUg21
 JJE9+3DuBHcorRjnprg==
X-Authority-Analysis: v=2.4 cv=bdlmkePB c=1 sm=1 tr=0 ts=69b1b047 cx=c_pps
 a=A+SOMQ4XYIH4HgQ50p3F5Q==:117 a=A+SOMQ4XYIH4HgQ50p3F5Q==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22
 a=6_mrDcixewTG61oOsKN3:22 a=MvuuwTCpAAAA:8 a=XbkwoOjMWocvkfcq9GYA:9
X-Proofpoint-GUID: HD8DTFXXYhuEixiFSslx6ag1Hz0puev2
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 clxscore=1011
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603110153

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
clock, so the clocks/clock-names properties are constrained to a
single item for this compatible.

Patch 2 adds the HPE-specific driver code in sdhci-of-dwcmshc.c:

  * dwcmshc_hpe_set_clock(): SDHCI_CLOCK_CONTROL.freq_sel is wired to
    a clock mux on the GSC SoC, not a divider.  When running at
    200 MHz (HS200) freq_sel must be forced to 1 to select the correct
    high-frequency source.

  * dwcmshc_hpe_vendor_specific(): disables the command-conflict check
    and programs ATCTRL using existing AT_CTRL_* macros for reliable
    HS200 signal integrity on the GSC board topology.

  * dwcmshc_hpe_reset(): calls sdhci_reset(), re-applies vendor config,
    and unconditionally re-sets CARD_IS_EMMC.  The controller clears this
    bit on every reset; leaving it clear causes card-detect
    misidentification on the eMMC-only slot.

  * dwcmshc_hpe_set_uhs_signaling(): wraps dwcmshc_set_uhs_signaling()
    and unconditionally sets CARD_IS_EMMC for all timing modes.

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

Changes since v2:
  - Replaced raw ATCTRL magic value 0x021f0005 with existing AT_CTRL_*
    macros and FIELD_PREP(), as suggested by Shawn Lin.
  - Refactored dwcmshc_hpe_set_uhs_signaling() to wrap
    dwcmshc_set_uhs_signaling() instead of duplicating the body,
    as suggested by Shawn Lin.
  - Dropped redundant 'maxItems: 1' from clocks and clock-names in the
    dt-binding conditional block; the items list already implies the
    count (reported by dt-review-ci / dtschema).

Changes since v1:
  - Replaced the second reg entry for MSHCCS with an 'hpe,gxp-sysreg'
    syscon phandle + regmap access, as suggested by Conor Dooley.
  - Driver now uses syscon_regmap_lookup_by_phandle() and
    regmap_update_bits() instead of devm_platform_ioremap_resource().

Nick Hawkins (2):
  dt-bindings: mmc: snps,dwcmshc-sdhci: add HPE GSC dwcmshc compatible
  mmc: sdhci-of-dwcmshc: Add HPE GSC eMMC support

 .../bindings/mmc/snps,dwcmshc-sdhci.yaml      |  36 +++++
 drivers/mmc/host/sdhci-of-dwcmshc.c           | 149 ++++++++++++++++++
 2 files changed, 185 insertions(+)

-- 
2.34.1

