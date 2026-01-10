Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6211B81D3
	for <linux-mmc@vger.kernel.org>; Sat, 10 Jan 2026 01:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768007251; cv=none; b=ibFmoVHPdOoLPHNfwPF54VVE6XiCp20c85sHMTUthJky2ysAQ5FWd3N7Wak6tdArp6zMxpYZBIqsMmTnVHW3VdtYR0rwWjWESazVgtD06KIXj2BjTxc9bNZDjETiuJHJ6PJRyNSq4rF+lcecmIj7VpiPQp6ex5B+QLhWfvMNdt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768007251; c=relaxed/simple;
	bh=G3rXZAwEVcy8xpSE0py21ph5FlouaPOccRvHf5EyOpY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZLWslcpRGBCYYWGEbXk3o8rocTB6DJ66ZojeXO5Nny5bXou/BOYE/WYcDMzwOZl05o0WioFiGSkajwO7nNSvm5654jt0Xar5dGZKfPnPuaMoVnI7NsnGTvaEB7uGOUoxziIsGrkj7LvMQ7tvko9WTZOLl3kGDic+RmWNSf6wQvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnbWfqYw; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnbWfqYw"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47795f6f5c0so29644815e9.1
        for <linux-mmc@vger.kernel.org>; Fri, 09 Jan 2026 17:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768007248; x=1768612048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7DHIbUC9kH5ID0D9IUKqXIWIzs+CamKmp3PsS5mVQKg=;
        b=EnbWfqYwzhRhAeV5iS5hCdvGz5Ownv6okCsYZer7wGf7f8a9rtxLpyEwACyTLZfIz8
         XKTTSM1mGyfSZHV/gSvmnkWWKXIXDTCA0ZnGYLFIcgOW/KCiPUSsREJSDqgplzlw3kp/
         mABjmp6anDeyF5ueRpTNElI6Y1Wdv76qCSqQ95MUeJ3gyN992e0nC3emFfthenO5TFi0
         ZLNd7JgNgkyJQeMPQ3rSQl1sVRS61p58p+5/H1gkvam/6xoVvVNod1GCVhe83YQ8cjYB
         Ir/HyDbTkZ8iQDz/Tql223Bpk08Z6tyHnxNScG+tyWRqQsosszL10mtKO8hBQmiUOg2Q
         fqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768007248; x=1768612048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DHIbUC9kH5ID0D9IUKqXIWIzs+CamKmp3PsS5mVQKg=;
        b=vjQFZlgBqHC5VUCnJeIrhFZNZcqb3tE8bJyA0A01KdjH2t0jeCjsDQJRyVKbGM7D1W
         Iz0tsRcmJgrmI6ESNNFvk9Kg6bEODBNIkaLuJPiHya9brYxcQD6JH0g32JZnYPeygVO6
         /ph52X46nJ18+C6iLwSOOw33hMWFq5/XpDBT8YmAv+v0UNK9+Y6d0eyMGBVXLY7aF1cD
         J+wMxA5kdujh4U4AKA5uaVcOsS5fuFWqBywU9ZlazQVflSyGup3GHwsomEsCQ6aaNpYm
         vVbJjXtASNk05UBp9sWIFfYNnMFNf0pClsvIqzdQ7HTDEWrUnRaMohFrNVQ1e3RztT1q
         eXnw==
X-Forwarded-Encrypted: i=1; AJvYcCVZ2AfCJcOtr/GGDiyjVqg8JfTJ+fH47pG8bSK67hKxrjwbiEqmLmefBS6/xogw51ZjJUubU1ZQbYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrD1DRYqKnkrdySUXCO7Vr5ZzYYzBjPHiKpGtJk89JRvOP+sTl
	jlSJUoSc6QpnBDI7wFs0TylrFxtizAsnLHmESn4B/UwWkMnRLW/iqxU8
