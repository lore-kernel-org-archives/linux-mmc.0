Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D6D3B71B8
	for <linux-mmc@vger.kernel.org>; Thu,  9 Jul 2026 19:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783625361; cv=none; b=TlcYS/Law4L8bp/6zij+hrq19RG3/2XaZS7WUBj3cyqUeUZgxMmXSvGjM5VLz+IBrPJlLbjVksa9V2nJ08aMfBVxROeaE98IiZMETI9xOkrLWnJawrVu993eT77sGCEcQYe4ulg5es7XxmufLC+JlTXXdEHgpV2idfGB876/ONg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783625361; c=relaxed/simple;
	bh=dPCjt2VVOrgeOOiej3J1U81Vg/oNhi0nOgkXTTXIb8M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a5x5pbrffeLtxqgLuZvKmhAi/SIKk9a2oBhhvJ7Qe2hryn1F29mv7mkixURaSJCGK91cLEdpUlSq8IcoBMZgtHtghun8GLITgjxqBR3ZDmsyYI0qEpBF1t8nplVGPeSXbexOdn7BJV8UCfR456nfNILWTfw6Q+PtjCQdQFV4tmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbmW8maq; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbmW8maq"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493ece78b0cso1502275e9.0
        for <linux-mmc@vger.kernel.org>; Thu, 09 Jul 2026 12:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783625358; x=1784230158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iJQOEk5yqB+dE9SiEhcvYRxkNhnNp9MLYOiszo4g7GA=;
        b=SbmW8maqe6RrhgpI1e5+/YVHoWVT6bJS1yzE17CVYAatNWNSTvVGo8jQj7HV16ezzp
         2/iE0NlcPsP5qF4gAXdCpjQLe1tN4j2RutsWj6ZnzBl8wPdBTwqa82SURrq41I9UDuBV
         dDlWQVhlmpBCqE7Es/3Py8uAsOcfg8WQUUhzN1rMmfgFNsO0uxEP6gYU4YksJi8KBKpk
         V71oiAedIENv1hFGDQYTzCYl6T2r8IDeHOVnM+m8uV2zKMvLhybd56WfZf4nrHycRIWs
         zdDIXlmF7OiSlYUhvIN+J1ohyqUGlYblQMFQEpzl9GHFeDefRkKi6qzd/qo+bHbsI8ZP
         MOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783625358; x=1784230158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iJQOEk5yqB+dE9SiEhcvYRxkNhnNp9MLYOiszo4g7GA=;
        b=IlG+8eqDiH5Kie6AyXeXNaHd/CG6OwXuXCBIF6REPbqcAHyk2jWZsmvsODeFKfeSqr
         7aojPUKk+LWr+/etipjzKw3lmj6rgd02MVigO1V9c5STE/ljg4Lz+XC+DMIQVXjLRLnG
         Gan9dZbp2cjYCFPLbMb5Y/beCol1EcSfRmCzDzPbMoQWPOtXDmpYz4HcGp4oJ+6YL+r+
         43kHxppihECz5lcc8kWHHfP0pOxNMHcFVcCMS22NcYBRBijvMSDSLGRtkBGJp4odrflz
         MhzrG3URoyPWdO3pCsWWZ0YUWYLurapSOr3TUzSLKP++WLKxxIpwmSkVOVwrLh6ToOEi
         mSrg==
X-Forwarded-Encrypted: i=1; AHgh+RrChAzGeLn+5KB2MECr6TKf2UG6stAlc7uNfozfWrwPG8Exn3+SxPRGVRDLfVRn+mQIRRMAZa47ymM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMaKQFC7RIn0AFW3PYroxfNkqEzJdcul0vYl3OXj6cn4tFoI+l
	0wkF+bcFuNARTvE80WELzwJOYiDCL7XEj6n15fO2YZ1QRFH+yxBUKhTMVCNN6ly7
X-Gm-Gg: AfdE7cmzJ1C178tqBPOrgOdd8yIK3hhs7j97OtBc6my6fREukjRka1FYnXOGKDBsiEJ
	WshDTgOjlpsu2gretvxMYJyN0VrBT4W3yEeyWNIuntLUkAhvGnFRYxpfhNDSN8vdM8GHDAEbNbW
	vwiPP2cUVHFCvFgcgQH0PaW2zpTP859IrVgf0cjla7KaKnglBXbbRoZ0eIsSC0TuoD91l7Jvl/O
	evETCpFhZPIOqYksTsCkekN5wNNXpquvU52t7G9LI1AV9C/vOWoWojLFCuAMxnsfBocoZSN3Z+s
	P7177RuI6JPnmhBJDoqr3dOoLAsUs00D/EvxNUBO3wtDQOShsbTWtlTjlJuUPvNLMDC74n6BTNN
	ZRMqv+PfHH1P7+MG9rTILqvHLQyvoEvYIXeHFUbnXEIdWV6KtVd6CbWSEJcyrGG4jEA5JRqHLDM
	vvdQt3GfgLVfuFn4xGPP5k
