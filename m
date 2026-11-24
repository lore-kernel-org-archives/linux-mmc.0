Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795537883;
	b=MIJk2CpisEm8tzd56hBJbhP/qedBQtlGqYqd2iTVadfIwiSG91+L9UW9D3lRwqLYqb5p
	 sM/7oxuJK7oViXs14CAf9Xgr3ZXKVhuNyMssCSbPdTfPCWjVEEIeCZLmT68i5+rHNWIzS
	 jUcmRMoEN27Q4LQIS8bAHjTuhxvP8yoNWuZyPlEBejHq3oxN8JUw9My+NddJOz6uifVXf
	 +Ye9pjCF0AZ2rKk/+zIsqdnIH4YZPEPqWaSw4kCbqw6WmjJOWzZsxkjwCrmCmzVUrwwEw
	 /hQ2Qh78VQC/79KQYor+DrrF1Cq8NCHa9ccfvdpqz9vKtMoKPc26WpymHZMs7mKQeYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795537883;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=oRL5aTXHyHFRAfz4KwgNvuAkNPsd3FsBbrJQRIQaKIs=;
	b=egBWVBNTufneaAfViMhdXfV8senzRxCeSrpQesd7obfRlCxqA7l7JL+GLicMJK2m8A9m
	 KJ6K13krx6JHIIm33cA1ScpCXPeneyVDTuFgmP1uGUI0nM/B8fuzBkfHhp7cHzeAmPdZd
	 kK4bUohg47DK+GFTzKJx0r7Q1wrgy60UYMSfL0f6iK7nTnLaSbeVUR0Lo2RsSSAE+E4/O
	 fsmZVlxYcRMKHFWIa37csr5N0RSRU3rDsxh6YM92IMbhV6mNuuUiBGyv9zHX8RvuKVMlv
	 eSLNoBnc/34NFwZ6iP6+V4uwgQ6OPwnkNt/CwgLFkzT6LWx7qM4RfnblCC3TMyhwszA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XvxPLgQw;
	arc=none smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D737606A32A
	for <linux-mmc@vger.kernel.org>; Tue, 24 Nov 2026 16:31:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D737606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XvxPLgQw
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b87a1a2babso10429661a12.0
        for <linux-mmc@vger.kernel.org>; Tue, 24 Nov 2026 08:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795537881; x=1796142681; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oRL5aTXHyHFRAfz4KwgNvuAkNPsd3FsBbrJQRIQaKIs=;
        b=XvxPLgQw+Hr6BptL+nZXEjfpUUmPl0SWRZAM+FEY270TDBYwbiqVsmfRXFWQGp2Fot
         sqcc1ywRiYO4zCeZQoAAKQXCJwN6OkKBz6YNbQySt7BZNt46MxlNfS/E9YGgsB1Fv8lg
         /xJ0DLjzinQahc2ruQzHDlpxtPSDIekxKtg7/3jOkkr0KDILxrFzTeMDOezHMZ4qA6LY
         JbD1Z+9ptIiNKJAEy0A+m2rRM2rp4L9Yy34H2v21MDbrB7QgWCoJIDj+jmfMlcuSTVwB
         jjP66WA0OOldGwC9eVtkK0+fodFUa8cVpMw2M4bSDSZb1uTXW9bY/biijl/Es1VjhnvC
         vLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795537881; x=1796142681;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oRL5aTXHyHFRAfz4KwgNvuAkNPsd3FsBbrJQRIQaKIs=;
        b=wsF2m5GOobprF7C3UYeq3LMHfcnkDexMgZ5VZCRadiG8wODRgzN4aYwiubfyO3tZm7
         Bv0oq0eQvqnqddzrOfyj8ME1W5hFhsEYpZeEy4noxnniAg/RpqiPGDrgGoXfA4NyYtNE
         xkKsukwRdnwZdjIIJA+sGwUne29VFl6wL2GXoH4trAOw2+FD1OzSemD9zpJIp+gMmB5W
         X3Ecq7Km9zLmPqyecqLMmOAEhwz7VrEPZLx4+xTqWx8fCsrHl3Gl9UvL9kQUgE5Lk8pJ
         1+6ITHlZkiH2b7RgsantLsxbuIgKGe9T89KN02sCSoZh41b4FRmH8k2XCq723cYzC/UE
         3zVQ==
X-Gm-Message-State: APuU4Z9mIyxiCmdINPhQe6/i9fQWxnaUAC30E6vjhXLZI9eEzFGtYT+D
	4sHqXMPyEBh6JxE6i3R3wbYEaICDEpwJiEHl+uMQr6velQm7n47pTnwA
