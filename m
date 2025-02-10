Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556A225A2BB
	for <linux-mmc@vger.kernel.org>; Mon, 10 Feb 2025 22:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739227065; cv=none; b=SwIAM7vVxo14dpLu8TkQhsd17tKTZev6dvKQCy7JgqswEv7MDqmiyOHvbNq+99Wy8gcjCITvkR4LIZK/M3Hlg/5YeMLWgcpthGXrQWBRu0HIYXg0VyYdj5KzNTL7G9rCINBZgr5oTPS/MMcqYErUGL9LMyBCS202eaCAjCoC68E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739227065; c=relaxed/simple;
	bh=K5V5TnWu+110nnHuULWw1Pwd0QiBFgzUapmy9BeC2p8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R4IAevGLES+AIBZIC4NB7vy4rnZTAS1fkpGVxbmzo4S2piEHJKw2nC0yFBgzRfUvDtDPVV0Gl4y70Tw/KmDTW4wCuoQo+TFB/NgektB/h7SpuxBmuzJuWED1bk+IDvWeX1mo7+6gd2mReCHnIKPHh9MT7gMZ7O/5xX5FcMUiUAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=z4odNCuW; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="z4odNCuW"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3f3ace3d30eso1142683b6e.3
        for <linux-mmc@vger.kernel.org>; Mon, 10 Feb 2025 14:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739227062; x=1739831862; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oAgdP5/7nbSCpei3bdgHz+Kvp3J/VbeQ+Dc9cWuRxQY=;
        b=z4odNCuWEIdXw6egWdAWzvkDfUm2yp9LCjnZQvBCOP3qcsaxfCXnX9ztT4tAzJgMaI
         oDzp3usrGdpGtWbm0FqUkKrpmWAEIq0wPRJUUbuLHncebfsQtZRIdXurTcE0coBezaot
         JCqwfqdc21V6HhF23eOTpr1Hv00Dk390SFpGVTMpKQAG5hTBVYYJCwcIsgcO9kiueCqz
         pcz1nbGaOl3KNFWRBj/DCKZxfPkD/u9KWoJF+RASmhfD3E5roTW7Q9RZbtvCdUfMt4C1
         4t7qWk6gsXi17m+oWug7qVV/Df5lYt5w/9r/5UtGtJtXuARRfAjocCTg95E9CRvg5S42
         AFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739227062; x=1739831862;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oAgdP5/7nbSCpei3bdgHz+Kvp3J/VbeQ+Dc9cWuRxQY=;
        b=XCJSW/wAT4JRJtrhXnzrTW7H227wEkypm0kFVr+KT26ne51XFibecWHPPnskDCu21B
         p4/sk5HfBQfXqOWLbG/XsGdjFMTNRCDR2rDUsr/NhSgPjbXtfq0L4Fjw1fhibgiT4oMb
         GND68gwtSK22VsHJyMXjgdsAf1jMQiK29h4udj5tDQ0d6Fu/DeJbvvsy1kjgIzxObvRq
         eM9fhJLHNN8a3Rcsrln48omEVHcpjU38A1hTJchLxQeVoRM+oJJGcC1M0ghrTCKt8JeX
         m8oS839HbVobIQi3HkYJ5B/DIaPRPxC9yimTvpxvHySrPvgit1ksTnw8fB2r+HfIzB6P
         CI0g==
X-Forwarded-Encrypted: i=1; AJvYcCWEqOc9aFn/vq1tXJjc/9syNHSxGGfj3Rc5wFfq+8yLscNs6nJ5X/XPlMfUbQX7peQoIPM8LOk3gGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQZVEQJSeiJRhAuasZxKIrKbDdHAiKyap1JYAbaLC03RBKc0st
	85flARkqyYjL4akope7XBFWSgjZrRcCglGAmrdS4ly3SJ1Rav7gRo2uWF42ZCRs=
X-Gm-Gg: ASbGncsuwuuxTicBG5vG6PpqOz6scjmdUVt9Ph0Mr6zfFrsJnZrCSMM0qjvbFeuM2jl
	XItwgNPBdyHwvCSNgGAQbbNDFLUOgIqYzWfwUX1KE+5xzPlE1NxRIC3vHEv91c3u9/IGzr3CSzH
	4Wp8jJLWWOvWy4j1fd+Q4aAx7g9KaD8dcfavkiocsbHIRjY3xyfXGCMNHRJsw3Me9Lx3nJhwqAq
	IhjCA84kz0Jd5CBJNIW0k6icrrzeabHu9WYkSCpc8zDV7Xq3gLH3hLsSx4o2kjJWJUT4niTnhkO
	14yD5xGQFKZKdzL8MIkElv5wQytxzWZ+eJtIXH5EUkMbCnI=
X-Google-Smtp-Source: AGHT+IGCum5h1AQwvUJNh3Kk51lVy6xq7QJ+B7z8EkY33CFant2nucCBaXwDqcXBpkDagMClSCsXTA==
X-Received: by 2002:a05:6808:4099:b0:3f3:b0ae:7998 with SMTP id 5614622812f47-3f3b0ae7b3fmr3901508b6e.17.1739227062548;
        Mon, 10 Feb 2025 14:37:42 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f389ed1ca2sm2521820b6e.11.2025.02.10.14.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 14:37:41 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 10 Feb 2025 16:33:30 -0600
Subject: [PATCH v3 04/15] bus: ts-nbus: use gpiod_multi_set_value_cansleep
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-gpio-set-array-helper-v3-4-d6a673674da8@baylibre.com>
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

ts_nbus->data->ndescs is validated to be 8 during probe, so will have
the same value as the hard-coded 8 that is removed by this change.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/bus/ts-nbus.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/ts-nbus.c b/drivers/bus/ts-nbus.c
index d3ee102a13893c83c50e41f7298821f4d7ae3487..b4c9308caf0647a3261071d9527fffce77784af2 100644
--- a/drivers/bus/ts-nbus.c
+++ b/drivers/bus/ts-nbus.c
@@ -109,8 +109,7 @@ static void ts_nbus_reset_bus(struct ts_nbus *ts_nbus)
 
 	values[0] = 0;
 
-	gpiod_set_array_value_cansleep(8, ts_nbus->data->desc,
-				       ts_nbus->data->info, values);
+	gpiod_multi_set_value_cansleep(ts_nbus->data, values);
 	gpiod_set_value_cansleep(ts_nbus->csn, 0);
 	gpiod_set_value_cansleep(ts_nbus->strobe, 0);
 	gpiod_set_value_cansleep(ts_nbus->ale, 0);
@@ -150,12 +149,11 @@ static int ts_nbus_read_byte(struct ts_nbus *ts_nbus, u8 *val)
  */
 static void ts_nbus_write_byte(struct ts_nbus *ts_nbus, u8 byte)
 {
-	struct gpio_descs *gpios = ts_nbus->data;
 	DECLARE_BITMAP(values, 8);
 
 	values[0] = byte;
 
-	gpiod_set_array_value_cansleep(8, gpios->desc, gpios->info, values);
+	gpiod_multi_set_value_cansleep(ts_nbus->data, values);
 }
 
 /*

-- 
2.43.0

