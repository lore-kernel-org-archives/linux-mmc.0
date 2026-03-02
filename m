Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B6B375ACF;
	Mon,  2 Mar 2026 19:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772478137; cv=none; b=TvY6LPhQCJ4YiejKST77tl0JZVv4C0akeHot8dC41fDJoGMpH1BtQBkh3IAjDkbey6zFZXXzk2yBqx+tCIsbSHr9Rr5X2eVkLyIUiLarxdDVlDtORFEOmK7kGfWcm/x1Nwj1JRtLHwaaRw7/NXiK0cv0Ayy6Ge5CeHSWnSib6Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772478137; c=relaxed/simple;
	bh=h1DpCNtVMnRT40PGJ3gi42b//b5erXZXf7rZxjPuArE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A4kjEj5BWIM5m1euXtUy601wiul4MYWBCdlxM8BxqiI/uPLyHwaKayKYaCqWkwiLRvROhE7EafyHNJctQ7jeyr7g5N55Cw7iSDfZLHyMnc3gtdCz6Akmbq49o3Seq5P4yi0ZNfaGqeSVxeVs4TESI/0BlYAniPFcVdSch9FFBv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=nBsVFiYZ; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="nBsVFiYZ"
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622I0eNh3767455;
	Mon, 2 Mar 2026 19:02:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pps0720; bh=0V3RxFXWqt3/Pv+f5P3ntZQEfRSFLi6w+CTcB
	mtmEFc=; b=nBsVFiYZ90qob2C4bG4LJtfK86UIJ+81es9qqbP73hIFg6AZWM4TJ
	NJWkbyahcf66Hi724yKXO+JKq8G5I8FCHLpzNzHMsalbwVMKPtucdFBM8ty+XKH/
	2jore51wYtkBDSs+bK7y1w/LJSnCNxjLCNwgobguFuP+yb9RHkKoqcxIAu5FUWNi
	T/tgb0auDb7T0+V3fIoFFTXF8FVJLQRWTq9ZHSeQ3jJNCNR8HNvX3Mgxg5Wq0oQv
	VeEHuavdqaDa2ONl5ukQYvpz9TNjhcTYoOPFvHlbot0pzeANyma4ZKj8GcfvkImj
	jJQZuKhu9K/cQ2YlVO4KgFXlulce6sDoQ==
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 4cnff18yx8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 19:02:02 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 1B64DB4288;
	Mon,  2 Mar 2026 19:02:02 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id A3E2481AD37;
	Mon,  2 Mar 2026 19:02:01 +0000 (UTC)
From: nick.hawkins@hpe.com
To: ulf.hansson@linaro.org, adrian.hunter@intel.com, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: jszhang@kernel.org, nick.hawkins@hpe.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] mmc: sdhci-of-dwcmshc: Add HPE GSC eMMC support
Date: Mon,  2 Mar 2026 13:01:39 -0600
Message-Id: <20260302190141.1481298-1-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDE0OCBTYWx0ZWRfXw7b5Fjl/ttQT
 7L3Ejl6lJrZz8x8JZuZmCeVQs3hxJ01s7gG6/D+tElqZzCerR/Pf15vu9b02ScE04f2coh2+wcs
 NY6l84wK+Rl3w1h8cc07/Ow0LkNR9TioODY6HALQLQZ8QizdZxuZ0dcqttPRc/htZNafMHZsraM
 W8OcZq75R9FcuB4HKZUKwQYtOtcP1Urk+0f3SpLcNhV1B3wy9a7DcBqfP+gGHERkzRJagHSR+vm
 hfkv/FUnCpFAdvyeIs+McQxzz6BNC2SPT8vButu4PzTeg/D3kygpq/XMemNlodxwTGiPCBvW1n4
 0KNr2PhSTgZd+hPmhqfS7tY0Za9nPqfVFqap5QIU4yomFfEY943NqbJ/ftW2qL+mZcErnL5syNM
 L5WwxbSp6yIa/tPiAe3lEHpW1rTkFgvmcqOze+f0PYoVlbswvWbUoetF/mQmKVzUxkOnqcRgmzx
 UyQH3y67GrZn3FM+N4A==
X-Authority-Analysis: v=2.4 cv=NPvYOk6g c=1 sm=1 tr=0 ts=69a5deaa cx=c_pps
 a=5jkVtQsCUlC8zk5UhkBgHg==:117 a=5jkVtQsCUlC8zk5UhkBgHg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22
 a=_ZmgHqWwjZUDpi_pur5s:22 a=MvuuwTCpAAAA:8 a=7CkxuHwdN_sW70-Q_JcA:9
X-Proofpoint-GUID: 57KN_tZxTOhSlBSYQN7WH7a3nCchF9Xl
X-Proofpoint-ORIG-GUID: 57KN_tZxTOhSlBSYQN7WH7a3nCchF9Xl
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_04,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1011 malwarescore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020148

From: Nick Hawkins <nick.hawkins@hpe.com>

The HPE GSC is an ARM64 (Cortex-A53) BMC SoC used on HPE ProLiant
servers.  Its eMMC controller is based on the DesignWare Cores MSHC IP
(snps,dwcmshc) but requires a small set of platform-specific quirks
that cannot be expressed through the existing generic dwcmshc code
paths.

This series adds support for the 'hpe,gsc-dwcmshc' compatible:

Patch 1 extends the snps,dwcmshc-sdhci.yaml binding to document the
new compatible and the mandatory second reg entry for MSHCCS
(DTS reg[1]).  The HPE GSC exposes only a single
'core' clock, so the clocks/clock-names properties are constrained
to maxItems: 1 for this compatible.

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

  * dwcmshc_hpe_gsc_init(): maps MSHCCS from DTS reg[1], sets
    SCGSyncDis (BIT(18)) to allow the HS200 RX delay lines to settle
    while the card clock is stopped, enables SDHCI v4 mode.

  * sdhci_dwcmshc_hpe_gsc_pdata sets SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN
    (base clock not in capabilities) and SDHCI_QUIRK2_PRESET_VALUE_BROKEN
    (preset-value registers not populated in GSC ROM).

All new symbols are exclusively selected by the 'hpe,gsc-dwcmshc' OF
match entry.  No existing platform (Rockchip, T-Head, sg2042, Sophgo,
etc.) has any code path change.

Note: the DTS node for 'hpe,gsc-dwcmshc' will be submitted separately
as part of the HPE GSC base platform series (arch/arm64/boot/dts/hpe/).

Changes since RFC: first formal submission.

Nick Hawkins (2):
  dt-bindings: mmc: snps,dwcmshc-sdhci: add HPE GSC dwcmshc compatible
  mmc: sdhci-of-dwcmshc: Add HPE GSC eMMC support

 .../bindings/mmc/snps,dwcmshc-sdhci.yaml      |  43 ++++-
 drivers/mmc/host/sdhci-of-dwcmshc.c           | 166 ++++++++++++++++++
 2 files changed, 208 insertions(+), 1 deletion(-)


base-commit: 7dff99b354601dd01829e1511711846e04340a69
-- 
2.34.1