X-Gm-Gg: AY/fxX4E6aE+yHtRcj2IkacFiWSg5zyjISwaKrKCeAp+o9GzBtpu31I2W3V6OB2Ow7Z
	G+G2qZHT3wx37De2d/I8pQR5TkDDMf1J+ywtrsetxO0b5KD6XRTh27GkObiwDdNXjp9JlhCTw+6
	4TxSAZAEOscHMCsnMJmPmvzR6K907V9fLeslmUSf9n/Gol7qz5mhehEU/SL4CAHJM2unVVCzkTy
	abzrZ9oyOPyi0bYcgW10MWgbJWtcMVDD45BjqmJaKkl8eOFzDGen9iXsNA1Xiv9Bpqz9KMjbmI9
	eyBcDDSWICYEA55jSXeXv18SHR8ERkwXL78kCsPQA8BZ/cVksEZqUT+SP1QtAj5wekF3sORN6Xw
	EUJq5aHelMGDmuPgxUl667iKkoTyy9Jp/QYwA1ZY9d0RqnN16J5Tu7HIh/a/QXxyefKvpM2bp+8
	c5ssS9m/Ufh4+KGBI4QSEArk7ZGoQ4W/gvgsh7gZCb1MgJVgyXrFOnwc09n9W8RtvMjwFbnq0EC
	sIPLQ0=
X-Google-Smtp-Source: AGHT+IEEsvTH07Jlq4vwgEsug+8S14LvBK1JHllAkePtf6I0e5EhJvagWLbuktY7BlslZdmsV7k6Dw==
X-Received: by 2002:a05:600c:4e86:b0:46f:b32e:5094 with SMTP id 5b1f17b1804b1-47d84b5b4fcmr123965385e9.32.1768007248471;
        Fri, 09 Jan 2026 17:07:28 -0800 (PST)
Received: from stor1.home.marco.cx (ip-178-202-227-016.um47.pools.vodafone-ip.de. [178.202.227.16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8717d9e7sm71779475e9.8.2026.01.09.17.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 17:07:27 -0800 (PST)
From: Marco Schirrmeister <mschirrmeister@gmail.com>
To: heiko@sntech.de,
	ulf.hansson@linaro.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Marco Schirrmeister <mschirrmeister@gmail.com>
Subject: [PATCH v1 0/3] mmc: dw_mmc-rockchip: Add stability quirk for NanoPi R76S
Date: Sat, 10 Jan 2026 02:07:12 +0100
Message-ID: <20260110010715.1610159-1-mschirrmeister@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses a microSD stability issue on the FriendlyElec 
NanoPi R76S (RK3576). The board currently suffers from a 400kHz 
retuning loop when the controller attempts to enter runtime-suspend 
during idle periods.

Evidence of the failure in dmesg:
[Fri Jan  2 01:28:02 2026] mmc_host mmc1: Bus speed (slot 0) = 400000Hz 
[Fri Jan  2 01:28:03 2026] mmc_host mmc1: Bus speed (slot 0) = 198000000Hz
[Fri Jan  2 01:28:03 2026] dwmmc_rockchip 2a310000.mmc: Successfully tuned phase to 233
[Fri Jan  2 01:28:04 2026] mmc_host mmc1: Bus speed (slot 0) = 400000Hz

Testing confirmed that the issue can be manually addressed by 
disabling runtime PM via sysfs:
echo on > /sys/devices/platform/soc/2a310000.mmc/power/control

I experimented with various changes in the Device Tree, including 
lowering the bus frequency and attempting to keep the power domains 
active, but nothing stopped the retuning loop.
The issue only went away when I forced the controller to stay active 
by disabling the runtime power management.

This quirk is the only way I have found to keep the SDR104 link from 
crashing on the NanoPi R76S, I am open to suggestions if there is 
a better way to handle this in the driver or the DTS.

Marco Schirrmeister (3):
  dt-bindings: mmc: rockchip-dw-mshc: add rockchip,disable-runtime-pm
  mmc: host: dw_mmc-rockchip: add rockchip,disable-runtime-pm quirk
  arm64: dts: rockchip: add stability quirk to NanoPi R76S

 .../bindings/mmc/rockchip-dw-mshc.yaml        |  8 ++++++
 .../boot/dts/rockchip/rk3576-nanopi-r76s.dts  |  1 +
 drivers/mmc/host/dw_mmc-rockchip.c            | 25 ++++++++++++++++---
 3 files changed, 31 insertions(+), 3 deletions(-)

-- 
2.52.0

