Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA281F5406
	for <linux-mmc@vger.kernel.org>; Fri, 31 Jan 2025 20:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738355101; cv=none; b=JDmOpVHjonhK/oEbi166lkbQN1dD9ALhB4aRh0f7zruQjOLeJin7BQFlGfHLOCXTPUaA9P1qC3ukSuzOgpniBINoN4d6d6mzvHux0ZbDigTdU5uIVTvLcupj29w+Z+diUJLb/K/LGcyWb3RckvR6Z1Us9iQZEbY3bqMj23rUyjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738355101; c=relaxed/simple;
	bh=Y984jgguFlZIBOThWuuUJpuuUbC3lQREEzsrrqDNozE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tXjRIWSdwHWvRUmByrjuQBc7SUfAtKyHGqmganbUaxg/7sJm1t+LHPZECjuB4m4F36vUOIc7zn6w7F5dyurMUZUTlmh65OLrEBeLc+7/URHZDHW9E3+Sgu7cxds60CvPppCi7FxhuMbvAJZVilNg6710nFU5MGIq1aGIKCVsDfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=g6MnSnqm; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="g6MnSnqm"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-721d213e2aeso637660a34.3
        for <linux-mmc@vger.kernel.org>; Fri, 31 Jan 2025 12:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738355099; x=1738959899; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o0JxocTLtlGRqW6c379kuZnM3hX6Je635Dhf0CbFSJY=;
        b=g6MnSnqmPtos+/Hg7bCHWyJKjyq+TDTZqQp7OZrONvvlcKC/VYH7QgztlisRLGBmdQ
         jghEuXFMKrOniW4QAFgqAQCOipaZgdbpuJ2O4hEfYH6TL1LPD66bsT8BBIUmC5cK5oXY
         a3WzaqU9TOr9tJbZlFvfxYd28mIK3gM++T93/iSK0iFNb/wyxXP5FCzwszwhwIwkWzPF
         Cf7b4jyXBl9ahw4wJ+Dwp0erV/pFzP6ulzDkKc2WOMQkoWqUs0lv6OwYa4WGFYdXzh04
         EW1bOG18E7VCvYDsAEcFi3H4hFINROcY5yuREBrnlO8RR+FZ0ZCadWx38i+EYlzpnau/
         dkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738355099; x=1738959899;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0JxocTLtlGRqW6c379kuZnM3hX6Je635Dhf0CbFSJY=;
        b=vi0MNdjry9bSOGwQ/ABiLHO+sIn5zkNCdZqQ4bwFUf0NUoAFZZt+cKwzIbMDYy0kgA
         6Mf1D4zvtbyHD7a2YhPSBoQPtii3b8GkbQ5ybM78w3JwiQsobu5WJXsckEuTyWTkEy5c
         UF6LTu/cbpWGcuLaAsCtytIb7ow4a4B7q7Q0swJ8tbfoQ6dPFhvON7cAahj2TAbuDs7K
         viA60bKBv7hWmhw64KccD2u51M8dIDH6qknEZL/soEuR9zxJD3YiSY6W0t0J18GPAS0N
         5fx7jQO/w3elSJ6k8I8xCLU0YDbK6zJFLjseQGuoT6Muuh3ZZsoZvxCddkx5S2dasZSb
         6sxg==
X-Forwarded-Encrypted: i=1; AJvYcCVBDwHhbcJBV/dxfkDnFDGpAZErgSlngynfEIRQRBM4CMOlSSa7un0pOD5rZ7TDnLpKnvNqgIE/7u8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8jN3JwISf080YM+DWGATzs8tHC6aoX9iNXLIw5zwPLZQqAsEO
	jXhtb9NYnw8OOLYRBxsT8KSkBR93wk/zIEgZR2vVx4KIeyWxmb7VHMHvUP05owQ=
X-Gm-Gg: ASbGncs1VBF7WyRvo2Mb5Abq+R/a+ojOkKg4s+3wYIqqJ9qKQ9isScglWRTcqblK+iO
	z2wWQ1gsX1JM4jq22qzAWl7MlMa+r1Xjzu2560RsA5eyPsSkQRFht6w3SyE90TGmM2rDMJfOhJc
	SiFoQWxu3RH5IHIzXUPt/gybPizEGhoPUyG5klfSnPokpCJV9EI+YmN1F452I0ZJl+ii7/YfM1C
	DEIfvCJZi8xdhxSRSwsMX0EnlxmYTwe5MOofJbJrXYQbQKNL/CoNOa7TfeEt+RsnRLcT9D74KSt
	7XBlwmD4I/yVA151bBCWfJymuaaYMagfVqF6lN9vRrAxroA=
X-Google-Smtp-Source: AGHT+IHLLvw8v92D1IAdlvToO2DW44SjM8+FGXyX2n6gPI7BbY77buvq2CWQaGC5P0PVhdqadGjO1Q==
X-Received: by 2002:a05:6870:948e:b0:296:beb3:aa40 with SMTP id 586e51a60fabf-2b32f350834mr9144614fac.36.1738355098867;
        Fri, 31 Jan 2025 12:24:58 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b35623d2ffsm1403157fac.22.2025.01.31.12.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 12:24:57 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 31 Jan 2025 14:24:45 -0600
Subject: [PATCH 05/13] gpio: max3191x: use gpiods_set_array_value_cansleep
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250131-gpio-set-array-helper-v1-5-991c8ccb4d6e@baylibre.com>
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

Reduce verbosity by using gpiods_set_array_value_cansleep() instead of
gpiods_set_array_value_cansleep().

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/gpio/gpio-max3191x.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-max3191x.c b/drivers/gpio/gpio-max3191x.c
index bbacc714632b70e672a3d8494636fbc40dfea8ec..fee8dd2bd3c9eb7c06817430634eaf905cc9cbd8 100644
--- a/drivers/gpio/gpio-max3191x.c
+++ b/drivers/gpio/gpio-max3191x.c
@@ -309,23 +309,21 @@ static int max3191x_set_config(struct gpio_chip *gpio, unsigned int offset,
 	return 0;
 }
 
-static void gpiod_set_array_single_value_cansleep(unsigned int ndescs,
-						  struct gpio_desc **desc,
-						  struct gpio_array *info,
+static void gpiod_set_array_single_value_cansleep(struct gpio_descs *descs,
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
+	gpiods_set_array_value_cansleep(descs, values);
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
+		gpiod_set_array_single_value_cansleep(max3191x->modesel_pins,
+						      max3191x->mode);
 
 	max3191x->ignore_uv = device_property_read_bool(dev,
 						  "maxim,ignore-undervoltage");

-- 
2.43.0

