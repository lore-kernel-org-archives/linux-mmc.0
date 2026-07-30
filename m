Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8F941D137
	for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 11:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785411136; cv=none; b=jtkGPscL0buhszmTpZbGp+0RXKua3vHfx0p8C3GA9PV+0RxjCysT9kp+dOnOkhTVzJbluzrlaFpmFuF8Mhv+GCQPXuIMzv1koWViJ1Bqgfs7Ua8FBxEeHB2DPt/8rFhfBrZR4n+Aqu23KWvD2lbJlwXrgUfmjMQEjNhVx9pDhSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785411136; c=relaxed/simple;
	bh=HTajqE9xViNaYOICQgF7NmLo4d/h4of+vEamjcy1SP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HTJCJuxQIV7NJlySqis8CDLAEczh1K1e4gpKENg/4xJqqcC86rb/hjfu4Ot8z5RBWwZaVVjfLjG206vp2/BSmvMec/EYU6m92sQWmzQNKfXTZNd/2FEWzDmfZTEDvSRWGsBah5oxi8YZUdWg1jPFz+cujuO8L5OLHy/gEEkwCBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mH/0JPao; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mH/0JPao"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4956242332dso17333585e9.2
        for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 04:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785411133; x=1786015933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YtZcN7GpDkBg195cOKfiOZQx7Z7+r/eMmI5spAnLmcE=;
        b=mH/0JPao2NQjKNQt9vAg0sV/ibQdgJ3/KymSewZJ3tm1h71FPhwZZh51md4MdvNsUw
         CZA2TgqgdgokEpJbA4j7SKMSPwM1zS2X5XGLZJNU6Pd5dMG4vxmAzG0ZPMZBbNk5Ovmh
         CQrpSU17rw/1Ih2cXQ/JU+jOsyVbjLvjXoYXAw5IFNx7KYMJuu1MoO3Zgw5z7YoP1TRT
         gtFnPIyCp7VYygaD5Hemxg1SlRjoi7bRiMerKxVoYVYC7vx+aCH+pZMZBbPXimL6fjNY
         WHh6TA+/vBxUQRg6PEJmLrKSp/BvjYLrn7VWm2npik48MQ+UGoMqtGxX/6eXw2VhPVS8
         wqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785411133; x=1786015933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YtZcN7GpDkBg195cOKfiOZQx7Z7+r/eMmI5spAnLmcE=;
        b=m2WoxagnFdUy0FuevTtVnDDqFbbGOXlo7t3diIg+rYefmHvUqTCJK0CXIsGCYeKtuY
         ntIUwpw62wYjwHi08omdIun74pQunyz+J3eHUaMIMqlEbdeXhcaRy1RAmIr0iMsTq9n0
         0pb9dcftiXK1Su8kBf7Y8+B9k7I/OsfqSy0yy/9ic6xMkkwXF5Cx8utLzQHenNxJSIVY
         /mhA32Z3s+x518EMZUHORWjm8b0jHZWa+LSZYnaruvTeQK2JOVsanCw0h8UISZ2SStUq
         WA0zddhnnqXBZaaWOuD9IH/MElBmfjIJs5Xmh1dLTK45gobfZ+sMuhf+zAvO/zj37SQ+
         WsUA==
X-Forwarded-Encrypted: i=1; AHgh+RrbEeePUMj07fCehOeX8bKRFquWJIwGb1SDt5kNWjBCukYWtB+DT1gtpLR5Al3Y3bGWLDohMUUQOMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxERS7+htr43qroneieLqXiBKFahmAHOdtnoezfw9afQTSav+Hv
	izZZjZnXpcyVZTYTjr4XvfNWSHW1y/sWcu5vj6M1L4R1TsoqEKKxx/GW
