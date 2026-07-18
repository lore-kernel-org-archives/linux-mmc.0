Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE953391E7A
	for <linux-mmc@vger.kernel.org>; Sat, 18 Jul 2026 13:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784381934; cv=none; b=S1x1Z2UWqBtuVGvlSwHLyV7UwQYnjtAOLQAkBqviCETSkyZ3OqpoTNBtDAu0cy2QADTEpYdq+FoaIuQGFOjm5mUYNE79aExhzhGBvujiKOjfDtt3Af90RWp3pNySYCW1akHwRNyATJVNBHwJr+1aS9mbV+ZV0/gd8pHRgTyx8Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784381934; c=relaxed/simple;
	bh=5exsGCY/QAdntBzZb1PGM5ydMEHgf9wYpWxkIufUqqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PIuE242Ib+YYnJ9+gjL66lUNLcga74qEUfTE29Rq2xkuUvytKyu5/BTIrwjAuWdUqRRn+nhwFchgvlLRyMroP6npRTRoqCUTe5qb2Unw4WOoFMnBGgKpY7l0yFPeT/W8eT8wo/FDPgjKkO6vAOUqQkJYfZXjKdGyi6fMXYXM8zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RymZQgTg; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RymZQgTg"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49554ebb87dso1862995e9.3
        for <linux-mmc@vger.kernel.org>; Sat, 18 Jul 2026 06:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784381931; x=1784986731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GwVBgYO9MGpUqIKGammrpigKOhLlm2sYqP19awJGrm0=;
        b=RymZQgTgRFyAl4KcfAW3ChrkCDbPQSurbpkgtb5ybiENJ+n6o3o0m6JweSL04ED2DP
         AeOU10h/lyRQfVMZ+gMBhaSZLLtLp3RUYNFra0CNPTzy88KD33jazV/psquBbkiTzHfE
         2kc2jVcaHC5cunwakP5wM/b+s+glDdwr0CCEbPEUZFNGBvIA+PhUOjXMnf6Ob2FHivOb
         GMfqhrAZYQgoCFfAuwPb0IcfOADDLp/xZXRtUEdonGH8nq97ox6COJWyq+gT/KwrNoOB
         XIe7roJ7goLsC/akKng11u3dTwJyJFnCMSuOIw9T+WZgsyiPzNbMRShH2p/letrOzAxm
         Jq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784381931; x=1784986731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GwVBgYO9MGpUqIKGammrpigKOhLlm2sYqP19awJGrm0=;
        b=FXpSxfMIteFoEEqwXecWliwSRlPRbHDJt36W6py+CCef/JzissKiRjRCZTcWHItwbf
         F11AqeMLUecGOGYV8TORcO6UvzA+9mjCX6MnqZqF4He94A1ZrZJb+4N+Sg4kQNe8bpEW
         mXhSSrguF+NPdgWe/zE0w46ro3lgRfkToVIl3edkapIauSMS7aJ1hDvtWO2vc9paChvM
         xAtPOzEqm+X35ZZ/Yt6wC2J+1Qimm2yLtdFHvUsFBWl3tSwgGXv/S5D156PSSr9aD5Hm
         lOwA8u0iHhrACw/mOyYjNJAtqXaTG3uC7O8KKnc4TXhWvAlYcN3LJ9zZ2ZkMSOVLUBFw
         Tnew==
X-Forwarded-Encrypted: i=1; AHgh+RrqXZ6uR5w8/7YF2czenH0t8lF3hOo2700uRN/QpENm5O8Qx2kz1HTiwh1MTEv0fBs+F4km/XdKCTo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrt4UZCuYt6q+122gZfQP+mDmyEIulefR0t8wXTVjYlYYsRX8N
	QAeV72RF/Max5m0gtKpKdUjvscmavMg8QdU93ejUjelTZwBj3srkAvMz
