Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795717791;
	b=yFIKHQuELlP2SLN2kNJsI8Ha8HpXxoBdPgi6V4Q4QyV5h1xKidwh783f5Xtll8+nufel
	 hNDGzA7kigtva4XJ5KRYNoAMOLpBgQHUS5+vtXKqr7+LQqJpNYWhSlBNgYMbTzrs6QsxN
	 U5qz+7Tu7FXB1p41jpCGizPzdNPZojVjx0u6ht4hs/qH/uPIsdLlmDo0mKlYJB5UWM46w
	 j7MfiE8rb5JnKSo2ElvBmA8cFDycxCJCVzyyDS+ZUy7GcKs0CfStuzo7BihRKLqZsVP3A
	 6KINK0sm8M/Yqb3H9OWPe8qpJChFn/aBkifKfHFmKIigC6ojT9JZ37rH8ocZ6MxjknA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795717791;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=owBndUl6B98qwPRw0FXk88D41lLAkcYrE6f1l+yGymg=;
	b=vezgP8t4fTihBeUJDHi8y92pG5daq2lPm/yWqcfGXcOwvn+i7k1INj1m54fxTasUJ4GW
	 x2AgFaWYH1T+PfYMKb6dkqfG91wBIyDThdgZYlPhHjYtt/5QuserskxDaYuCevxSHru0s
	 VaieEZ44AHwRbkdmBREkOegVILFobSWoNk6SbOO5pawtjyxnXdWrJ1qHYtils/gCd8vmN
	 UYAiRLTrQiaQDBGnini3fPTm2rDlXz0UNVx1q9/v8qe/wlZo8Edk/IlK6VGE62nydgwoa
	 VkvgosFvQnK0F0XnXqtSKuVoZof9NfRufMIhDKlMpDsTj5f3o7C/98oyTfQJv3E8Ljg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y675L+Sf;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168C5606A32D
	for <linux-mmc@vger.kernel.org>; Thu, 26 Nov 2026 18:29:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 168C5606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y675L+Sf
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4bb85e07aadso90349905e9.1
        for <linux-mmc@vger.kernel.org>; Thu, 26 Nov 2026 10:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795717789; x=1796322589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=owBndUl6B98qwPRw0FXk88D41lLAkcYrE6f1l+yGymg=;
        b=Y675L+SfSBGgIp4gbRlqYw83S3pfbhJAzzPw5nqXcBq6ljlY86fpJGR3BdtNu04vWV
         a9Vyk8hnGgxUIh+vCOimccWs+lPaCJx5sYduXTaBfagVyUQ/r0KYAWbXQPq3cDjTWvlC
         ofDy4WFwyZE8FsOEOQ2HyA5EZi2aQgvwgsY4dXggjYHEI56rDiunjzl+hfCBQo5OOs0L
         B1zg/Z5jkToLM0X4U5RY7eA0Iz+1Kh0mOLmvPndBEg24tSbkspdEHmgrNKYDcOkAItU+
         T4r/80re9A+yDhu0vo1rV90lEu/m+o4UlOe0ANNCxDQAGCk6f7GNUypevDl89XT31IP8
         h2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795717789; x=1796322589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=owBndUl6B98qwPRw0FXk88D41lLAkcYrE6f1l+yGymg=;
        b=k6foyaeh27NY70uhbatPpkl+15QIQ4n0dZagb5li/YjSK2OM4bq2MYQQwMVGk7skav
         vRCSyjIeVPsLWoa30JDJOSvenDJ3NKRrGDVlK2lVg+f8YKmBGvtCQ1ZVgGjcnf8aQvI0
         pyteBqGdPyHE9Z7tqJybzBnnpduVlED47qg/JLU5fq2dlL9/o+ispbXaYOSvhBdGToI0
         6jlgULmUdvwPzRmCldj5QXYuztypjrv/oEez+/irbjTRTcZqqXs7TTaLdssqBoUqCxL9
         Sr/LU6jUxSGeC+8luwjR6x/CfBOSz4RfxdX8gS70lUVRoqe+Y+/21oyxZLBcHrFJzLw6
         re/Q==
X-Forwarded-Encrypted: i=1; AL+hErExlF9oVVT/lHHaeeK1wxIV7BMu/lmb1Dm6j2oOHl11BIZdeUGXOLX8k1oFu7br2HIWefUdabOt88A=@vger.kernel.org
X-Gm-Message-State: APuU4Z9SIJmh9fpvzk+7cSnNXO/ALmcKjiP5fbwlS+uw1a1CDr89oB0F
	Bp2jxVBRf5Z+DSTIzOilL7GEmAA4hl+KczJazs85QUqSEy00Dgzoo8wBPQqihg==
