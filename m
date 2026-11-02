Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793639778;
	b=Z653q9SQxkZSnr/J0i/JgVTmq1HqZdIYl1R3dzRw8bJOI5MkwCJVr2qr0HPo7X3TGBwz
	 MoHP7aLKltEy6bgBSs9GKQlzLDkHKr20YqZRiU8EAWa7OI8Ts2WgKzYgGWef4MmNh+C4v
	 ZBGVXhi3qcv2qJqGjTzGNaK3enXu61WEctoK1osQjIToqwYurWH22GpKOYhmLJWbe1Dce
	 N7Rp4C37cM9UGpcd+VFZjQq13v0JerB1dudA672RNRsgw0EGRDdQymwfmpJFN/9+WU0RT
	 eZk4zM9kQzdrNs3U7f7zcrYr9hheR93kfTdLUzeJ4iY5X3OwEaNEhGE9NuAHVv/4mKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793639778;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=A9NhjEiTs8MY8y/q7o/Otn/Omwz5Gf796OYmmromK3g=;
	b=swyZrA9XyrlqUauAjIjjilXjZI5PlLun5CWn074pR89FY80QNp01i5k/SU6sCVR0a164
	 MQxVV20+Cl4FQcZS8f0iQZCfQKnQ9VyjmQBE0RVY34EzOJK1QkfFT1+C2mmRJ2HzYzvKL
	 VmbWyJytrbDb2mpHpKLPp/59Jwm2y8/67iNyIfZgTdBeVVylU7t4W5vIvBhv7VYPFG51P
	 od/tQ2MLazpW7QlaJuiYLYUPVvK0+mp8P2ObEJaBzlLBfT+nCj5q3m1IRT0VpfcdxEDeh
	 N0v1nlFCaGCNJWkHSPF8eWEGZwwzvkw4unoNgnlfZLRQor/gwwwbFwhyCOwBmxspobg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lha3S2ld;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9C5606A924
	for <linux-mmc@vger.kernel.org>; Mon,  2 Nov 2026 17:16:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F9C5606A924
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lha3S2ld
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48dee593f18so3146597f8f.3
        for <linux-mmc@vger.kernel.org>; Mon, 02 Nov 2026 09:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793639775; x=1794244575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A9NhjEiTs8MY8y/q7o/Otn/Omwz5Gf796OYmmromK3g=;
        b=Lha3S2ldXQeXGGzuOaVI2SSRdupbvuUhMMMZqPcrzn0TEL+roGMSoQmZJGt7kvbldn
         PtzhzYLQM8YHNLLonUCSyFEjCv6T69UDOcXWim4i/qoJ8HD49ZRYMlg+XZi/Yjku3CXK
         etlFsM40qo96ihPVYzEkTsBTcOk7+VAbTCDL8KlruJmfK7cW5Sj55q26jIN0TbIywuPh
         vPRPGqnYYVftcpuSU7V9sopSHJKVxb3oen3SziTWMBPngtAI7fdLQn10gpZu3LWzV31J
         0fI7n1uzHxXqsUE4s/IB4nF665lTVwCRQcNxLTnGNDPEVOA2Kr4mE69VhAM8/K4+1Eey
         5Rvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793639775; x=1794244575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A9NhjEiTs8MY8y/q7o/Otn/Omwz5Gf796OYmmromK3g=;
        b=wm95xiKiMtX4r3HzZhzXHVrWPBYz2whd7MMYibgEGAOHHi99VKqiRcr24Un2TiRFHh
         gv2joZL2pAYyvN+BMvL8mhR++HLMKE+sF0Bl35VtxdUYAK1OWeVZszTTxKLQZIp+h4ol
         HLUyyIeQRNWktcroHtvpk1C/IrCiZOp59bkx3AutXGMu2V076Iecn/33DFHFEWh1upq4
         lbfFTdb7J7Od60zh+8Hq+KnFFqFNXpTDpf722UYsYcRS/zmnptOay2M5buvJA+/kPR5v
         fO6vxE1r5b/hX6XU0LfIj8+Y2NHg3I5+qocZ5z37IyT2R0KPXflFasGR0L4jdqL9cYNg
         KMGA==