X-Received: by 2002:a05:600c:4e93:b0:490:e5c1:b8b9 with SMTP id 5b1f17b1804b1-493e67f7c3emr78360215e9.0.1783625358090;
        Thu, 09 Jul 2026 12:29:18 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:8fb6:1d85:3dc1:42ab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6ccdbbsm84366045e9.3.2026.07.09.12.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 12:29:17 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v19 00/12] Add Renesas RZ/G3L SD/eMMC support
Date: Thu,  9 Jul 2026 20:28:57 +0100
Message-ID: <20260709192916.630794-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Hi All,

RZ/G3L SoC has:

Channel 0 supports SD and eMMC (including HS400/HS400ES).
Channel 1 supports SD and eMMC (except for HS400).
Channel 2 supports SD.

The SoC supports a maximum frequency of 150 MHz. The SD0 interface does
not support IOVS and PWEN in the SDHI register (no internal regulator),
unlike SD1 and SD2. It has an internal divider for all modes except HS400.
It also has a 2048-bit divider compared to 512 on others. Moreover
RZ/G3L supports HS400 enhanced strobe mode.

v18->v19:
 * Updated commit description for patch#1,#2,#6,#8,#11 and #12
 * Updated clock and reset description with AXI master and AXI slave
 * Added else condition for reset and reset-names.
 * Renamed aclk->aclkm and reordered the axi clocks similar to resets.
 * Retained the tag got binding patch as the changes are trivial.
 * Fixed the clk_mask for non-DT platforms.
 * Fixed max-divider setting for non-DT platforms.
 * Replaced the magic number '9' with ilog2 function in
   renesas_sdhi_clk_enable().
 * Dropped divider variable from struct renesas_sdhi.
 * Updated renesas_sdhi_clk_update() to return rate for HS400 mode
   and non HS400 mode(uses 1/2 internal divider).
 * Updated handling for clk divider.
 * Renamed TMIO_MMC_HWADJ2->TMIO_MMC_HWADJ to make it generic for
   hardware tuning delays
 * Dropped duplicate SH_MOBILE_SDHI_SCC_TMPPORT2 macro
 * Updated suspend/resume with scoped runtime calls in suspend.
 * Fixed extra space in HS400MODE2 comment block.
 * Updated the comment HS400mode2->HS400MODE2.
 * Dropped the updation of clk handling as it is taken care in
   previous patches.
 * HS400ES support is enabled based on of_data.
 * Fixed the space in HS400ES comment block.

v17->v18:
 * Collected tag
 * Merged patch #4 and #5 and updated commit description
 * Annotated the empty sentinel entries in the OF match tables with a
   "Sentinel." comment for clarity.
 * Retained the tag as it is a trivial cleanup.
 * New patches drop struct renesas_sdhi_hw_info, instead using
   renesas_sdhi_of_data and tmio_mmc_data.
 * Dropped clk, pinctrl, SoC, and board dtsi from this patch series;
   will send later.
v1->v17:
 * Collected tag for binding patch.
 * Resending the series as there is an issue with patch threading from
   patch #14.

Biju Das (12):
  dt-bindings: mmc: renesas,sdhi: Document RZ/G3L (r9a08g046) SoC
  mmc: renesas_sdhi: Clean up whitespace and add OF table sentinels
  mmc: renesas_sdhi: Add clk_mask field to support flexible clock
    divider widths
  mmc: renesas_sdhi: Add max_divider field to support SoC-specific clock
    ranges
  mmc: renesas_sdhi: Add tuning delay support for RZ/G2L
  mmc: renesas_sdhi: Add TMIO_MMC_INTERNAL_DIVIDER flag
  mmc: renesas_sdhi: Add optional axis/axim reset controls
  mmc: renesas_sdhi: Add RZ/G3L SDHI support
  mmc: renesas_sdhi: Save and restore IOVS across suspend/resume
  mmc: renesas_sdhi: Make HS400 OSEL bit configurable per SoC
  mmc: renesas_sdhi: Add RZ/G3L HS400 support
  mmc: renesas_sdhi: Add HS400 enhanced strobe support for RZ/G3L

 .../devicetree/bindings/mmc/renesas,sdhi.yaml | 108 ++++++--
 drivers/mmc/host/renesas_sdhi.h               |  11 +-
 drivers/mmc/host/renesas_sdhi_core.c          | 250 ++++++++++++++----
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  73 ++++-
 drivers/mmc/host/renesas_sdhi_sys_dmac.c      |  12 +-
 include/linux/platform_data/tmio.h            |  18 ++
 6 files changed, 385 insertions(+), 87 deletions(-)

-- 
2.43.0

