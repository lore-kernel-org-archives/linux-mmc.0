Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794933290;
	b=xymChJ9AhUxp+UlWhbzkv47ioJ5tyeqDKlnGqNTqquHedy//T22NoFTpcI3BmYf0CUzm
	 REBNi1wpGohRHxK7QyykjJEXZ7AaKyNo8qiwIooxUKIZL0/D66KhRKG89jnj739geeoom
	 cp+UCVf5mBcZAKkc9JXiOJ7x4v+JG5imZXzC4qpZvI0w3ozA0LFhQwl+t1FDjqfbnQsI3
	 clSXX+jz6Xln3hhIiRHvJQ1+xRIH/OOP41jSqDA6lXxdiGSJDx1KISqnVMGiqMwaU8uMU
	 VsDDgJL4sEZvfkQrZYmgyoTAOdnoCilqjaB5sSBC3Q5n7/1KiDODbk8DEOsLWsV6LFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794933290;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=0nLr92kUcJStZC2BCr+sdHppUBlRwS9fPEEDDTJn8Q8=;
	b=pHYffxhFNygln2jTEy+lHzD4PZB3OnjU+GVgD0dyQ6Isq7bXLul3T7AmP8U5gjAyv4ch
	 a/iD74lSbOqznSh7bU7z0oh0iQVgoVILZEpwNiivtjtV+fbX7hlSGf81xVzkx5IfeDT0o
	 Twcmd0JfndFkriKJKedh4CFKKLIHiaFb/2W8jRJATks/jmk+pz1Tqy6tuuBrXLTb3i4pY
	 VsEaJGqcm4OIxmPl5PqEAzF15hhT4XQl3fhi1wQOvzzkuNB63fizT8NLaRHeVyt6RoSb5
	 3K0huouDrVhV1PsiUyEUNAJt2PPhM9isUEwpqAzazdYIfFJTpdixvDC+h/0uLrXzYSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C4q3T7wT;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB1B606A31C
	for <linux-mmc@vger.kernel.org>; Tue, 17 Nov 2026 16:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BB1B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C4q3T7wT
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4a5506f09f5so382240f8f.0
        for <linux-mmc@vger.kernel.org>; Tue, 17 Nov 2026 08:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794933289; x=1795538089; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0nLr92kUcJStZC2BCr+sdHppUBlRwS9fPEEDDTJn8Q8=;
        b=C4q3T7wToBWaEWAHAaUkEgc7IXBfUPR9NnEL98/CNVERz5kG9TGeFB4fZqLgIAD70n
         JMRkTC3c7PdNLL2uD9l1LY3pZ1E1rCpTpHmq9HDCylbBUNSVqnoTOlHrwUUzYMPS94rZ
         uyCvWY8DWOancmBiHuWEanvDTdxe/lKOGFOTewYj2LNJPh9mggqU4h6LfuJc30qv2bjJ
         yudF6uYvmMaXLRPDXnIgAV0qDlcimx8Chb+Co+hViyJxovQQM6v1ciJDL98tcOJ/abKB
         OcnapyrtMkAWiSkbcXTzjiQCPc1F4J75s8j/feT9hdhyfLtx66BnrIMsTBet3DkogyC3
         2z3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794933289; x=1795538089;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0nLr92kUcJStZC2BCr+sdHppUBlRwS9fPEEDDTJn8Q8=;
        b=iIbQGNX4BCnz6eFFO9OAdsU0wh9PJfiL5RWplrvHNy9KWaoty+xzkCbHVhBRTuuyQO
         Gu5GVrhd+NQ/W+Myz+7Llq/RgQ/DjG48QvPt4csst9AUje31ck0L9DvHVc55lYpZKYma
         4yfPioNlm9iWzIAbtmJbJ1l3u/EdRnfK5cqR8/WWe6zVoArhya6dg89SJ1AsJlgsUG9G
         yeNbsm95h6d7E6ynIlFJvOr59XtXGOcZY1uF77FG6FnnEAWJV+ADRsBBzIeQIdB07NRG
         U90jAowNbR01ke15IdfhVbqA+bfvL6Qu1JmWwWNkAlaB9BIxfUDAbK+ckkEZDQQx0dWx
         aJrA==
X-Gm-Message-State: APuU4Z80t2TIm34cgmQHDWL+oxaCG6k/qcq1ixqM4KgEIHw4wrMLDZVd
	vp3ejaaDeDa42vsAmYd1N8Q0Gxso5LVt52d7uZEAU6rlE2lpZfrmL2tI5sGqLw==
