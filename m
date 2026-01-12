Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C76D315776
	for <linux-mmc@vger.kernel.org>; Mon, 12 Jan 2026 15:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768232836; cv=none; b=KRqpeTWaT8wi8FjwIzDLmvMYpktBMPxk8A4zHuNF8NL+9a4lwyXoAU0riqUEggJbttTwfXsgmR97AZlsbLu7dEd94kH6kWGPMdU07spAZ05cxb8X1VPDpH2hsL5z0AbgvKG9yAu8PxB4Xj/YfgzVt78VwLXMHdcPda+rEzFZ2HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768232836; c=relaxed/simple;
	bh=vHWFPBypaVR6QO9yY+NIT52Fwn/AnAUPV0IFF36KmuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VGHDSUs3s9ZrpRM4qDagBjqCI/2EZrsvdtjKf1PWGhKqmzuYvggUmDlP/5bbYvMG4aJk5yGyxZBi+XFjQCV0twasC55grAbZxMxGxb23nPNRBaHbjklRT3D6Q1RyHNshD2muxDnZofdGeFreyPzIccI3YQ953DDrr1qsLj7TWQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0myqGsO2; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0myqGsO2"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47d182a8c6cso38880215e9.1
        for <linux-mmc@vger.kernel.org>; Mon, 12 Jan 2026 07:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768232831; x=1768837631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QU+wdPQeGIMx2R82MPiKqXDiY8zUt2eXhqlQOcy8HXY=;
        b=0myqGsO2xvaRKfH8bkgIAHGNfjElsxUKLmD+oEQlq0SmO4RtzHus4Vs4d0PL2BtMhL
         dnGnJUW73JCXZBYKkVQjEf2/PNZmtS/dg3dv6UhiJIhaBgc16QQ7lHpqUmYahVzDGWWM
         qW0L+S8RS3qF+NaGLRqdPe57c6WCz8VE6kgvK8eEJMIJP9b11x9ZLBwwIXZ8SPQkrfo3
         FE5la+wW6HHqnFk7VvTUAonELcwi+qNQMOEVkHecLGmlON/gg9sRKyONt2nJ2wFaQ5aR
         wPruFAjv9ksozvnz/JaEXMyyTZoU1q/FWIFR+/g/Wd471DqPwvXMKK25UXF0YTINBc1E
         hVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768232831; x=1768837631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QU+wdPQeGIMx2R82MPiKqXDiY8zUt2eXhqlQOcy8HXY=;
        b=GWKAi9bF2Nug5jcHD7uAoZ648XQIm7QDsBhpIyullHH3TfDfJNIwrQpH9iYf7g9mYW
         CgrrHBYtdp0bDWGre3S5i7sT3MQ9uymN4rzUZNGgB6FzC7R4NXuxHNKV5OgKzXWyH7EI
         4RBQ2p4cUqZBzVQQFcVTAexVCNMeXOYDjcA3WqU0hYPMThGQvlRuRTEDJe+kj03AoE6H
         EsRhV3oNHc+kEqEb46Z9Gl16eBHSNSImJLXgwLtxkbMV+SQXpJHp9BRvV/OfmIOsUlOV
         YR11uZaupSOls8OrXR3gfOthL2pLOtWSA9Y4FB0UIlie9y9XRdw1cIw0Lbd7X6lGjb67
         TMOg==
X-Forwarded-Encrypted: i=1; AJvYcCW+XWun4uB/qlSCC1m6gu6ffiE7Cx8uKN5s6eoS4T1niPYS9rUBG4iA9g2kz9cFwFG8wSnmcMcZkcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYpw98U6O3Il6hBN1gpdsLg7btwsrbXyzAKYkqPiK8VJCS40Wq
	iZNnAJacT+VH0DdeuUYllf0wLZaeXf1N7vMDrnXZ54n5F4dQ53DDqP7P3UWCxiUDdCc=
X-Gm-Gg: AY/fxX588MlfIlo4pEKBCKYtnV2Xz6wC1irC+xgZailNEmOl3FBo7as+UvmQrzNDfRU
	imB7iOoMJ5qD2VD3PeBqXJghZJACK/pRsDsvDtKd1Wr64uGu2XMT8S7gqCAJhYukhQPhWRyWbzC
	q4eW22yuIujjGRo8bplOlqQUm0pIP27yGumADeOYuuAiNpgqRqaFZ3nYzhfSloxEgKnB1lNC7Zd
	jd9KHupNb1exjBiE4iDRfsfSHxaNcPG+0fo4YZCZs5VBPmPYROcg4eu2/L8KwkRIpDLbjZBvAbh
	UOH+DPBCWjIr4HJ7lxIDWIH4WsB9+IDiuFWJPA+YMXahictxKzqJskQTBgs7o2u8L9OdRriP8sN
	6Lg8OLkLZYpy2DyMstpEyGBQLMnrrwx27mkmg+JlU0YEupfbP/4z2nZdpmRgm5NDp/NpmqElcTL
	EN8U8sB3nEg3XwlE+bVlraZTbNry920wbxWDNLUyyKyMUutffehZBsQfFnPtUgCSyoQtv8O0aR
