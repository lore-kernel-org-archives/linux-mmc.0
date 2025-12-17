Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3DE347FD1
	for <linux-mmc@vger.kernel.org>; Wed, 17 Dec 2025 11:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765969792; cv=none; b=LzmgOH7t+AoJeN0r4b1KRxhdv3H9/aQKT0+GzPZdKKi4fOuP3a2SjtkZMJPHF3D/Th40iOEGWFhvHSL6sVYxnen/M9Gr+RhTVlOprQ3YcBSMt1AEWAR3rdYsKkVfGCXQOsamc6zjZyUjFbvgzxohKWdDC8jHfnCMwRK5k0ljDFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765969792; c=relaxed/simple;
	bh=SkcAEzo7i/6i/n+AriKV4xHUsY6KE3N6pRVzU1yP/iM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=no/R/QVp3FfVGx9Z0T78+DIFzMgrTjoSlKovvFwfY0JCCtJb00yqq6hBxXMHGsImE3i5RIIANIfrOUaUOHPf4H7/00lBGopDYXCgCn7cRptBixyF2XLSL6KJDMav5inv3nsPEJowutc0a99d8/svxb4HaMjHnFqNEdJcebwQE6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QmQtolJU; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QmQtolJU"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b734fcbf1e3so1127715466b.3
        for <linux-mmc@vger.kernel.org>; Wed, 17 Dec 2025 03:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765969787; x=1766574587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJ5P43t34Lz1EY6AFSYYgZN1NN5lPCazHIAbk5Krusg=;
        b=QmQtolJUuW/qCucTk88jQSAs+EewoXKM64Eir2LcHEslPF9RvPYviN8PVwvt9pP1r9
         3et2hEc4Hwjf/KokfTF60BPnymf4y1N6ZSYyRqJktnsBW5E0v+exMuqzspgXWtHccaWd
         aEQXixQ88FwiUHeLaI78Cu8Ti1v/VW2+m72EuvJRQH2+u38j+ghPkDhLDqwnrPukQ9LS
         NawMoa58rPKeb9DyC8KuJ2tAr/5KgvvP2BYI5ni+ezFsqlK8UpmaHg+8aWKEkV8v/nOn
         d+t5kJGwhXmjyqzlZ5gVtOuar4SgvIlKI35yDvN6USz3a+lfnFK1a3oSP6XNJFyc9y81
         bYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765969787; x=1766574587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uJ5P43t34Lz1EY6AFSYYgZN1NN5lPCazHIAbk5Krusg=;
        b=CWVXk0dRCjsCvO3PKuW4JJ5uWpJzeHAqBB5lO8dawbkBEo/FIuP2cJk02D46ahQ5xF
         ZNY8N7uryM7NShg1wIwYczdvnQRfEEGtl4GhSbu8djZuBHe5Qx6PjNgIgJekAAs5acWd
         0UnvE0Fe5xmY8VvHfVoaSffzIfea5emA4SctKCc1oq9aZy9MKbH4e9XLIZElY1DwbS6y
         Hm0cDY/6UUrCiAFPYNfXf+lMTUv34a165E86yS2DbiFDsjckNuGTv8umkI4kZIMnt+YA
         TcgYo5ZZumatPdSRr9qgcj9T0mV/qEcReJc/0XroYymtVwUpDLFJuS3CH1S5KwzRx0WJ
         geKQ==
X-Gm-Message-State: AOJu0YxUkpgJoxtzqdZGWsjvYAheE+Lfblv7r18rkJxI1zDBzn6wtsr1
	1uBsa23icomSykk81ViX3NtCIn26PTk7n5nYppGp9Dyd7GEWEgr9ww60rCDykjk8KNs=
