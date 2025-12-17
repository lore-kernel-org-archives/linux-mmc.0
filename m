Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE8833D4F8
	for <linux-mmc@vger.kernel.org>; Wed, 17 Dec 2025 11:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765969788; cv=none; b=MLk3qOS7SGmprUdph8l4ph0eSZTKg1ZAPA0RgKgpXQ3Tpt+BOZO9kV0UWhI+7xqBCyE7iurpqjtaaejyrBBYAncSYyWIc8v0RyucWdlmNjTLdrDyYHm6O2DjDb4kIpB0O46Agy9aTTuwaDgKRG4jfmbuawbDOeihKylSGfdrcT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765969788; c=relaxed/simple;
	bh=dkyXLuLg+7eYiSQma7cNLg4NKd9rhkvKdGkZMgOE4QY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kDah3KRXw0jCiESKScEZmvB3EfH2Hx6D4DoIbNrR4pJurK1Ut4SQejpKcU7I6w5s30B0L7Cv7r8DM4KwopFjVj35ozBtXfat2KMKUratwjbVUnhNsrUAKputpxh1s0RsavnXn59xaJz7pnQeKsxqqvWc8IwnzTC/Ue16mGyZALw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zhYbuAzs; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zhYbuAzs"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-649820b4b3aso3799851a12.3
        for <linux-mmc@vger.kernel.org>; Wed, 17 Dec 2025 03:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765969784; x=1766574584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVXfFEnyomZ7n1+faa+96lpi1G7Z02nuAcgJTrKE1/w=;
        b=zhYbuAzs8SLIplAIzXqbO80XdbI7uy37F61fvSV158Hz1N7WuU3ldMFFLjpFl+Rpmc
         jHf2V90JExRXfgc/xK561V/76sin0QVkQ9iMlVKkThl60scEC6sgkyx7YEoTEwjolBwo
         tl2VouMR6+6y+akf4SO7MdbE98VEG7akylLXOw3WLAebMbIzWXA0SRRqaJw6+Xxvp9LU
         Nn/aGQQwOETn0o3d1rOKfKCxnvIujTaUPOh33dmrRVN4s8zCWZnKcDlry+6jZz5paaHb
         xg0kNRNhhaWnn3U9z8fFnjQh9me2DUGN7ufmQZTkoKQkIFOjEHx+ssePHuHcI+REamvt
         +9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765969784; x=1766574584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QVXfFEnyomZ7n1+faa+96lpi1G7Z02nuAcgJTrKE1/w=;
        b=arELMjOzR8aspMIIulGNbn17c+uAx17CvKpMMkBdCMzxI8SsrYdb1HLUxvqA0FR3Pa
         wm7l07UJumeVW9s/qmbWZk/DslaZK0m6Faj766rq7nTo6hc1oUZPvRAv/SvgbxhmiVYQ
         rJH2Yq8hEm8PzIDpCaZBdMjRQ+JM6BiQsQaSnXLHJptVASIKFSD3O2hiLWg2FL48IH9j
         C4YV6PW4S1YSMSlanvULFoS472jnc79ATpDbev6dz/Z5aP+hdzR2L2e2+/f/WuGlrhmk
         NXtHiP0+NRuo0FAJyqvbd70MLU6AzUzHpi74uSCTSvx12k/483z3RSJj9Va3IcLiRwpT
         BgCQ==
X-Gm-Message-State: AOJu0YwFEI3afFYubqtIJi3q9WYJt56fiWL3y+n2QH8wf/MDGy77Pa7P
	WkR46tNini01781PAznBRTJBZz3xc0BTJ0YlFFQj0fZCa3tVmyyHPj4QoGyUKBzvs/8=
X-Gm-Gg: AY/fxX4MyxniMNr4OpEtGvhvDJnmcxMCqxCFLZJV19DB7ghQi0HJ5eccwNlR1YKXv/Y
	ilHhNDXEueuMPeiwNYQ6zTRRR0HHZ1WNFkJZKriu5iocYGR9KSpxKFdZjDkHR/mW6kIQQw8fFCc
	qB6NAXP4cWcTu11KEYzwYOSY11zyf1kyBCGUHXGIHgyDWLde8B/v5pgRz+Re4EfcIizg21RkZ1j
	XyogPNSGR8wmCfGnqoXsxMxAkFVm8lNRBlqR5Xb5pPpOdtiIu1UWZRKaXFcwSGocojPgnNzUjlt
	Jbx7eJ52o17sf6wAptH44F7O4/sncDbd0WSfhLU2MlFnDdm4acFhMIZQbEezlDxzyqQP8jCq3ZW
	v7bKSbVOkykC/bvf7W7FAujswXi8c2Nxo7cmrwyTxo6Hj1EYv9Gpiv+23tu8NjI9MdVy5QDDO/v
	ySodO32T1eMTAr2BHO
