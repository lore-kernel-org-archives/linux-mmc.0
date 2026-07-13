Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEFC34C9A6
	for <linux-mmc@vger.kernel.org>; Mon, 13 Jul 2026 17:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783965126; cv=none; b=e3QnEMtODZSnDE3ekJkbi1Sp2WYN9mmK+0hRrzjzbi2yB9iQFDgV7+RzoxOzgyMVMmiTFpv/eoz/BQwPy+fRpF4Q9dIHZ43kXW73i2hk+ofx/QfDyDMgaQrYtVFA+JF07mG9l2doZQoEiblWTcBb9dIxaZemtIqoySWuedRqOWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783965126; c=relaxed/simple;
	bh=tqFTum8xzoiTwzEIEq11HF/yCjbkDK04uQ9G8LptZfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MqUk2y+bBj7pQhME/s0j//eMBA/DWsFbOpmTTBh1GSZ8fES9EdDbuenaQTI/ynL7WrGcYfRocI5kRnCo5s2Wj5XU9YuAUGrBeGAt2nyLHHRC12qGvtf0DWmHZPFp7b+nmzySK543t1yNs53d47osdIGMf0h0zyFE4FsN9EXIMUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBF+qj9g; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBF+qj9g"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-472326ca506so2810181f8f.2
        for <linux-mmc@vger.kernel.org>; Mon, 13 Jul 2026 10:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783965123; x=1784569923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pAOIXtxwq93qyBcSiXjj47sdRqztMqiVwZYz/1dkMGk=;
        b=KBF+qj9gyEsEzMPO1zfCme4Ao6+6LyyL5XcDxpva+3Ax72ZhHGQTWG56R37UpV1Tmc
         mKyP0A9Y6l4MBHKievJUYhaDsM86wWKjqg1k9f4hwEGfXiKHbyoIxifQ7qBhstpFx5Bs
         quWPYlR0ovkeUzZBctiOIRZEFPYK/b1ryNlyk3oJ25tk0hJR8fEl3BT9UTevbanLeQiL
         v34Mhz6mJwSDQ7pCMjtnTpQZSGLb13i1xnZHuRmTSmEkQTQ0GDM86S9YMyK41YSj+Brb
         7SHmrc5X/mBJGGEcJ1r2o6Lmkbn6r4Gc6iFI7LyjxnnKnm7B4ZctaAKdIIy43TxFcnZA
         uEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783965123; x=1784569923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pAOIXtxwq93qyBcSiXjj47sdRqztMqiVwZYz/1dkMGk=;
        b=ptaX3MYVzpC2V1LTe5eGOGRKfF0mh+RomIvF1YK7876YK2I9Cks/byh98UfkVEICnE
         KED8pBMX9xsHUOFb5/QFQubuaRimef+bGfME9ygdzxqBEwwHJBYnJXTEmqbngvFu5kXd
         IwjBWgIREHR/mXCb6A4wTnfqcy6DK91evABQsJsQsICrxTw8tJvb6qGrgptZV68NEsSR
         0UcoRY0kMshELNlKyPzcdwNMJ8NhwcphMLEVEAOMROLVkNFuiRPWCshZ6G1EZ+WCfT4i
         MXw+Y6uNF2uVC56zMoW6nM4gG29XQWdo3I1LuSZqrnrrge2pamLjfXnOtfflXG/tbhLc
         QVUw==
X-Forwarded-Encrypted: i=1; AHgh+RoruQWhqgpIVbAmkJPcQjSej00GrOU8KyaM3vXyKfw0wdBCLS8Q5PCyNJAF/DrmfJ+C1eH1iUenu1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YypKbiXvRFI9Dw0ooVzAQiWNZPyB5VODOrUm6PqSpxvPOwaikjG
	HAvSAjjbkbfqfDpT29l7yE+lObhvYPVCeH1ATXVe8vK7+eMOYSGgpZec
X-Gm-Gg: AfdE7cn5+a0SVSakDhw5ZthF5+Kt04UUyW4PWIpjl5o2WHb1yzKdcuMyR8+X8W/Wl7T
	bgXI0VxodFc8CBk4rCUGLz9f6ZeEtE1ZhAwPH4ivjyaGH2uT35Myg8QgdyrBOM8lBm4+IZlHbaN
	IhFBNHpkNyf4MljFLTDcTW2iNab1qAxMGj64dGnvB0EqGSOIPZYJTED5uagq24hhONpaJRPyNtS
	pH4gtTJcpnsF/Oh1FNGDzTaatgZJ260v55KGhNejFXkFJqX11+O8J3Kyo7jVg7dJUFbSu+a+ByV
	3sFLcvPvqXjP+lmJ+/STDjZygsYhWBvev7unWcVUrFRXB1FoNhLxbenXtXEvzXKaRK5bEkH6KTu
	tK8BF+WF04gmJ6SbRcXfV9tliCmoRrflCnmtg9L3e+vhI3zLYCdGsTyfmKqatELXu9ij2weGbjd
	MeHLmnwKBatbpnLxPC2F0XJP5KSkLSWoCT7rvI5g==
X-Received: by 2002:adf:f74c:0:b0:46d:d5db:98 with SMTP id ffacd0b85a97d-47f46386edcmr630296f8f.44.1783965122623;
        Mon, 13 Jul 2026 10:52:02 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:c899:4fec:2bdb:b719])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464d6fa7sm1011037f8f.37.2026.07.13.10.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 10:52:02 -0700 (PDT)
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
Subject: [PATCH v20 00/12] Add Renesas RZ/G3L SD/eMMC support
Date: Mon, 13 Jul 2026 18:51:41 +0100
Message-ID: <20260713175159.138334-1-biju.das.jz@bp.renesas.com>
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

v19->v20:
 * Replaced the check mmd->clk_mask with mmc_data->clk_mask and moved
   the code after assignment of variable mmd, this ensures assigning
   the default values for non-DT platforms and DT platforms with no
   device data.
 * Replaced the check mmd->max_divider with mmc_data->max_divider and
   moved the code after assignment of variable mmd, this ensures
   assigning the default values for non-DT platforms and DT platforms with
   no device data.
 * Fixed the ordering of resets in suspend/resume paths.
 * Added bitfield.h header file.
 * Reworked on renesas_sdhi_set_clock() to handle the 11-bit divider
   case and the 32-bit register write.
 * Updated resume() with scoped PM runtime call.
 * SD_CLK_CTRL clk enable turned off before updating SCC_CKSEL_DTSEL
   register.
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

 .../devicetree/bindings/mmc/renesas,sdhi.yaml | 108 +++++--
 drivers/mmc/host/renesas_sdhi.h               |  11 +-
 drivers/mmc/host/renesas_sdhi_core.c          | 274 ++++++++++++++----
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  73 ++++-
 drivers/mmc/host/renesas_sdhi_sys_dmac.c      |  12 +-
 include/linux/platform_data/tmio.h            |  18 ++
 6 files changed, 408 insertions(+), 88 deletions(-)

-- 
2.43.0