X-Forwarded-Encrypted: i=1; AKwUvBzUQXb81bLJvldFWCLt9IYb1vgVKgf9pXR0bWVeLCWMYJjASPQF0JEubCUA0/Pk6plPIwQ8A9SqZ+Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z/DAnu6fEBWK8Cy969d80/AEirXx9sRNp9cJYjOg9iaJnlsFysi
	cFRp9wxjwo+0LM4RkhKIsJ0Ic/yXZUyqGtlkcWlZlZvRse1HxnUHQWp5mQYXTv9PhUS9rQ==
X-Gm-Gg: AYBFou3k0qNyUynGhemUkG6xeVZSq7QOYp0GpDrRiv0kEazkjPVVKW0t2Q1EHP4cikX
	m0rvjaCq9+znwEER00vK0yEucYDdtP15w49kgFCTI6oO1zlIEQWKKtNkeJ6K9KQs4CMqC1pdTiU
	JQ79dGD2aU1qFfRfSa9Co7zi8ytRwti4jJOCyYZC8BofgzPngjom5NZvyD2uHByCmkaKPd5UL3T
	Bprc82bboMbEXEGkK3lpy368uUB/cGHPZpDFWJQTZA9o0VBQkBPYg/ZLBJfByCIKg9zE/mgoyC2
	zHIxZn28rBLpz3ILmKKBNplON7qCWvCvCsge793E0JxafATMkOwCVAyfC3g4UboA4hovl/DhL/N
	IJ07vFaqMnQVPbRQSPtSa2cPcuzzIqO8iIRWX+QAe0hVzYsJfuKwq1Qg5WZVmQEazHNbadqHHFY
	O0TU0yJiWCDJ+UytCfZd3RoaZLpn0ITZieYcb5+Z2AkKxAyZusY14RHVf69ej6TbKJV5/RDTqOO
	JImU6thL1voAtZ2z7ElXnC0+rD19R9AjVdMbTIMMdUJFea3DqlZ+SJ4d0+3Zs/DvrB3b/7/OHp2
	Y5DViTupoCzejWw77QkoOrkHe53vkhKs7qaOOe2mg847wiRX02USIwaK46hOqmU=
X-Received: by 2002:a05:6000:719:b0:48d:fbf4:895d with SMTP id ffacd0b85a97d-48e6e2e7552mr23436272f8f.19.1793639775208;
        Mon, 02 Nov 2026 09:16:15 -0800 (PST)
Received: from debian (ip-78-137-176-146.broadband.digiweb.ie. [78.137.176.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71a4d3e9sm23598760f8f.6.2026.11.02.09.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 09:16:14 -0800 (PST)
From: Pablo Mazzini <pmazzini@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Pablo Mazzini <pmazzini@gmail.com>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next 0/4] wifi: cw1200: add XRadio XR819 support
Date: Mon,  2 Nov 2026 17:15:59 +0000
Message-ID: <20261102171603.368298-1-pmazzini@gmail.com>
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

The XRadio XR819 SDIO Wi-Fi chip, used on the PocketBook Verse and on
boards like the Orange Pi Zero, is a CW1x60 derivative. cw1200 drives
it with a bootloader stage and two firmware differences: channel switch
and join. Patch 2 moves the per-chip firmware into a table first.

Tested on a PocketBook Verse: scan, WPA2-PSK, DHCP and ping.

Pablo Mazzini (4):
  wifi: cw1200: don't update the beacon in station mode
  wifi: cw1200: describe the chips in a table
  wifi: cw1200: handle the XR819 channel switch and join
  wifi: cw1200: add XRadio XR819 support

 drivers/net/wireless/st/cw1200/Kconfig       |   3 +-
 drivers/net/wireless/st/cw1200/cw1200.h      |   3 +-
 drivers/net/wireless/st/cw1200/cw1200_sdio.c |  13 +-
 drivers/net/wireless/st/cw1200/fwio.c        | 121 +++++++++++++------
 drivers/net/wireless/st/cw1200/fwio.h        |  15 ++-
 drivers/net/wireless/st/cw1200/main.c        |   2 +-
 drivers/net/wireless/st/cw1200/sta.c         |  12 +-
 drivers/net/wireless/st/cw1200/wsm.c         |   3 +-
 include/linux/mmc/sdio_ids.h                 |   1 +
 9 files changed, 126 insertions(+), 47 deletions(-)


base-commit: 2c50cd5d10e8723797f28c7978f1f61688e0c0d2
-- 
2.52.0