X-Google-Smtp-Source: AGHT+IG02+mlmUp75Y8aN15AB3fqyEtjlYTbsKkWc4VXMQLd8E1R2A0XY8IFh9I/XNFQRNEDDaYuBw==
X-Received: by 2002:a17:907:6e9f:b0:b73:6c97:af49 with SMTP id a640c23a62f3a-b7d23a972c5mr1808467566b.30.1765969783886;
        Wed, 17 Dec 2025 03:09:43 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b7cfa2ebafcsm1939736266b.28.2025.12.17.03.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 03:09:43 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/4] wifi: rsi: sdio: Reduce use of #ifdef for CONFIG_PM
Date: Wed, 17 Dec 2025 12:09:24 +0100
Message-ID:  <f291cca2741f6ac994b2bde1fb9d21194fec4d3e.1765968841.git.ukleinek@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1529; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=dkyXLuLg+7eYiSQma7cNLg4NKd9rhkvKdGkZMgOE4QY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpQo9nGdmxPZIIu7N/pwilj9mRvyvv5BXVkckRa 2AS6RJGwcKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaUKPZwAKCRCPgPtYfRL+ Tj7vB/4h44YpCoZWZ3nsb90FGI3e04zfgPviKqmXaBoofMxTHX8kvhuiVW6F5dF0uaw1lqnOOeP +FFPqthr5lT396O8SnCeY2/m9Po3sMCQc8L8z42wwrWi4+1xzhvGZIvFrpCJBJuQ4TC1o7KplNu Lk2D+CWBFdTnjn+cJAk4YK7y3Tkp+CF9V+kkvtgUlGkY0qdK53shaKTQ/D/B4ngV2g1FAlm9FKY T9ZwZD2mYwEZ4v9Zu7/KBVznsaIOrY+76NGS3SBqWPyLzviCui/APNfw5bEj0/6roQUECMWMHzC w61S+QQ/YpQ77CdfBgm3FPFPPx5KKNGUJoB4/OLbHuIKOWAF
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

This drops two #ifdefs (which is good because they are ugly) without
changing semantics. This also improves compile coverage because all the
code in the first #ifdef block is now compiled even for configurations
without CONFIG_PM (and then thrown away).

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/net/wireless/rsi/rsi_91x_sdio.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_sdio.c b/drivers/net/wireless/rsi/rsi_91x_sdio.c
index 1e578533e473..c2b2d09b616f 100644
--- a/drivers/net/wireless/rsi/rsi_91x_sdio.c
+++ b/drivers/net/wireless/rsi/rsi_91x_sdio.c
@@ -1243,7 +1243,6 @@ static void rsi_disconnect(struct sdio_func *pfunction)
 
 }
 
-#ifdef CONFIG_PM
 static int rsi_set_sdio_pm_caps(struct rsi_hw *adapter)
 {
 	struct rsi_91x_sdiodev *dev = adapter->rsi_dev;
@@ -1499,7 +1498,6 @@ static const struct dev_pm_ops rsi_pm_ops = {
 	.thaw = rsi_thaw,
 	.restore = rsi_restore,
 };
-#endif
 
 static const struct sdio_device_id rsi_dev_table[] =  {
 	{ SDIO_DEVICE(SDIO_VENDOR_ID_RSI, SDIO_DEVICE_ID_RSI_9113) },
@@ -1512,12 +1510,10 @@ static struct sdio_driver rsi_driver = {
 	.probe      = rsi_probe,
 	.remove     = rsi_disconnect,
 	.id_table   = rsi_dev_table,
-#ifdef CONFIG_PM
 	.drv = {
-		.pm = &rsi_pm_ops,
-		.shutdown   = rsi_shutdown,
+		.pm = pm_ptr(&rsi_pm_ops),
+		.shutdown = pm_ptr(rsi_shutdown),
 	}
-#endif
 };
 module_sdio_driver(rsi_driver);
 
-- 
2.47.3