X-Gm-Gg: AZFdTZdawbUiSajtrJFpEABwTNcLXTIPubbFZF7tsC7S+2u3VftaoHhaKbh5imi1cBO
	p0q5edIjP39d+zHoOMAbe5cjU83FdzTbjAwoVwXMltQFKIEXuYgwWaf8/wU11+H65dxayhfbDZ+
	WCYfh2XgmJEs4SqPl4fZwJUaBkcEvUic190Z8LLbuabveU34mbxlDN5MDWJhNjSWSz85z0yESRb
	HhkFfYdBZTcECeoCtBjfVv5N6fvLrpOBCnWSSWPxQEAcY53H2CdiPcPaPa9h7ByohxeowKXR0xA
	iV0h5Ue18SEnnDt5JW85FzSrSK7rP6r8ObHf99YUMkLmzQWkSezl7rsRIzYjiVp4eDQOztfJGJO
	HjQnqE2++JmhUVkTj9Y2kIqmshD6iCmkkWS5SJ8RHH2cSq6roPumAuCz+P9dMk8VKv6+cjHuVJP
	0kNN6cxQ4xlWJ7KTIEZb77U4B8+YZdl7X8yrDGvk29Kco9PuB7SJZbtNK9jWV3r8Z3WqTa1/Csb
	IeJfBKQYSsFHMIhJFU1RHC5VtrPNohlBgenUbVdq7GVH8B2gmCRn42x0rT2aOGGPXCB+UH7KbGV
	yYqTChGat2jc1iPiHM5oWdnYzPSo1wL4HVdYeoI9Y6ChQRKhs+V2ZchzgZqwbLPNeyKKj0SLz2S
	JlQZ1X+61L5o=
X-Received: by 2002:a05:6000:24c6:b0:491:273c:9649 with SMTP id ffacd0b85a97d-49c70b051dcmr32305652f8f.15.1794933288673;
        Tue, 17 Nov 2026 08:34:48 -0800 (PST)
Received: from [127.0.1.1] ([2a00:23c4:a702:d301:9260:9c28:f0f5:e091])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c6d079a2asm26672248f8f.16.2026.11.17.08.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 08:34:48 -0800 (PST)
From: Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v3 0/3] Add RZ/G3L HS400 support
Date: Tue, 17 Nov 2026 16:34:45 +0000
Message-Id: <20261117-sdhi_hs400-v3-0-b4659189db69@bp.renesas.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACWC/GoC/3XMywrCMBCF4VcpWZuSmfRmV76HiLTNxGRhWzISl
 NJ3Ny0Igrg8B/5vEUzBE4s2W0Sg6NlPYxr6kInBdeONpDdpC1RYAYCWbJy/Oi6UkqVVDZWoazy
 CSMEcyPrnjp0vaTvPjym8djvC9n6Y6puJIJUcyp6M0YCFak79nAcaiTvOh+kuNivi/x5Tb6gAW
 3e11Vr99Ou6vgGElEJJ6QAAAA==
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Ulf Hansson <ulfh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794933288; l=2081;
 i=biju.das.jz@bp.renesas.com; s=20261020; h=from:subject:message-id;
 bh=CBpGJ3J11Ge4CceUmYpikw5K8cAJ7APFU5cYhMUuhMo=;
 b=f1Ib0zXkvJbVhSIRi0rJXpTosKpULS2jRkUem/AewnONbvsTd9To1UD27al99sVL0I+cpOg/M
 8av6eBULDyADkZjoSUf7RzLMME6/kIjvommvFAoXxgYjxWu0Fa2VppO
X-Developer-Key: i=biju.das.jz@bp.renesas.com; a=ed25519;
 pk=yzD2T1OLS3lEYflbk64xhLlxhk75lZ+NoOtkTOqrlVw=

RZ/G3L SDHI IP support HS400 and HS400 ES mode. This patch
series aims to add support for HS400 mode. HS400 ES mode
support will be added later.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
Changes in v3:
- Clear hs400_active/hs400_clk in renesas_sdhi_reset() after a HW reset.
- Disable SCLKEN before leaving HS400 in renesas_sdhi_set_clock() to
  avoid transiently enabling the clock with stale divider settings.
- Drop the ios.timing check, which bypassed the divider before HS400
  was enabled in hardware and halved the clock; hs400_clk now follows
  hs400_active and the clock is reprogrammed in hs400_complete().
- Link to v2: https://lore.kernel.org/r/20261116-sdhi_hs400-v2-0-de41f7a7f330@bp.renesas.com

Changes in v2:
- Added fixes tag for patch 1
- Using ios.timing to decide whether the HS400 divider restriction applies
  is wrong: mmc_hs400_to_hs200() lowers the clock while ios.timing is still
  HS400 and then walks through DDR52/HS/HS200 before prepare_hs400_tuning()
  clears the HS400 bits, so the divider could stay at 200 MHz or prohibited
  non-zero dividers could be programmed while HS400 is still enabled. So
  tracking HS400 hardware state for RZ/G3L clock programming using 2
  variables hs400_active and hs400_clk in struct renesas_sdhi.
- Link to v1: https://lore.kernel.org/r/20261116-sdhi_hs400-v1-0-c5bedd312408@bp.renesas.com

---
Biju Das (3):
      mmc: renesas_sdhi: Save and restore IOVS across suspend/resume
      mmc: renesas_sdhi: Make HS400 OSEL bit configurable per SoC
      mmc: renesas_sdhi: Add RZ/G3L HS400 support

 drivers/mmc/host/renesas_sdhi.h               |   5 ++
 drivers/mmc/host/renesas_sdhi_core.c          | 111 +++++++++++++++++++++++---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |   5 +-
 include/linux/platform_data/tmio.h            |   4 +
 4 files changed, 113 insertions(+), 12 deletions(-)
---
base-commit: 522b5bdb42c730db0269a384bf5a2501ecb21e8d
change-id: 20261113-sdhi_hs400-5f08e5237291

Best regards,
-- 
Biju Das <biju.das.jz@bp.renesas.com>

