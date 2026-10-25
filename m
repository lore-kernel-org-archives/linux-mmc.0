Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792937084;
	b=itDiZISzMmFynusQIwq5D1HnldhxK8OuTPg9V3UuNkMrD3gIuuuqwzMs6uExvn7Wn4NY
	 HP39HsA8SEYKN0gK2yQha4gnad6+9pYo8Gbsy7Mt3clondvYHQEUOwl63Y1AgWpmLCQm0
	 UjJC4tMWlp9vaJ6m5NnHSUlNk4c62FPw52gOnWRIdJX1lEHduMR4poLpdUvCylQzHTajj
	 nT9+IZK7a0vgbw8yv7HkW9WlPllyMcTzrsmBOTqjMvu5TeXLmA49r9rrKoJsfWCotrmwa
	 BNT73XS/FW7EksQqJguDhSyWQwig4Z8L/uUNRMkxfVE09w9vYnDBzZL5adB3LC0Yccg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792937084;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ri0CPShEuql4BAUZEt5/v7rw6sqPDnjjvp/wkFZ8g2o=;
	b=BEol4OAjmH/k0X73Ls07A8erKi57CULQdooFc59T8l3eWjvBO/nzmSuI7WN0+y0EVCof
	 v5K9jrut2QGcaliSVlfjtgclMQgHkhvBpPNfWV5Ft6Mo8KL7PlsEOtQNISjqvg0xkldHm
	 NSPxXOKZwtTFlcGUmHkvr5nEA+XxR+/QZc0KpVvSSVa3Y4U/UvZ9eh6tuVBSohyRcLhvI
	 ERxl24WUGe5I5qE1DyHlf/JU/zUl6I3n4VukrWcwa+/3r3eHmmZfXQd3DUWFDFECzsSGS
	 5wi7pUaWI656IGvZQ+0s4ZYI+cGHj2s4r/2hHBsPwI/IvBtYJH7t2d45N8QuAnlV1nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=mgcrea.io;
	spf=pass smtp.mailfrom=mg-crea.com;
	dkim=pass header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=SjDpN5Dj;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC76D606A31B
	for <linux-mmc@vger.kernel.org>; Sun, 25 Oct 2026 14:04:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC76D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mgcrea.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mg-crea.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=SjDpN5Dj
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so2016035e9.2
        for <linux-mmc@vger.kernel.org>; Sun, 25 Oct 2026 07:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mg-crea-com.20251104.gappssmtp.com; s=20251104; t=1792937082; x=1793541882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ri0CPShEuql4BAUZEt5/v7rw6sqPDnjjvp/wkFZ8g2o=;
        b=SjDpN5DjCTnhznnyUfyIVV7i5xm+PqIL6QXKyqXFa8G2NJQ6k84eQdfRSr/lMkb/f1
         s0sWzyNB06ewQNCakES2NfeWkb3pioPR0z42VT9ERjg2nJS4V3y64dWjBS9Ek00efXYb
         finHWi9ats9CUH6KdxD+EwYM85Zt4j4asDR0LYgD0bdDFtc73SpDvQ1FrSfh7kirQhfn
         gJKyFyj3A9ypexVlwr3MD9ghP4lkMO0mvSeqY2zS5w+GN6i6UXxT38BfEydclyy3Rdrn
         bQaJ34hDcqqFsymi4vUUyXtXoT/AHJ8J5fXepQeksl0/mtXL2nvEIscWmckZnFNMvcK0
         mumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792937082; x=1793541882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ri0CPShEuql4BAUZEt5/v7rw6sqPDnjjvp/wkFZ8g2o=;
        b=eDO0vDgPKDCmQhxwOuAhUJPKPm3TuyCcGz64Sn7AHtQqcDuLM7nVi4/DZQqO8rTU7R
         TEjP/de2YQLpu5hkrRCGCdOGKG+40kqofwu00VZvW0+27AA4FL2zAoTCMo9e0Un/lHgE
         NleOaHtB8PAnG3FraU7bpA/JPGJox+h70FD/M5f4Pn1LLPToV56aCO6zx5EQTdNhPF9X
         MX5eCGXgSqg7eVp/lZstZXkT8r3v+T5LoRRcGeMvm9oIidK2tnMHDYuhDIV/1JTi33tf
         MC6rzApOgmtUjjEkn6eUUMON7HMGpaqli7qd03wD5rWhRLnUqH+4WVVVeFEmGNH1Ozcv
         yjVQ==
X-Forwarded-Encrypted: i=1; AKwUvByOEt36ASLEwsSVbPadUJ8N6MrkGkjavt1ys41/DvHNZPrZUhIi4uPZLAqBf7JDfSnB97EMSBc69bY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLut6OxpBgdrMrRdheu5hBT3zuUOnJ/Au6pSaoE5ShzGwHuyw7M
	JYX9xHL4KBDaDz4x3JsUG7P9ulv+473bslBEnePC+tQR9ux+c9MCMGe3X53EHjOEidg=
