Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915092C158A
	for <linux-mmc@vger.kernel.org>; Sun, 17 May 2026 01:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778982838; cv=none; b=tVSJogZXuZfeMMeoA0Fu2khFiTcmXM7KgmU8B2xjg8oUU1aGVdEzSz8Cy0i8AKhfdio5cb8NodENrmxrJ+qz6kepMiHvmDtkrya1COQXXpi2M1ZNYgCJY2a3TlJ5RRrIjp2iPZFIIySaaZy+mAd2tJPil94Ke1B2Ut+fWkQuBgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778982838; c=relaxed/simple;
	bh=JaVXWMrRZV5aY6IzFGI2uXhAZRPpxXE3JfC0e85gfgc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PPJ9L2pJoYawCAhCvnXAg19s4iO37xb11S/7GEEgOA4Zw0pzU2rInzukaLioppO+xyOXyMkp/Fc7RpVkvKoq9GpZjkY+U7KYOJcItQR4yvJr6pYEwvJeBhDNsoar72FVf1KaHOM2bsTgFvb7n43ye7d04w5rLBVOGzf/+Kdi/2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OH8k5TG3; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OH8k5TG3"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c8026aa4d53so804722a12.3
        for <linux-mmc@vger.kernel.org>; Sat, 16 May 2026 18:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778982837; x=1779587637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ruPNhgJfwlBNQX6sl8b5PNgkfqKs2p0CuWeAsFczdrg=;
        b=OH8k5TG3T8UGfXDx4SmvdsPlsedEgfAIQxA7e2WoRyLjn7094cp9WvxbLQWa4WxbYU
         ASvu5SxGqf7lEgNDIYAiLmr3cY17ZxOynpaVvQ0f7kB1XLGQqTM2mz+xdT6q7iEAz3Ob
         6uB8NxjJOqo4xPLiQ9bOqCvtm933UQ0xcRb03ZIvUAnGNMwxaZywQoPgJ1ITOlQw8nBx
         18U6YDwkIPYRpvimB9HB6MI7nrgVyiEL4jJ+3gxvwk4tx4z+pJCwr+17igMsxBfQrvQ6
         /WANxylw86PFvyRj2jiBarUQFenSQVtgCulUvfedwUQNvnW+LDw8hmls8kRxQk9Mas9+
         ktkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778982837; x=1779587637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ruPNhgJfwlBNQX6sl8b5PNgkfqKs2p0CuWeAsFczdrg=;
        b=eyuc/bueHn2uv/BIUvfgDKmj1p2ppzDwAYDkJAjTaPFU9gjlqsAu10aXE7SR66v+av
         7lmiXeTHVXzx+mh7vLOKn4VtqcDJb40hHC8YlDWolFpiSlL7zSIHc1WHUuUheSD4I59I
         nyFKPMNtb4zOVET9gBWKuxeYBb9ORIUzVOgrf5cMhM/8/Kt+Np9zF9Hz1wGvJWnulA8F
         jty9G2y+/9Ostkfwc/EEadBpUNwBRfMOc8cMvh/7QohLaWqLxWc6h02MxzxkknRQBoqI
         6fl/LkAM2ujxi+jclZrsMyPhsoGMDc7vf8A5ulunuK6Awp/bImtAFEz9e4WlTraKiAXd
         2lkQ==
X-Forwarded-Encrypted: i=1; AFNElJ8q2LSso+US5Mhqxrfemd0bgWP5bglz0BOB7Z0juVGiPzewS0uMBk3XtDTJQ2P6V247QEk59IjOkFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZKUXoHcmMqjKo+yB0MpLqCxq6l0+15tBp4qt1nqNl2zr0AUEP
	OMKEXdXbyhla7d49tD6hOFSMNfs+Umynj9IMKrq7RrD9WQaz2/dctd+T
