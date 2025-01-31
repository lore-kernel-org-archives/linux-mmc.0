Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DAF1F78E9
	for <linux-mmc@vger.kernel.org>; Fri, 31 Jan 2025 20:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738355115; cv=none; b=lRPefj/kXSd54fjdusG2s+x5tf9wD7ew6GQm67IQjtZAVoAoCjaZjvBbIgNUWO11uUCTih/fbH6IPiJVtD1+BIPtHKWtaBldjw9pe2Y8zKhg0onKqi2rKDdPqRWDXC9tER3Op+qpu3QLY46pSL+kK+FjP1+XkrnnpbHhXUBo+Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738355115; c=relaxed/simple;
	bh=9CicIm6xDarlbk67AANQJSF1s3m5MgjSBlIRcxjc/Fo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WSlGA2CfeMN85XV6S3ArOe/iQ5Oxz0w0n3B3Ww2lsKqU0iHOk6pER0vnmRcLMy5TAuQ+d4sw/v5YXLsW7xw1LBegcC7l6AeIqlYI8S3KhYTeSmlCeuUdSp0YMTNs+J5tnFKu8NyOdgBbXgCAyp6eqoXKvzj/PahxdBMUSHTd40o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wlI+CUIC; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wlI+CUIC"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-71deb3745easo541415a34.3
        for <linux-mmc@vger.kernel.org>; Fri, 31 Jan 2025 12:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738355112; x=1738959912; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q8dlq+1FyobpCXd9TkKRwFwRft57r9IiORFW/g/tAaA=;
        b=wlI+CUICXgXZ59m2jPFbdGv2J3EAl6YkI5OUi/o+5HQFg88HspRlr0dr1Ize9/zZhX
         vgbpaxsjqQ/QqRq1yjMqvW9qbxX33uCRK4wTRB91evDI5+FGRFEuBDaMCqG/MQZpJC3/
         bCWmxqxUDHoywe7tnFcOdgK2yuwPKsY+vyODObT6GFruCueLz/oc+ccc/9kSiZ+XWO8E
         8hdmqDBq4XpUmELiwQFDfZpCjeeFhJdOkm6M20lOsf8VzfgOqD5FaKNCKmDUeS++Fdp6
         Xq3mCVUjEVhfX7aQ5E0CD3QkC7ZwhZ9xffOXr1M0hlZ8bVJXGwPCZbNeTgRpOff8wAZW
         z6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738355112; x=1738959912;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q8dlq+1FyobpCXd9TkKRwFwRft57r9IiORFW/g/tAaA=;
        b=bfYUkLrqA114S0DI+TPkqMNhQTwT7rVICqEcPUPIrnYgd/eiRnx1EizjyhBPxrm8Qo
         PcCNAb+zj2mImSgn9F8doM+bb4I4Q6L4I9BukYYf/qGhYbzGarHHBRDCQWx36EE4Edwc
         Qah4HzPvHDk21LssstD5OFHXlT1ioKO0kmK1DPm0ulZAx16B7wIWYjKNodyQARLgGnJk
         lsB0jaiXIH3RADhJm4e9lN7ynB/j7DPiPjAPmiBhrqYxDqX2nPlb4hCDuE2rg5gWAGBH
         ocdrt19aVpcdpNOhpo2w8CiTGm/q7iCwMdLCHXW/kmMLQdO2ymA7qPp3b+4ip1VQ3BNB
         7pew==
X-Forwarded-Encrypted: i=1; AJvYcCUdb1RTNcpNBMOecriEe7D03f+voQj+4GqNUci91TOwhByOe37Hoe5uyeWrM01p6yDalZu7VeqOhnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYS4wu/BzFzpM05eRi1ZIuezLc0b+NcbZjjuNSve/jOV/wO7i+
	PHy+qPXzhipHXk8LOYOUmH/AHWIV4g7Pfac23pEPmhlZJeNbpqGqWFRTuc5v3zM=
X-Gm-Gg: ASbGncsNMfjBoy4Vc5Loco3ht3UmTWYTbah+gEMQGhEHFpcMMG13BlCCq7yLZXbhQ4c
	M8XmDbunZ0effQeP5BB4VBE6QUMkGqgy15myTZ2fcEKwT4Z9tWUVfRcwzjAeSjKQzUP5j8Og0it
	xqRACcS7GIEYmi1gARo5cozwd1TtM3E8sL/qixu+2ifs1LHmg2z+0+i7U+81sZs38fj86cPai6h
	ThXjDYro67IX3pHIQYbbwnCwqCnYTntQQJg2omn4SO3now/8UDywxauAAHFQbdJowAQiJAvz1R4
	y0yXLUQmnCxnJgbXREkNta70m8WbybuOwVVGaaaeXV2uM18=
X-Google-Smtp-Source: AGHT+IEOPFpYcNvsoJvtChI72uu39YNNI5XV7tV2UH+PWhk+hEwEt/BHCYYItie+9RSXj9400mKLXw==
X-Received: by 2002:a05:6871:2106:b0:29e:2caf:8cc with SMTP id 586e51a60fabf-2b32f30c9fcmr7202349fac.37.1738355112453;
        Fri, 31 Jan 2025 12:25:12 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b35623d2ffsm1403157fac.22.2025.01.31.12.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 12:25:11 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 31 Jan 2025 14:24:50 -0600
Subject: [PATCH 10/13] mux: gpio: use gpiods_set_array_value_cansleep
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250131-gpio-set-array-helper-v1-10-991c8ccb4d6e@baylibre.com>
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
 drivers/mux/gpio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mux/gpio.c b/drivers/mux/gpio.c
index cc5f2c1861d4a22d984bcd37efb98dd3561ee765..fdfb3407543dc3c2563750b013754ceb3390e39a 100644
--- a/drivers/mux/gpio.c
+++ b/drivers/mux/gpio.c
@@ -28,9 +28,7 @@ static int mux_gpio_set(struct mux_control *mux, int state)
 
 	bitmap_from_arr32(values, &value, BITS_PER_TYPE(value));
 
-	gpiod_set_array_value_cansleep(mux_gpio->gpios->ndescs,
-				       mux_gpio->gpios->desc,
-				       mux_gpio->gpios->info, values);
+	gpiods_set_array_value_cansleep(mux_gpio->gpios, values);
 
 	return 0;
 }

-- 
2.43.0

