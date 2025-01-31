Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895DB1F8673
	for <linux-mmc@vger.kernel.org>; Fri, 31 Jan 2025 20:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738355118; cv=none; b=YCLc0GZNd3ehf6RVMzPyGvkngvbBFddXoKADBn9v8TUPBnSxSOxx2/Q5q4usHFfpjJQwLasRVNr3Q+9VGylurSQQQzVm6BJqfdk7Agoj93upbOqHpMuys3EY6v1xlKxFK79T9Bg3G8uHHawl7zJuws2aAHu06tJEh5Fi7clWkdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738355118; c=relaxed/simple;
	bh=5lFciV6sDtnvvFQNJQrSdhN6LDbuB2QD+esDyLXoYWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aGG3iWZJHFctJDskLNoWmpVWkJaQp+MFaIKEF7MlkFdO+BuMLDLotlQHnO9I04vGVwBtBtquFsUpkF1Lz5yofB4LNQdB2/U4kGjabUu5n5yP+jPcd/9LPmaYQ4RO7b3kIHULFtw/+Z52iT1whXTsF4NTPI1on5Z7FsazPP+FC5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xfWVISNq; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xfWVISNq"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-71e2766994bso1199313a34.3
        for <linux-mmc@vger.kernel.org>; Fri, 31 Jan 2025 12:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738355115; x=1738959915; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=59JJI4CO0oacXanEEbv/QOEs28IMbairlUQePRWumA8=;
        b=xfWVISNqGvmJvPxCnksE/Yz1kneKNWKaDoiPyVLVuJJqQz0AQds5/lIkpGqMh16iAD
         ZERvZm4NHH8ecjtnA156EOdT+s3afBz+65DNdZt3iYc6HqEWYMjMyPm8Oa1Zu3dPVK4n
         CbpaQ2ouRcwZeE4GRJsuUuze3SLPEEZf4CyvVcS6g/sEFkP/lEB0nbmevg42OYuehQjL
         4ohqvG7FisQgxd+xvcJN/S6d9ahf31PmA33gG1nKowgQJgD8P+e0HjR3kWZiVVKkuPUD
         3mdj0uy6cgk5FRaXgawn4H7fxeN9x9oZP6o3ixsNVrT4QqFTpirkBPSGe8iZKk7Ez5iQ
         nxhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738355115; x=1738959915;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=59JJI4CO0oacXanEEbv/QOEs28IMbairlUQePRWumA8=;
        b=UG+ZaQgp5s0G09t5+Czu76RgHpZ1vvTq664oGzOc8KgJa6PU9P8isCSLOLSljhXUme
         H6GJz0fqzrj/zvoHp5Vwx6tNteL86ENii7Emc+3yII6r8nRLhOVMNtqw1alrVjI3vDUD
         K6np/NrpOGIWnWt7nQg1lonRnMmmwXqrswRSuv2JcFqHcBjWh2OO7Zmv6qz+fIzQT9Sj
         ANmYLbX7W6PaI2CuKs94ZdpCWibwk19V0OPDEj64enf5JvuI+kEG2Y2fjdg8UQnfc+da
         TWoQeD8W+JI9nj9/f+I9EPNgHpcwqcoQBkG7SIfRY0w3PWoX5YO6IsHhxAmtaCC9TgK3
         nYfA==
X-Forwarded-Encrypted: i=1; AJvYcCVWf5MKX+mfhiL0a+R72MEKbaSlqwEnMkAbN21NmSUsYtcDI61wQKmPFZaGmvHfggAMl+MWYyi54YY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWvu/9YZPGeRx6CPYL3J/ltbfv4XH3RpFnX/Dac9Sw1EMJsAVL
	JXiLSfUO1AVigfAPVsCzA2936Mlm3lSrz/WxNuETqjD+JNjkJzMpimjB+akXWNs=
X-Gm-Gg: ASbGncvyBwb2okg5ifo85VsW5ghID3V6nyNtkjkbg4L7UyuVtRQflvudDD5KYYaKMpT
	JnrxTbrYkJio9JRlMc1UQKmo1bRMBr1/OzU+0mAydIi8rBjNQ+XTnwkDqMkCKxTqLxryMbwztE9
	PBF6gdtP+uy8weDBi+XAHUYWsnI9W6gBcUbh8fzEsg/Dwmo+Y5OGv9YWNKGfzqBMhBTfoV2r2R0
	63DAECFgKM7w9TelJ/FdnjFIhw0UvuJ/d2qzOyil7/Sp0BTLFjoqqdhnvsLNHehYEVvQ84NETve
	OMDbg6+nPMrpcVGHKTFcZ1ZjmLvFR8raQfOkD87V0WUs7hA=
X-Google-Smtp-Source: AGHT+IFrVMAfd3Y3wOZ0h4O9q45j+fMg4Vw3AAmlNZ9ZgYIq1KVZZxWHseA00ADe6a66eu+rR/ZJMg==
X-Received: by 2002:a05:6830:6805:b0:71d:eb02:baed with SMTP id 46e09a7af769-72656774376mr9460293a34.8.1738355115546;
        Fri, 31 Jan 2025 12:25:15 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b35623d2ffsm1403157fac.22.2025.01.31.12.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 12:25:14 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 31 Jan 2025 14:24:51 -0600
Subject: [PATCH 11/13] net: mdio: mux-gpio: use
 gpiods_set_array_value_cansleep
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250131-gpio-set-array-helper-v1-11-991c8ccb4d6e@baylibre.com>
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
 drivers/net/mdio/mdio-mux-gpio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/mdio/mdio-mux-gpio.c b/drivers/net/mdio/mdio-mux-gpio.c
index ef77bd1abae984e5b1e51315de39cae33e0d063d..d7eaeadde2873977606bdcb5821dba18aa4a578f 100644
--- a/drivers/net/mdio/mdio-mux-gpio.c
+++ b/drivers/net/mdio/mdio-mux-gpio.c
@@ -30,8 +30,7 @@ static int mdio_mux_gpio_switch_fn(int current_child, int desired_child,
 
 	values[0] = desired_child;
 
-	gpiod_set_array_value_cansleep(s->gpios->ndescs, s->gpios->desc,
-				       s->gpios->info, values);
+	gpiods_set_array_value_cansleep(s->gpios, values);
 
 	return 0;
 }

-- 
2.43.0