X-Gm-Gg: AZFdTZfFYTCII6EyzqNKww7Hxcs9SJQART0Q6ZHtCT0IwOhORNJ5p1x8YuQU28dXv45
	nPWeVk2sGUf19bCs7e+I5NwPVOr2rn+0eAcjjBZA2pscMidgfdxEngwOw41MO9DNjRJiwOyJjVC
	cEl51jMqSsQIzoJNsv19VsD/jiG9krk+4H/GbeQvFIBamDN2bTJpkAUo0X1vTje47kBVJJo/6SD
	3rrVxEWWr4aSp2Em/27ja2pEZg5AMJGFnvDbvmAPMdgpT/uDMPnY0CgdUZP2WTAPdeXgJ+QVV4v
	7NVGVj2S3iDAeiyUdZ0U3STJJHQ9IqXaTr9+rnLPc27e4Q4rPZ9E4EYMhU+D7adu+wQiRxkg4rF
	G6r9i/Ms3ow4nUdyoCgdtbCLbJ/B4BNZQKSMtzaooB7wW+XQPDyX0Wdr0Ph2uI4ER/shTpX/v4R
	NbqPxL15+Ig/6spruA3h2nY2Q3w92ivBZLcyPZHkLj8iAIkuRtT1FsL3hIHzXEjY2vUWig6jRd3
	N/xFxrxG+oIjhSF/uSiFmWsrygsGrj9uo972fhXhe4RKaZQKiOj69R+F5OSlggVG9ZTbQ++yHPF
	wuVqwKYZ2h/w8dTyHRC2PqVvX5Vuc4yvGCeSPKodTUTdlNhWFxAzUk+KY37gKFLJ/kY=
X-Received: by 2002:aa7:c0d8:0:b0:6b5:6b89:e3b0 with SMTP id 4fb4d7f45d1cf-6ba1fc3dcfamr9661275a12.19.1795537881297;
        Tue, 24 Nov 2026 08:31:21 -0800 (PST)
Received: from [127.0.1.1] ([2a00:23c4:a702:d301:d107:658c:9ded:696c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fe75sm33058741f8f.24.2026.11.24.08.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 08:31:21 -0800 (PST)
From: Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v4 0/3] Add RZ/G3L HS400 support
Date: Tue, 24 Nov 2026 16:31:18 +0000
Message-Id: <20261124-sdhi_hs400-v4-0-df452ccd9bca@bp.renesas.com>
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
X-B4-Tracking: v=1; b=H4sIANa7BWsC/3XM0QqCMBTG8VeJXTfZ2abTrnqPiHDu2HaRyk5II
 b57UwiM6vL74PefGGEMSOywm1jEMVDouzT0fscaX3dX5MGlzaSQBQAoTs6HiyctBM9bUWIulZE
 VsASGiG14rLHTOW0f6N7H59oeYXnfmWKbGYEL3uQWnVMgtSiPdsgidkg1ZU1/Y0trlP+9TN6hh
 tbUplVK/PRq682HV8lbXeQVlJWzRfXl53l+AeqSIGwpAQAA
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Ulf Hansson <ulfh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795537880; l=2391;
 i=biju.das.jz@bp.renesas.com; s=20261020; h=from:subject:message-id;
 bh=lQGEntqH4CiR1u9MFrLMu9kE6DSxkRjbYdv0Tpbk2l0=;
 b=vj0BH0pIONB915GtElwlKlW7sOZ/HzbofWz6k8QNZHuBjYEePyw4hDHLEGQUlf2MFh/w3a/O6
 IPE3tKir9gLA4h7fPRC/UH8pHJp6Io2v2CSUEpmlV7+Kjb0UsUnL2h9
X-Developer-Key: i=biju.das.jz@bp.renesas.com; a=ed25519;
 pk=yzD2T1OLS3lEYflbk64xhLlxhk75lZ+NoOtkTOqrlVw=

RZ/G3L SDHI IP support HS400 and HS400 ES mode. This patch
series aims to add support for HS400 mode. HS400 ES mode
support will be added later.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
Changes in v4:
- Fixed ios.timing check in renesas_sdhi_set_clock() halves clock.
- Fixed premature SCLKEN enable in renesas_sdhi_hs400_complete().
- Fixed overclock in renesas_sdhi_clk_update() for HS400MODE2.
- Link to v3: https://lore.kernel.org/r/20261117-sdhi_hs400-v3-0-b4659189db69@bp.renesas.com

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

 drivers/mmc/host/renesas_sdhi.h               |   5 +
 drivers/mmc/host/renesas_sdhi_core.c          | 129 +++++++++++++++++++++++---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |   5 +-
 include/linux/platform_data/tmio.h            |   4 +
 4 files changed, 127 insertions(+), 16 deletions(-)
---
base-commit: 522b5bdb42c730db0269a384bf5a2501ecb21e8d
change-id: 20261113-sdhi_hs400-5f08e5237291

Best regards,
-- 
Biju Das <biju.das.jz@bp.renesas.com>