X-Google-Smtp-Source: AGHT+IGBO9eGPmHs6J445wbi3UmFE0FvHJHaxJck1zKJZ9qqr1A5nU0vnmnEQ4zzMoAofUQG+ru4TA==
X-Received: by 2002:a05:600d:41c9:b0:46e:4e6d:79f4 with SMTP id 5b1f17b1804b1-47d84b21250mr200825905e9.15.1768232830771;
        Mon, 12 Jan 2026 07:47:10 -0800 (PST)
Received: from localhost (p200300f65f20eb047d7efe6100b35af4.dip0.t-ipconnect.de. [2003:f6:5f20:eb04:7d7e:fe61:b3:5af4])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47d8662ffaasm132658945e9.6.2026.01.12.07.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 07:47:10 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-mmc@vger.kernel.org
Subject: [PATCH v2 0/3] sdio: Use bus type function for shutdown
Date: Mon, 12 Jan 2026 16:46:56 +0100
Message-ID: <cover.1768232321.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1799; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=vHWFPBypaVR6QO9yY+NIT52Fwn/AnAUPV0IFF36KmuA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpZRdxpa+mgz/013rdQO8j6edwGc1OkH+Mw4/kK zqyYkMywumJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaWUXcQAKCRCPgPtYfRL+ Tu0eCACAG4l5+26CC1ze23VOiVgBa3fPHJORep2Jda+t4jPg95bAUe4p9gS+vNvJVOfcG2aVPRr FyAV1rHhW2KsTYe5Cq1+o59QCfHLUEqtzninrJGVddD11Q1fxxjRNk02t4EnsM+VF1Yr2J0ESEt 7biNL5m18vKnXOhIgwT3hAjF3b1w/fXvju9KtmxTGHqfaY87xs2sP5OgshyIP4embaIhmlw7WSx Gji5CSpppjxDMFRNYBHBFci2pPQ9wfSpclApLYJ2tvTs1GJrL3GgCNdAivvwcBQ9zu6dC9t+Yds Sn8PQsTAH9oyptg2Humj9sI/TmYe624pn4VsZoZ0S66Qr1IS
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

this series is part of an effort to get rid of the .shutdown() callback
(and .probe() and .remove()) in struct device_driver. Preparing that,
all sdio drivers that up to now use this callback are converted to a new
sdio specific shutdown callback.

v1 is available at https://lore.kernel.org/all/cover.1765968841.git.ukleinek@kernel.org.

Changes since v1:
 - Drop patch 2/4 which resulted in a build failure with CONFIG_PM=n

Patches #2 and #3 depend on the first patch, and with just the first
patch applied there is a runtime warning (emitted by the driver core in
driver_register()) for each unconverted driver. So it would be nice to
get the whole series in during a single merge window to not let users
face the warning.

Given that all drivers are in drivers/net/wireless I suggest to apply
the whole series via the wireless tree.

Best regards
Uwe

Uwe Kleine-König (3):
  sdio: Provide a bustype shutdown function
  wifi: rsi: sdio: Migrate to use sdio specific shutdown function
  wifi: rtw88: sdio: Migrate to use sdio specific shutdown function

 drivers/mmc/core/sdio_bus.c                   | 25 +++++++++++++++++++
 .../net/wireless/realtek/rtw88/rtw8723cs.c    |  2 +-
 .../net/wireless/realtek/rtw88/rtw8723ds.c    |  2 +-
 .../net/wireless/realtek/rtw88/rtw8821cs.c    |  2 +-
 .../net/wireless/realtek/rtw88/rtw8822bs.c    |  2 +-
 .../net/wireless/realtek/rtw88/rtw8822cs.c    |  2 +-
 drivers/net/wireless/realtek/rtw88/sdio.c     |  3 +--
 drivers/net/wireless/realtek/rtw88/sdio.h     |  2 +-
 drivers/net/wireless/rsi/rsi_91x_sdio.c       |  5 ++--
 include/linux/mmc/sdio_func.h                 |  1 +
 10 files changed, 35 insertions(+), 11 deletions(-)

base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
-- 
2.47.3
