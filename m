Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794830540;
	b=1KKggy3Zl8OKVhirN75jr9uALrXNODkEkZgpSwATdx9HIoM0ye0UAHTBxfhOKzTTLDJ/
	 f/ybsNlsmSAmfzhamT1++fjTIR8g67tExTjwOiIORAjQn71MZuyQc1HQ7G52zDiuQo+dS
	 xwZl3Z//sVDdEWN1vzCp5qiEmUWk8xp6Uanj1UEdu+3WO1nx8h2tQeh2UVH4wDp6jZkGX
	 y/YXmUC+tUUbpXa30Y91JHv6J11/M8JV2L+Xu1n8v0YZRo7XabxYgG2tLJfti//Y7TUYk
	 SGJkk60qBDCeWYHbqqJif0CNRF7bhbALYKA7XjCbrc2bJrLaY0qe1197tc9i1eJPvow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794830540;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=nh6jfj3FGfAPsXqZYuyunwaADn/6sS4BjP6Ar7TjIck=;
	b=TBKw7KWg3y4HsNy5HnT5MUDlBS0O4UP1eS3hvnE8+cvTf3j+QqSrAIF+RrNVzPMNV1/3
	 arhADUXluHeULPv7cR2qnCRnJ8zPen1qt4ji8EzhJWIGXWkG7TTopu1qRc+X4zdVeIqoU
	 o/jFI5iNa/vsm2wrAuhz6GgCC9kE0pn9cr9U8bDcZmJ4OL2iTFONqAdjNDmQpwZHAOhOz
	 z0mHmiYvGly9fETf606UB21tq7wmHzlyGh3IN5C4ZbdTJHXNyEtg/o7ht4UCI19VLh5Ng
	 iuMt7CqC/gwoGFDgyzA2d5BHV9RR4h/sckmKSmiaPIRiIuFyd6JYxaOmr7152VYihFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a9EMNyZ9;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB256606A32A
	for <linux-mmc@vger.kernel.org>; Mon, 16 Nov 2026 12:02:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB256606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a9EMNyZ9
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a2d6d01ecbso21569725e9.0
        for <linux-mmc@vger.kernel.org>; Mon, 16 Nov 2026 04:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794830538; x=1795435338; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nh6jfj3FGfAPsXqZYuyunwaADn/6sS4BjP6Ar7TjIck=;
        b=a9EMNyZ9zyoxMLEVaC+D8hdoEKr0x/Bp/ew18oUrnl+wmy70iLeyTKS+bnTHj8ItQq
         ttzIPbM6oxLcEcuuhswfwJx0SuLZRki/qmXEDgMnTLRCCFlXpUXApKvGDbH+LtOAgHJK
         FOR/f139RXVVJtCa23Oy9/sO+DyLehPyS8Caduh+lhF6qY+Sb6YKeCZ6JknUzkosm4TI
         uKlrouq5pg9u2j5htuo2XlhmhQiGFHSZsAWuaB0rJNNL9JWW5jon8okLd0FnXhSPdAJb
         dYDr94slFeS4mfHNBiL2ntcRP3VxQqsdNgfx4AtpeCxSfQ8eS52lc2++MNHpRDaRlYWt
         TfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794830538; x=1795435338;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nh6jfj3FGfAPsXqZYuyunwaADn/6sS4BjP6Ar7TjIck=;
        b=pOJWCwLo4xqDF92ZWBaA2/EWXh/dnRFkj7OHLEarlZ88WkPMs4Jdq7FZenXspy/64P
         i6SjFK9gpQPx387VLGNBFZmc5CxUZyj246RIVZUb69Pum+ND+HqqwM7WTWdbtg4ZgU/g
         XYt6Tz5EEnylQ+CKq7WNTflmvAIOpZ7B1fjO41LKdLLlzTfwtq2hq4ozq3Ky+YcoFs/x
         mEfxRbqyqtXV4u2tSOVMgbnNMB73E2NyniRGpSXn71GtPolpKJ/LyapGI/VCx1Kx7ax7
         iZaI9kEQbWQN7nds/F1g/hDGjiZcYw2L9ylLLJN+OoWnejzZO7bZxgNTtvH3zwXpyqoX
         Blxw==
X-Gm-Message-State: APuU4Z/W7z/A6Y3W9WycK39MbPVMrPbTSnHuWC5tQ6SgcERcJaJ/zhE7
	4y8D05cvGGkwroN0k38G0r0YBZI43voq5oq/Tg/FufTFS4GpQKl+n9iVbQGomg==
