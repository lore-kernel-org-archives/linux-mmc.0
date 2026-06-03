Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0F73FD95E
	for <linux-mmc@vger.kernel.org>; Wed,  3 Jun 2026 06:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780469872; cv=none; b=hl3eElJmWyc2qxSn1e+ouKrEb5bkg3MaZfTMovClHnJkGsSTD32rXQN++6OnhGlr1W6liebMm2QrhbI0f9JP310OV70BzXT8X0GryEVzL3ix6l1OVaJzoUVyFI9xCW53vH+iAndjkZGUm/QUGe0NwA1X4Lj00xNDyWTGe82GNUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780469872; c=relaxed/simple;
	bh=CQyKIL+Hk8L1r+uZcNTI0BvcATuWoaXUjyANufv/trc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CL19BR9uNtdMdXXwMCQv5btK2Wl4a8VetAdJkoyZEjmvLU6bsSeajhZ/mxeu5FpXToAEcznI+C2SacBS7QWWf5LlLcAoeAqJzU5rE4e6mrJqS5r9sS0B4T4I1eSq0irdxMIuubcNl/RX59hyXSr/+IWtEdgsfFtSMyKlTbOoxPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y88iuVVE; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y88iuVVE"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490ae94a89eso23375475e9.1
        for <linux-mmc@vger.kernel.org>; Tue, 02 Jun 2026 23:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780469868; x=1781074668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBWFx0Q8TXTvM2GGYsSte2yTUylNdi7118RrwX+m250=;
        b=Y88iuVVEoQZqRytcTM1Tix2STaRiKw+phwHGngikdwZ1wbEHNhZBjXCSr+v4Eoc8/5
         +ph0ogwoJ1KEs13TyY2NXVv6r/jPBTXCyAdb8MUwMSyChnIo74zJL0HWsx4Ny5R++qPU
         KOg/JGtFaFVNfS8wsagl57vYR3i80be2hTN5vlIc90NrJQkDS38T89FBw2crn9L8O6x1
         x9JcMt9PCHqYMJa2YlMbvVK7A1LMjcv2pouIxBF5x4osXEXXhqJEpeubum8+/zKRB+tj
         ryq6pot/hScKWe8y9667axW+PVQ59iAUw7nqkMHMPUjoLyeBrjmC5DnrmXTonywogKX5
         VvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780469868; x=1781074668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QBWFx0Q8TXTvM2GGYsSte2yTUylNdi7118RrwX+m250=;
        b=iho7tpQi0UdY9CdX/MY/jpWeMxhk4UBy398WRbYlxfwIFTGPqFfIDG+EQBYbcXE3yz
         gCyV+BnF9+UMqBRavMFyGUMtKQyIJH1LEkBL28CQTTUPhWLwrn10sQ2JGPh1A4QhYkbh
         e9m3JNS38UHZpHgjuAtgw//7aQS6TLrIKI0iW3+Z7qj7HB+QADBVxTo5iwGVWnpypHBw
         VqEv+pe0QRGsz9q/Dl2F5OI4ghaVAkVluaWNsjkJ+x2clj0VzXKfjlQDinuMubh5YHMg
         J+SJDi6bM/wOR5VkBqmw74wc7FrXeruW25TbN411bc71g6Ot8Ixe/BC1mJPLgBmMBLQc
         OVOg==
X-Forwarded-Encrypted: i=1; AFNElJ/6ldpSroMbUkzJdyndNAeBtXHqZXjk9Dn3lR2kzh+vbM5SSAHwpcStVvWQCBAlMkoyIz9u5VGeZbk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy3ctopr/bb5CtpD323k9lbH9qPTB+QuPkNxfeIRCyhCrS/AkH
	agqaCbh2J2+1W3YJVlWFn76axLcmXtDEEWQluRpg+gb6P7UYvnNdx/nL
X-Gm-Gg: Acq92OEYmcebQwMj2WKwZ1XNWHJPpEKTrzWhfHhCV+LeALnVOpU5IAsHeEJydhxi7cY
	e2bBhcIE+cFKFG4mZz3tBLzKCf8pn4vdEW1kyT7VUGTnAs26YEj6d1NPlZ7ATGzC6o1Vg+alIzB
	2SchEVIBUQw6kYsEjYdEKlb8RJ/5WbBzrZxkFyDVDoVz61aiJ9V/3TCOhb89lRSgQeqHjlxVDa+
	c/iUa6O7tBxr2iag2FNpUZZNiNFtatHdI+4ENqqUXpGf40D7sdIr+KIgrFiNC2xoS86ZTxEWHRS
	imJpflzcN2+Z4h11VTWECZ/sQ5/v1QOGxq66aH+o2N7MgcbLuisir0mS5Cnk4XTadlijDFNTMBE
	uDZxCk3J75vF02abthTt+o+AID9sQ7tUx7h9DfjzEgh8gqeH1U46EuqeZH3LryRxnY/Jatdrc7R
	GQMxSA2ED7jvyQvxztyKXHEM1oWuvZX65h9VhxUZTFf/QBgmjI+b30PjMhTak=
X-Received: by 2002:a05:600c:871b:b0:490:b9ce:a73c with SMTP id 5b1f17b1804b1-490b9ceabdfmr8387875e9.31.1780469867598;
        Tue, 02 Jun 2026 23:57:47 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a700:7301:179c:89ab:19f6:9ba4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b79d90bdsm9001855e9.0.2026.06.02.23.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 23:57:47 -0700 (PDT)
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
Subject: [PATCH v17 12/17] mmc: renesas_sdhi: Save and restore IOVS across suspend/resume
Date: Wed,  3 Jun 2026 07:57:12 +0100
Message-ID: <20260603065731.93243-13-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603065731.93243-1-biju.das.jz@bp.renesas.com>
References: <20260603065731.93243-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

The SD_STATUS register, specifically the IOVS (I/O Voltage Switch) bit, is
not automatically restored after a suspend/resume cycle, causing the
regulator to report an incorrect voltage on resume.

Fix this by caching the CTL_SD_STATUS register value in the renesas_sdhi
private struct at suspend time and writing it back during resume. The
save/restore is only performed when a regulator device (rdev) is present,
as the IOVS bit is only relevant in that context.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * No change.
---
 drivers/mmc/host/renesas_sdhi.h      | 1 +
 drivers/mmc/host/renesas_sdhi_core.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index 6c024e7f69e1..10f634349da9 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -117,6 +117,7 @@ struct renesas_sdhi {
 	struct regulator_dev *rdev;
 
 	unsigned int divider;
+	u32 cache_sd_status;
 };
 
 #define host_to_priv(host) \
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index ee1b1f70c9e3..974acdf110d3 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -1379,6 +1379,9 @@ int renesas_sdhi_suspend(struct device *dev)
 	};
 	int ret;
 
+	if (priv->rdev)
+		priv->cache_sd_status = sd_ctrl_read32(host, CTL_SD_STATUS);
+
 	ret = pm_runtime_force_suspend(dev);
 	if (ret)
 		return ret;
@@ -1410,6 +1413,9 @@ int renesas_sdhi_resume(struct device *dev)
 	if (ret)
 		reset_control_bulk_assert(ARRAY_SIZE(resets), resets);
 
+	if (priv->rdev)
+		sd_ctrl_write32(host, CTL_SD_STATUS, priv->cache_sd_status);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(renesas_sdhi_resume);
-- 
2.43.0

