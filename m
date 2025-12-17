Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ECB33B6D7
	for <linux-mmc@vger.kernel.org>; Wed, 17 Dec 2025 11:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765969785; cv=none; b=tMqH66b3Yk4w1Vn/HMxnM1MkPtE0jH5eWeCgu954ydFMumK8pbyyJEy8LuHB2AeOQ7oFupL+I2pZhQYyc4E9ifB2HpI98ljunOa0CJm2+u/nMwLpw4+np8Z0BSAG9rNwUeIHsm/yqhna3xGwKv2G1UpOcC0vWPYyo0PSMP0SuTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765969785; c=relaxed/simple;
	bh=u6SSU7AEZcgA49olidngU6vW2SbxvDPL4yoP3splUH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uBCA7fhWp+SoWsVlzTch2RWh94V+/eIxx2egAYN1K+BgXzs9N3QtgQpLh9dufA0Mv8GcOOZBRVjU6BjVNkdjcBWvgCnUMf2R+uaxy1RtRudJQCHX7x2279AIp8jJhaJVjI4aC18kGoI60TYWno8No0lonLow5MvgR7VIHwA/rck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XFea7ZlQ; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XFea7ZlQ"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b7a72874af1so863645866b.3
        for <linux-mmc@vger.kernel.org>; Wed, 17 Dec 2025 03:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765969781; x=1766574581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UmBYT20UNic55FlAL2fCJm3PAjnMYU3LNhn2MV64R3w=;
        b=XFea7ZlQ+MGmHaY80ClAa+FcCl4G2sA851o27Gur42/lWLCYKRXXXmmRcUbK2YcGlI
         N5U4aU60v4I1NNl9FcRUJrLv7tgjY4p6nAa89/VR58mnGCXyymMAzqB4o1SPJX+WCFC5
         6Jcsz2cWGpxxW69JaKwvBRPqvGB7rRx7m3/05Wt+JgTLLW/R/UcRw9K9sZC+XK0pLUXb
         8uceXQVRVQ4baSOxNhH5AX43jyOuvSCL0Y/fsxITzm3HaJq9XX/tdqEXg8qq1LSX4oKW
         3VerMfo8+f4sK21RrTfuOV18GJWBt7BaieyP1b+4tSUYci64jWKUjL5bk1pc2iypi4Gu
         eAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765969781; x=1766574581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmBYT20UNic55FlAL2fCJm3PAjnMYU3LNhn2MV64R3w=;
        b=Z5oppxFGfkXjgtPgHEZ6/iMFWKIfVCroW2tagjBQJEtXkhVBn0PWY2UoZO/WpJeZar
         0SJAkP5uX49fVWu0hoE2skJv3cRelyjMGQhgDBUSTGCAG3OevQWT1b2jWO0KmXV95NbW
         ro8+f3gwu2JENPZgxRJ7PFHNBunAZo7uestKjrXeIdeogF/hwDMKKgWMVY7qiQop2xe1
         r3NFCckBJpw+KEMiYpdwtq/Npa+pW7w4DQalULiJUI3ZHliOw//MwnQ4kLbUOlcbLkWi
         QoqHnkkSPk3bMX3WasK+C437yo/xAS6lNfeeiFdUyUjgijFzKXoprNXFwWXz8Y3kpyXf
         MRFA==
X-Gm-Message-State: AOJu0Yy6gaeVqbWEC6t3HzMUbNg7H7vfrCDfD51xkc6oZpfGMJfYXUya
	1fBAmPZ9VK+6zBG93N+8EeEyyKpE1jxfZxAeBAandZndCQ9weHzCMZTjgv2cNTdrZ5I=