X-Gm-Gg: AR+sD121e4EOy9D3v9+6BgcpgRmOkr0dBb/rvC9mNzCdlE/2uBhhznBQ35M/e1bz2Jk
	Oras+JPr4oVjPFhHvEBbqAaXlfcpKa6Rab5qpHAFBBAhSScAFLZjpM9HVH38abBxL8jVXmZa+Bz
	NfzyOUXCYa71gB9XMkm2tl8SrzywjHRTmZByzhEzRuGEDwLmXNY4tkGyNTon1VeOaTU9mxBrjBA
	OlO5NbMwgdcsOcolzsGbe0Ix3B3a7noLjgICudpDtiA4cU8qYSGT9pfMQhZyqeSeLSQNVyJjoA9
	1z7bdLwA8/mYTch7T3J3qAV8Z7xfCxp/0E3J57v835I3AH0Yqu0pDrl5t5E9LCN+7Uy7428xPfC
	wjjM5Qmm42VyxcuM2keUGT1KkOkXqQ+83J3EtK26IH2RXbFpizDmu8+He8IZVTLC+Bs5yQtcfZz
	QLvwtZzdbRSEjZIL26T53u6qgLQU41yYaIdB+r1nvbptTXSIjsUlmYvodOv7/1pRRrmVYvmEbYe
	UKdYyxzT2HhRQ==
X-Received: by 2002:a05:600c:a0d:b0:492:6f6f:fa42 with SMTP id 5b1f17b1804b1-49800ecf287mr28802595e9.37.1785411132466;
        Thu, 30 Jul 2026 04:32:12 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:eabf:a623:1e7d:c359])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc89351e3sm5737947f8f.29.2026.07.30.04.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 04:32:12 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v23 09/14] mmc: renesas_sdhi: Add write32_hook for CTL_SD_CARD_CLK_CTL register writes
Date: Thu, 30 Jul 2026 12:31:47 +0100
Message-ID: <20260730113200.36456-10-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260730113200.36456-1-biju.das.jz@bp.renesas.com>
References: <20260730113200.36456-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Add a write32_hook, analogous to the existing write16_hook, so that
sd_ctrl_write32() can wait for the SD bus to become idle before
certain 32-bit register writes.

renesas_sdhi_write32_hook() checks whether the target register is
CTL_SD_CARD_CLK_CTL and, if so, waits for TMIO_STAT_SCLKDIVEN via
renesas_sdhi_wait_idle() before the write proceeds. Other registers
are unaffected. As with write16_hook, the write is skipped if the
hook returns a non-zero error.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v23:
 * New patch.
---
 drivers/mmc/host/renesas_sdhi_core.c | 9 +++++++++
 drivers/mmc/host/tmio_mmc.h          | 7 +++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index ebbce7f010be..ba109a15b47b 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -969,6 +969,14 @@ static int renesas_sdhi_write16_hook(struct tmio_mmc_host *host, int addr)
 	return 0;
 }
 
+static int renesas_sdhi_write32_hook(struct tmio_mmc_host *host, int addr)
+{
+	if (addr == CTL_SD_CARD_CLK_CTL)
+		return renesas_sdhi_wait_idle(host, TMIO_STAT_SCLKDIVEN);
+
+	return 0;
+}
+
 static int renesas_sdhi_multi_io_quirk(struct mmc_card *card,
 				       unsigned int direction, int blk_size)
 {
@@ -1203,6 +1211,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	}
 
 	host->write16_hook = renesas_sdhi_write16_hook;
+	host->write32_hook = renesas_sdhi_write32_hook;
 	host->clk_enable = renesas_sdhi_clk_enable;
 	host->clk_disable = renesas_sdhi_clk_disable;
 	host->set_clock = renesas_sdhi_set_clock;
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index b9de03325c58..8d6d65a51be7 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -190,6 +190,7 @@ struct tmio_mmc_host {
 	int (*multi_io_quirk)(struct mmc_card *card,
 			      unsigned int direction, int blk_size);
 	int (*write16_hook)(struct tmio_mmc_host *host, int addr);
+	int (*write32_hook)(struct tmio_mmc_host *host, int addr);
 	void (*reset)(struct tmio_mmc_host *host, bool preserve);
 	bool (*check_retune)(struct tmio_mmc_host *host, struct mmc_request *mrq);
 	void (*fixup_request)(struct tmio_mmc_host *host, struct mmc_request *mrq);
@@ -284,6 +285,12 @@ static inline void sd_ctrl_write32_as_16_and_16(struct tmio_mmc_host *host,
 
 static inline void sd_ctrl_write32(struct tmio_mmc_host *host, int addr, u32 val)
 {
+	/* If there is a hook and it returns non-zero then there
+	 * is an error and the write should be skipped
+	 */
+	if (host->write32_hook && host->write32_hook(host, addr))
+		return;
+
 	iowrite32(val, host->ctl + (addr << host->bus_shift));
 }
 
-- 
2.43.0

