Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F6835DA5D
	for <linux-mmc@vger.kernel.org>; Sun, 26 Apr 2026 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777202429; cv=none; b=JLmVkiZgHubo1OPI+y912WnaVIyFMzm+uoZDEwfLySx/gYYDhqhFnytwDxoy5c0GQUtIKkxCZ7PQi10SYfNjC4GyzJ+s0Ufbau8n6gXE3g5P7r6eGDLtuqgnDHFb36SZexLXNQ7NaL6fMa+APEz/8jPXd/ZaVPIoYhD1Mf56YKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777202429; c=relaxed/simple;
	bh=JqbJLk14vCGlsCWRweRgQshxSFPu/HWhxsqxliRveAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sg2P+z+poQEibbw69oKdF8oVmmiJPR2knd0Guxx+PhzOtialxMouwQE/jcTOWTTat2SJbTQ9kGgppxiUJ+ihDcv0O4L1b6XbpJ3D1Y6/zaQcrXDybN/vESK+Ma+r6jan0ZmNgRVeJiGn6AFWLs/V5uCuwpjGXR5P8/4/+njz1pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qJFUzOdU; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qJFUzOdU"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c79467f128cso3441875a12.3
        for <linux-mmc@vger.kernel.org>; Sun, 26 Apr 2026 04:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777202427; x=1777807227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UO2VqzqBzg530NbLwBe44sSvOnp4fu4zqGNZVGfqzM0=;
        b=qJFUzOdUc9/WlGI138J+orbq99koLB3XZx2J91K05Uf11oI37pyqHoR26xbHD4ASOQ
         moQS+Kj2iPfSrqZJ1TqvK6BeCpCA+hZZh6cPfSiZfaoEF4ADu9Xl3B7r83FUQ4W7kf+V
         En6bWA1jPd5SOE1tjoCxq5OPL+gfAZqWqip9gUESVTLipSLKdSNVuz1NEFVDbZ05+PZS
         0rWRnM8yKJ7nIyIUggVvi9hiEV0TyT2WBfGdGAlGFAh9SsyOZKtAjT5eWkjw3f7OEreK
         PGJ/mv9tDoFYN9BZoZgDtn9pE0y2sFr0CFOCe2b64onVq1OODD+Rz5fK9Dp8U4G9bBlL
         chHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777202427; x=1777807227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UO2VqzqBzg530NbLwBe44sSvOnp4fu4zqGNZVGfqzM0=;
        b=fIlnZQ5fg2KqvK81J2rx9GpqrvVa/bubzH6kjAlz0lKHRTY7dlUZRHH99HIgoVsvZh
         ayjc5QpFIRTd8OARRuDYqxCnWQ7KsF90wyD7PqpUess0KoZBfjUvByFY0rNu3OAv4y+X
         QBqAdVV+oNYvrb51Ijan7PzUOkDqI/l9jAdsPPgeNpFqWisc0NofKAdX8XD5wjtJKr72
         nDY0Zrn3Yoa9Wqp5wOsE8HSWmRMnaX9YsCK8yLa8HkomtR9QkOQM0jUfYQ0bbuu8Olm5
         qbj9g9vnfaga6fQfk+CZXXpPt48a2N32cpa4lvmEMLu9PL9EGs4d5HbKcoFcTFnmpsYz
         ZhCQ==
X-Forwarded-Encrypted: i=1; AFNElJ8apqFlS2+xoKS9fpmghTHErLEQHwGcVTGJQHfBq3ESrWSeZ/cNOJczgpmKyh8t0T07h1GfOgBrxr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIqYSOds28MfOkRwEmyPHGT1A/kEDGSOO7MRHc52MJsZ8gPiT7
	d3uqU74o/scqwRcVB4mPOexAtAnGIEkE4OrBK+JE0wOOS5ujD7pLjYh9
X-Gm-Gg: AeBDieuaV51vppJGA3aL7iHinwZYPgE0hxMYgKxHUNxO4KFYev7Fd8eDXbwjfC0Q49t
	6dZJFTtZmxZFee4TKFPL1Yali9n4YY1iybzPpFh4FH1GgPru1BTIuEjMVu9ZNvNZarZvsTBULWX
	TZOF+W1xrSrWpc/DKPjJOziL9KusSOquREiygfuS50DkN3RfyOb/6kyNwF1Q4WWCGnL02oW6OaG
	aNP7c4bSZ81LGpXPZVs3Qf1SodzuGK/h6p+bSUkCAirJfQPZgKpCOs0OsBWtKvxdws0qvvD/b7B
	y9qdD/czv7V7CZIYtiyP7w9TAp8EZW7Yc+zpOYaRLgk7L4z5N1Hc0/SSN1Eu0kRRaH04mnMJo85
	rrgX1wNO5bu5VyYWeI0Ku0ozc+w0sdimppBXiJT0RI2CxSMp6+PfRcLGUtFUD+/sL6exDvCG1jP
	XNy/1GMaX4Ta1E6v0VUDML67qehk3v/V/lvA==
X-Received: by 2002:a17:902:d592:b0:2b0:ccad:de1a with SMTP id d9443c01a7336-2b5f9f3aa58mr383468695ad.30.1777202427355;
        Sun, 26 Apr 2026 04:20:27 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff98csm275607105ad.3.2026.04.26.04.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 04:20:27 -0700 (PDT)
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
Subject: [PATCH v3 2/2] mmc: litex_mmc: Set mandatory idle clocks before CMD0
Date: Sun, 26 Apr 2026 19:20:15 +0800
Message-ID: <20260426112016.1370929-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260426112016.1370929-1-inochiama@gmail.com>
References: <20260426112016.1370929-1-inochiama@gmail.com>
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
 drivers/mmc/host/litex_mmc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/host/litex_mmc.c b/drivers/mmc/host/litex_mmc.c
index a8d9c0ece16a..c984398d0803 100644
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
@@ -142,6 +145,12 @@ static int litex_mmc_send_cmd(struct litex_mmc_host *host,
 	int ret;
 	u8 evt;
 
+	if (cmd == MMC_GO_IDLE_STATE) {
+		litex_mmc_setclk(host, SD_INIT_CLK_HZ);
+		litex_write8(host->sdphy + LITEX_PHY_INITIALIZE, 1);
+		fsleep(SD_INIT_DELAY_US);
+	}
+
 	litex_write32(host->sdcore + LITEX_CORE_CMDARG, arg);
 	litex_write32(host->sdcore + LITEX_CORE_CMDCMD,
 		      cmd << 8 | transfer << 5 | response_len);
-- 
2.54.0

