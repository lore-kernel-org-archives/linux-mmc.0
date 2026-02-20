Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BB829A9E9
	for <linux-mmc@vger.kernel.org>; Fri, 20 Feb 2026 19:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771616852; cv=none; b=U15VfFSfZIKVdIDwBiCBoH+ghvbK7pU9RtNf+Od0nE+uvfLAbIhQXsllpmMC/0xUrsDy7I2tAov5PP84UWqYFHpgy3/x4yR7zxjwcWMvhUkdH+TLKEHG5AWt1DJxa4lZ5kNjc8VKUNoNK93PGdtOg555Qg1+ug0aNfMhlc29iuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771616852; c=relaxed/simple;
	bh=0G4KFfYK1+YXwVEigy9PGfxDtl6ONA/O/odMVh65a1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JBGy7IMXerJ7sx6ZS80e0B0DVGeuetzCc7LW5cGiaqDTRTEF+Llxz5OagmUyChnZrsupExAjqnjNWYyB0YI3xhv2U9ptKXCuVXEvFmTD7vI1yE/QyL2EuOchobrNj1so7Or/HLvVMtV6huJXaHRaR4l2sIAd9rFTLDdeCmqPf4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aov4icyP; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aov4icyP"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59dcdf60427so2628761e87.3
        for <linux-mmc@vger.kernel.org>; Fri, 20 Feb 2026 11:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771616849; x=1772221649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Owyf7V4DSAu+UKDutdINA5uU1OgJ5uFzzkQ0lvvCGc=;
        b=aov4icyPIQ25wscXvqYR8XSzT8nshExy7O5xamJCJLp5zqPWCvhw7uMzd0cnO0vB9C
         l7IbyKFuD1aubDGsRPDTsEP9aUTOtV/b5kuZq2rc/ngxuiHgYl4H2luoISUqlnXbbXoK
         5VC9iFcTGShDw7SiLRvQIhc/tYO5YOZuQ5Ph/pIlQJHjcjJcLsrLp7RFBSvQ/OnGDJvh
         BSslnuMKIPRsttx0GAVOm5uhJ3iw+TSEVvNJhdXgABqEIq5c2Gpnk2LrjCxVWjQwC4y8
         AVu9IAvKXsFft/IFaU3Bd0qL6XpfpCcVfbosHGgVIbxym2EL+B1NkdZvZffU0jOiEPMU
         9uFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771616849; x=1772221649;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Owyf7V4DSAu+UKDutdINA5uU1OgJ5uFzzkQ0lvvCGc=;
        b=K2agSuszSzIzYtOJzdardziAKOoAUQdW02/QQ1Q1aZTs6VErfQju1YGhXjMGmzySiT
         ws0Aj5+Iik5MK+tEehRi6xicvIvXI3dhiqTorosrodQyA17hZuqEsVGzFRMEgOgXmVj2
         oc4Wd7uWjSI3vG+V2nTXISmwm1+htKGkj/87K3oShZh5iM6pCAOpY0fyLxSf9TkunKI3
         gVCzYm8O203ARadxX1eNVMGtHDFUSQ2EmfqcuRXlF8gxbn+P5oyMZtFDOYl/fHvbyn4m
         RuAI06xDVaWyDaFvI5IfejP2QjjaMjw4PGtW88xQqsjNxdeKuEEkhkZqNe3IOcJF69hl
         Gh6A==
X-Forwarded-Encrypted: i=1; AJvYcCXVBYG3tp5eb3qKnth8fmER73NGAGoABqp/oMUDdmJvaU3K+1KI4KEw+CAO/Hv9e9bO9Q+/6LU/5bs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEy58uutNwlKJADXuqyz+CpbDCG5Nbc6yaDe5MeCzSvZpdbrsm
	fd75LSsnyxQkO7mqb7/SQ/WdJJcQc7s6159sbM/MWmxyQ019W7PhBGHz