X-Gm-Gg: AYBFou3dsf1GO/hK8s/YUeONsBL3SKOneG47szF31WbAK8+H+K9sLqVGkpR2UUUQIH2
	MOjax5tkoEyFLTWpdro0HnLWshlhW7sIEyZoFkpK43JgFAtVgfEeV0pRVr7weyb1Px/Uf+aO2GP
	bSzznnUlTdhO2S+uEMEH1Pup/EN+DM3mnOMVlLviA4PaHxXltK2wVfFwvihv5saoaHOg7YRbYQW
	1RDAHb/PmHSspDEd1Q2BWxy3uK5mjWrBz8WBYISbYxh1F6BjQQrKrX/YuAUahiZ1xGLbGgaIbS2
	/B9+N3JA3KmKXiuSEnBgQxDTmksrNvzJAzlqAkuibFUlHDgJXbU1HfQeGWMFdOF+6xMgmpmGSwL
	FaBRdIO33L99vgejcZEYzZphqIG3h4Juflhib/AOooGcukzd7tdEyV6V1uznZPN4cwoT+UybEVg
	DUdmgH1WtlKWjUUqlq7jVxzMtQi1JIr4j+1ozPnhjVOUYJ6s+ncV/w5DgcHG6lKGRjDn2BiE5N5
	x+ensaRX7pShGZAma7/FtQQ5Q+alAzy43jpo5IFU/TIpAhArTiwrZYjIZZLn4Agrik/eg1fE0YL
	3rQ+rWuCbANyuEl4wJ9e2WsHNhaWp/NF0YXzr8nunE1rXQKdWhnU6kdtCFeaUIqkmsU=
X-Received: by 2002:a05:600c:1daa:b0:4a1:d087:f6ab with SMTP id 5b1f17b1804b1-4bb55a4ea8emr211649535e9.18.1794830537971;
        Mon, 16 Nov 2026 04:02:17 -0800 (PST)
Received: from [127.0.1.1] ([2a00:23c4:a702:d301:6889:eb24:5e57:83b1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2adf53sm395562805e9.15.2026.11.16.04.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 04:02:17 -0800 (PST)
From: Biju Das <biju.das.au@gmail.com>
Subject: [PATCH 0/3] Add RZ/G3L HS400 support
Date: Mon, 16 Nov 2026 12:02:14 +0000
Message-Id: <20261116-sdhi_hs400-v1-0-c5bedd312408@bp.renesas.com>
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
X-B4-Tracking: v=1; b=H4sIAMbw+moC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQ0Nj3eKUjMz4jGITAwNd0zQDi1RTI2NzI0tDJaCGgqLUtMwKsGHRsbW
 1AOrlteRcAAAA
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Ulf Hansson <ulfh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794830537; l=881;
 i=biju.das.jz@bp.renesas.com; s=20261020; h=from:subject:message-id;
 bh=NY1YQ/WkIlzl25YtvFcKwA/c51TX7pD2EXQVeDyJAt8=;
 b=zYP1Fw6njEwMwgmLH6MA5VIBOowST0gQVNGdraCi8m3mBze9FB1tYgRebNocFRiPvA3godzAf
 TPpeblDjaqiCzeNc/JEss5CpPYaEYHIxZ7bo/BoyiLyYHw/jI+JP6Ay
X-Developer-Key: i=biju.das.jz@bp.renesas.com; a=ed25519;
 pk=yzD2T1OLS3lEYflbk64xhLlxhk75lZ+NoOtkTOqrlVw=

RZ/G3L SDHI IP support HS400 and HS400 ES mode. This patch
series aims to add support for HS400 mode. HS400 ES mode
support will be added later.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
Biju Das (3):
      mmc: renesas_sdhi: Save and restore IOVS across suspend/resume
      mmc: renesas_sdhi: Make HS400 OSEL bit configurable per SoC
      mmc: renesas_sdhi: Add RZ/G3L HS400 support

 drivers/mmc/host/renesas_sdhi.h               |  3 ++
 drivers/mmc/host/renesas_sdhi_core.c          | 70 ++++++++++++++++++++++++---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  5 +-
 include/linux/platform_data/tmio.h            |  4 ++
 4 files changed, 74 insertions(+), 8 deletions(-)
---
base-commit: cbd778b5609cd176ace3442a154bb22d736d3a76
change-id: 20261113-sdhi_hs400-5f08e5237291

Best regards,
-- 
Biju Das <biju.das.jz@bp.renesas.com>