X-Gm-Gg: AY/fxX7z/G1Ak+lgK4y27wBdpmaZ4i6uoFWIsrdEDHXz1Z5fCVLIKju7KGljUs+2aP0
	MCpey/WxXsETB/Wk1eaVhVNjVuHLWAs8rjBzObs85P0ALfmnjX0v6jr740InuidCo3bpT/pkSUn
	CatxvQam9EpieYNoKpPlxduP+2ihGf5QZFLFZYPvPDjLIAdmGliO4Suxj8mMsYA/+8cq7NZjHHg
	/peP38V3JIjfqLUdJX9sQD65Zzy4Fc/RPkq81ayMatwlsw3KAKVcQqeeDVxmjhtetydc3jhcNvJ
	0aEOn5FiWrqSbnDNmzpavSW8GWguuewU+4saF4iLoP91FeBjn09BjGiA8t2OrQmxsarv+fb+q1T
	7+j1Ed9ZzVqPVSTP5Ee/T9jTkfKwT5SjFmW1nklMHxsIL35/rP86+h2OxOTCr/gIQbvyLyqG368
	UQxM6M5FZGE7luR7KX
X-Google-Smtp-Source: AGHT+IFvzs7gbTYqNv/IrH+Io0Hb2O1HvOFutj73wppNa2IfoOa9tOxTbg/zFDsIuwFGVu6mAhmfDA==
X-Received: by 2002:a17:907:3e08:b0:b7c:e758:a79d with SMTP id a640c23a62f3a-b7d238fa0cemr1785176866b.37.1765969786896;
        Wed, 17 Dec 2025 03:09:46 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b7cfa5c8e59sm1971004466b.62.2025.12.17.03.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 03:09:46 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-mmc@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/4] wifi: rtw88: sdio: Migrate to use sdio specific shutdown function
Date: Wed, 17 Dec 2025 12:09:26 +0100
Message-ID:  <fc0282fa38f4c62fdadecc5622d7388c3d12657f.1765968841.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765968841.git.ukleinek@kernel.org>
References: <cover.1765968841.git.ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4923; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=SkcAEzo7i/6i/n+AriKV4xHUsY6KE3N6pRVzU1yP/iM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpQo9sOPlvqvTSgB0Q3DAfkaqL3uclOe0t2At8i JEhuGlvagCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaUKPbAAKCRCPgPtYfRL+ Tv8hB/93CYUMggD8g4pqmoGjAUQVzbPT4ksM0WDss7kaMLvVS0XImkhyFkgEbWW6KFn2F2FQanb QmUjimhEXuk5lYyJzHZ0k5cYaVHr1/RuqItYa9ApNf0Jypi9px3vIuimCyc2W4BS5VL8kktRgSP 0U2CLhl63nX6Mb141tWWp83k2SY8fquzEY96jXtq7/mM2yGVf1gx9whJLhjBmKJpaqwShFh0zFU WIvZ7HzM9pUDmSvs4f6KHIXrIs+YSPU6XJinKn3sQu76t9LYN5aKbzgQXjJ+EV8x71O296GnuV7 HIAiHU/uy8Vt73PfImZRzg4o7zYiBdYGMecyOE/2AIJn80xd
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

This saves a cast in the driver. The motivation is stop using the callback
.shutdown in rsi_driver.drv to make it possible to drop that.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8723cs.c | 2 +-
 drivers/net/wireless/realtek/rtw88/rtw8723ds.c | 2 +-
 drivers/net/wireless/realtek/rtw88/rtw8821cs.c | 2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822bs.c | 2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822cs.c | 2 +-
 drivers/net/wireless/realtek/rtw88/sdio.c      | 3 +--
 drivers/net/wireless/realtek/rtw88/sdio.h      | 2 +-
 7 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723cs.c b/drivers/net/wireless/realtek/rtw88/rtw8723cs.c
