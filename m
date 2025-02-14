Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72898263C6F
	for <linux-mmc@vger.kernel.org>; Fri, 14 Feb 2025 12:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739535507; cv=none; b=j18jGla+9vhAv/BnWgqwtgt3JRafMqy/mxJAW0xHaHZGafj+2VOJ5gfiYTTTGxG/nmiauu+xrvqTubSEp9VLhLnUl8+V0I9v61Ap8MAojRxXUaldo/mNuq2gIOx9nDcEy3oVtJx8KOawVKnUesrfm1U2BYC1jVxZiPIp0zu+uuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739535507; c=relaxed/simple;
	bh=7adhrVeGo6H4LUVbse/IZZXrXiXQD9ZHuQw6udBALFI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gtwhNdaY//tUu06H/8RHAJWT/dBel7drz44tUwlaDQD7Ge0T2UHM+QZYa0VMpxopG6O8vXS8AwSUYGYvvZALpCOfOe7Ldw/dBLi2W+VQo0tzns2v+7Qycphqu/SmxOFa5yA0QhabTchLTfn7dr4dnsSKgrtD2JBIAO12UCNqbFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MhAdqCTr; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MhAdqCTr"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30920855d5bso5506431fa.0
        for <linux-mmc@vger.kernel.org>; Fri, 14 Feb 2025 04:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739535502; x=1740140302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XrzvjH3l79+hdw58qHfR52BGxRz04Zk6OgyBxJx9CpA=;
        b=MhAdqCTresI8Ldo2NF1YLJwfP0rr36gW29O2N8ic2ZRptZhWMEUwi0YXqWuHqJ23KC
         SrLrgKlNxLq0QAxewCsKDPSpV2fmeE973IwWia4/dS0LVBz2+YTcv7hxcTIvTiISQAkK
         L60qzc8wL28gHsc29Zoq668HQ9Fw8wFFRqd5HqZ19KEUj++XwbD618rS+722WxILLTYp
         GcZgYheHtSrR5ZMQliYzoFBYJ9KkSymWMNCe4ZuxM+7Pm7VlBqsvI9AE6QaycqnQs8qN
         cp6hAbVVGjqLIOe7cr/f2Ko9K1h0wnFee9bnJV9v/TxNjPV0qvR3scOVWycozexc2UEV
         Axqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739535502; x=1740140302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XrzvjH3l79+hdw58qHfR52BGxRz04Zk6OgyBxJx9CpA=;
        b=O+ZMA5OMh5mgoZ6cEUKzlKbuwlZwsmMaxILuM4YbldDY5QKoITG+VRWaFBIvfyx31A
         S+lAUHybmKwzpMxj7te4TzIT3Sob2HSkmZSSIH2YPwW2s2IUxqIymR3JuRbITcnL+qQ5
         Ho/7xB9MBqL7Xq05I6Awg6wU/8LbBgld+7lBl6/wbUbS/ap9UQTRe6ulH13cGiTbSOu6
         IzJWjuDb8glCxZQEEIghJn1Nt4AYQNXRlVD6BR8BEaiZ1EdS7Clh32LGHscbAfeEqRn9
         6u61yDqIkNSvgC4tSVqDFfrss49tw2wTJctM1SKP4DNZWJV0qlzYySq0PcsabTh857KF
         YGxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdIRha1asX0ADa/FxrVweu9UGql6gYpT++fh2EaGIShHRzDg4k2ktaVMli/wSKGscTWz+pmpRjmIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaOr0scqL66tkZ0mNFz6NsZoMgln6S1pqn4wcRbtr1+1UPFmrz
	dPanDig54itGBbPXfaD6WqIApvylTWB1rl9wOo9T+0AjPFwuPv7PETFXt4y8DOA=
X-Gm-Gg: ASbGncu56FjicfsIEXt8xFsZndNoCWYiD+61QfZkOd0WCy0j8FQwL9yXwHqAhaOJyuK
	XbGMukTfOO+TtzOzvGx2+4K3S/WVwmkIUbI94kWTiJFjmnTyuFM9O32KlcWQ32Ak2nv6hVptw8r
	fZLVWSAd77UFBLmQJ4UwLLrfeOH6Iwxt4GS43stowtBgV3DEozpbUebL/Ncfx0+qBZTFmhCLlXy
	MHaWvNLwsemQuZADvr3SxDYbCZEaCDrqp6xRBjr+qcv6WGEKVv8kmCSPQRpKd8CaLeCVprGHu8V
	VMkZn/umypaY3aA/WyKC7RfFlujwkR8w+AcP3pXgqurBWmM10Zo+ohmlSlDMIMfdCg==
X-Google-Smtp-Source: AGHT+IHGwPkIu7AEThobtQDnIS60RAWChZSIkpJXCQDqrg9REU22/CFOX8p/6/pVOccfoi684zy07Q==
X-Received: by 2002:a2e:7d17:0:b0:309:1f60:82e9 with SMTP id 38308e7fff4ca-3091f60867emr5618761fa.10.1739535502348;
        Fri, 14 Feb 2025 04:18:22 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3092440033fsm777621fa.14.2025.02.14.04.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 04:18:21 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.14-rc3
Date: Fri, 14 Feb 2025 13:18:20 +0100
Message-ID: <20250214121820.100545-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v6.14-rc3. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.14-rc1

for you to fetch changes up to 3e68abf2b9cebe76c6cd4b1aca8e95cd671035a3:

  mmc: mtk-sd: Fix register settings for hs400(es) mode (2025-02-03 13:34:50 +0100)

----------------------------------------------------------------
MMC host:
 - mtk-sd: Fix register settings for hs400(es) mode
 - sdhci_am654: Revert patch for start-signal-voltage-switch

----------------------------------------------------------------
Andy-ld Lu (1):
      mmc: mtk-sd: Fix register settings for hs400(es) mode

Josua Mayer (1):
      Revert "mmc: sdhci_am654: Add sdhci_am654_start_signal_voltage_switch"

 drivers/mmc/host/mtk-sd.c      | 31 ++++++++++++++++++++-----------
 drivers/mmc/host/sdhci_am654.c | 30 ------------------------------
 2 files changed, 20 insertions(+), 41 deletions(-)
