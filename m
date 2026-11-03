Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793730652;
	b=rj2vTEqQ2rfC0BRbcHGPTFp8NiaHk3K4Wt0Mks0CX/fIVZHDbveutkG6xWl1Cfwt0BeL
	 VMww1n/qZhduCit5iMN2OK5CEyZ+KmohEd+xcuj1xHyPLcWLXxgnTb660fEQDoqpG83om
	 qqa3SO+QRl3hvGMvlDETqCpfuVWgsyHpXXXQkyrgE4DjD+MBEmL7J4UM7/TclNg04Yc85
	 XJ9dqQCKshAUBP5PVUSLDNyI91Bli4y+kzjYv0bdAJkTwyWCYU1U6KhspieJYhFsvki1g
	 lQC+/qgcO2LFvFInenNoil7b+Kl2PO/7t0FyfYTNvi2CzokpucPHaRcFPj7n4LcYs7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793730652;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/iod9oXhgsGpyGcJPFTu5fqKBMIMVHyACTtYwHQfVM0=;
	b=pig/Vn5iX9mIAcfheZkXPcMUVIRooX1JhKRjXWOuzsHJfMlFdtCBAqslwFeq7h7o+NAK
	 PGH5GGwm3V5M+ZvJIOate+8qSmfNKtgwPLTuFd5BgqmdR4JqI4EHfzKNjti6rPmbL4L0+
	 9rG0RQj+DYTqq2zO1FQW/r0tfkVyHFRh1Tkk4ScorKC8R+x55u85YCZKQeD6b+n9O0+SY
	 0k5atZEOq6GPFHqAf3SXU6k5QZ18px5X7nJ0g8SpbHltGJ2tW+9V2RfV3txpKej7BL+eu
	 UbUzTbfegHjoTp0dCadR/nbaUo134TdtEFE3dRMVQcaV0JpwxPqCKlbGJDu7QEe4OFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oTE0Ftyd;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDC2606A32C
	for <linux-mmc@vger.kernel.org>; Tue,  3 Nov 2026 18:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DDC2606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oTE0Ftyd
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso50242015e9.1
        for <linux-mmc@vger.kernel.org>; Tue, 03 Nov 2026 10:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793730651; x=1794335451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/iod9oXhgsGpyGcJPFTu5fqKBMIMVHyACTtYwHQfVM0=;
        b=oTE0Ftyd1ftHdx/k4ZvP62rvGiEotVrlyVzG8K8lXiQB0n7GOL/Ivt6ERRZJspNbDU
         woWFmaXITSpmezb4vI1eSBO3vKdT1L9ObUomyL6sBzkYAJDTzjhK3NWmArSJdE0pjM58
         nGjaDDgROXLR92862kuVIr/UqW8GGxTErnhpJraKIRKCxjns0+TbHFajys4PwFsp6m4p
         NKlz2SyLsfJKDpWRSTsMHAgbEwrHAwhiWiXCxmfvYmTqqnRwgithsHO5R3YU9o4MU9yO
         RYJhaWzyqaq4HSD1PhvLPXGrnzTnRtnwrqTIcPw3oXyaNKfxaz4HpZC33TGZY0yRmH+p
         4OkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793730651; x=1794335451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/iod9oXhgsGpyGcJPFTu5fqKBMIMVHyACTtYwHQfVM0=;
        b=cpNO2lniXnSR57NNa6RK7PSWPzKB/AS7DLbYRqBQHwRbsHFVLMdylnzsAer0+ObC7F
         bD1KamrXgxAAZtXTZcOAlfP99+mVItb1gzgR61S/Mu56QcYN+RVy6jMXjPWuWp5Iiosb
         63QbPE/dvx4zpCA335nJlC1Kvs5cJexeKGTxyTkvrPKJsAXODClzleJ+NRu0jJf9/dfn
         5N6E7uA/rSSN/tjnuOlNQN+By7t6SBBVeX+mgiA4Dz0un1ITNTaJhqyUHe373y/hDN0+
         CEay7Hf96yWeI9ia/JVSgNUeaWcajC6PSjCVmdFYjrLOBi13v+Xq4MNlZzJzNMXVwAZC
         oOng==
X-Forwarded-Encrypted: i=1; AKwUvBziDS3FGyhvYT5WD9ctertyVNL168odIP+bpiroponFW+RpewaGIKZru5eHusEVeiPl7/MJWNTDD+0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+vqfaR/uRh9zFCMU1i1dIBLLeA3CZ5OIx7PBagHbGytrGPhwtZ
	ciZ8/JdV5brEG9LIzf/y3yvQd/Z5YgfWTA83NHrpHmG6unGjQ6+cpbxA
