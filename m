Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5D21F4297
	for <linux-mmc@vger.kernel.org>; Fri, 31 Jan 2025 20:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738355096; cv=none; b=SEQWG9wegGlaM16liTgqQ4kynZjd91vnjQh5rhy8aMMC1Zj4goZTcw1/wWucVwhj/Xrq4I+8zaEuPc66dHWYqrBS4TG6y3M6Kdz35Jqmj9tvwMj6ntMqBgMKhMaMwNs8dtVKCYUNYn0Jp3BmXPti5MAeqcsr5EAWPDmONVQUKMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738355096; c=relaxed/simple;
	bh=KSnpvBpYf1I2zTKJ1PQkgSeFWmdqfKH1K8H306V9HCs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iRXgZeEnDDfEqg2ypusxF4xUoQ3wm19i+AlquhF61RGtq0AqBBQLCow8TNKUOIganhYcRv+e2iP5KFf3kOP83Hsdj/UydOJSCq6SkUYkeQlMJyZge5QxvcWSR3k44M5V2AjKZHu4aQ9q8fhipWIXNwe4Q3uoEndcx5dL1vYVPxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kHPWQe4x; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kHPWQe4x"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2b199bb8af9so1727286fac.1
        for <linux-mmc@vger.kernel.org>; Fri, 31 Jan 2025 12:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738355093; x=1738959893; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g/d91jflGtqcHyVEIBk6nu4SgcmlMkVjeTIYU/X9iWg=;
        b=kHPWQe4xfcF8hLtkR73pCTnp9JC2Vm/ElpZTPXHBFENS4iT24APePUQBTkbV4+bEA/
         0RhMD7TIunoXPctqU2fPlCrGa3VuP1xVpfET4CmlHHA1RSayvsnIsckNhUuiwUOXGQmV
         xa2xA2Ch6zTxl5kOtM/fsVWxGbOJ2n9EuIGsxWawKEj6TZ9BneYxeOYrFCRo5FzBVbX8
         5SQoMARcWE3CvFe+zbojReetgvJiknmmYk+Vzq++6AX6SkxKURkZKOduwIkDOp1rr46X
         A2gNeYU0pPxNBBIic4gouY0tM+GFGx3F/Id9f/o9Qc7JiUnW8AEMLqd+xt41yWYjYJMg
         VJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738355093; x=1738959893;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/d91jflGtqcHyVEIBk6nu4SgcmlMkVjeTIYU/X9iWg=;
        b=JbJvOE9T+oxy6s/Eni5QegA1wer9oCFK4O7a9gOVLiF8a6/j+fy9kdGfMej7evrOCK
         v3akZPPFdd7q6GgLSgfiKnRYxaDOOoZzcbpMeaaKsQ9ggLuRH+W8uLRTD+astd/2YoLD
         URQHKaOKZ6UYV1ham/ezx/dA8FojGgEc2+uC+njy8IRKNTfIK9OIg7PMXDoMmQDL/b7z
         +clSRstzsDSeNnYICeZnbrYhdhZZDp+gAlOYXc7bmUrKwtamL8XYCf50n3AW+PWb1O4s
         J7MZ0UXIlG7Y1x2bxbSlGAzZt/uBaCLeJxWZ00Ap4r+dDbsUv4grZSn1G1rHR4dtgbuU
         B9+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXGL4jF7UI+L7L8e+5MlYWIcW95TEg1041NNGg9jYQHxxpJCPvptAoRzqa+pnU6YJlwaAzGOf6G70o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNQgokLMtpw5xovb86thY+ec5nUCHvhzYu1Fzyor2UluWSky9X
	Ukd/UK5f8afLgm8rcg21l8RIAVEOABDdnxgb993wSWnTT2Ia3MIHvA1mVnciMoI=
X-Gm-Gg: ASbGncsy+3NkYYTBoYfQsq3GJ2in9IKGQzq8SMIXXyEuC8RxNx/cU7iiN95ZNVvB35/
	CBxnYkFK5uDJvW1mkJXfZ34CmnxtSEMA0WvYpLBN3j7UyLfEldfStTqWJ5cPVsKjfvLwXYXKgDj
	cfkq+xzkXo+7WwuRRDtY0aHybu+vGKmWAaxsccRFR8d6PPCBU12HcDNRO0LUE9wSaqUAYRpO2r5
	GvFDxOCWte85NQ2mft2St2g84lZ1a7yER1elSlRM/1eDr3b8kbNgNdiAFyujD9Sd1K5lt93d/3F
	Zzg6HZaycPLaO/d6rBWknBwnKoUJUIVX2VyQfoFt9FWcsN4=
X-Google-Smtp-Source: AGHT+IG7MwrRorXxkcWjIdgGK+4mzXkuq9AO0FFEdnZrk7oRmiSNnPUZ/DfqxHivj4lEixFczChGQg==
X-Received: by 2002:a05:6870:d1d0:b0:2ae:d23:3c2d with SMTP id 586e51a60fabf-2b34fe99372mr8034579fac.8.1738355093684;
        Fri, 31 Jan 2025 12:24:53 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b35623d2ffsm1403157fac.22.2025.01.31.12.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 12:24:52 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 31 Jan 2025 14:24:43 -0600
Subject: [PATCH 03/13] bus: ts-nbus: validate ts,data-gpios array size
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250131-gpio-set-array-helper-v1-3-991c8ccb4d6e@baylibre.com>
References: <20250131-gpio-set-array-helper-v1-0-991c8ccb4d6e@baylibre.com>
In-Reply-To: <20250131-gpio-set-array-helper-v1-0-991c8ccb4d6e@baylibre.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Peter Rosin <peda@axentia.se>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org, 
 netdev@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-sound@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Add validation of ts,data-gpios array size during probe. The driver
later hard-codes 8 as the size of the array when using it, so we should
be validating that the array is actually that big to prevent possible
out of bounds accesses.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/bus/ts-nbus.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bus/ts-nbus.c b/drivers/bus/ts-nbus.c
index 2328c48b9b1260e805c631f2aa7379d620084537..d3ee102a13893c83c50e41f7298821f4d7ae3487 100644
--- a/drivers/bus/ts-nbus.c
+++ b/drivers/bus/ts-nbus.c
@@ -48,6 +48,10 @@ static int ts_nbus_init_pdata(struct platform_device *pdev,
 		return dev_err_probe(&pdev->dev, PTR_ERR(ts_nbus->data),
 				     "failed to retrieve ts,data-gpio from dts\n");
 
+	if (ts_nbus->data->ndescs != 8)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "invalid number of ts,data-gpios\n");
+
 	ts_nbus->csn = devm_gpiod_get(&pdev->dev, "ts,csn", GPIOD_OUT_HIGH);
 	if (IS_ERR(ts_nbus->csn))
 		return dev_err_probe(&pdev->dev, PTR_ERR(ts_nbus->csn),

-- 
2.43.0

