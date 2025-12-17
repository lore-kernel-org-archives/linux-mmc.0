Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F272733B97E
	for <linux-mmc@vger.kernel.org>; Wed, 17 Dec 2025 11:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765969786; cv=none; b=SfrmJ5N+PK+wQpQthwLPDoazvdT2/9/RtRaoVL3Dv6UARRPbUnixxwFs5849ANMEIRMEH+8pgpZEG/uwKyXwzU9oWev+NZ7HxXuAEGEUl53baRiNbQfUja2EPdMjuMORmVLMd3nHuP08vRqREa/B3EklWTRHBZA7wiuCfz2S/zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765969786; c=relaxed/simple;
	bh=xWvN8DVqDcWBo/v4eE8MagMMQU8shW2qXTVYsch0jko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=os6E/6xUdM2yXbe6Ds+5IzgvZHGPcVnxfxee1KTGr9xnLGNlOA3AQd7z+6xWW3cSs3HDijgl53YpRCKYrVvNrkKb8IVnl/p2/YmiDLNXTaw+l/Ko0lHqhcJhXXZfYdhqPl+FmP1kg+jEsHOPM083w/yDR+GWLOqRN6N67eu3Vlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FJ46O2+P; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FJ46O2+P"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-644f90587e5so9581632a12.0
        for <linux-mmc@vger.kernel.org>; Wed, 17 Dec 2025 03:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765969782; x=1766574582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFxo7q8Upg9sDha34TIZTJlyln1hXfyfUaUuvCwVFgI=;
        b=FJ46O2+PUpl1Pf1OePIA8SU7wqH9JmlPolOZJ2NoZHmhExC9+9M+3oc/QSmaWBMHHe
         LPEWkRyB56jUdyXRHzAr95W2fRMMK4BRe+bqdjMh2eULAwYKXEshdqCfBYUkHjo/StXM
         UDM0SMmEO2+ghldW0xBUZaROYO9PP+uuMUOmknQHkh7SykP8DkI64b0/QFDgbV8UEl1g
         NKL9fWvBrhCLSOTDjBr5SJ6ZXM64UQFBvwTlweoB8IjEVAb2WKmB9VHJRpKE1XflrEiv
         i85nRAXlkdJb7M1N0kOSXFgWLkGljS/VU2BGO4oXmHbro6w3kfWvpPAhTCwQthxaCbE6
         rvtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765969782; x=1766574582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SFxo7q8Upg9sDha34TIZTJlyln1hXfyfUaUuvCwVFgI=;
        b=ZD73ntzAt85QxEr15YM11+/9pggHtxzrQZG1vOowFmkS1ZY5jVtd6VoYD/HrRjoerf
         EAqyhW4FFzUQTHZF0jUfzbN08lHJjsEA+sLY5ABC6rxzBVc6LrVXVn64oKDvj2riijKW
         6FbdUW3JbGx9HoOvPi6eqHCPdIRiU6dWX0QSFJPBMXcf7E1ehLIMKZe+ME5eAoyiPjIU
         HCKQnznCKsifBYuHSwPLP9EICgKaZbdwrGdwYm5bbB+SOGUqq3/r/ONoaauxy2HCF00g
         fGK52adLOsZZPicfsyvZe0s7lZkEEqrPn7j8MVtlf4hoHPB7RqMbgh6mZP7gna+0DwbY
         /Pwg==
X-Gm-Message-State: AOJu0Yyw7K3f9nqYmqAXU8dZMhN+Z1Oq4JxNRv+ENo3fgOILBuj/t/hY
	LrVn0lWKBQIVcDxFB2E8B4Oxmtfb7sESEb6pWl6oPiKIblZTgbKL02LRijBhWbPDQXU=
X-Gm-Gg: AY/fxX4VFpg+GYI9WPHlr5O0wb1QXlyg90D5ALQjCIHOfaF/kv5QHYowc/pXeYmDKcM
	nLZ2+yAjj5edz2UnI9qHHOoOzcpQ/9VNkyfxYDPRkPLH44p2CbbwbX1MQ2GMwvqES9DuWe+QUFh
	9dfzUQb32pdC1lGQGeLcBb1hajYxAGuWCcdjUZIgkiaWya8jNuCp56sqtocYbgPaSCBtfJMxTzK
	MTY4+KEO3ivq8po8ndM6F6tr/c8mPl9lXCKAotLlxnG2ScbTvg3d+tzPU7JLk+Dc/JJkUxbmu01
	i/U8LpHVcL6lwM57t/HA44TIjLk+tzKoLBQ5b6PyzypDTVTCFFEYlkL074/q68k7XayQw0eb4/k
	PIx3OZkBNCxykuPvpd5Md/U3fGr8PEwDIjtK5PJVT0WpH+NHDNZFeRSXgUvOjE+duyZAj4GW/sK
	bD3GfoDvop8KBo7s9jOq1dB1eQCTk=
X-Google-Smtp-Source: AGHT+IF5iq7R0NeDYU0B0g78afNST/PVuQQcOsPbPhKkJsVqaTqu+qAJudf/rYk8PgPcpCjGsUxSiw==
X-Received: by 2002:a05:6402:4311:b0:637:f07d:e80f with SMTP id 4fb4d7f45d1cf-6499b041413mr17015368a12.0.1765969782271;
        Wed, 17 Dec 2025 03:09:42 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-64b3f56b3e4sm2343875a12.28.2025.12.17.03.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 03:09:41 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/4] sdio: Provide a bustype shutdown function
Date: Wed, 17 Dec 2025 12:09:23 +0100
Message-ID:  <397f45c2818f6632151f92b70e547262f373c3b6.1765968841.git.ukleinek@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2714; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=xWvN8DVqDcWBo/v4eE8MagMMQU8shW2qXTVYsch0jko=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpQo9l8isJBrlUSpFk4tQ0feWeQ7zFVLKRysli4 R9Ml9XWx2mJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaUKPZQAKCRCPgPtYfRL+ TnerB/9g1J2vhIOAmHJHDhB6LU86vr01CcpgtvQPD/axm5i5BKeBqXK9PIVWLgQQrQ5qGmzZDw+ sG6by5hal3OT837Bkz1/HKKlCwd+dfBQHtr6tGK6ylR8iL/odnQ3Mv3rIjMLzrGMVRVH9la95ra T1mXPXWls00Ho0fTXyAyBOgA1IkSdk2C9TN+m4f9p7JvbMjpA2U8yFS9x8mrteEPCY1t9op4xJ+ Kh5a5HsnFDdFIv+7EbSsUDL7vk8lSR9RUpaY+WJmhncbe/uNmLDb4G5Na/JRExU4sCQfcXrV/oJ CxRqpa0952m7NZSFhPk0yEQgt6VndtKsB3Tgm7Ml/LXPq86T
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

