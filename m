Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE9D2DECB9;
	Tue,  8 Jul 2025 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751982858; cv=none; b=ZtBOUpWeVlekvzEgXSAHr2vc0aAYB39toQmXYNIqY4zMO36I2W9ZLS2tLsBt6qFOGdTa1oytUNWI0ZGEw0VQNT7ld+z8EXUevp93a0MPJETi21G1v9EIaTd9KYQC4isuKnIrdReeTx2LJIqMZl+YIvyMdl1SJk85HTSHC11ErQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751982858; c=relaxed/simple;
	bh=mAhPPavXkKHrE0vcCRSBihqibbUJDweSpxPi7CdwSxk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OISyOXGkulGBpoiX3QB1mdKhW4B2b7IQm2GOG2Q2wRjmA4ErOIXNefnTWWj4VM87n8AneR5qS6/95JWNiC8bYR40Azku2jfGU6+mIrg8buNCUHC7OpfpvG66KiHUg1B/zJsQiuE2MKak6/uSVTRCobtcl49noL1gww3WIw82Djk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K82Ucj3B; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K82Ucj3B"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-450ce3a2dd5so40480655e9.3;
        Tue, 08 Jul 2025 06:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751982855; x=1752587655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vdAQxHLP+3o1vDkIgSOJJSKYu8Xg9Of88cKaUZYEM+4=;
        b=K82Ucj3B2EbwWI1F7YHS3QmK/B0HyzRhpFJubPihSEooECnNpnr9+jfY67GqV/PntQ
         qReAZfQF0hFp6YFog4urd5t7qZ0gtohVVNG3LBq36sxmsXEeF6J9vUoCCEe3S/p5Zq8i
         ah62zwh44rgQ8sn2U6WS+VuRHPqR7RxkzHA7o8Yo5AUquCIGnY/fasMtnN0Oo++DvJhG
         bad5SI5BWOifYSlQnoZvrh1Uc1oeLnBUk159ptC2n0hqfPaaHXmoWa+hwSayF4aeEJ3e
         jwXJAGOXAjzaw5OxtFIuMRN2PACUIjrEC1ce+2E0KWtaNRxJeYmZR/3G2XLDhSTOoWRy
         nRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751982855; x=1752587655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vdAQxHLP+3o1vDkIgSOJJSKYu8Xg9Of88cKaUZYEM+4=;
        b=U5sZUN7v+o2rLMbZDVGNW+xvQHH5DprZ+p/b9OV6TMQhoVHZ6H2lTRD/qzB7lpimtk
         TymM7R798Pt4VBwjqm8sAs9Z4lrQUarJ6tW7fuB7luJsRCS/Qjl5jPy1Zh0vsX1adYJ0
         AnWuIuNZq/UybNVbN0i7NRUociopaQtt6afnels5SM5RXZ8yms1YfA2IESj9NlC5wGae
         TyTW8v6eZt9J1xu0XboB0TRcHtEzQAA0YddXtgw7hdjZM6Q4gNeqNWfrtxmK0uAb70bz
         8ZSJEQKiQ/4ktcURdjVi/r1W7GNcNBAYMIzueoHIp1sj1dsYcYdixDz+uQTJkMeLiokI
         IkXw==
X-Forwarded-Encrypted: i=1; AJvYcCV9hxdZnQqpIjsD7B+ROFYH36nvXGjHg9ve4ktlbWV1ldIVsOTwGzrbkVzoflddTkEODI5Pe4vsY5kg@vger.kernel.org, AJvYcCVI8QQ0VuJEour156pcccamdk2U78E66vmLAaWNOCAyTwvfADwoe76MtB5+wBpzaHHR432mbjDrM8WHZvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcdNN1bTHD4gfNLGH8CvdDV1LaEoQnjEMqWGtvRMHVvPY1JU0h
	uWu07xRoNzdjzXj2WdnvDW7eQX3PEG40Ay0rECw49WS+zhOKYqoN2QO3
X-Gm-Gg: ASbGncuHJkLFkywC+mEIfL0THk3GHgofQaqUnlYejL88w63AaurKzsE2L4jEoj9tW8l
	91DzV093VpprUByY4/90dH5m5Z1lv+HKxNDhDE5UHMA6Uh8XUa40HbxTRbjnjn7zVXSZTHv1ScL
	/oWpO71atJRYRwxVwtvY/vacpmOwg5TxFuijUdpNoDzZ5xk+CpMotxfpL8DK1jhlRkmE//MdHHg
	4PAcVBP6kJhRXkYN6BXEDa0owJR3OhqTmCpprL7IQAJP8NbwJc165frWXZWpdUzHPtSo8XNxEYr
	dRihTetgshODCPgR7AA5PPSxnLItimGjEfqaMBvnbEk0WzhZ/FES0PWX/+qb
X-Google-Smtp-Source: AGHT+IHDlaTBiGQaI1Dnhp8EYZ9SUYXOQKxdp3obYZzKbXLiTVWC4HGItzXoxgc5NcWKLNQvrc+USg==
X-Received: by 2002:a05:600c:a313:b0:453:6ca:16b1 with SMTP id 5b1f17b1804b1-454b5110ed2mr111006615e9.26.1751982855127;
        Tue, 08 Jul 2025 06:54:15 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-454cd3d25e4sm22926675e9.26.2025.07.08.06.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 06:54:14 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Binbin Zhou <zhoubinbin@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] mmc: loongson2: Fix comparison of unsigned integer with less than zero
Date: Tue,  8 Jul 2025 14:53:48 +0100
Message-ID: <20250708135348.1888817-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Colin Ian King <colin.i.king@intel.com>

Currently the u32 variable ret is being assigned the return value from
the call to regmap_read_poll_timeout and checking for a less than zero
error return and this check is always false. Fix this by making ret a
signed integer.

Fixes: d0f8e961deae ("mmc: loongson2: Add Loongson-2K2000 SD/SDIO/eMMC controller driver")
Signed-off-by: Colin Ian King <colin.i.king@intel.com>
---
 drivers/mmc/host/loongson2-mmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/loongson2-mmc.c b/drivers/mmc/host/loongson2-mmc.c
index 515ccf834f0a..ba6bb8fd5535 100644
--- a/drivers/mmc/host/loongson2-mmc.c
+++ b/drivers/mmc/host/loongson2-mmc.c
@@ -485,7 +485,8 @@ static irqreturn_t loongson2_mmc_irq(int irq, void *devid)
 
 static void loongson2_mmc_dll_mode_init(struct loongson2_mmc_host *host)
 {
-	u32 val, pad_delay, delay, ret;
+	u32 val, pad_delay, delay;
+	int ret;
 
 	regmap_update_bits(host->regmap, LOONGSON2_MMC_REG_SEL,
 			   LOONGSON2_MMC_SEL_DATA, LOONGSON2_MMC_SEL_DATA);
-- 
2.50.0

