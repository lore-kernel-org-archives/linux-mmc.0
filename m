Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794855163;
	b=J6Bhmdqoj7CTGK+ucjw8jRA7vrUgWZ0imBlCYQmNQFjYSPPtxyewKnXCtiF3LzU0kXAA
	 1bycAAXe2wOe9zIDRRuoAc/vikDFwx8z2OFkJbMQ7aJ5jKWZ1kAl5t6T6tF8/RdI4sxdC
	 om3dYcxIU9UlMz1vj66eB08VQzbkdsP9alOG+rmzZ14Q0ptg6164Xh2JDEfyknVPxQ30N
	 BVkwLbdylPGPlTD1JemDPLyYuF4HtSPx0kYuwbdMWXNY6EhZGWJje1vMJ00Ss2t93X2rN
	 s42NRstGIRKfk1e6YxSbOtfU2dfqcRzzVwlk1Ow8GZN2O7UAHdKo8+dkV7DOVzN3ang==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855163;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=m/Z2nYi9NZNoITMZsJFvw0t9wUHDOrpZ4vvlNzigGVA=;
	b=axlJ4GYZ7vBY2RAb28g/82bYaaxFRZ1fIN0ZbHCwJknWiRRzkQnLnM9FQJnlYAchCkoY
	 zru9cbr3y/To4mmlWa+A+YjMqb8kQQTHQyO0gprHLcqR+PoaR/GDBWV4nguQFQe0wtOiY
	 efhYts0dxy94MDZpUGayInzFavgvhkGgkHysqLpO6ahBir9syrPyH4/Mt4IVePQhUGbLr
	 4Mf6WSWqGd74LxdTbbkLLeLkaewr/sAJ3my8Q04oXGHF33WIh5fSMJzDjMRKuV5J47/GE
	 jhIPKGHwU4WbP4eoDyojObjKFrsad4JoSm624SFohMOvIcoImNTiOC7FOOlK3cX9k8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Js4XTkPu;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49BC606A329
	for <linux-mmc@vger.kernel.org>; Mon, 16 Nov 2026 18:52:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A49BC606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Js4XTkPu
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bb70074ab2so13804445e9.0
        for <linux-mmc@vger.kernel.org>; Mon, 16 Nov 2026 10:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794855161; x=1795459961; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=m/Z2nYi9NZNoITMZsJFvw0t9wUHDOrpZ4vvlNzigGVA=;
        b=Js4XTkPukbCMDuP+silCcUkGbdhKS0wyVvy21AGdd+TmgOsiahvn6FrhdgE8k1fhVA
         Tx2AP4PQpfZGqLLznhjxaiOf9WEjlfnV3LD3mRtVFIAktbCvWEGSKg+Slq8Og7voi7u+
         3gxtr1u8YM+Q4ohDcvr0Xvd87te5jFCOOTcq+LHUT1AALtom6J6Y3ygMi5r3VzxbnGkm
         +D0lYSxXUvkAS+jk/De7oD/D0METPY51FyUXa35VRphFlRfPEqUypwJ77fgI+8FXRBZ7
         WM+NKLoevu9bUKtq8nYmHavdEAUeA/Cq+C7EI9N1Rt6zfzMRHsrHbWYO2ThyXdZ6rIfQ
         YJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794855161; x=1795459961;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m/Z2nYi9NZNoITMZsJFvw0t9wUHDOrpZ4vvlNzigGVA=;
        b=SdsiCLvAr9aURyp/V8+Jh6p+BgCVGvAD+2L1A3kD3OHIVRBSa+TiLWDHna+3zSU4E+
         1SArRreSJlojAFFF1od7nZq8E3jGX6mnkw4ZjKbDqeTRtWWpiNGzJPUChfIM1uFzCVfw
         mz02kqsh08FELCkiGflgyw+dQNtldzSAouKMi8etzAWtEZ2xcicTXn2cGIT2hnM2GGXz
         9b49/x3viM4V3G0Zuip/kYoTaNvWUVPR+IRW4gzZEJaNMwitv+3nyS2jlAPMkBXBIZzv
         r4bSvhYhyETg/zExyaKiMkZXDgAw4JyBtP1EpHbIlRT3uouWyErh2VFyh0n1SQIdE7r/
         wTgA==
X-Gm-Message-State: APuU4Z/gWt/5wLpEnxDi/ySMtkAYdCTsmKklxBU9u5mP4oBkXdz4V14K
	mQBPSz/w+ry78QFmS4PWY/sLKI0xsIDoJEFLmOmdyVswXkvS9Po0W9HH