X-Gm-Gg: Acq92OGTHR6wdkXj70AXx1nnNAWDo/N2PVHJlp3fHpfZ5+csgVMcJJU9A4khQElCm6M
	XPQxLlhC1ULLl6bVz3SSoHue/cvbtWYLQ4mp42VQZ+8TfcK6yCWzjtclOZFlxFL1v+GSKIrolPB
	Y0O1zOHXx1yOlKuVVbzwVodumGogtR8Jvlff2iZ6sayBfJ/5dNdJtJGhSctwd0zangItrY5fSE3
	mYnGfkoNhkZl+PBAuXKGppIm/uxWD+yR6Mj6k7YoUCtFx15k389eFuteIAb9XkBQU2LQMWKgZKa
	RfYDYhSj/mStTOxwx01fbWgw+sPuPa+nNC/xq+tqxU9FFUmzazJH4kbE7saDVpZPqD3SOsAQKOO
	S6B4+NMpUmQZyuRsDjiXH7pCDuHDkS9NP+xNgVMOj3yU7SdP6aiQkwBVeYfirK7N1qCvWRxiLsG
	BeG4KDO3QIKdUnv6S/JuT40TY=
X-Received: by 2002:a05:6a00:12e7:b0:821:7d7e:41cd with SMTP id d2e1a72fcca58-83f33aeb06dmr10650318b3a.10.1778982836830;
        Sat, 16 May 2026 18:53:56 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19664a59sm10351579b3a.1.2026.05.16.18.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 18:53:56 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Karol Gugala <kgugala@antmicro.com>,
	Mateusz Holenko <mholenko@antmicro.com>,
	Gabriel Somlo <gsomlo@gmail.com>,
	Joel Stanley <joel@jms.id.au>,
	Kamil Rakoczy <krakoczy@antmicro.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v4] mmc: litex_mmc: Set mandatory idle clocks before CMD0
Date: Sun, 17 May 2026 09:53:23 +0800
Message-ID: <20260517015323.264179-1-inochiama@gmail.com>
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

Fixes: 92e099104729 ("mmc: Add driver for LiteX's LiteSDCard interface")
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
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
  mmc: litex_mmc: Move litex_mmc_setclk() to bottom for reuse
  mmc: litex_mmc: Set mandatory idle clocks before CMD0

 drivers/mmc/host/litex_mmc.c | 37 ++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)
---
 drivers/mmc/host/litex_mmc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mmc/host/litex_mmc.c b/drivers/mmc/host/litex_mmc.c
index d2f19c2dc673..65d5c728f536 100644
--- a/drivers/mmc/host/litex_mmc.c
+++ b/drivers/mmc/host/litex_mmc.c
@@ -68,6 +68,9 @@
 #define SD_SLEEP_US       5
 #define SD_TIMEOUT_US 20000

+#define SD_INIT_DELAY_US  1000
+#define SD_INIT_CLK_HZ    400000
+
 #define SDIRQ_CARD_DETECT    1
 #define SDIRQ_SD_TO_MEM_DONE 2
 #define SDIRQ_MEM_TO_SD_DONE 4
@@ -449,6 +452,9 @@ static void litex_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct litex_mmc_host *host = mmc_priv(mmc);

+	if (ios->chip_select == MMC_CS_HIGH)
+		ios->clock = SD_INIT_CLK_HZ;
+
 	/*
 	 * NOTE: Ignore any ios->bus_width updates; they occur right after
 	 * the mmc core sends its own acmd6 bus-width change notification,
@@ -459,6 +465,11 @@ static void litex_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	/* Update sd_clk */
 	if (ios->clock != host->sd_clk)
 		litex_mmc_setclk(host, ios->clock);
+
+	if (ios->chip_select == MMC_CS_HIGH) {
+		litex_write8(host->sdphy + LITEX_PHY_INITIALIZE, 1);
+		fsleep(SD_INIT_DELAY_US);
+	}
 }

 static const struct mmc_host_ops litex_mmc_ops = {
--
2.54.0