X-Gm-Gg: AYBFou08c8niumRGPkT/uOr46BeUPreigz4lSgsMlyE8GRih5RNpP+lKWkYHgehSheK
	Ng9WEZ+4iC2vmJApHeIpKLttyR1Rf+eDCHrYGZ23iptQlqZDOLKco80cIQklt6iAeKPRgHczgVq
	5XZlIFgCd4Pi0lJcKJndAo2zH9QRCSI0z6DbPMcdxQC9KOe+oSqURpAz8exPHTDot1vx0iDYXOZ
	ej9g+22EG8XF6O9RUlCl9CakBFjH4W+ok62DiRa/AwKQnXnyb7qDbGXFiQApbCAHb9jc8julzgS
	mE2hEd7Ii0sQFRqw8qOXHgFbeNTjGQjV8dxl1HtNfcQYF024LrwaTjDJawAdTeruDLCFJFH0l2m
	P17QajvRwi1EA3xHVx+sENQWP/FKl0+TrUyEkgXMWq5nn7PMJ2lbxgukMeoN7OYXUFjbksQ9zQn
	pF3lCVFD9WDsbatK8iRkDFpR0ejkER9ZilFwPZV5/1mBuZKAE0f6f9vzL0IIw8klKQxC787akSm
	unENSNSpaRYCCNTpHO3OlUFWikTfMAuMBwIyFeMaHcmhg0rld2DwUmCnRWSvkvtJFfOthWgT+Gs
	OGcVEqsaXwI9MOfjr6LHjvVQRoFD9B84AOl2PIa7CxXgPN0TXgw1eLcmwd7R4/LQy1RCj/1UP6y
	ivohaeDkKXm2wCgwTPvQ=
X-Received: by 2002:a05:600c:46c5:b0:4a2:1364:252b with SMTP id 5b1f17b1804b1-4a35acba20dmr76716765e9.35.1792937081944;
        Sun, 25 Oct 2026 07:04:41 -0700 (PDT)
Received: from localhost.localdomain (2a01cb060184ad00bcfbae5efa3e0f0b.ipv6.abo.wanadoo.fr. [2a01:cb06:184:ad00:bcfb:ae5e:fa3e:f0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a574088sm112317695e9.9.2026.10.25.07.04.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 25 Oct 2026 07:04:41 -0700 (PDT)
From: Olivier Louvignes <olivier@mgcrea.io>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Olivier Louvignes <olivier@mgcrea.io>
Subject: [PATCH RFC 0/2] mmc: jz4740: Use the integrated DMA controller on the X1600
Date: Sun, 25 Oct 2026 15:03:23 +0100
Message-ID: <20261025140325.73204-1-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The X1600's MSCs have no request lines to the system DMA controller, so
jz4740_mmc runs them in PIO. This series uses the MSC's own descriptor
DMA there instead. On a HiBy R1 (X1600, SDHC, 4-bit, 50 MHz), reads go
from 17.3 to 22.5 MB/s and writes from 13.9 to 18.2 MB/s, with the CPU
free.

It is an RFC because of how a read is known to be finished. On the
X1600:

- DMA_DATA_DONE (IFLG bit 31) never came in our tests, masked or
  unmasked. Rockbox's driver for the X1000 and X1600 waits for it, with
  the FIFO thresholds (CMDAT RTRG/TTRG) at 32; we tried those thresholds
  only with the flags masked.
- DMAEND (IFLG bit 16) is only flagged while it is unmasked, as the
  manual says. Unmasked, it came for every read we watched, including
  the 8- and 64-byte register reads at card setup; MSC_STAT's DMAEND
  stayed clear for the 64-byte one.
- Waiting for the DMAEND interrupt made reads very slow in a first
  attempt (minutes to list a directory). We haven't found why.

So this version polls: a read is done once DMADA has reached the end of
the last segment with DMALEN at 0, or on DMAEND. Is there a completion
signal on this controller that we have missed, or is this acceptable?

Second, reads under a block (the SCR and SD status at card setup)
sometimes never raised DATA_TRAN_DONE through the DMA, and the card
setup timed out, so they stay on PIO.

Third, SDIO writes that brcmfmac glued together from several frames, in
segments that end inside a block, timed out through the DMA (CMD53,
-ETIMEDOUT) and left the bus dead, while the same writes went through PIO
cleanly. Transfers with such a segment stay on PIO.

Fourth, the X1600 manual's two descriptions of the descriptor's LINK bit
disagree. The code follows the MSC_DMACMD register table, which the
hardware matches: reads spanning several descriptors work.

The R1's Wi-Fi (brcmfmac over SDIO on the other MSC) goes through it
too: its firmware download of about 420 KB in CMD53 transfers read back
correctly, and with the rule above, 10 rounds of DNS, HTTP and ping and
three Wi-Fi off/on cycles went through cleanly.

Only the new ingenic,x1600-mmc compatible turns this on, so the other
SoCs keep their external DMA or PIO. Not tested: error paths (CRC
errors, a card pulled mid-transfer), suspend and resume.

Olivier Louvignes (2):
  dt-bindings: mmc: ingenic: Add the X1600
  mmc: jz4740: Use the integrated DMA controller on the X1600

 .../devicetree/bindings/mmc/ingenic,mmc.yaml  |   3 +
 drivers/mmc/host/jz4740_mmc.c                 | 182 ++++++++++++++++--
 2 files changed, 174 insertions(+), 11 deletions(-)


base-commit: fd9af27f6c2319713bb23832066585f8a59a1771
-- 
2.39.5

