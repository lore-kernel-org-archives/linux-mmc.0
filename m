Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E743325C6E6
	for <linux-mmc@vger.kernel.org>; Mon, 10 Feb 2025 22:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739227070; cv=none; b=PBWjQycnZ/xuO3JuMW+qqdmZTExSrQpbpvno+0oTZJCQNGMOnNnM58VJJFIDs6WpAbvD12DPikKdHXRMfBw8iGcMNQ+MpqDe7uXnOteUcbH8UfL/YV6jSn31c3BySnq1SFosK7LZ5pdojYYFA+/o75jnVrJoIAlRBPrm/wqSk4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739227070; c=relaxed/simple;
	bh=LctkGb8pv2p2rQX9wrZO/xPsAUNTTxqNczAZXgDu87c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NtbNDvrD6oPTn8Rqvm97AfMc+9baqkLK0GRk3Cb9OKMuIiGxLtCovUG7bwdo3MpYyuFX8sSzdyU3n0GVQUd2TUccMI6BvitID7zTevOrg+ZClT0l13Lsh6IJEhP0w5WTKNdifuaWxV3EcOkOgsQ9AVtCIbN1qVlddnO+0HbxkFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JSuLsJIu; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JSuLsJIu"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3f3b83185d6so601076b6e.1
        for <linux-mmc@vger.kernel.org>; Mon, 10 Feb 2025 14:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739227068; x=1739831868; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bXHiG48V9LuVOCVuPYOg0jYRbGMvcGRS76/y0RlN0SA=;
        b=JSuLsJIubHBSOQF3wLWj+iCM6/U9leKY2xdJrIXTYB/Ln+EEvCyBucdC3O7xK7+yjg
         +UXX9Xh8D+egCKgFE/HB4zzq14uH5zJKE8hzBMMEYKM8JPwsCk9NxqKuuAr2Bm7Ac25H
         zW9HtmlIp1YhAudqNG6vA2twyN7AwrZi7V4fW/s03pOnm5cQsfR8ETYqbh0u6mzK2V5h
         Ac7+R55B2wD/ne9vPaSiOU0sWD50XAUm6WcKFqmOCDglpSluMpvXz2+Mc7mCCbowvRP7
         +FqWlSj8UETjcdjwyhYHUxb6orF7xrrDPf837dnQ0MsPCvwhDzBldHlffteYLRTmmIky
         bwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739227068; x=1739831868;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bXHiG48V9LuVOCVuPYOg0jYRbGMvcGRS76/y0RlN0SA=;
        b=UhhQtgqmuF6rNdsUBzIxU7Pb5CW5YjyS0M5JKEnY8lKBIPB9x7eLQ5VByv0cq8Z6Hj
         9P8Vs4nzlUkBUGMCrGkR7o3NVzcscjBv3Oqrk5bkJ1lWFvp56PiEk6OxUxgGkd7it3Ea
         +emUXoHCET39yZrSQREMtFKpN7JCHRUfLbJqZA52yP77EKvEk+ecgkYOD5JMSX6mou5d
         VvCDqel7jn7wtgzyODJkxnuzKwVp8INfv69xjZSleCDbxm+YjGuHd4hXVPTjbg3IFEbC
         YmbQPjFxgSnyEO7wJwjBVrVjQmOf0j8eXv+rYzVZ5fq+5hMFL3ipXkgDtiU9nOTdM1dz
         XrGA==
X-Forwarded-Encrypted: i=1; AJvYcCW+LraxSiPuMSsqyN+539Rhpkg8yPSDjphmmo+cRRGG6hmALaiMY1azAqQgb66yh7YRwBAMLFg1IyA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4AtDs8+mUS/NHU/DjMdGzWvHTT/qbFWPGhyrTtCd8lczfLNJq
	d3f+dbzra+I+aX8Tq3Tzd17egHZGdrpiOaN+Sle8o9obhqJVm7/1JRq2sz7xHVI=