X-Gm-Gg: AYBFou1Tfs7eWGn/gyphWHHZKmGxFun86VTM0V9XDL91hyPKj8o5DbJmiozvrdRM0aj
	In6v+r2/MZ0CkiOtRB3yEqEM13DV4uPFH7SjMULsN/JpRrx89wITd08qUnQsFrAWkM1r9ePcOoF
	Yppb0ugHnT6ZKRkMWzCpanvv5YTJGeNiXNuB+weYinz5b06RPketwDJ/i5VLLMUI0BW23+nhjtS
	jnqfK9Lxf+PzQzzF4+wNgTS2mTMv0eyMhj7f4Ru407FvDMacD7rNlz4xWsNMoBcrz5aREtlhjgj
	Le2Zqhw1kOhs7DsjnQ7pAalmv8Q1F5avXJLwI8of+kPRQUgjZfy4B9ja7puwIkRE/mTmulW7IYY
	L+nYTrHl48xM79pyFLyxBOc6kFnF4AjwTLUK3Dt3XWXZZSWdGMrTbpuwdyyk+H0tBK0xO+2upsx
	ldI9KVpIHgrwIlHz7pUSCowe+KoEBnvwKIk32YQgwMwjIYhz0EzC76NG6mA6knQshv+bjwp52S9
	tO70m5fW8bvxK73qNyKFUBW8QXS9Oi91FxPHpbfpjg0eLVwGLE2gC3QcdFhNiZhiFtQU2mNmjzb
	twzlrk4TnMgmtA5SpyTUSrCWKCjt6tTPY68dud8m0lm7p9lSXcrB2EwRsMER7u4kphgL/l5ECri
	Eb2L1hnM6RBMI3Do7gga0AWq5ZjMe9ceGujhhNN4PcPKcKxUFVhmZtN4n6U6Ue7ihf6PMVvVLz7
	Gdv74VApJq9TSh/xxDCQP1mOQMJyXqY45yNxK4k2Sd/AKOI5FUhIk137CKmCOZ/ndrhTF9XROhX
	wYDgXK9h1A1kwOc6nJ/i7FIx0v73LfPKhizyi9uZznoW2UNmZi2yxHa7mAF7q4uTN6onTk=
X-Received: by 2002:a05:600c:3f10:b0:4a7:9025:5c3b with SMTP id 5b1f17b1804b1-4ac1889cc2fmr303664565e9.19.1793730650716;
        Tue, 03 Nov 2026 10:30:50 -0800 (PST)
Received: from jernej-laptop (194-152-27-116.dynamic.telemach.net. [194.152.27.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2ab00ff3dsm146339785e9.14.2026.11.03.10.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 10:30:50 -0800 (PST)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Chen-Yu Tsai <wens@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Anfernee Cao <anferneemelokc5@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 0/4] mmc: sunxi: fixes and preparation for A523 UHS support
Date: Tue,  3 Nov 2026 19:30:26 +0100
Message-ID: <20261103183030.81078-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.56.0
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

This series fixes a bug in the sunxi-mmc driver and paves the way for
SD card UHS-I support on the A523, which will follow in a later series
together with the A523 clock phases, delay-chain tuning and the PF bank
supply switch.

Patch 1 fixes the manual stop command error reporting: a successful
manual stop command is still reported as failed, while a failed one
stores the error in its response instead.

The remaining patches improve the DMA setup and error reporting, which
the UHS-I work builds upon: a DMA mask matching the shifted IDMA
addresses, IDMA descriptors built from the mapped DMA segments as the
DMA API requires, and CRC errors reported as -EILSEQ instead of
-ETIMEDOUT, so the MMC core can request retuning.

The series is based on mmc next, but depends on commit 5e32202f532d
("mmc: sunxi: fix clock and runtime PM leaks on probe failure") from
mmc fixes, which adds the error_disable_mmc label used by patch 2.

Tested on H3, H6 and H616 SoCs, on multiple boards, including Tanix TX6
and OrangePi Plus2E.

Best regards,
Jernej

Jernej Skrabec (4):
  mmc: sunxi: Report manual stop errors correctly
  mmc: sunxi: Set the IDMA DMA mask
  mmc: sunxi: Build IDMA descriptors from mapped SG list
  mmc: sunxi: Distinguish CRC and timeout errors

 drivers/mmc/host/sunxi-mmc.c | 122 +++++++++++++++++++++++------------
 1 file changed, 81 insertions(+), 41 deletions(-)


base-commit: fd9af27f6c2319713bb23832066585f8a59a1771
prerequisite-patch-id: 8d600908a2eb84acfcd034482dd6e345242f1464
-- 
2.43.0