index 1f98d35a8dd1..2018c9d76dd1 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723cs.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723cs.c
@@ -23,9 +23,9 @@ static struct sdio_driver rtw_8723cs_driver = {
 	.id_table = rtw_8723cs_id_table,
 	.probe = rtw_sdio_probe,
 	.remove = rtw_sdio_remove,
+	.shutdown = rtw_sdio_shutdown,
 	.drv = {
 		.pm = &rtw_sdio_pm_ops,
-		.shutdown = rtw_sdio_shutdown
 	}};
 module_sdio_driver(rtw_8723cs_driver);
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723ds.c b/drivers/net/wireless/realtek/rtw88/rtw8723ds.c
index 206b77e5b98e..e38c90b769a2 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723ds.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723ds.c
@@ -28,10 +28,10 @@ static struct sdio_driver rtw_8723ds_driver = {
 	.name = KBUILD_MODNAME,
 	.probe = rtw_sdio_probe,
 	.remove = rtw_sdio_remove,
+	.shutdown = rtw_sdio_shutdown,
 	.id_table = rtw_8723ds_id_table,
 	.drv = {
 		.pm = &rtw_sdio_pm_ops,
-		.shutdown = rtw_sdio_shutdown,
 	}
 };
 module_sdio_driver(rtw_8723ds_driver);
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821cs.c b/drivers/net/wireless/realtek/rtw88/rtw8821cs.c
index 6d94162213c6..58e0ef219cdc 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821cs.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821cs.c
@@ -23,10 +23,10 @@ static struct sdio_driver rtw_8821cs_driver = {
 	.name = KBUILD_MODNAME,
 	.probe = rtw_sdio_probe,
 	.remove = rtw_sdio_remove,
+	.shutdown = rtw_sdio_shutdown,
 	.id_table = rtw_8821cs_id_table,
 	.drv = {
 		.pm = &rtw_sdio_pm_ops,
-		.shutdown = rtw_sdio_shutdown,
 	}
 };
 module_sdio_driver(rtw_8821cs_driver);
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822bs.c b/drivers/net/wireless/realtek/rtw88/rtw8822bs.c
index 744781dcb419..2de9b11540c5 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822bs.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822bs.c
@@ -23,10 +23,10 @@ static struct sdio_driver rtw_8822bs_driver = {
 	.name = KBUILD_MODNAME,
 	.probe = rtw_sdio_probe,
 	.remove = rtw_sdio_remove,
+	.shutdown = rtw_sdio_shutdown,
 	.id_table = rtw_8822bs_id_table,
 	.drv = {
 		.pm = &rtw_sdio_pm_ops,
-		.shutdown = rtw_sdio_shutdown,
 	}
 };
 module_sdio_driver(rtw_8822bs_driver);
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822cs.c b/drivers/net/wireless/realtek/rtw88/rtw8822cs.c
index 322281e07eb8..b00ef4173962 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822cs.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822cs.c
@@ -23,10 +23,10 @@ static struct sdio_driver rtw_8822cs_driver = {
 	.name = KBUILD_MODNAME,
 	.probe = rtw_sdio_probe,
 	.remove = rtw_sdio_remove,
+	.shutdown = rtw_sdio_shutdown,
 	.id_table = rtw_8822cs_id_table,
 	.drv = {
 		.pm = &rtw_sdio_pm_ops,
-		.shutdown = rtw_sdio_shutdown,
 	}
 };
 module_sdio_driver(rtw_8822cs_driver);
diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index 99d7c629eac6..ebd7636e2408 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -1412,9 +1412,8 @@ void rtw_sdio_remove(struct sdio_func *sdio_func)
 }
 EXPORT_SYMBOL(rtw_sdio_remove);
 
-void rtw_sdio_shutdown(struct device *dev)
+void rtw_sdio_shutdown(struct sdio_func *sdio_func)
 {
-	struct sdio_func *sdio_func = dev_to_sdio_func(dev);
 	const struct rtw_chip_info *chip;
 	struct ieee80211_hw *hw;
 	struct rtw_dev *rtwdev;
diff --git a/drivers/net/wireless/realtek/rtw88/sdio.h b/drivers/net/wireless/realtek/rtw88/sdio.h
index 3c659ed180f0..457e8b02380e 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.h
+++ b/drivers/net/wireless/realtek/rtw88/sdio.h
@@ -166,7 +166,7 @@ extern const struct dev_pm_ops rtw_sdio_pm_ops;
 int rtw_sdio_probe(struct sdio_func *sdio_func,
 		   const struct sdio_device_id *id);
 void rtw_sdio_remove(struct sdio_func *sdio_func);
-void rtw_sdio_shutdown(struct device *dev);
+void rtw_sdio_shutdown(struct sdio_func *sdio_func);
 
 static inline bool rtw_sdio_is_sdio30_supported(struct rtw_dev *rtwdev)
 {
-- 
2.47.3