X-Gm-Gg: AYBFou1fleo0+jTt4nGFjF9GtUwsiJdUX7rayhdZYW/WIG15Vp2lCBUNBRzZBwEud2P
	alpE7yXJdNN8hf1XyJxFlGgw2N6ejexY+lTYwqDdNuh8lfJyT0PhxF7qSnfZyrpFPQLYiJY4LSv
	pErycfSoH2XSKrSKrM3S6pF/MNesjBUL1vepIKW0DHKlbCzh9SpvHSqj56hXjkncKmoAW9/4Gml
	+zG3LSXk7SqZWtI+l6TVhsUOxAnIdeVOVK36f6OT3B343DpggCL55RSWfex19fv1kAgTTvL5+cz
	v+CCaFiY0yNsfCntyHmFCDqohQdKwbCwccZlx6xOpUtN7qJMVEt8oxdFgZtVrc/zT/Dek44sYAj
	rW8POZSCU/6/FCTkxNjM+pVnm1dcgZAtUNxgSfxEPZ8ufw5EXoEFkJq1CAj5bmEacW3ibdyvRbN
	F3ZHGqGfvKU51PYwgnKpYn9O9+k0WSoatiH4gsQeFMsplzkve3UrDhgzxAO8URX/809bC5w10CZ
	yK7RfdCCk9yLpx3dSFqWosPqmhJXRV3PwPKFcyuR9n5KdSyTQVYqbpFdrvgR2g8qscksNUZ8dZX
	cDg+/zM52yULWj1mSJ07EMu2e4fEe9nF/Xpc6ZXiouP7Y9rjSGEVFe1fN9i4gui6VQ==
X-Received: by 2002:a05:600c:154a:b0:4bb:6a5a:7824 with SMTP id 5b1f17b1804b1-4bb6a5a798emr116616505e9.30.1794855160850;
        Mon, 16 Nov 2026 10:52:40 -0800 (PST)
Received: from [127.0.1.1] ([2a00:23c4:a702:d301:6889:eb24:5e57:83b1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb5720f6basm157961345e9.4.2026.11.16.10.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 10:52:40 -0800 (PST)
From: Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v2 0/3] Add RZ/G3L HS400 support
Date: Mon, 16 Nov 2026 18:52:38 +0000
Message-Id: <20261116-sdhi_hs400-v2-0-de41f7a7f330@bp.renesas.com>
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
X-B4-Tracking: v=1; b=H4sIAPZQ+2oC/03MywrCMBCF4VcpszYlk16srnwPKdI2UzMLm5KRo
 JS8u7EguPwPnG8DocAkcC42CBRZ2C85zKGAyQ3LnRTb3GC0aRGxUmId35zUWqtm1h01pjqaE0I
 +rIFmfu3Ytc/tWJ4+vHc74nf9Me0/E1FpNTUjWVuhqXV3Gdcy0EIySDn5B/QppQ8GXzMrqQAAA
 A==
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Ulf Hansson <ulfh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794855160; l=1545;
 i=biju.das.jz@bp.renesas.com; s=20261020; h=from:subject:message-id;
 bh=TTEJfEawvjDbFSQ6Fs65tzvehlnQj31DNLAkJJXRiME=;
 b=2oQyctcsRUZIl5FW0fFWgIu4Gh0NRzja9Fppp82DjTe9EZNEPy+nV3Ik5RkN90TaZQPRdHbgw
 Vh08oHhQ5uOCYIwCOEZN5YtoLqqlAMDxRgMTjTAFa/HtwACmv+vV17v
X-Developer-Key: i=biju.das.jz@bp.renesas.com; a=ed25519;
 pk=yzD2T1OLS3lEYflbk64xhLlxhk75lZ+NoOtkTOqrlVw=

RZ/G3L SDHI IP support HS400 and HS400 ES mode. This patch
series aims to add support for HS400 mode. HS400 ES mode
support will be added later.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
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

 drivers/mmc/host/renesas_sdhi.h               |  5 ++
 drivers/mmc/host/renesas_sdhi_core.c          | 95 +++++++++++++++++++++++++--
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  5 +-
 include/linux/platform_data/tmio.h            |  4 ++
 4 files changed, 101 insertions(+), 8 deletions(-)
---
base-commit: 35dd24973da5e5810a6fae86c291293d11dc8022
change-id: 20261113-sdhi_hs400-5f08e5237291

Best regards,
-- 
Biju Das <biju.das.jz@bp.renesas.com>

