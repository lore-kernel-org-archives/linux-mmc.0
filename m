Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B45448BB5
	for <linux-mmc@vger.kernel.org>; Thu, 23 Jul 2026 15:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784819449; cv=none; b=CXkZBFxPHTFq+SeXrtAl+Y6JZMgB3NGnm1An2s6iZg89jl6wBSpcDb4zeSxFElDuDyvWUtfXxy2tIY9MBKpD8kXTArSrKRRpKaFzFDRsGXnNCbvUSAqZBW5/B3WeteiQThThi3XCKIrzU/lXjQRDag9lwn6ulKQyniMWNPgQUdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784819449; c=relaxed/simple;
	bh=AyAyY54zBoSivQOEiGp3ASyCdtZpU1hjqqqjen323BE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rXbRhacVYJ911ozhnfPNkwwzT/SYa66IflkBV+X1Wz8AE5rlfCvEDD6qQ54BJQ5gKA2uwWLSdRIgvmjT74i5CaxNSvaiTQPMWGAMo/kh6gXIIru5Zpn76scitO4lLkaXl2YvhEUT+Gmm589uXSDoAkM/Xf0evxVa5QpBVM5ia7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+QBPiD+; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+QBPiD+"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-475417f010dso594756f8f.2
        for <linux-mmc@vger.kernel.org>; Thu, 23 Jul 2026 08:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784819437; x=1785424237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WVeQmlhXu6vwdJqyFXFnrCGqyIeQoByrr/pflj+7TA8=;
        b=E+QBPiD+c/AP+GbH/1PyJQAJsFaul2XuOUr3vAZA2mY59GLtpn5kpwQ+c0kvwWcl1X
         Udv/GE0Kcb+D7wINGoE2Y8WLbYckxYjP0IfDx0amRzLbFRnW9Gvz0mZ2eoJLwu7C2fLF
         ioV4eNP8sOvU+QciaH/F79HVPhtdVe0aTN1IQF0TyZz8CQIz4TLymRo6GxaPruD9n+Yi
         CZ24mabHfb5dMW9PJgiWAyTQeAK3cGTmYCdtRuMXpZUGfS4Cdsyz6crLPnt2u7b6wpEL
         iZMlOWkp/xW+69jevcZ65A84Lcli8hrwQa/Lt2pXS9jgrFwJG6a0JKvRJssJ+o4ugq4m
         lbJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784819437; x=1785424237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WVeQmlhXu6vwdJqyFXFnrCGqyIeQoByrr/pflj+7TA8=;
        b=Ilol5topbgGpQrDjPVxuUtZiowbr6SwBwo6n4Y0xYn8O8CiMtif+d3rgrfYTC7t+Tp
         DWSsPUU1B0EebuO0zk0BSdfQ/h/yAuJOVcvx5H8HbOp8rcGUY9+PSneY9w21HyCVU5yr
         5lDT55jRLx0yQciNh0Jnk3axYndHF5VRIhCUvDg8lHbHjnIDswdiga3NxIWThPjzp9+U
         VUtJSMXpjIDThvVDvuX8jXQt7eH8qh8r37cBRnk6qDLfynHrY5K0owIwo6UORa93OvCW
         F8F0RNWdLSZq1kSmpXaXZwyLD8BLFqJdZSUaCdDvoY5tB1aCzVJEVOx5AWCrviu4c/NK
         tdAQ==
X-Forwarded-Encrypted: i=1; AHgh+RrfMP3tyqGXne3KxC0CwZzAQr/Wz+3bJPHBZ2XJh4oTZsVK0drtngvN45Guog8K+YfTwYDTZX1BmUc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7lFbmK0KUi2c8DZXt8f2x/8uzRYjLOoKw7V8WFOuWIdorNs6V
	oAQPfbSgXvjYcS1O2krFqndbEaXL/L7ED5EngdYfz54uFdo82muhHAIk
X-Gm-Gg: AR+sD10TjUmfFg+YShWa2lBR+9w1OIE+2h2eq1V0KT17Vu0as5XO7TxmW4z8STnggCc
	oYXrmSqNHyjxC1KnSA9V/r53CjTIlZhzo0G9859Ors00wY49gmvgRSNFCl7oRRzr489WmuzXdXq
	NeaClFG1YZ2i1TdUYOI2h8gdAF6xLeaDjtAqO2SeQjdH8cV+QdpZ6c10xelkBt8PV8FXtaMVTFo
	dTxHm9Kotu2Ydl7RS59l/tgoz2ww/VTlSY/Yrd0Kl/1PoLYuuS1LFfLdVQqQvFl3cUjtCnAGqB+
	pM2Olym/oiIRHPZQue/00AhDBFjWeUgcCUolxV9c0k6ScZak9iW1vuZOzixbds6M8Hq4gDX1Lnv
	adNiOSor8pEMwIMzqgC7aOfI4BYcvi7UoloJhAuvfavddROxQvPcQJGaNgtzYiNZ/pQheJ/toPF
	bW53XehsYY+BlrN/dXi2TYibz7AIg=
X-Received: by 2002:a05:6000:2993:20b0:47f:8e50:93e0 with SMTP id ffacd0b85a97d-47f8e50956emr3651284f8f.39.1784819436709;
        Thu, 23 Jul 2026 08:10:36 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:f073:32ed:a057:cd3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb81dcsm15886823f8f.12.2026.07.23.08.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 08:10:35 -0700 (PDT)
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
Subject: [PATCH v22 10/13] mmc: renesas_sdhi: Save and restore IOVS across suspend/resume
Date: Thu, 23 Jul 2026 16:10:14 +0100
Message-ID: <20260723151024.318918-11-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723151024.318918-1-biju.das.jz@bp.renesas.com>
References: <20260723151024.318918-1-biju.das.jz@bp.renesas.com>
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
v21->v22:
 * No change.
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
index be7720305d32..70ebe5902f6c 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -1424,6 +1424,15 @@ int renesas_sdhi_suspend(struct device *dev)
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
@@ -1453,8 +1462,23 @@ int renesas_sdhi_resume(struct device *dev)
 
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

