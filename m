Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE6233EC
	for <linux-mmc@vger.kernel.org>; Sun, 10 May 2026 16:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778430630; cv=none; b=GSmDfMzQbiBDeYUE1h/riuCJu/6j7qe/YF2VynvAe+sWJw+bpqf0MuHAn0v8zo33tKf502Io3iTRAD/0jeUhwd7Sw9igJR5j2N3oi4lmvnP0eLMNc0Cj5vtn1R/iEBuns5elSbvT8DHd7ugV7SYSQZqOZ6HDT0KstKLW4UJ+h8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778430630; c=relaxed/simple;
	bh=lmbCQr58FaBWfDQWGL3s9gx614McebkkHoCivon3Fkk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=r2A0y3MONweZhcUDFSDMwfj6OBPOTsELS9ozLM9MUWmzHtHbDba80Jcld5RtGMK12PZImtmbS1dm4bB2mmFl9BLeySJFB3iC1y+1Lmt3RSW2RZaLGhWOJCoAQfO31cd/0zVAdOcpcCWsvhUuhWGlBcZmNTmzsfHA47BhrZXwwqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NqSIitp2; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqSIitp2"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so34981535e9.2
        for <linux-mmc@vger.kernel.org>; Sun, 10 May 2026 09:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778430627; x=1779035427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=He4B1KwYa6va3akEchflA6TfkGWI7BelAApRMUKrFY0=;
        b=NqSIitp25VqNf1djtm6jcRv8hRrdENvfB4bDKTS32CRT99vKjTw8atoBlk4CXHahOZ
         5fffmgtglxIc1hQMXHGFxXz04pUpri4gG17aOUNEmQo+bNFPlyCEDHzs2P9u9RRXX3y5
         OqkRyIaLPYd6gyIqLID+d9XhgZbeOIufnDNKxGpGkZhPjz4yqlFNjeHQvhpoV/f381e+
         9vJFWXOmoiQaxEFR7GHUp8de54XSGQQHnzOyNfX2Qx+4q9gPkK+4pW2sfhzzKCrQBbYv
         8L0Kg3dA6KHlqeNx1vS0lhv+SaU4rjsL1uekngnhSvYT4Deq/B8gU/siPKTyUR1TE3Vf
         HIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778430627; x=1779035427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=He4B1KwYa6va3akEchflA6TfkGWI7BelAApRMUKrFY0=;
        b=Sj9g2CZI8M0lYsrzEO9i/X/9u7Y58BMA94ofUMbWZenV9kstfDv3BckspOz38JvM5I
         RQXMd2WkBBzASLN3a/R38bZT7mVdPQlYHIUQM1BrBHh2Y/Kc7c6rWMOJfIUKsLKHPfRf
         Zf5DnPF8ws3qhsaEaFLOX1l5g8usuNWX1JMjat+j17pe4O37MjcxhHXqakbFyb1Qa4Cd
         sfiic7t3vwOGQayjs51oEqm5tzA141rGYjmP8hDVKIXYToDlG3OkeRBxAasA48+yD+Fw
         S4FhEyqh6vJxFrgZvoV0wue/e7mQdsKvIKPeyLz4A0kp+gTPvqfAs+oXyp6bp0b+0tdO
         4D5g==
X-Forwarded-Encrypted: i=1; AFNElJ9Y3M9tFc7g7mAFXj22L/RnSKh7mmF3+930NOZ/y9Ru/6RL/gURNj9WwSnF8lhiGvOYdIA/5RfxoDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU964D0Gw65oMsfBBgrjROmGsFrExcwvQ4u0DfY3Ir/MZp66SE
	4v0Ksiqd4TlNdesrx7YuFZumhOMRxo+kDT25xNQY2KXgRS19v+zocd8p
X-Gm-Gg: Acq92OFNKcNeRZtqv8oXDPysDOtEyWMenMI0nvyYuRceK4mECAYelT/aMsw8PuTS1XE
	l24SNarABgBgBDemgZScUQyFG9UEH59FR/ECmSKRzuumObSm7F/HvluD2dvQ4U50k+5hzjGMoZh
	Wc3uXUsMMAisU4/clP+XDEMRggUe3FQ6clRyGsWZnGICihL1VTuTirenpu9neLxafoq6LDyUqen
	cX4XKNgs80DLuY7w08E+noHYf8L4V3gnhbFs7scxM/W483A9TVxqOEXsYK81C1+GxIvcZFmS71Z
	pEI2zklbOjp2Ph7Jf44Dl4CrtY8VQsFYcGi8daEbJPIFb/AdmwwWqTxq2DHtdjbKFrzd7ZOfyOg
	2A5hBYgmbFJNi9DkkKcq31/DIJTCYUrpV4uDbJkxYuFSeEJHzIihwQng9vDpMj84yNB+bc0xf4t
	LPizvqyjP2VOfUo9lEeKJ+zOQ8vrJg0g0Q1hAiowyKaMqvVg6cDG/mQHUvZsFT
X-Received: by 2002:a05:600c:c11c:b0:48a:52f2:a0f1 with SMTP id 5b1f17b1804b1-48e51f46d48mr238026445e9.18.1778430626919;
        Sun, 10 May 2026 09:30:26 -0700 (PDT)
Received: from osama.. ([2a02:908:1b6:8980:13f8:e1fa:3829:74f9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6daf911asm67627755e9.5.2026.05.10.09.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 09:30:26 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: bartosz.golaszewski@oss.qualcomm.com,
	Ulf Hansson <ulfh@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Colin Ian King <colin.i.king@gmail.com>,
	Osama Abdelkader <osama.abdelkader@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: davinci: fix mmc_add_host order in probe
Date: Sun, 10 May 2026 18:29:39 +0200
Message-ID: <20260510162941.704940-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mmc_add_host() makes the host visible to the MMC core. Register the
interrupt handlers and advertise MMC_CAP_SDIO_IRQ before that, so the
core cannot start using the host before IRQ handling is set up.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/mmc/host/davinci_mmc.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 42b0118a45a8..a598febe7332 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1294,14 +1294,10 @@ static int davinci_mmcsd_probe(struct platform_device *pdev)
 		goto cpu_freq_fail;
 	}
 
-	ret = mmc_add_host(mmc);
-	if (ret < 0)
-		goto mmc_add_host_fail;
-
 	ret = devm_request_irq(&pdev->dev, irq, mmc_davinci_irq, 0,
 			       mmc_hostname(mmc), host);
 	if (ret)
-		goto request_irq_fail;
+		goto mmc_add_host_fail;
 
 	if (host->sdio_irq >= 0) {
 		ret = devm_request_irq(&pdev->dev, host->sdio_irq,
@@ -1311,6 +1307,10 @@ static int davinci_mmcsd_probe(struct platform_device *pdev)
 			mmc->caps |= MMC_CAP_SDIO_IRQ;
 	}
 
+	ret = mmc_add_host(mmc);
+	if (ret < 0)
+		goto mmc_add_host_fail;
+
 	rename_region(mem, mmc_hostname(mmc));
 
 	if (mmc->caps & MMC_CAP_8_BIT_DATA)
@@ -1324,8 +1324,6 @@ static int davinci_mmcsd_probe(struct platform_device *pdev)
 
 	return 0;
 
-request_irq_fail:
-	mmc_remove_host(mmc);
 mmc_add_host_fail:
 	mmc_davinci_cpufreq_deregister(host);
 cpu_freq_fail:
-- 
2.43.0

