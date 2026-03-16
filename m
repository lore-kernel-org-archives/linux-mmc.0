Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F5B308F33;
	Mon, 16 Mar 2026 15:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773673313; cv=none; b=EmHVXHhdkImhmokCHfn2p9Zp4dc26qSpw+tT/RAnQ/gXCIsMd88v+cK4eAbpOMYWYmZa7FuIWOabH1SNjhBe08Q/MR+krNwM+gSGfEZ3zlal3Qk8OJS3+sWAFN/2kvhC7N4lJSO/kDO3ubk+AJjSM1OKnitcMKQdAfKq0g3cxhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773673313; c=relaxed/simple;
	bh=RL+ZOJqcvCJH1r3lLXUyULq7CwZTPvTNjoFQ/BBDC+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sp0E7krsD1HfalXy72ydNZLEm6b/XRPOTc2mxxyx7tciPUR0YqB1YFc0pcgH+HNyF4r/zenPSB7C+AHo0YI+LeC+Z+3YoJXWMhwoPBEcWSEwsLfAJofFbwD3EroftkTRzrNcPOo1crTIP9uJGFYHjZUQPDz15lhznzlhhAX36+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=LoEQl6vs; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="LoEQl6vs"
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GBWNLx2523952;
	Mon, 16 Mar 2026 15:01:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pps0720; bh=Y3Wo3VNm513eLsOg5A9QsAMgkhaH/xmoK0sES
	QoTcBU=; b=LoEQl6vs4fF07wWSuIEpher2Vp4cp1Ko5GWGsjDfNp8o91P15w0lb
	mLfh8d8XcObYeVtPCxBWt6deoa/Hx2Qe6s29cn28jtGxHx3pTnao08cKg/N2qOrT
	dBAioBhaIf/R4B56jZynY6iM+jQWRbYTobpK0N/3sPdoc0wXJfI0J0HZO3Za6hq/
	n19c0+DwcCOeBkFdS0ktJfBadWiQTA5N1v2NsN4Bqby+VLTzA+szvUn8HB34cSLF
	obhGj8OswwxBqxwH+zzsvZ3s04DGbSztW1n2S7Wr9wMqkrTF3E8STj4rn5cu2FCu
	Mk1SU9Dw0MzrDhwS6yCn/j1hNODVsItFg==
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4cxeescst0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 15:01:20 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 7A61FD279;
	Mon, 16 Mar 2026 15:01:20 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.39])
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id D429F8097F2;
	Mon, 16 Mar 2026 15:01:19 +0000 (UTC)
From: nick.hawkins@hpe.com
To: ulf.hansson@linaro.org, adrian.hunter@intel.com, jszhang@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Hawkins <nick.hawkins@hpe.com>
Subject: [PATCH v4 0/2] mmc: sdhci-of-dwcmshc: Add HPE GSC eMMC support
Date: Mon, 16 Mar 2026 10:01:13 -0500
Message-Id: <20260316150115.2616827-1-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=IMMPywvG c=1 sm=1 tr=0 ts=69b81b40 cx=c_pps
 a=5jkVtQsCUlC8zk5UhkBgHg==:117 a=5jkVtQsCUlC8zk5UhkBgHg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22
 a=ModqzXLkJJ0tFyq98apW:22 a=MvuuwTCpAAAA:8 a=Zs-rDJYs6Nww5mYDgI0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDExMiBTYWx0ZWRfX6MON25x98FJE
 0Svhl7dqVfM3UbSrltKNpBnCMMoC8pfcqH2nzC8tiwjxE0sCnyjflmuWCqQ2PV2JtUHP1T+JWZ5
 FwznwekYzZ5ktXt/XO+pjgAROUgC5T67KXMVS0UNeqxgHi76LNT1y9ULmXKakni7iqOnVf4LUUo
 q4cTCn8U/9c0GjSIv9/47Xf8G7HPcFqUbT01PpNPY0oiWeHVG/jfYnmr0GokKl741lkysaPJPrS
 yc0MPZSc8ULpKYUzOu/s50tr7WxWdEhJUMt4780u/yPr297I6RTeKHw5ZjWITDti1jK1HgXeuCg
 JcYssO1ZLodsvpEAgugRT7R+PM+iNBySHTOC8aLCNGTxL9Zs04lSTzbOakUk8JFD65yKErVHK0/
 1eocLqI2B7CEzjOB/d2a4JTLBHF9VYWA0r4dquEYl0e9tCr5q3YnD45/2jhwAFL37SF3qWrb9Fv
 +o+7YZUowrrt3TnsQfA==
X-Proofpoint-ORIG-GUID: 0GtWcHD30EZTbTDRkTn30J8hzeXE-O7y
X-Proofpoint-GUID: 0GtWcHD30EZTbTDRkTn30J8hzeXE-O7y
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160112