X-Gm-Gg: AfdE7cmRkE1PO1+OTqE9dC4nP9u87RJGBQ07ecnUM31OfzRa9lrNZ2NUUYXSEoJ1CwY
	fVENit2/x/RDVqroDDhpPIXREjqwSaAIw8pitrR1qwBGX5zxRuexHE8fqyru7P3G1fyTvxUUYs0
	Zuq/CE+5NF45srQ3rA80+OoNc+2Q9QsQq9WIhnnyyEbhoOlDM0lKurVDNUdnsxfdnGhdHQOqJqB
	s2V+31RbCo5QI7sEyvG5jIBls1wfhoxcG3O4imsQGFW8L5yvdIk1Kred1FbvhWzTTYESHokfoXY
	PMhMMxHahyZ57RSfS2XzoDs/8Zyrie3qOdRg/EX8oue2+QM8kxPznGoFP7bbAj2Yr8ZGrIeMMQa
	b849X3cfscU0OfLa0RmbJ2BuTttI5kPUTuKCcSr+DLhabRiD4uOUghmcJFeEu9Y4y0Zmj4wNmY3
	9AlAptjFIAK4UEsh5up3g/LhTDngw=
X-Received: by 2002:a05:600c:154e:b0:495:49eb:1ccc with SMTP id 5b1f17b1804b1-4954a3eff56mr80040385e9.13.1784381930911;
        Sat, 18 Jul 2026 06:38:50 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:c53f:e1cf:6009:4c03])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49549c96ff7sm121717845e9.10.2026.07.18.06.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 06:38:50 -0700 (PDT)
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
Subject: [PATCH v21 10/12] mmc: renesas_sdhi: Save and restore IOVS across suspend/resume
Date: Sat, 18 Jul 2026 14:38:30 +0100
Message-ID: <20260718133838.152905-11-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260718133838.152905-1-biju.das.jz@bp.renesas.com>
References: <20260718133838.152905-1-biju.das.jz@bp.renesas.com>
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
v20->v21:
 * No change.
v19->v20:
 * Updated resume() with scoped PM runtime call.
v18->v19:
 * Updated suspend/resume with scoped runtime calls in suspend.
v17->v18:
 * No change.
v1->v17:
 * No change.
---
 drivers/mmc/host/renesas_sdhi.h      |  2 ++
 drivers/mmc/host/renesas_sdhi_core.c | 26 +++++++++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index a085a4cb2e38..e2c26917b884 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -105,6 +105,8 @@ struct renesas_sdhi {
 	struct reset_control *rstc_axim;
 	struct tmio_mmc_host *host;
 	struct regulator_dev *rdev;
+
+	u32 cache_sd_status;
 };
 
 #define host_to_priv(host) \
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index e3ffe790cb21..d5d8afde9bfc 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -1406,6 +1406,15 @@ int renesas_sdhi_suspend(struct device *dev)
 	};
 	int ret;
 
+	if (priv->rdev) {
+		PM_RUNTIME_ACQUIRE_IF_ENABLED(dev, pm);
+		ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+		if (ret < 0)
+			return ret;
+
+		priv->cache_sd_status = sd_ctrl_read32(host, CTL_SD_STATUS);
+	}
+
 	ret = pm_runtime_force_suspend(dev);
 	if (ret)
 		return ret;
@@ -1435,8 +1444,23 @@ int renesas_sdhi_resume(struct device *dev)
 
 	ret = pm_runtime_force_resume(dev);
 	if (ret)
-		reset_control_bulk_assert(ARRAY_SIZE(resets), resets);
+		goto err_assert;
+
+	if (priv->rdev) {
+		PM_RUNTIME_ACQUIRE_IF_ENABLED(dev, pm);
+		ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+		if (ret < 0)
+			goto err_pm;
+
+		sd_ctrl_write32(host, CTL_SD_STATUS, priv->cache_sd_status);
+	}
+
+	return 0;
 
+err_pm:
+	pm_runtime_force_suspend(dev);
+err_assert:
+	reset_control_bulk_assert(ARRAY_SIZE(resets), resets);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(renesas_sdhi_resume);
-- 
2.43.0

