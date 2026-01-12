Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F4D32862A
	for <linux-mmc@vger.kernel.org>; Mon, 12 Jan 2026 15:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768232836; cv=none; b=uI3g7BsOx18pNLG519IYRRZ6XXWl6TpH6JrmQkXXTy7q62ZpvaL/X64DF5gvHvve9iCyc4spcx+SIVds68xJzMHjJtfafGkB8Rg+Q7GYHbxlfsyojiD3/SinHjRwBv3cN7iRr+llBeuSEVoeRp2qxr5z640Tj8x0p+vd8UZSsUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768232836; c=relaxed/simple;
	bh=xWvN8DVqDcWBo/v4eE8MagMMQU8shW2qXTVYsch0jko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uq+L8NAg8C3kmOkF13vGAmVY7s3Qrc8q3XdC7ihqB1/u++Lv9ghzr2fWc3zIMbK2z8JIK616G34OQAFen+Xof9w0Ie9GFOqst4IiouG7pij3bbhEjVbPpuWukUmJhEMZH1tNiFc5JW2sJ+IB68rVnZu6vVYzTNHq/s3WfvUeo64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DxDppMfm; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DxDppMfm"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-477a219dbcaso52265785e9.3
        for <linux-mmc@vger.kernel.org>; Mon, 12 Jan 2026 07:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768232832; x=1768837632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFxo7q8Upg9sDha34TIZTJlyln1hXfyfUaUuvCwVFgI=;
        b=DxDppMfmu7v1ZUTXUkl1nzzWHhbVGp6EMe/36fZFsPk3SMDIrr3ytHmej65yHmEKQG
         0tP2BxbOfQMhQLVJFTvV0Xxc/hZkc8tZ0/Z2KmP63h13LYFJHYgj3khcqJmjoE+uxgSp
         Gh5iNG0331tk086F1GUPzfpZ8hI33qD0sfPNxw1EPBNhiRb746OFQvai61v3L+BNH90Z
         hVh5Z8Nbettdp1A4YqiZj0zZrASoiTdn5yOxSOQOgTW+MXdLdBShxYPonXspKyzAC+5d
         xQzfNyb8TLuIiQF18WYcRoW2e3QOzi+lVdcho0VBWFioNzXntsYLnp2QN5+tA2FiZ5z8
         nmkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768232832; x=1768837632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SFxo7q8Upg9sDha34TIZTJlyln1hXfyfUaUuvCwVFgI=;
        b=sGzdVh0b2HUI9gHF4gv4n3z6n4j91D5eU94+KGrZtN/NYL0LPsZj8elO1kXIUq/jbQ
         vzKze2jZm/c4BDrTO0q+QwUfK5o2FoK7WxnFUNu/pp9UApP6qS0TVZTN0t8EG3hHck2b
         cNgeIZgKIHduo4CCXzVtam8uK4rDK1+8ydjOMeF/JDuycHOCSGZAu0GNPXQiD/JOHNm4
         uDLRO6l9SvrDQWdjUF0PFFetqWhUlrA8uONTnqhhDxHNyjlW4RQitExseG+ZTFSGqAMk
         pfO6w5ayQAsLDZLGCn+Infc/KKhrNEgJxMyUhKXkTtMVmvhigDJIk3H0qkAmI3iVkjin
         Yrkg==
X-Forwarded-Encrypted: i=1; AJvYcCWXGG6WnT/yg2bZTxuWctBbXr/J5YllM3lc8mmSu1rAwxRCgZTGskyKkMBj2H8myjFekgxZ6S0FP48=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLRUivxB7NLte4vXrjKgWF3tMhr5LdkYFV+zwL+Z4C0IWENSUL
	t1QaFXAsbSd/fx9rqgEJQwSvBp3MzhveZxe4XYncaBE6kesAki/YOCuC0EqKo7RGoUg=
X-Gm-Gg: AY/fxX7aTe9vGxinGlXE8BGIxr0ZIZT5UwnFGa+c4/mfmj1lss36GsP5jFFfocTXezd
	KiVKz7//MZ+IkC2Kkn4kGm6yCfxZK0V/Gs7q+50wrz+tdRqmNnlfPNHAlSGcsfgCNYOwI7Vt+/k
	AH8YYu5eusrftPAoA47tiIa93OtISSuZoxrJtdbk3JapJ9b+RPG9yoSlvKwdHL68iUAb+UPMYQL
	8SLKJzWcQCEP2ESXac7LuRmOFhXrpq8mwag7N/g0W1q55BzecE7fCleajKoH9mnRAs0tZNSyWzK
	ANcyRZZTLi4h+TgeEMdTYVj0mb3WPrtVMn7fH/xTTk0+b27Upm2q1QuizlyNaOJdJnkTtaceznD
	5EOnc+buud+NXTNotpjr3esJJDLK7XzNuCYPJfTS0Tb+jT6SZzOL2hppHtkmdg3TjB69/By5ZY/
	EkKSuVoXSpKb64TRyVGURu+E24S6tQfEksjpPSskvNjhPEgPC51p8jqYccirg6XGKo4DJm2cbK
