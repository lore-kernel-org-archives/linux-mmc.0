Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F31223DC5
	for <linux-mmc@vger.kernel.org>; Tue, 10 Jun 2025 11:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749554208; cv=none; b=ZlafCraDSgiXVninmFhgFKl+m7LrN4vWObS7qXdjfFUTzW88W/9/pGD3KF+A4xnOjgwdfGeHFRc687Bn0DQRX7Ln0ruEltsp0es4Xom+K13cl5yaD8rNNNP5+kI8Sogff/KZLlmh1CPdhN4oRmfBUssApsHiHPmpqIpTwXPPPPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749554208; c=relaxed/simple;
	bh=zDeUcuv0yIbt+CHEosHsPE/6OpchOeANXKzL+3pPZ5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZJ2Jkpftb57bhTqUl38MQBITSh2IVyFwYmyh3dC6nxeMjHiHsYv9BhCNxdQt8TQmsPJXd2iDXk1yS643SyuqyUKdofJ1/DzG96asQ9vSnyPlOo3UQcvwCDGw6Gs1Nx8q0JAHrUl7yppJ4uzUD5Nr6k2JCeU2/7h543uyA3oSoh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AHOfRn2K; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AHOfRn2K"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54afb5fcebaso6351036e87.3
        for <linux-mmc@vger.kernel.org>; Tue, 10 Jun 2025 04:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749554204; x=1750159004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DaisSQk71updXPXwWenQ0eCHUVGGjGQ9tauWhBJXRks=;
        b=AHOfRn2K352HHbttT5Z+D+yaoRH+pl23mWkGaVrmPF9XQR4JzyFwi3b/fTOsTmxwF7
         9W8LWPlVJx6ubYiMoIzvkijlsDVDKHCjpAn3mucnMiJFYhDGh7uLqGSSZGE3ccTRSVsG
         6AoFRduNmUnnNODVMcKrkuq0B+D+TR70ypXCyNG6mxDxNPle8Dq/9/ZgSDTs20muYBey
         M+ohTt6ooiKFv3gnmrHa3E7G3p6WKiOaDAioKQ9hjZcFCK6fTyaYlx6GJiAuZYtUL66F
         6ob/q5GRukWsibxHcoLGYoWDyyCJCLjBk0GF1uZos5KbmiVd05jTDpzl6J0o2XjtK16r
         RcMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749554204; x=1750159004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DaisSQk71updXPXwWenQ0eCHUVGGjGQ9tauWhBJXRks=;
        b=KnvrKgDN6PA7pESsQcZHodMT1A8WAdOcZGnW/8uVlxs960snSH6ZVQLCweYT+82PmR
         ksKk6Kdma2QcxaIC3jYIZpqCyIHfHZcuDXdolRVDG2DnyFbAJ6vDJuS7XYLy38w4Ql3S
         1uKgTQA6f4ItgffTpepzYXvdYn60bOE3V8J+/XFBRSwCc70ELgrts0mP8mX7vwSM0xAS
         KoqIF4FI8CBdvV7kjNyWa0lv2l1pmsRk6l5QiWSHNfTsGqtrHkMSo/RVUOyDfXmoqVnM
         Ze2jPL/7oAfwqIdfCt68ICpimq0RvwrWvdZVMXj09I/l4nL0jXIKXkbU5rLojIb9stru
         Q3Eg==
X-Gm-Message-State: AOJu0Yxm/Cre7M2tfQn2kZGNr3NR2a8p+8V0ENzsO58IeEVARJy2dJZE
	sbD717U4XXkRBJQR6CnBFqY68OwAd70lG/IdY2DrKvD3W9JSFI5F7FIZr8dhiXhr3Ihutn4XW7r
	FOTnfIAA=
X-Gm-Gg: ASbGncs2CuQQXmUDU7FCxK6k/yzXnTg1Sfq6DLSwHn13wCLVLLO2UPvDUDvG3aD1OnQ
	BZmt5b4/YZOhc8gnjUohPd2JWJbw+R1o9PBSW0g+q+Zo+0y3QFZWhL4eoo7VNIJKCm4elFAlEOu
	7zBU8ifPAjMSr2kGITfa5csNT7cKYnaAYCVqp9aw+aDy8TaPe1j5MZYdoZ7HzIfDxebWrAwYG0l
	LMP1Wt/wYbpNpHDua0t+1p06as9k6jBTLOZIlA3ScEfWTTzc9DUtA8k4cdPNZ4asmnNxyWifUSA
	OslfyghzvbcAxmjJNuSA9cJiEodUqA5lEWfjZipbuQXdTagqfxTvF9ed/ki9MoF4a4atubGyqC5
	4eaf+r+pjvUK0ER/GTwAXaoE8Qg5b0tGs3h94
X-Google-Smtp-Source: AGHT+IFY3VnRE9UcSrBVBH5iOgtbkmizeDx0kmpdz4+rinUwu3zbjO++INcIj2dBpGSkxIptNQK/Jw==
X-Received: by 2002:a05:6512:1318:b0:553:515a:5ebd with SMTP id 2adb3069b0e04-55394745ef6mr667032e87.8.1749554204142;
        Tue, 10 Jun 2025 04:16:44 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55367722481sm1500146e87.126.2025.06.10.04.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 04:16:42 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ricky Wu <ricky_wu@realtek.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] mmc: rtsx_usb_sdmmc: Fix error-path in sd_set_power_mode()
Date: Tue, 10 Jun 2025 13:16:23 +0200
Message-ID: <20250610111633.504366-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250610111633.504366-1-ulf.hansson@linaro.org>
References: <20250610111633.504366-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the error path of sd_set_power_mode() we don't update host->power_mode,
which could lead to an imbalance of the runtime PM usage count. Fix this by
always updating host->power_mode.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/rtsx_usb_sdmmc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
index d229c2b83ea9..8c35cb85a9c0 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -1029,9 +1029,7 @@ static int sd_set_power_mode(struct rtsx_usb_sdmmc *host,
 		err = sd_power_on(host);
 	}
 
-	if (!err)
-		host->power_mode = power_mode;
-
+	host->power_mode = power_mode;
 	return err;
 }
 
-- 
2.43.0

