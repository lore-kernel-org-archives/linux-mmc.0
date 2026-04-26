Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A74123EAB4
	for <linux-mmc@vger.kernel.org>; Sun, 26 Apr 2026 11:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777202425; cv=none; b=V9tUW7HUwr/MlrcqlhaLyWZhBojqJ/o0rYESXDSMpHm1LcJXKVhnHWVeAgDwuGVukeXcgGnWpDkaHs/DgipQor3EvPCwxvYJ3viO/a7Y0S7bD5Fq0AXlGCQv8R4JtQfD2vwLVnhdRfoma9ZjdotVI3IxHo0+NqXGGFrUs/+XWMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777202425; c=relaxed/simple;
	bh=1w7O9gmWy3sIjAZt3kVQj/T3k7iMftsJrLOirwzWBGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dwwRS3vPXW7LQwXhmRGPOYQlf3bZwUxIfQWn7m3dj+XXcFLky1oF+/rZOikmdgcaOBiTOpbq96ZCZ84s+iWS9zzLQAKrK/nrNy0kkWlvAav0YllJjHqjN8CFvXaCfiCSwlNPPtRBizvwBBByiQ20/N+SoLlrZNuY+wJ48LAUql4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=glEg1iSK; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glEg1iSK"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b2429f98d0so54024765ad.2
        for <linux-mmc@vger.kernel.org>; Sun, 26 Apr 2026 04:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777202423; x=1777807223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BmPCL1+9p5aL+IA2x5xQcxGGT6lF8VCMQislE1nMxSc=;
        b=glEg1iSKhmB7ECb/F+kFOOsam8nLGRhgjFxcoFuRrCFsyv6M4s1AJQQYkFFqJFufdR
         abzHrbe6cTKgNK0ge2NCAOSUeMtc09p5AEm9VPV73WCKBjUmHL7QHwYVIX6mOuA8iI/U
         4lu9KyM9nH2PD2leufG7AbmaiJ1IPSCAz+pBnr+EataP2Alts3ANuWDyJ2muc2ud6OYh
         w+rY+TiZHh3aS5YoQyo4kQPFSperCASfjgb2PVqv8iCNAr14sRGoyR2XZ6Aaq8x51OE5
         vekTxofGsJtnO6Pq/fmJaQ+f5kpqK6JvNVP4Uc7xA3+XID0VBzHBC+BsIIUJsE4fC080
         REng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777202423; x=1777807223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BmPCL1+9p5aL+IA2x5xQcxGGT6lF8VCMQislE1nMxSc=;
        b=gIEF4unKJnhPmnWOJhGWJBv7ibDFFa7GEzLkMkWgf8JuFJRBcIHB6mXeiZZfITfwr5
         Xmu23rYcP0H4KroBrw4KCM30H2z/9ScMTBg53df4hC4ZdJfIciSSWW9aQ34gCK8CJPbj
         X7ktXCXu8JTENwk/9hXzEBty/PZ/zSs97b8rpFBP8Droipst/iX89oFmgiKKzGDR6cpq
         L8tBHv//cwsy0BX8T90m4Ir9hopwRPbZIDec53XA4zk9bEzU7gF1Ekuwu6keGABkQIym
         K4ycqgLDPMRInJN3BDkjSDeCroLAWGDlzalQZtyGnMs93q2DXiQ8SPmehB1/7P51WTcm
         zBgg==
X-Forwarded-Encrypted: i=1; AFNElJ9TWneXniXHax4EOTEJMsM8/4h7r2KwjxkxcGAUDoqO9S1VY0CyYF5tO4vjH+16uMqA1yDPYfXmBeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO2lQJmLUTcf7n8Rmo/o1EnlEUPaRzKgC6mK+QKdjNa2bjLLUA
	LqFMMBlNJGGYc0VC860hMP5zG6JnZ4kNUP3KuGm2UvtFq6X/RtZGSswnIfR3hFVN
X-Gm-Gg: AeBDieuCYn+H5y8KpoT6UhWGlXRnfyiuU94M0Mk4TjZvlJl77WMYCXzRn8tiz3sjqTv
	ytMHfVNLPaxxSfbZyWQ2XsZkvS3YjV8jYU0xjtsvvQhqcqivJFCKyPtKQARSUurAiFB/Qhmr0y4
	7OFpzifrN4BwqzM7ZCi776lbGVStlZNERlSxYq8LvUukRRq0rIEGR37j71J4L3m1/+vRuaevwiE
	hGxggUl1OPUSno1mWvIJkzOdS4H7r9huZN/yIxSGCZ6OybTGF28ouO7WhZ3O3POtk4ZoXVo9pcm
	Cmg8VJoACXMXpXwSk9sWNUnKDZte/O2YoUhy1yTpeRm0un5a+XWZkshsbHKdnj0klR7Z7Nf2qOC
	OFmupn++vVF2ml1Womftgye/9n4BYO17cGiJ7Lp7KmyQG59gLBa8wiC0nqQTt/t1YjwgY4rTL1Q
	zmLyUHM+RyKY6gdC9/kRSyYb6aug8ZOVeJboDwDOvy/Qz8
X-Received: by 2002:a17:902:be0c:b0:2b4:5e65:5d0e with SMTP id d9443c01a7336-2b5f9ea23admr292540915ad.10.1777202422797;
        Sun, 26 Apr 2026 04:20:22 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab3a929sm268451225ad.72.2026.04.26.04.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 04:20:22 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Karol Gugala <kgugala@antmicro.com>,
	Mateusz Holenko <mholenko@antmicro.com>,
	Gabriel Somlo <gsomlo@gmail.com>,
	Joel Stanley <joel@jms.id.au>,
	Paul Mackerras <paulus@ozlabs.org>,
	Maciej Dudek <mdudek@internships.antmicro.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v3 0/2] mmc: litex_mmc: Set mandatory idle clocks before CMD0
Date: Sun, 26 Apr 2026 19:20:13 +0800
Message-ID: <20260426112016.1370929-1-inochiama@gmail.com>
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

Add required clock settings and initialization for the CMD 0, so it can
probe the new card.

Changed from v2:
- https://lore.kernel.org/linux-mmc/20260424013615.470325-1-inochiama@gmail.com/
1. Remove the added function forward reference and add a new patch
   for moving litex_mmc_setclk() function

Change from v1:
- https://lore.kernel.org/linux-mmc/20260421025052.755471-1-inochiama@gmail.com/
1. use fsleep to replace udelay

Inochi Amaoto (2):
  mmc: litex_mmc: Move litex_mmc_setclk() to bottom for reuse
  mmc: litex_mmc: Set mandatory idle clocks before CMD0

 drivers/mmc/host/litex_mmc.c | 37 ++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

--
2.54.0