X-Gm-Gg: AZuq6aKlWnFWleqM/XXIKj2qsG46DZV9a+U/OoLFU581mRegzPNo9qpZM4WgtLJZVzD
	ay8b1TnA7vLJus675Ml95WI7qvqFdAiqaq/R6r/XKYNO0Ijya0QJEMe86ZdMn3K1fLokOUautAy
	cCbBjImnILyGLFjY0JeVtPVnnoQgbT5T/6qTyxaMz/pU9lDP/s39wfq97vsXCs1qW5xzVe16VH8
	3NU9F+B6NdiwCnzDqjHWtXFJpeJMZeHBPl3L+yBbC2R5pvzdvDGS/MCgEAvBY6RGRXyFt1/8moD
	6XsqH3BZPDEQ8Lkc7j/XKVIbyFxfjKkqcbYfUBpbEGg8ORnzbabKxiZjMoaKkEoziS3M5zsuTW2
	HJgovF5zFN2TxVzsgHWhWlkFmRf/vwVKSKEybBg9fQcjanvEaSza8sZIclmMM+N2b4uFOXVVlLO
	I2EEOFPHobPMIjSDVPCHkNOgQyma3e+dt/SPjwa40=
X-Received: by 2002:a05:6512:aca:b0:59e:5d0d:c1dc with SMTP id 2adb3069b0e04-5a0ed9c21ddmr157115e87.48.1771616849140;
        Fri, 20 Feb 2026 11:47:29 -0800 (PST)
Received: from localhost ([2a00:1e88:4473:5f00:3201:1ad1:d6d0:d47d])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a0eeb3ea50sm15968e87.57.2026.02.20.11.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 11:47:28 -0800 (PST)
From: Sergey Suloev <sergey.suloev@gmail.com>
To: ulf.hansson@linaro.org
Cc: catalin.popescu@leica-geosystems.com,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Suloev <sergey.suloev@gmail.com>
Subject: [PATCH] mmc: pwrseq_simple: fix probe failure when CONFIG_RESET_GPIO is enabled
Date: Fri, 20 Feb 2026 22:47:25 +0300
Message-ID: <20260220194725.1341281-1-sergey.suloev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The driver uses a heuristic — checking if exactly one entry exists in
'reset-gpios' — to decide whether to attempt reset controller API usage
via devm_reset_control_get_optional_shared(). This is semantically
incorrect and causes a permanent probe failure when CONFIG_RESET_GPIO
is enabled.

When CONFIG_RESET_GPIO=y, __of_reset_control_get() intercepts the
'reset-gpios' DT property and attempts to register the GPIO as a reset
controller via __reset_add_reset_gpio_device(). If the GPIO controller
is not yet fully initialized at probe time, this returns -ENOENT instead
of -EPROBE_DEFER, and the error path does not respect the 'optional'
flag, causing pwrseq_simple to fail permanently rather than defer.
This prevents mmc1 from probing on boards that use 'reset-gpios' for
WiFi power sequencing, such as BananaPi M2 Magic with AP6212/BCM43430
on Allwinner R16.

The correct indicator of reset controller intent is the explicit presence
of a 'resets' property in the device tree node, not the count of
'reset-gpios' entries. A single 'reset-gpios' entry is just as likely
to be a plain GPIO as multiple entries.

Replace the ngpio == 1 heuristic with an explicit check for the 'resets'
DT property, making the behavior unambiguous and immune to
CONFIG_RESET_GPIO interference.

Fixes: 73bf4b7381f7 ("mmc: pwrseq_simple: add support for one reset control")
Signed-off-by: Sergey Suloev <sergey.suloev@gmail.com>
---
 drivers/mmc/core/pwrseq_simple.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
index 4b47e6c3b04b..780c8818a273 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -124,7 +124,6 @@ static int mmc_pwrseq_simple_probe(struct platform_device *pdev)
 {
 	struct mmc_pwrseq_simple *pwrseq;
 	struct device *dev = &pdev->dev;
-	int ngpio;
 
 	pwrseq = devm_kzalloc(dev, sizeof(*pwrseq), GFP_KERNEL);
 	if (!pwrseq)
@@ -134,8 +133,7 @@ static int mmc_pwrseq_simple_probe(struct platform_device *pdev)
 	if (IS_ERR(pwrseq->ext_clk) && PTR_ERR(pwrseq->ext_clk) != -ENOENT)
 		return dev_err_probe(dev, PTR_ERR(pwrseq->ext_clk), "external clock not ready\n");
 
-	ngpio = of_count_phandle_with_args(dev->of_node, "reset-gpios", "#gpio-cells");
-	if (ngpio == 1) {
+	if (device_property_present(dev, "resets")) {
 		pwrseq->reset_ctrl = devm_reset_control_get_optional_shared(dev, NULL);
 		if (IS_ERR(pwrseq->reset_ctrl))
 			return dev_err_probe(dev, PTR_ERR(pwrseq->reset_ctrl),
-- 
2.43.0

