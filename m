Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F00A3CC7CC
	for <linux-mmc@vger.kernel.org>; Thu,  9 Jul 2026 19:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783625370; cv=none; b=dOBJ10mIpvjd/qgJ2mcyqbT+7sJO/t5ujGzmKreUQVWQrNg3/bSILJ9mOgacGP0+50PaBksln5pICTrcgUSDn1W59kDkE97pp83+VqfWLMYMBNqJNlzeWGa/0xk4bM7SNiTGFgnZSIU9THK+OkJ3akzLxHhm0pKFI5qHet/hW/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783625370; c=relaxed/simple;
	bh=KCRL88UYwQ1FSJOf4LDM7HO191xofB2eq+pUEUSI+DA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lmwopv1SfKcQv7jq3FUgivaEEayqCfyhRfK62MkIzxPuznCxg5vACWgYlaoAR8hYVFPJtEZBio0UwKDtBYUqjyQtz/f25z7V4uDd3Znv9yrz7XwKN6arBTuPTRxspeSYO2sSFi/Y1iU9Btj2Za9hJ+EfkRiDKm2DFz/pYRKi2dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVFmKpqA; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVFmKpqA"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493ec555a26so1176435e9.0
        for <linux-mmc@vger.kernel.org>; Thu, 09 Jul 2026 12:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783625366; x=1784230166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4bu2XDvGDTi01cs99wwcdGNtrPxlcDU/u4Y+5NNptKA=;
        b=RVFmKpqA1MFbXCMqlKbZB2K+1xXfNv8gcekJsNdysS5XfIRPpqTBZs0r8tCvJTv9/+
         j/tD9kJLUMuT7BMEyg3WI/q2H3uFZyzyqMzpLyQvS7Vztj7H7tiwb+Njrxmvn4RtneFm
         djYiIzHkJIQ1c5fYmYwgDroItskbN6+/3/4HhPig2eBcHg3OGEho/WlFoQBMea0I2E6F
         78DNhLwfPyi0WE70iqu9i99+pGaFVLLed8c01t9R2lN4It9CES4HEaifV8RohgOlIEPz
         c8IABY+QtDp6yY1L9ubVZncYgHjbAqR/jkGFNHIVjQ4VlYapyYw1d1Zgp9NzTTYs4hXH
         8ApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783625366; x=1784230166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4bu2XDvGDTi01cs99wwcdGNtrPxlcDU/u4Y+5NNptKA=;
        b=DvD6CMZc7jX3jDifVjhoS2/NmUgy9c7ojwKFm/sxwGZhUUv+PORhIu7XrOVpDUpvpX
         jEnN3ynaEtXge20RTZ99Eex0ocFvhEN1LFXcn9o4sT3gWHahIt5Tc44umBZXnpLspyig
         2nnau4SOZW0xSbLQmZVm7oSu+9gk2vMXVnCHwBehvNdZdmus7COXoPdeeZ1Yb6dV5lJn
         OpdmnBpoz7y/heQedOHoNeeuCWBTdky4JzIa6xybkKydWLH5ot1nUN/qLI/KDc2RV7JL
         7hpa8FxuwG0Iog256QYSTpLaiWfPWAV/pSd/d/gwNGXx9r8MLW4/vWpO+kE3WM/uNCQ0
         y51w==
X-Forwarded-Encrypted: i=1; AHgh+RpzaBxVdun7U2oabxxVIq4YkvbsZdvRCan67+Ns9d4NtHXtsiY74kUggjArv6oNzxaxdYHFWGlpCHY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8qkvruPnD/gBAl8VMsveDG2cD8o70Q9NGZwgK0niNNPY78HYT
	3Q3YBIji55G/QTHzqB/D4ETPH8+FRW6XiqY9CvzuvfwBd0f4iC133bJg
X-Gm-Gg: AfdE7cldD8iIeIbVQRZ3qWpKbGRpaZTEX3J2457D6qROT2zUj14WYYRWr754w4H3Dsi
	iOqHsqZFKPjRSOVr3Wm2sBBOAWIYD+S4pwx+LkNGGMmGTWxj5yoJFNDjakm8HUga6kypUoCFVlr
	gjvxDStOw0J83221GsDEGWYVPy/Pz5a8vCDTPOSRLI877Lfb0hbZKVN8YkzmmbfBPgylxCs4bRc
	cCKBnd7ZLpUDZ9lukOGhfdkPWlvTIeAQlzBeDf7Y7xDrEtjYRmDRm+8iKApv84I2+qghebyiQ7F
	AmW2iPz8PXSFJBB3CJL6pgOrgKgBmyEdvzKLJiyUn9rQQS83sAdyqxNLPO2Ai1S8eOTc5vqaVfR
	yajrGZQq2AhEi85CF9wn+Y/TJ7zgX/EgfLarsKMvDds3SCbaRGvRdOx3FwUn3cJI1q2e/n3n0D5
	bd6n1IllGHP3xqWcLRWACj
X-Received: by 2002:a05:600c:871a:b0:493:edde:33e2 with SMTP id 5b1f17b1804b1-493edde34cbmr36301625e9.32.1783625365851;
        Thu, 09 Jul 2026 12:29:25 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:8fb6:1d85:3dc1:42ab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6ccdbbsm84366045e9.3.2026.07.09.12.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 12:29:25 -0700 (PDT)
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
Subject: [PATCH v19 09/12] mmc: renesas_sdhi: Save and restore IOVS across suspend/resume
Date: Thu,  9 Jul 2026 20:29:06 +0100
Message-ID: <20260709192916.630794-10-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709192916.630794-1-biju.das.jz@bp.renesas.com>
References: <20260709192916.630794-1-biju.das.jz@bp.renesas.com>
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
v18->v19:
 * Updated suspend/resume with scoped runtime calls in suspend.
v17->v18:
 * No change.
v1->v17:
 * No change.
---
 drivers/mmc/host/renesas_sdhi.h      |  2 ++
 drivers/mmc/host/renesas_sdhi_core.c | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index d46598190004..39d915da6f38 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -104,6 +104,8 @@ struct renesas_sdhi {
 	struct reset_control *rstc_axim;
 	struct tmio_mmc_host *host;
 	struct regulator_dev *rdev;
+
+	u32 cache_sd_status;
 };
 
 #define host_to_priv(host) \
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index c4908c09d89d..cec703122b22 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -1400,6 +1400,15 @@ int renesas_sdhi_suspend(struct device *dev)
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
@@ -1430,6 +1439,8 @@ int renesas_sdhi_resume(struct device *dev)
 	ret = pm_runtime_force_resume(dev);
 	if (ret)
 		reset_control_bulk_assert(ARRAY_SIZE(resets), resets);
+	else if (priv->rdev)
+		sd_ctrl_write32(host, CTL_SD_STATUS, priv->cache_sd_status);
 
 	return ret;
 }
-- 
2.43.0