X-Gm-Gg: ASbGncuKj8ZupfUbexttufPwRxn2mfLM2OizTcizB39LCqPHCKhQGQ/nJu518X+651K
	JX4ZaVyi9hzNreKumr2MzVjxL6cb5tcTu/jeWebhZjI68BSzhjOVqMQ3oKBwmg81ft+2EwB3wD5
	va5n651YrxL3HVpMQAw0Jf8qhcx501/ydAdYpkIJIT/ulCEx8V1+3t3tv0bMf2xiOLZz9gGvXRV
	bEJkp9kNRjQPDU/cqrI2UYGflohL8mL5FnIkaydhtChemzjIWL+nlaiaNwMdNO+u6nU92uuiD4q
	yvGi/t6hIL12q+juW2OPR3eb7BpUvr87YAGVFvIIXfx/HKQ=
X-Google-Smtp-Source: AGHT+IFehF7HNx0K+6D6lVInKbCaf1fMxaCHCpkyg1GkxvFsa7pSUfnDQ2Sc+6Hc2oSsp+PH8uo0Jg==
X-Received: by 2002:a05:6808:2f13:b0:3eb:8d22:b6ef with SMTP id 5614622812f47-3f3923b0208mr10855482b6e.37.1739227068102;
        Mon, 10 Feb 2025 14:37:48 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f389ed1ca2sm2521820b6e.11.2025.02.10.14.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 14:37:46 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 10 Feb 2025 16:33:32 -0600
Subject: [PATCH v3 06/15] gpio: max3191x: use
 gpiod_multi_set_value_cansleep
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-gpio-set-array-helper-v3-6-d6a673674da8@baylibre.com>
References: <20250210-gpio-set-array-helper-v3-0-d6a673674da8@baylibre.com>
In-Reply-To: <20250210-gpio-set-array-helper-v3-0-d6a673674da8@baylibre.com>
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

Reduce verbosity by using gpiod_multi_set_value_cansleep() instead of
gpiod_set_array_value_cansleep().

Also add max3191x_ namespace prefix to the driver's helper function
since we are changing the function signature anyway.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/gpio/gpio-max3191x.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-max3191x.c b/drivers/gpio/gpio-max3191x.c
index bbacc714632b70e672a3d8494636fbc40dfea8ec..fc0708ab5192bd518bb0e6362f737bacbd549d61 100644
--- a/drivers/gpio/gpio-max3191x.c
+++ b/drivers/gpio/gpio-max3191x.c
@@ -309,23 +309,21 @@ static int max3191x_set_config(struct gpio_chip *gpio, unsigned int offset,
 	return 0;
 }
 
-static void gpiod_set_array_single_value_cansleep(unsigned int ndescs,
-						  struct gpio_desc **desc,
-						  struct gpio_array *info,
+static void max3191x_gpiod_multi_set_single_value(struct gpio_descs *descs,
 						  int value)
 {
 	unsigned long *values;
 
-	values = bitmap_alloc(ndescs, GFP_KERNEL);
+	values = bitmap_alloc(descs->ndescs, GFP_KERNEL);
 	if (!values)
 		return;
 
 	if (value)
-		bitmap_fill(values, ndescs);
+		bitmap_fill(values, descs->ndescs);
 	else
-		bitmap_zero(values, ndescs);
+		bitmap_zero(values, descs->ndescs);
 
-	gpiod_set_array_value_cansleep(ndescs, desc, info, values);
+	gpiod_multi_set_value_cansleep(descs, values);
 	bitmap_free(values);
 }
 
@@ -396,10 +394,8 @@ static int max3191x_probe(struct spi_device *spi)
 	max3191x->mode = device_property_read_bool(dev, "maxim,modesel-8bit")
 				 ? STATUS_BYTE_DISABLED : STATUS_BYTE_ENABLED;
 	if (max3191x->modesel_pins)
-		gpiod_set_array_single_value_cansleep(
-				 max3191x->modesel_pins->ndescs,
-				 max3191x->modesel_pins->desc,
-				 max3191x->modesel_pins->info, max3191x->mode);
+		max3191x_gpiod_multi_set_single_value(max3191x->modesel_pins,
+						      max3191x->mode);
 
 	max3191x->ignore_uv = device_property_read_bool(dev,
 						  "maxim,ignore-undervoltage");

-- 
2.43.0