X-Gm-Gg: AY/fxX7vV4uWJDyU+z9x51hAvGaeqox1f72arAJgIpI7FWWOB7VAHlxRK3QnF6oBeRs
	gCakPlDLHQt0wg2vzoTcEJC9/OA94/oOhGqJiY2kA4mSN++5EH51Zf7fgLlbxcEclySKxOKwE83
	wIZRWd6vjE+uJ7jbc8y/tiflhxyBJ6CFt0JB/biHyFdcOzJVD2BI7TKdUSlf0Ok04uYHshnwm9c
	h71jvdjj+x8u6Sb9/QdYhhVGBmD27uadrKsoyyk8fgJsXCHsJ7HKmDe5z/SHMeYtJDxWUG5pcy3
	sTSkbvKvwzHi2aWk0ppLcN2veNSNLGdY2nCe9psiiJtoAkFZN8MNbFpUMoQEUzvZaq1qQxQLgDq
	wxZsm8RzDC1Q6tBlddio44QvzYvbho9EmnbxKntGjs984KytNu/dEM2YR+MeK1c05prqeqsCq95
	o3a68qtUq2xjbnApImpeyafPGDE48=
X-Google-Smtp-Source: AGHT+IHP2lwM0eOAwU4kuW/KeIcjt+T420AcrYZOAyvIMPTw9kL3NmQQjHrM6H02cP3JMUpfKqbH4w==
X-Received: by 2002:a17:907:94c7:b0:b73:6d2f:4bb8 with SMTP id a640c23a62f3a-b7d235cfe56mr1708920066b.2.1765969780669;
        Wed, 17 Dec 2025 03:09:40 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b8003cb349csm275897866b.68.2025.12.17.03.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 03:09:40 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Karun Eagalapati <karun256@gmail.com>,
	Amitkumar Karwar <amit.karwar@redpinesignals.com>,
	Kalle Valo <kvalo@codeaurora.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH v1 0/4] sdio: Use bus type function for shutdown
Date: Wed, 17 Dec 2025 12:09:22 +0100
Message-ID: <cover.1765968841.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1986; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=u6SSU7AEZcgA49olidngU6vW2SbxvDPL4yoP3splUH0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpQo9ib112h/BhHIrfTmZ5VWzXjLnsL9JWjTpQo mrqmMZ/LP6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaUKPYgAKCRCPgPtYfRL+ Tl7YB/9Vn+Y2f3Z8YdGuQ65byD3ZWTOMOczcQE8Gx7I9v++2bvbkOJ631lOYny2IVlIr51DZbFU nMobGRUitR21SYE50Kdp103W4AIhPxqlNi+gYlUguo3JH+zt7gaYbBJU3GJgJEakR2XHPUrYAgh zbMETOeBSbu/ieH4JtJ+0x3R1Ep3uOXdDpg+MpH9yGxc8qzTb81AbV24kPJetG71cD+5RfV3TW6 UzcA48HqTO+/VZyt7HJ+qZI4RfQmy7LrvUUAtPOgIIp+zs8dVXwUL/CJveZq3ihaywKYKQwzR/q ptYyCmXlcmZ+qjKeRpx1BFNnSnN+4PtAatHBTJv9bu4pLWdW
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

this series is part of an effort to get rid of the .shutdown() callback
(and .probe() and .remove()) in struct device_driver. Preparing that,
all sdio drivers that up to now use this callback are converted to a new
sdio specific shutdown callback.

Patch #2 is just a cleanup I noticed while working on
drivers/net/wireless/rsi/rsi_91x_sdio.c. Note that it's uncommon to have
the shutdown callback conditionalized by #ifdef CONFIG_PM. I guess this
dependency was introduced by mistake in commit 063848c3e155 ("rsi: sdio:
Add WOWLAN support for S5 shutdown state"), but I didn't address it
here.

Patches #3 and #4 depend on the first patch, and with just the first
patch applied there is a runtime warning (emitted by the driver core in
driver_register()) for each unconverted driver. So it would be nice to
get the whole series in during a single merge window to not let users
face the warning.

This series was build tested on amd64 and arm64 using allmodconfig.

Best regards
Uwe

Uwe Kleine-König (4):
  sdio: Provide a bustype shutdown function
  wifi: rsi: sdio: Reduce use of #ifdef for CONFIG_PM
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
 drivers/net/wireless/rsi/rsi_91x_sdio.c       | 11 +++-----
 include/linux/mmc/sdio_func.h                 |  1 +
 10 files changed, 36 insertions(+), 16 deletions(-)

base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
-- 
2.47.3

