Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E25425D54F
	for <linux-mmc@vger.kernel.org>; Mon, 10 Feb 2025 22:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739227076; cv=none; b=LMjQnHNAFxNTtR2w5GYoBfMBqc4KBAO7Ar4VYppcqUahM5OKln+Mk5vLfh0dCH4V0aQukZbBaCV8pR3jONfRg110JDM17t74UK1Rgjalk2FG1b2HxHW9rTxdKQ366aef8u63wbWhC8XXvJTLyiU1W8UNz+rN6luTrq9j4d69VKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739227076; c=relaxed/simple;
	bh=DEtDLgJv5UYwZaak4CnPj1ALmi7rrV6hWuddp/nLJio=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nSB2MmI3FA+0BvQ1ObL5fvAoBbLOLU7OlfjAe/1ILOVZfp2SddrWmD7NhQD1aTVN9mEngxcpfZRVQ9oB8U7eGWywD6uFN9CdxbWUjvSFc39ca4ObbW7BdKdYIe+RnB33iykfJsp9m1UCQj+aZOia5i0Ve4QDnh3w9xDfteKPRws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vujvn9q1; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vujvn9q1"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3f3b6d7045fso801122b6e.1
        for <linux-mmc@vger.kernel.org>; Mon, 10 Feb 2025 14:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739227074; x=1739831874; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GMcrxDurUnSK2SHairVKflMalwdh2XVxdj0wjaWv8sM=;
        b=vujvn9q16sHkCxjODesonUK7YfToaWCovqp1meHYAiAMGuxuvuxvtjgT7kb4u9Rr6V
         swRcw0YIojKyBSboU0wstCJdaRggX8BRWH4M6uBpGT8p1fBitXYbaydpvLWzCEQjAgyH
         NK8GDJF94FCeuET5MshCx5YbGjJaWqAgw3WdWfpWFRjlu/QtI/QggzM5FO97TiYmaxBz
         PAABk2lpH9oFI0pUI/2JkcpFJHdPWUeviNglFTcXNGwMqsgsZIHJYDsnSsc9LP95ZXSs
         ERAcFCFmZaDh5TkuKpoMUw8CZYx5ReOtYpGtHricMbLSB2JZJizhsvkfgo09Zkf0S9Pe
         pc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739227074; x=1739831874;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GMcrxDurUnSK2SHairVKflMalwdh2XVxdj0wjaWv8sM=;
        b=cxZNlPVI2XQrSexZQm5AFafveghDY0DHuqzFZOnXhJhm++c1r5uD5/Avu1dFyjJqrj
         2pzRElECGNLvbQ0Q6GDp1ckxEDaqi1LU9KNVL0x75+cT2ti1nDK0LOUwSToED0omb0Rp
         UdrbX/RlUGnib8v0wFzrg4qAgWI3gABdLr7sPI1BGLgM7vNAwiczBjCWW36TSX1y3INw
         oXJYzSASl7/E6O+WCpZ147u2vUu6uHvDk04F8kxqAfPmDlkqTG5f/JFjM50zfK0OLVgv
         miuCCdnO+M2EX0bWQDyoiBDy2CLPq4akJbt3w+Xq8DFTs3BVMrfMOtEZsH2fld6jPvtY
         ThZg==
X-Forwarded-Encrypted: i=1; AJvYcCWs6auM/GB+O6skMOho/DKfOOPEVpPzh5lf4axPT2hQoLa/fL8IEoGMg8u/Qb4xsSTcZ01IRte6CA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBmJQbW9elXO2lTLcsgeZiJ3eLijMEVI964W9BWyyq5dEoGYLy
	kWZBTOfT5jtgFnp4e+NxodQPGgmlRI06jWb3FJy/kMSo0+x87G2/QxMktKUW98o=
X-Gm-Gg: ASbGncsvo/EMjC1lKZk/w1dQ6OM3tT0WIlO52ZknBYPla4O9gbt5WtRMH+3Hsxxu42t
	+Z3SPY+3mQI5JWpI7oExOGoReN2hd6EbC5zwhh7lIe98Wpawa/ECW0JF9lJ9BR/0e0AwMuFBGNt
	YT73/UPrXpFBxpRUmOoOCi+Ask6O9hWGYCQ4yBgyKP5XEYYyeuJ0gs1WczVTWW5KvdvsvG/LXHO
	qm+HjiypYhdtoooiHyBZkMFLr5qBXvqIXMhaNwnYeaKlhZjnpd5D0PVBm58vRk88hvDI3knrVsZ
	gYaG6g0R1PlRefmI2gcP9eQFZ+D+U0hvqntwEDFOBLWvgsI=
X-Google-Smtp-Source: AGHT+IHpQCMO/UtYCFM9csSv77tlAPoKshLmX0/bTL0+YDtp28Q6Z4e9EVZz3B9NbqVlL1P+vOnPrw==
X-Received: by 2002:a05:6808:1a19:b0:3eb:39f5:de8b with SMTP id 5614622812f47-3f392362d24mr10975894b6e.32.1739227074492;
        Mon, 10 Feb 2025 14:37:54 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f389ed1ca2sm2521820b6e.11.2025.02.10.14.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 14:37:53 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 10 Feb 2025 16:33:34 -0600
Subject: [PATCH v3 08/15] iio: amplifiers: hmc425a: use
 gpiod_multi_set_value_cansleep
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-gpio-set-array-helper-v3-8-d6a673674da8@baylibre.com>
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
 linux-sound@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Reduce verbosity by using gpiod_multi_set_value_cansleep() instead of
gpiod_set_array_value_cansleep().

Passing NULL as the 3rd argument to gpiod_set_array_value_cansleep()
only needs to be done if the array was constructed manually, which is
not the case here. This change effectively replaces that argument with
st->gpios->array_info. The possible side effect of this change is that
it could make setting the GPIOs more efficient.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/amplifiers/hmc425a.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/amplifiers/hmc425a.c b/drivers/iio/amplifiers/hmc425a.c
index 2ee4c0d70281e24c1c818249b86d89ebe06d4876..d9a359e1388a0f3eb5909bf668ff82102286542b 100644
--- a/drivers/iio/amplifiers/hmc425a.c
+++ b/drivers/iio/amplifiers/hmc425a.c
@@ -161,8 +161,7 @@ static int hmc425a_write(struct iio_dev *indio_dev, u32 value)
 
 	values[0] = value;
 
-	gpiod_set_array_value_cansleep(st->gpios->ndescs, st->gpios->desc,
-				       NULL, values);
+	gpiod_multi_set_value_cansleep(st->gpios, values);
 	return 0;
 }
 

-- 
2.43.0

