Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4E035CBA9
	for <linux-mmc@vger.kernel.org>; Mon, 17 Nov 2025 10:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763374372; cv=none; b=pT5/zPeW2JkM4qQZb1Lp2EKAQnnx9HcIwN6wGivQ+fs1bh05zD4m9TbFWYYnQAoH2V1A3hg9EO+heR0fde6ojE2qw4SRR8iNLbu/lnCqB/bhPUCkipAJOHBJ7nD4ZsN16ApU5QRNB3FSrEV5YXdLSCDLMMqfD5X8I9IjQcf7thw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763374372; c=relaxed/simple;
	bh=fsl4GdK0w4fbHXOEuakzruyemXNmcFNvBUEzXjpWhlU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YDk5uahTcoY2s3lAhmUGUYKlKqTSPbPUDqBYpZBcoh750rKlYePHM3rVe10kZQitxJbCCyy1wUELye4/Rh1t+vsNXYuxyo8MiUB18k017xOPWwQuUvOobUFnoSLJfaEHe9mVVuihJ1vHAZLQicQjriHkiiC1+YsXD9tL1CrQV/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=bSkbgMcZ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="bSkbgMcZ"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42b3d4d9ca6so3327531f8f.2
        for <linux-mmc@vger.kernel.org>; Mon, 17 Nov 2025 02:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1763374369; x=1763979169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ha7ZKgbJ8ApHbh7yZc3t28HL0IX/pZtGOjA6oG4SIOk=;
        b=bSkbgMcZiRrDvUdUEmx2PNxM9Z22IWZfI89ROpBxzN8A3zzLKVXlrnaoLX7P3qqGjP
         ndrm075N2BVOMP6jFxuoTHH2xyAi2hVisohOD9trAXOTiXcmLuK2DqKecZvupvE4wHKy
         VdEHZiHz5qTjZmAgUyQbyxhyTXqbsI0ZVWb0Q9rRiinCNcBzZqBmStN+HHt1E+dqP0X6
         U6/IfRRZ44fOqh3BQHNrGWI6K7m7sEcJ5SyJ4Xz2c1dl1cvg4xvoBu+XSDPDJOfFL2iO
         Ql6SpbrSmlk2iq8XiB6Hx7d2YtFFPKOiq1DbfeA1CTGQVxBSWYoB4QSJj1Dh8Q8AYF48
         romg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763374369; x=1763979169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ha7ZKgbJ8ApHbh7yZc3t28HL0IX/pZtGOjA6oG4SIOk=;
        b=w6e1tylvNvIXF3xWw5iWFR33NZG5jXYbxnRSnidYfP5x0dqSEf83nOUe4cIL27aiEd
         woXp7ZRI9aupS9Rp6yG0PNJDsA3tHCIWtpbAL2I+N8Fn6aYQJRmxpxkekaDSzEV+KrqX
         lBkPORDgSRCfILUyQAK7rExNMuBYMNc1HGfE+tdeJv/wTnH4QW3k3CFYI+DzUtTqtbKP
         AA0TWvjwt2IgVPDLu1p04G86fqxQ8W/whuLUKTHMduSJsnTAqnC7vm4lO+gm4UKfRIgQ
         QRmHY74PKQFqM8+4a4eEQjzZI1+2OEumuOXTXI0urplaDJaOxgfHII+MDTy5UXaHos+O
         vfOg==
X-Forwarded-Encrypted: i=1; AJvYcCWZn9FvLOTObT/erWXQzI4Et+cyRhYdrUZWpxpSbO2H2j+4AmSICgk3Ny0aV3uzPcjKxxu2F2qyzWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcpN53pdnpTZ5Te+oFFtrG7Ez/ccKYqNdY3NjjGiJrV4RJ1Lrz
	Pmb0I3O73ty2Xih374weW9PmIeQWA6jeFvjX7VK12NYe93ZQcNAyPC5KbWRdSRTW5u9o5KRP4Ok
	usrUais8=
X-Gm-Gg: ASbGncthqoyiR0yMqKZGgzGqIy/UPlwM4a+QKuBg7LFK/eARvwXNfBo1wOrGpLfGLXH
	grg0CdMb69gRV2dFcoU+39k1YeZTmLpiTnLq32cJs6abYS+O0PY3jUD2joPJKgbkhUFKVWi4C+N
	RPLFdOS1gb3mClWpX5avFQw7bszf8CODHQIevO1kBt9s8RICGEx7VB3MlBUoiScuJLG5H4xXJVT
	qQ5mhUjPeFA3FzQYEpMmZ2M0kuY3gruCtcydW3TaQ/eQjE5i9QawoooPg1vF+od+7pCDenC0tcO
	PUgJzMJ+MIsFr/27rra24tL3mG3ATTs/H7QaXdtHcb3hX1Tbn1ytrO5w6LkhcWUB707BJ/pOQlW
	6MCMPXW0/S64uQgtqmJN2vEIptydgQtgcgw86iTl9ZFS7WBJmLec6Ug+knGdpiWHrciLqk2lPAz
	cD9osJHq9BGD8YtXBeJ1Nk1fdojUIJOnSIvVxnpJgN
X-Google-Smtp-Source: AGHT+IEVUbpzsci7hh2Q7hwO7mZPiaZww0u3tvUbVJ+jQOZMQH5YZIcfcfZVXJpCw60gHMbCsJOs7A==
X-Received: by 2002:a5d:5f47:0:b0:42b:3d9d:c5f8 with SMTP id ffacd0b85a97d-42b59328f50mr10500068f8f.6.1763374368734;
        Mon, 17 Nov 2025 02:12:48 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f203afsm25806958f8f.39.2025.11.17.02.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 02:12:48 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: wsa+renesas@sang-engineering.com,
	ulf.hansson@linaro.org,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	geert@linux-m68k.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 0/3] mmc: renesas_sdhi: Handle resets
Date: Mon, 17 Nov 2025 12:12:39 +0200
Message-ID: <20251117101242.4018208-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series adds suspend/resume hooks for the Renesas SDHI driver. These
are necessary on RZ/G3{E, S}, that supports a power saving mode where
power to most of the SoC components (including SDHI) is turned off.
Resume from this suspend mode is done with the help of bootloader
and it may choose to disable the SDHI clocks, resets after it is
done with the SDHIs.

Reset signal was deasserted/asserted on probe/remove as well to
avoid relying on previous bootloaders. This is also useful for
unbind/bind operations.

Along with it, driver was converted to use
SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() helpers.

Thank you,
Claudiu

Changes in v2:
- in patch 2/3 drop unnecessary code changes in tmio_mmc_core.c
- adjusted the patch description for patch 2/3
- collected tags

Claudiu Beznea (3):
  mmc: renesas_sdhi: Deassert the reset signal on probe
  mmc: renesas_sdhi: Switch to SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS()
    and pm_ptr()
  mmc: renesas_sdhi: Add suspend/resume hooks

 drivers/mmc/host/renesas_sdhi.h               |  3 ++
 drivers/mmc/host/renesas_sdhi_core.c          | 39 ++++++++++++++++++-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 12 +++---
 drivers/mmc/host/tmio_mmc.h                   |  2 -
 4 files changed, 46 insertions(+), 10 deletions(-)

-- 
2.43.0