X-Google-Smtp-Source: AGHT+IFGY3WIybFukjEnPQTkxRYatH3BAcQKn6aQe/w3mmQye7zIiF4J3pVH+tGK00tq4SSxhSzDGg==
X-Received: by 2002:a05:600c:840f:b0:47b:d949:9ba9 with SMTP id 5b1f17b1804b1-47d84b1895fmr223043065e9.13.1768232832566;
        Mon, 12 Jan 2026 07:47:12 -0800 (PST)
Received: from localhost (p200300f65f20eb047d7efe6100b35af4.dip0.t-ipconnect.de. [2003:f6:5f20:eb04:7d7e:fe61:b3:5af4])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47d7f410c6csm373106935e9.1.2026.01.12.07.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 07:47:12 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-mmc@vger.kernel.org
Subject: [PATCH v2 1/3] sdio: Provide a bustype shutdown function
Date: Mon, 12 Jan 2026 16:46:57 +0100
Message-ID:  <397f45c2818f6632151f92b70e547262f373c3b6.1768232321.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1768232321.git.u.kleine-koenig@baylibre.com>
References: <cover.1768232321.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2714; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=xWvN8DVqDcWBo/v4eE8MagMMQU8shW2qXTVYsch0jko=; b=owGbwMvMwMXY3/A7olbonx/jabUkhsxU8ZLt5TUqVs7H5utvntW9QOHFe69wBvVzGcukDKyco 3NnWst2MhqzMDByMciKKbLYN67JtKqSi+xc++8yzCBWJpApDFycAjARg7Xsfzjt5Vb8SPhxk2vX 4eXvnp5dxJn1q+v88UNRPq5FDnWddr3nfy56pszEqKq53GNf8Iq3f2Y/s2rb7TC/OkS6qSfHLEi nzDfw/2utC/4XuAuXn1z0VcfDRMJaZuc9tz/fZlnYuafyxchf7mp+UmDf58YvszG0+/ulJcskfe tFO5fFdu7YJiCwl+kNx8wz5hFLnnQYHVjIZCM8fVvWCv/JKSst/6Vnbvp8UoXRagbz8Z67L1Jup 5umb+Sbelj7xbmYg97cG1lKalLXXJQS6+JsMvf/aOTDZRW9SiHCK7zqld8/E4u0Io95b4MKXALS uG5qnbolqLFOaNojpspcl1qhJct4I/7M2XZLdarrqsRCAA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

To prepare sdio drivers to migrate away from struct device_driver::shutdown
(and then eventually remove that callback) create a serdev driver shutdown
callback and migration code to keep the existing behaviour. Note this
introduces a warning for each driver that isn't converted yet to that
callback at register time.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/mmc/core/sdio_bus.c   | 25 +++++++++++++++++++++++++
 include/linux/mmc/sdio_func.h |  1 +
 2 files changed, 26 insertions(+)

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index 10799772494a..6e5bdc2f0cc8 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -232,6 +232,15 @@ static void sdio_bus_remove(struct device *dev)
 		pm_runtime_put_sync(dev);
 }
 
+static void sdio_bus_shutdown(struct device *dev)
+{
+	struct sdio_driver *drv = to_sdio_driver(dev->driver);
+	struct sdio_func *func = dev_to_sdio_func(dev);
+
+	if (dev->driver && drv->shutdown)
+		drv->shutdown(func);
+}
+
 static const struct dev_pm_ops sdio_bus_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(pm_generic_suspend, pm_generic_resume)
 	SET_RUNTIME_PM_OPS(
@@ -248,6 +257,7 @@ static const struct bus_type sdio_bus_type = {
 	.uevent		= sdio_bus_uevent,
 	.probe		= sdio_bus_probe,
 	.remove		= sdio_bus_remove,
+	.shutdown	= sdio_bus_shutdown,
 	.pm		= &sdio_bus_pm_ops,
 };
 
@@ -261,6 +271,14 @@ void sdio_unregister_bus(void)
 	bus_unregister(&sdio_bus_type);
 }
 
+static void sdio_legacy_shutdown(struct sdio_func *func)
+{
+	struct device *dev = &func->dev;
+	struct device_driver *driver = dev->driver;
+
+	driver->shutdown(dev);
+}
+
 /**
  *	__sdio_register_driver - register a function driver
  *	@drv: SDIO function driver
@@ -272,6 +290,13 @@ int __sdio_register_driver(struct sdio_driver *drv, struct module *owner)
 	drv->drv.bus = &sdio_bus_type;
 	drv->drv.owner = owner;
 
+	/*
+	 * This driver needs updating. Note that driver_register() warns about
+	 * this, so we're not adding another warning here.
+	 */
+	if (!drv->shutdown && drv->drv.shutdown)
+		drv->shutdown = sdio_legacy_shutdown;
+
 	return driver_register(&drv->drv);
 }
 EXPORT_SYMBOL_GPL(__sdio_register_driver);
diff --git a/include/linux/mmc/sdio_func.h b/include/linux/mmc/sdio_func.h
index fed1f5f4a8d3..4534bf462aac 100644
--- a/include/linux/mmc/sdio_func.h
+++ b/include/linux/mmc/sdio_func.h
@@ -78,6 +78,7 @@ struct sdio_driver {
 
 	int (*probe)(struct sdio_func *, const struct sdio_device_id *);
 	void (*remove)(struct sdio_func *);
+	void (*shutdown)(struct sdio_func *);
 
 	struct device_driver drv;
 };
-- 
2.47.3

