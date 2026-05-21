Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7F62DB7A9
	for <linux-mmc@vger.kernel.org>; Thu, 21 May 2026 07:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779348125; cv=none; b=HUNGtsF/+nsF53aldcA4fp+bS19lqlvlVHlADG/Lw51iBJxK0sCo69qYBDVIIHe23wz50JFozUMRQd6AedJDlXGDAho1mQj7wXFTeWqABic/z9xrHn19ZCYJakykBp7nlVvSx7YNqpDoFBu+T07uk4rkB0xau5JRn8vUtih/YI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779348125; c=relaxed/simple;
	bh=xOXRPX8bVXBZXCvORudEd5T1dkNTZFPtZVfHUJRnlS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K6rCvyi7blNY/suJ4RjCzNJEqiJjYTkHxuJ3W//KEv58yeZ++FW+6p9Gq04075TjMZ7Zst6H5SFM73wRWhGM3GFItNW6pCRzIZd6Y46mYQEXzxtF33/m1LwUr/LDMJvQDWu2d6iKqGs2cjvNPsWLZ3o0AMbhnnapFoCWP4WR9i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MzxPHNT5; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzxPHNT5"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c7980c060cfso2566831a12.2
        for <linux-mmc@vger.kernel.org>; Thu, 21 May 2026 00:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779348123; x=1779952923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qZY8FoHrhZ1XR/Ghkk+/h+RYstJWms0XV1rSvT93RfQ=;
        b=MzxPHNT5nyjw8G63TYlQKxeBW1l8DW+45BWrBkeLGQ1Agsax/nfoHTkvT1JsmGKC88
         n7jH28rn+VtOzkzi8Vw80qzwAFnPlO14WzfTxVUi0dovZBY9hu6wbQbYKDShHxu1iEPe
         B1WWQ6oEy/KDdTkMQPMja5IFhP8PpDBcQnE2sKHF7AIlIBk3nIDIIqNwI/wucleGVuZR
         3l+oVIOVI6ZLWjCLfAEq9MG4UECszSdl+9Bq7IE11HSY7iTTfYameAtC/f+Jc8jcdE/e
         N1z7dvMY7UQQTzuzKrkW+gzJpUWhnohzbg4g4BOaDPLd2sE8hwKmQZuZL9gVdu04J/LM
         SVsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779348123; x=1779952923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZY8FoHrhZ1XR/Ghkk+/h+RYstJWms0XV1rSvT93RfQ=;
        b=DnjKkAbQJeKrKl3pWIfD49fc3A8GsSkZiJJl9mxIMzVcy0aneIzXam1edSQq4ikgFm
         h8CXUTUxFu88qzZgCYz9W60YDwmcNZO43boK4yqvTUAvnjSCNF1CHt9972NcrFkXsJ3R
         07aXywfxkOXHBqIBJVq3cnkZ4FXEe+EZQPkibu5+rhRfzz3Vw39HTNFJHqQ6YE9lvDTS
         LZdC16Slmth96qr1VKicwJQzl1m4sp6zyagUA8QQwvfHkug8P1g12BU4fDIi6LxRfruM
         yEgxYwkRwQbrikKMCcrUniGYy6c6yrryhhzdGKaKsOyvh7g206se5VPDDFEpPpwlItvY
         2G/Q==
X-Forwarded-Encrypted: i=1; AFNElJ/+octVpHWg43y+rgAR1IosmntyI3nkpqwSXSlvoS+eoIIGRg9CA7msZE4tyHoF8Oj7ZaDjnm/AUvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxeXt1JLu3j+vcqjuPEfUuv0rljhhOMu2yZHf9OKESnxnPWI3T
	Dkxknt6Es7ew1Y+oLYczu/tqyscXBnj1oGymUo9+ed+maNnonxlM1K7o