X-Gm-Gg: AZFdTZcwWNkg5wohhK+lhqzWqnwC/V5mDQIrgJ+3SvAgS7JYPTN4VtaccCZYc2Br5I0
	CA10FSdXUB4qrSYwuQ6G2gDc2GtphVgMwKQzRHEHhOHUVHKxFu/CfNO2ybbQbf2xtQfbQ9HF0uX
	K47Dx2S61yqQKNu8q0QzXrKD3glT61k0R8nASGDk1NqfU7MQirUeVdyjUTaHGJRs9EAQboRQB2B
	BNpH55Hmg6FH8cYlv1COSfJNitJ7PNuE6kz+gDwL65EtfQQdnfXT/gUVIGvUzF0N2WkHvMWHgC0
	aMy0HkFs3MNSbiiU3k3blWmprH7pqU/akKmeOuA4CDIdFtDyJJr6vAivDKczwERWTnq2iKiSVG8
	va+w1yiERVPRbaCE/fZELgaZQtv/a2+4hioo3ikvRqhnwxoJx+CpHc+AHFJSmUTaZhmOGuE/ZFC
	d9Bk9ikldI6gjGfAezmQWvFj1JOkrg4daYDAWKEsJBQuSiU/Vp54iJSCHDs/qZqG7RWx7ScbsG0
	j2Xt1ZDcLOhnCsn31DdOEkdiHbk+M/oq2Xli7ibmTr+0Igp7G8uwwz9+F5OCfZ4PspzdywLZJTr
	yOQjjJL7jRDj3N+LIc0QXycV3GGTfxW7j/S2vd92pPl5o++KxtHLzOHYDAbZEqIyAGXL2ATLjzT
	AG/COEi147QBSYsIdRSrq+qYu1lsZsOENR7tx67rx/I/2Iy4b+oB7k8H+6m6/7912CH96MNVdqz
	J/Rs9nCE/5cU4eBET/a25V70N0XJPrz1xUcpKkF5SOOq7VNFidtPraivd0GHoEPqQjS6WEQisrs
	ejNh6iRsvpXBWkipomOtzZ7LD1EPoaUNNVF4Je7gA==
X-Received: by 2002:a05:600c:a087:b0:4bb:5c92:ce22 with SMTP id 5b1f17b1804b1-4bb887fe887mr443791125e9.8.1795717789172;
        Thu, 26 Nov 2026 10:29:49 -0800 (PST)
Received: from jernej-laptop (77-38-7-250.dynamic.telemach.net. [77.38.7.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b2052c8sm42382159f8f.41.2026.11.26.10.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 10:29:48 -0800 (PST)
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
Subject: [PATCH v2 0/3] mmc: sunxi: preparation for A523 UHS support
Date: Thu, 26 Nov 2026 19:29:41 +0100
Message-ID: <20261126182944.3136900-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.56.1
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

This series paves the way for SD card UHS-I support on the A523, which
will follow in a later series together with the A523 clock phases,
delay-chain tuning and the PF bank supply switch.

It improves the DMA setup and error reporting, which the UHS-I work
builds upon: a DMA mask matching the shifted IDMA addresses, IDMA
descriptors built from the mapped DMA segments as the DMA API requires,
and CRC errors reported as -EILSEQ instead of -ETIMEDOUT, so the MMC
core can request retuning.

Tested on H3, H6 and H616 SoCs, on multiple boards, including Tanix TX6
and OrangePi Plus2E.

Changes in v2:
- dropped patch 1, applied to mmc fixes
- rebased on mmc next, which now contains the probe error path fix
  the DMA mask patch depended on
- Link to v1: https://lore.kernel.org/r/20261103183030.81078-1-jernej.skrabec@gmail.com

Best regards,
Jernej

Jernej Skrabec (3):
  mmc: sunxi: Set the IDMA DMA mask
  mmc: sunxi: Build IDMA descriptors from mapped SG list
  mmc: sunxi: Distinguish CRC and timeout errors

 drivers/mmc/host/sunxi-mmc.c | 116 +++++++++++++++++++++++------------
 1 file changed, 77 insertions(+), 39 deletions(-)


base-commit: 299ac25f5af7cbba27d80e4eaa8f9c703c96b2dc
-- 
2.43.0

