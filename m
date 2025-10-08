Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967A529B8F8
	for <linux-mmc@vger.kernel.org>; Wed,  8 Oct 2025 04:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759897536; cv=none; b=cahiN0jRvx0YCX7Vw+CATqM3UWeHmewB2M4zMrszkUqTnqXUMFjkOCl6WBFtYMLq2PcgkLYn//jEGqqNQRNp8xr0H3vmbzxNWSq/t5CH010s2mrSSMkIhPrW4WCtWa79MdDk2RoJ21sshpmrAZGNUpgxsTKr2ZHoWY9w9/zr1DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759897536; c=relaxed/simple;
	bh=uvo8MURSa2p9gInQUNH+tPgQ6tPqUppd1Zm8dQDK3qM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BB2IbDbSSC7yzwoiN/4SOXLjMZ1RSiEDsEo2kweE3/cmPxETr23wOT4AXu+NCfiUs5mreVaK7FolxKXEcOCH4+jNYmX4i/X6ciBCMGjMBWF+54cp7xCb76W9dT67zleJUq9cgszd+6ri3kkUP6lHZHdHqPqNtqXVNUzsEy9KH/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Rl0ibyTA; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Rl0ibyTA"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b3c2db014easo995687166b.0
        for <linux-mmc@vger.kernel.org>; Tue, 07 Oct 2025 21:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1759897533; x=1760502333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KqPeHNCg3y5qhc7WNVFKhuuhnp6HCa8NSFOoHqEFOX8=;
        b=Rl0ibyTAu29VfN48rdeSWiWt6GE43HU3Itur6UBAOWuf7zz8houvqiiKqXJeVUSfOh
         LQs6KWzJuQVOYZFChaQXrrU+WLfWYU66waRa1Fdf526G6R4c0qbm+uP9tYzioo0R7KgH
         IWuKmhAkvQ9aEH+cM8TUybHUkbHxGjETFwNKkgODJlVJn0OVUbv3RIbXpWMDZ3ZppB7l
         SDdORnGu0VwuJI5xfOm3nK+yd+R4Hrk+JOTyKQLV8bYK3REN1O0QJFPK2b0Wm83iAdEv
         xJT/4olJHGN+/7o8Oi4Eea5Xi6EMQx5kk5QMNMkNGeH/sYBlsl2kduWdNugMMcHF/9Na
         8PCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759897533; x=1760502333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KqPeHNCg3y5qhc7WNVFKhuuhnp6HCa8NSFOoHqEFOX8=;
        b=X+CFiSagk8ObHR8abogmYXfIZZ+kwytty0x+8CMyUzu8GmRfyxlgz6vA1gbntPDtrN
         lCBmKffeCpYZbQQoqbrwce1hpFT7Eu91IcCZuOZVM3j/DFv2N7oQzIKXlbLXqfKts6Ym
         V3Rob+pDZOHwxtbLc97NTC9x8QfZeWbx7LjOaRRqvp1EXZhzhLNqjNJaqFTWZqbBfIjk
         JR1nfFTpba6QfXRsVa7i2d3vmcSVxVDDBRsMqzmOP7dpjg5mlMhBZ3WeB0ANhuh3bh8T
         /buJw6Y4PRxwzH/Mtl+yrYBQSRyX9R8ltTRGRFvlbVVAvkyiMp4WUSHJltDgz1XtuiTr
         iNyQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8FW/ZzvfKTMLrxYiMl8CGQs/wJLykc56KaheC/R0ch9/TZQYc4K2v9zjk/Vwt4521NsscNIHWnHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsFc5BkTL9p7oAOHGDsnfGuYtLLTd/Qa4WkAwwhlZDfrAU7gF3
	TzaDuoBphXtHd/9pkDP1WUfYHP/sbtPDXIja0vYYDfWU147ncw5a2iw0Tkbts34Rexc=
X-Gm-Gg: ASbGncs/lLHchNwuyTkr2k/mjuzt/vmiu82l+ZLLSs/cXTqHNXXhs+9ngGXx88ix1V1
	D8PRDlv9sfcts7jtdXFKseOWAROo+CYfFEjDC5KSs9l0YoU84q4c9UIkqaE/XkVZ4xhP5mvfhbb
	Wo5B+9LPYZ7qu4ikgzJ1+wzn5gzz9GV64nXtUDsVNhfzF1VcHG3iS92nXgToMAUpzAzwcFyrpsu
	dyTXv5llWYxrNQLhPRA1bhEnJj2/mHHI0418oz6c9dGvxbS7+Afgbzd09F63LyBqCMx4WdrKLXC
	hF7kQZM3LXoQUqdoiC1M3MdU3fV4rJxq569NngFykmgFYAJIMUyK9wmdsM1egj9HTkmv9bLDdpl
	9GcLCT6+rPo7xE6HfqQs4PWsBGUyIgJOH3suiDlnm3btRKSPgileaCOTH8dFnTs1nmbK+BHhGhh
	Q=
X-Google-Smtp-Source: AGHT+IHmej4QzXHOIpsaT/87uRiiQOGLrQ5yJC8DCvqwr///MfonEbf7G0dLYffpxIMlynHEt0syPg==
X-Received: by 2002:a17:907:9407:b0:b2b:3481:93c8 with SMTP id a640c23a62f3a-b50aa3921e2mr218794166b.19.1759897532884;
        Tue, 07 Oct 2025 21:25:32 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.59])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4865e77427sm1583124466b.36.2025.10.07.21.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 21:25:31 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: wsa+renesas@sang-engineering.com,
	ulf.hansson@linaro.org,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 0/3] mmc: renesas_sdhi: Handle resets
Date: Wed,  8 Oct 2025 07:25:22 +0300
Message-ID: <20251008042526.3312597-1-claudiu.beznea.uj@bp.renesas.com>
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

Claudiu Beznea (3):
  mmc: renesas_sdhi: Deassert the reset signal on probe
  mmc: renesas_sdhi: Switch to SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS()
    and pm_ptr()
  mmc: renesas_sdhi: Add suspend/resume hooks

 drivers/mmc/host/renesas_sdhi.h               |  3 ++
 drivers/mmc/host/renesas_sdhi_core.c          | 39 ++++++++++++++++++-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 12 +++---
 drivers/mmc/host/tmio_mmc.h                   |  2 -
 drivers/mmc/host/tmio_mmc_core.c              |  2 -
 5 files changed, 46 insertions(+), 12 deletions(-)

-- 
2.43.0