X-Gm-Gg: Acq92OHDIArX4iLn1sfiqQlJmPKyX/eidbCL+Q1WFPr4X46RLNyMy5nmXXvZvcR+eyn
	1IkUH295YRJ2O/O5u2hfDveudoXSlMpvJJEyL5sfLj3PBhIx0CGJmHjMMlYkDApXhLZjQVDAYw5
	Q3RlGJJ+sQ3tQreXfOWUlxZc5k6ryh2yZUNL2/wJBksmhsZzAEovyiB9jNWaGut1ovOA5WKD7IV
	nDPh7f/45uYKtK4ZLRpapkfd5VNIx+LfKlnVePMCIcFPEF1sjUb9jJH8pLripndY5gWwTI82Fob
	sR8TP46L6oGBVIC9XlqQCqtE3FBYvg7CY/fswjgP4VKDCtFUQ0XBHIqdM4Twkm2B5P90ZGghV68
	xm3DnDoKdI4aJm14+7q841GjI6F2YTEYQUnJPHm++S17JvvwMSzEcsHXBI8Hzwky/rs1/FU+Olb
	2cleihgbngIrgE+vPXKlH4A+A=
X-Received: by 2002:a05:6a20:e293:b0:398:9379:d04d with SMTP id adf61e73a8af0-3b308867966mr2078161637.24.1779348123052;
        Thu, 21 May 2026 00:22:03 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb123986sm23721016a12.32.2026.05.21.00.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 00:22:02 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Karol Gugala <kgugala@antmicro.com>,
	Mateusz Holenko <mholenko@antmicro.com>,
	Gabriel Somlo <gsomlo@gmail.com>,
	Joel Stanley <joel@jms.id.au>,
	Maciej Dudek <mdudek@internships.antmicro.com>,
	Paul Mackerras <paulus@ozlabs.org>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v5 0/2] mmc: litex_mmc: Set mandatory idle clocks before CMD0
Date: Thu, 21 May 2026 15:21:19 +0800
Message-ID: <20260521072122.1601215-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The litex_mmc driver assumes the card is already probed in the BIOS
and skip the phy initialization. This will cause the command fail
like the following when the old card is unplugged and then insert
a new card:

[   62.923593] litex-mmc f0004000.mmc: Command (cmd 8) error, status -110
[   62.949717] litex-mmc f0004000.mmc: Command (cmd 55) error, status -110
[   62.976606] litex-mmc f0004000.mmc: Command (cmd 55) error, status -110
[   63.002516] litex-mmc f0004000.mmc: Command (cmd 55) error, status -110
[   63.028442] litex-mmc f0004000.mmc: Command (cmd 55) error, status -110

Firstly, fix the clock divider calculation so we can get the right
clock frequency, then add required clock settings and initialization
for the CMD 0, so it can probe the new card.

Test Results:
Rocket:
# dmesg | grep mmc
[    0.109176] litex-mmc 12003000.mmc: LiteX MMC controller initialized.
[    0.256926] mmc0: new SDHC card at address aaaa
[    0.257058] mmcblk0: mmc0:aaaa WC32G 29.7 GiB

Note: it seems like the rocket give a wrong DMA result when the target
address is in main memory.
See issue: https://github.com/enjoy-digital/litex/issues/2464

VexiiRiscv:
# dmesg | grep mmc
[    2.368365] litex-mmc f0004000.mmc: LiteX MMC controller initialized.
[    2.576993] mmc0: new SDHC card at address aaaa
[    2.588966] mmcblk0: mmc0:aaaa WC32G 29.7 GiB
[    2.620197]  mmcblk0: p1

Changed from v4:
- https://lore.kernel.org/linux-mmc/20260517015323.264179-1-inochiama@gmail.com/
1. Add a new patch for fixing clock divider calculation
2. Move everything in the set_ios() callback.

Changed from v3:
- https://lore.kernel.org/linux-mmc/20260426112016.1370929-1-inochiama@gmail.com/
1. Remove patch 1: mmc: litex_mmc: Move litex_mmc_setclk() to bottom for reuse
2. Use set_ios() callback to apply the clock change.

Changed from v2:
- https://lore.kernel.org/linux-mmc/20260424013615.470325-1-inochiama@gmail.com/
1. Remove the added function forward reference and add a new patch
   for moving litex_mmc_setclk() function

Change from v1:
- https://lore.kernel.org/linux-mmc/20260421025052.755471-1-inochiama@gmail.com/
1. use fsleep to replace udelay

Inochi Amaoto (2):
  mmc: litex_mmc: Use DIV_ROUND_UP for more accurate clock calculation
  mmc: litex_mmc: Set mandatory idle clocks before CMD0

 drivers/mmc/host/litex_mmc.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

--
2.54.0