From: Nick Hawkins <nick.hawkins@hpe.com>

The HPE GSC is an ARM64 (Cortex-A53) BMC SoC used on HPE ProLiant
servers.  Its eMMC controller is based on the DesignWare Cores MSHC IP
(snps,dwcmshc) but requires a small set of platform-specific quirks
that cannot be expressed through the existing generic dwcmshc code
paths.

This series adds support for the 'hpe,gsc-dwcmshc' compatible:

Patch 1 extends the snps,dwcmshc-sdhci.yaml binding to document the
new compatible and the mandatory 'hpe,gxp-sysreg' syscon phandle
(with register offset argument) for MSHCCS register access.  The HPE
GSC exposes only a single 'core' clock, so the clocks/clock-names
properties are constrained to a single item for this compatible.

Patch 2 adds the HPE-specific driver code in sdhci-of-dwcmshc.c:

  * dwcmshc_hpe_set_clock(): SDHCI_CLOCK_CONTROL.freq_sel is wired to
    a clock mux on the GSC SoC, not a divider.  When running at
    200 MHz (HS200) freq_sel must be forced to 1 to select the correct
    high-frequency source.

  * dwcmshc_hpe_vendor_specific(): disables the command-conflict check
    and programs ATCTRL using existing AT_CTRL_* macros for reliable
    HS200 signal integrity on the GSC board topology.

  * dwcmshc_hpe_set_emmc(): helper that unconditionally sets
    DWCMSHC_CARD_IS_EMMC.  Called from both the reset and
    UHS-signaling paths.

  * dwcmshc_hpe_reset(): calls dwcmshc_reset(), re-applies vendor
    config, and calls dwcmshc_hpe_set_emmc().  The controller clears
    this bit on every reset; leaving it clear causes card-detect
    misidentification on the eMMC-only slot.

  * dwcmshc_hpe_set_uhs_signaling(): wraps dwcmshc_set_uhs_signaling()
    and calls dwcmshc_hpe_set_emmc() for all timing modes.

  * dwcmshc_hpe_gsc_init(): obtains the SoC register block and MSHCCS
    offset via the 'hpe,gxp-sysreg' syscon phandle argument and sets
    SCGSyncDis (BIT(18)) in MSHCCS to allow the HS200 RX delay lines
    to settle while the card clock is stopped.  Enables SDHCI v4 mode.

  * sdhci_dwcmshc_hpe_gsc_pdata sets SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN
    (base clock not in capabilities) and SDHCI_QUIRK2_PRESET_VALUE_BROKEN
    (preset-value registers not populated in GSC ROM).

All new symbols are exclusively selected by the 'hpe,gsc-dwcmshc' OF
match entry.  No existing platform (Rockchip, T-Head, sg2042, Sophgo,
etc.) has any code path change.

Note: the DTS node for 'hpe,gsc-dwcmshc' will be submitted separately
as part of the HPE GSC base platform series (arch/arm64/boot/dts/hpe/).

Changes since v3:
  - dt-binding: Changed 'hpe,gxp-sysreg' from a bare phandle to a
    phandle-array with register offset argument, as suggested by
    Krzysztof Kozlowski.
  - dt-binding: Added else clause to disallow 'hpe,gxp-sysreg' for
    non-HPE compatibles, as suggested by Krzysztof Kozlowski.
  - dt-binding: Dropped the third example node; two are sufficient,
    as noted by Krzysztof Kozlowski.
  - Driver: Fixed multi-line comment to use the standard block comment
    style used in this file (opening '/*' on its own line), as noted
    by Adrian Hunter.
  - Driver: Added DWCMSHC_HOST_CTRL3_CMD_CONFLICT define for the
    previously bare BIT(0), as suggested by Adrian Hunter.
  - Driver: Extracted the CARD_IS_EMMC read-modify-write into a
    dwcmshc_hpe_set_emmc() helper, called from both
    dwcmshc_hpe_reset() and dwcmshc_hpe_set_uhs_signaling(), as
    suggested by Adrian Hunter.
  - Driver: Fixed regmap_update_bits() argument alignment, as noted
    by Adrian Hunter.
  - Driver: Moved HPE_GSC_MSHCCS_SCGSYNCDIS macro to the top-level
    defines section, as suggested by Shawn Lin.
  - Driver: Switched from syscon_regmap_lookup_by_phandle() with
    hardcoded offset to syscon_regmap_lookup_by_phandle_args() to
    read the MSHCCS offset from the DT phandle argument.

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

 .../bindings/mmc/snps,dwcmshc-sdhci.yaml      |  32 ++++
 drivers/mmc/host/sdhci-of-dwcmshc.c           | 147 ++++++++++++++++++
 2 files changed, 179 insertions(+)

-- 
2.34.1

