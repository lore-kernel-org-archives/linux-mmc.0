Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=88.99.92.76
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793370150;
	b=clhlWSmRbnBR603TKsbmijHbXqyc5d8a+hUJqfkkTXiJdoi3RmLBmlAcYCsPGTMK832o
	 YmAFvi0gLSp7V8gAUjhf6aTonxtMNQdH0im68bi107h+bgUstdDGvs4eQUlOKTrcSoecb
	 F0RHu9pFp5eW+yO8v8xgLMFQo9vHcVFtwcgd790etDEDNvUoyP0YXUOFVh5GtY/udMv5h
	 RoeVKKQc/QZFZ1s4wn0NQFhd0Bf/ZqKUl/dma1+TtJ1eElMIFLDdOjYhONHqEML7NGq/t
	 phPTIDqVoRONFn3OxAt3tC0fgk9dXqZXMvHvNsyAU+TssE1GZQWUQ0SnZ0z1qF3+Ssw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793370150;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=NDPKoE3F1+TWhlCmk2CMsmSIXdCQ8HMZzuqYcQzRnYo=;
	b=CyU2hreNY+Ggjk8eZbG3RDKmsRcPNHOt3p/A9ZovsnNzcbINVJtin8msWOFWwHc4p0Oc
	 IErE2zXuPX3yNgcjMqUvnom3Fmm7vpZbkpcqrscbOekwsqxtQ1jPeA7BR5tXohqX6/fp1
	 ywN0PhcgydKonKRTDJetNLdah0dpZtlMJPgtevulCXYU1i8ow8ZAqXfLxTbaN/G+O9oVR
	 dwTfwN+CuCqlmfIZ7iCpZ8dILDIHG+h+4Bvlt1P9TamBTYqRZDdYkWlZTdIdRA7EUW2I8
	 /XyemP15Ph3YaBicVXm4HeCAdVvFB7FNaLwJe6U/RRiW9ZwP3i2hR3fCMRskynike2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=rojer.me;
	spf=pass smtp.mailfrom=rojer.me;
	dkim=pass header.d=rojer.me header.i=@rojer.me header.a=rsa-sha256 header.s=main header.b=l7DvaZPv;
	arc=none smtp.remote-ip=88.99.92.76
Received: from mail1.rojer.cloud (mail1.rojer.cloud [88.99.92.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EC4606A31A;
	Fri, 30 Oct 2026 14:22:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8EC4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rojer.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rojer.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rojer.me header.i=@rojer.me header.a=rsa-sha256 header.s=main header.b=l7DvaZPv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rojer.me; s=main;
	t=1793370147; bh=zhRGuNd16hsLL8a3VXJU6R91e0L5kNHVEFVE4q/U/eM=;
	h=From:To:Cc:Subject:Date:From;
	b=l7DvaZPv+yU0ZvsKmI8R7zSULkQ8ZWgCr/gHqQvm/oPixYrLxkVw+qB+JI5TYBqRn
	 85qhr1ZitONhX3N491WYEVPRXbcCW/hR8vI1HwQABvPJMQCp6SzgXK8WXE1cOCQpGp
	 XeA7F5ZEJfxL/s+eIEQpG+lydfNwO9WHm+Hvl+uVJt7AmKjg1RVDuskTeB+TXPs2NP
	 phfTlRwm4j5ct8CoemKN4pa9sJcUVTJj3WaeU2ubpnotNLsy1sdtNdDXW6aPLEQS0y
	 do5jpNbwOKygg5SNyyFaw3ymrEjSYrwpV8nqMEBLGteFFtqjDQ/mbpINGEFB+FE7Tm
	 NNvbvVjfRF6NQ==
Received: from nbf.rojer.cloud (unknown [46.32.99.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail1.rojer.cloud (Postfix) with ESMTPSA id 4866D21647;
	Fri, 30 Oct 2026 14:22:26 +0000 (UTC)
From: Deomid rojer Ryabkov <rojer@rojer.me>
To: ulfh@kernel.org
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shawn.lin@rock-chips.com,
	llj@rock-chips.com,
	Deomid rojer Ryabkov <rojer@rojer.me>
Subject: [PATCH v3 0/2] mmc: core: sdio: fix UHS init with fixed 1.8V vqmmc
Date: Fri, 30 Oct 2026 17:22:22 +0300
Message-ID: <20261030142224.3183407-1-rojer@rojer.me>
X-Mailer: git-send-email 2.53.0
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

The Realtek RTL8822CS SDIO Wi-Fi module on the FriendlyElec NanoPi R2S
Plus (fixed 1.8V vqmmc) reports S18A = 1 in its R4 response although the
bus is already at 1.8V, contrary to the SDIO Simplified Specification
3.00, section 3.1.2. CMD11 then times out and the module ends up at
50 MHz high-speed instead of SDR104. The SWT6621S behaves the same way
and, without patch 2, doesn't come up at all.

Patch 1 makes SDIO init fall back to high-speed mode if UHS init fails
(e.g. tuning), instead of failing the card altogether.

Patch 2 skips CMD11 when the host is already at 1.8V.

Tested on a NanoPi R2S Plus (OpenWrt 25.12, Linux 6.12.112 with these
patches; applies to mainline as of 2026-10-22): SDR104 at 150 MHz; iperf
as a 5 GHz VHT80 station goes from 70/29 to 123/125 Mbit/s (rx/tx). eMMC
(HS200) and SD card on the same SoC are unaffected. Longjian tested
patch 2 with an SWT6621S.

The device tree part for the R2S Plus is sent separately to
linux-rockchip.

Changes in v3:
- 1/2: pass "oldcard ? NULL : card" to mmc_sdio_pre_init() instead of
  "card != oldcard ? card : NULL" (Ulf). Equivalent at that point (card
  is either new or already oldcard), but clearer. Kept Shawn's R-b.

v2: https://lore.kernel.org/linux-mmc/20261027122417.954133-1-rojer@rojer.me/

Changes in v2:
- 1/2: the existing CCCR fallback resets the card, it doesn't
  power-cycle it (Shawn).
- 2/2: note in the commit message that this relies on the fixed 1.8V
  supply being described as vqmmc-supply (Shawn).
- Dropped "2/2 alt", the alternative to 2/2 that kept sending CMD11.
- Collected Reviewed-by (Shawn) and Tested-by (Longjian, 2/2; his
  reply didn't reach the list, it was HTML).

v1: https://lore.kernel.org/linux-mmc/20261023232813.2983368-1-rojer@rojer.me/

Deomid rojer Ryabkov (2):
  mmc: core: sdio: retry without UHS if UHS init fails
  mmc: core: sdio: skip CMD11 if signalling is already 1.8V

 drivers/mmc/core/sdio.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)


base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
-- 
2.53.0

