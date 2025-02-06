Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE85237706
	for <linux-mmc@vger.kernel.org>; Thu,  6 Feb 2025 22:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738882115; cv=none; b=B2pCt0xEMCmfMivFe1wpT/ozrNzVeA0MdBK3uz07gXgrjtu/QJ73SBCRj2yp1N0zqM0+IIo+i7dUS3okEARQ0E6usgcQCpbr4BISfgWcNZ2eG47X9yTMYq9TBv+IQqHe+wYrFpW38+hp3S8+nUt1iGkdSOaPvfNTMRcQVZFUi34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738882115; c=relaxed/simple;
	bh=dVRjAU54tx+uhyYX3p8irPZ6yP65YxRfaFsbht8BOc0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IhYpC0OjDBzc3F2KPixzCw0RQ1x8tm6yO+eiC8thBfiQhOKOahE8LSqx1715l7jdXEm93Z0U1GvQs0STdfPdHqBFsOFXlUYpgr3jyNoaQhc4yREF5zTiyOZbhTTinsHE/On/WG4YJhbqwxP9tQ1/RPy/VdS988XmO4R/p7EjdPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wjbvpfe1; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wjbvpfe1"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-71fbb0d035dso905171a34.2
        for <linux-mmc@vger.kernel.org>; Thu, 06 Feb 2025 14:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738882112; x=1739486912; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qt9BcvBwXw7VI7drRQ9jRI7HoN4iY1rdT776+r9izwk=;
        b=wjbvpfe1y9vbu9WfWQNJOmobf4evI0a0DTqd05GYZWCD+pM1oc7n1Pr8t/K2ePbKwY
         9h/gKre5OlfmXCw7nBB4j2zHdshTFR7WrNNDx9WEQpLUbvz+ozbm5/xTnZ66YBwvGIHa
         oo6Hzo40IoTI9+Py9Hxzi1zeyf1uIxrkfNnFGUE57jmPb80KqZkMBV5qek8E0x9MWsfa
         3mT8OhurrwEVP1aUbipi6IJnyVVDFyfjBTA/ZTAE9GFG7r0iSLInyyxgOGvyKGVZKZc+
         GRNIspbp8MyE7wOtYKSUf6v1a0tJzFDo39su0Cb+GCY+I5dnygCR+FzmQI4OpWEf6zeD
         Dn5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738882112; x=1739486912;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qt9BcvBwXw7VI7drRQ9jRI7HoN4iY1rdT776+r9izwk=;
        b=gSiua/g8kxFZxh4ygxxCDGqvRMCi5L/LEwY65sVIu06Gyj7TlV7kA0XWon45M9K21E
         C4mBRBOkRxiJOVRnTaqf05jMiZ735MfkTR/DfB4UaU3X36y6JVi+c043SSeDHlnOgGI/
         WbyIflbcRMs62KhSN+MrXuxKH8xR/kJESa2/gCxI3hhTuDbmXUw1kx99RoGshDDnvgkq
         svhF6/2nFzMasJTbYQv5p9z0sfKeAt7X0rHmWcoo7MSYcRbkwfEHm5yJirg23iWwHo/n
         b22Acji4ydi+kkRG/6eu++N2UUQjlKs0kYkj/0hEcFDHtxg9d7XPw9qXjknXZezuWJI9
         8dRg==
X-Forwarded-Encrypted: i=1; AJvYcCVPCUEhJgp2NLK1Eql2XsdvGayNEso7nR0+uKBI7sV5tavbQrbyS1QUpbLhRGJ2nuHglP8DyC6YKH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEP0iax4btu04X76Ewhx7M8aqsPBjAafIiF+Sd4lZHMGWP2TXZ
	sruBsvBTI5f/YTmKBy8dQw22pUkEmQtIVLmgfRWjKKk7Yl7F2ZFiav6N8mPQwt8=
X-Gm-Gg: ASbGnctA66ikaGAKDTHntkqNVwTdYF29qbFVVmBOvQrH0BMj7Ee/I30FL98W5/yQCl6
	LbPK8Me97aGy+4+SmZHmpBgB2XAlyMyYGFgrz5BqdyGjR/dH7hAj4NjvCcIHLVz2+cYveCqhKhT
	SuBSQneoTK7/ScINrUHkdfwjKBRNpsZyhMbY3eE+GFA49vH7AwvXKRAsRILtubujnK97K9bOIsK
	x//mXgThKnYiy4loAr3W9e3Ym7iiFD8gZKw5GRNROcphNnZgtUsXBHNafjcHiS2cwyea9hmiiu7
	Rn23AO3o6KOjUHPeq7jeaJenbXZUHrxl/dlYoCToBpR5mOE=
X-Google-Smtp-Source: AGHT+IHXxKi2A/XYeV5UWyLNbvoQ8dEflCn5kPNBQNuzG5uM6VGTHdJPWbFF8OVEjlJC3/X0uqQhvA==
X-Received: by 2002:a05:6830:668e:b0:71e:48b1:ad28 with SMTP id 46e09a7af769-726b87b3665mr815075a34.4.1738882112753;
        Thu, 06 Feb 2025 14:48:32 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726af95bbb5sm510986a34.41.2025.02.06.14.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 14:48:32 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 06 Feb 2025 16:48:22 -0600
Subject: [PATCH v2 08/13] iio: resolver: ad2s1210: use
 gpiod_multi_set_value_cansleep
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-gpio-set-array-helper-v2-8-1c5f048f79c3@baylibre.com>
References: <20250206-gpio-set-array-helper-v2-0-1c5f048f79c3@baylibre.com>
In-Reply-To: <20250206-gpio-set-array-helper-v2-0-1c5f048f79c3@baylibre.com>
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
gpiod_set_array_value().

These are not called in an atomic context, so changing to the cansleep
variant is fine.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/resolver/ad2s1210.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/resolver/ad2s1210.c b/drivers/iio/resolver/ad2s1210.c
index b681129a99b6cf399668bf01a1f5a15fbc4f95b8..7f18df790157f1e411fb70de193a49f0677c999f 100644
--- a/drivers/iio/resolver/ad2s1210.c
+++ b/drivers/iio/resolver/ad2s1210.c
@@ -182,8 +182,7 @@ static int ad2s1210_set_mode(struct ad2s1210_state *st, enum ad2s1210_mode mode)
 
 	bitmap[0] = mode;
 
-	return gpiod_set_array_value(gpios->ndescs, gpios->desc, gpios->info,
-				     bitmap);
+	return gpiod_multi_set_value_cansleep(gpios, bitmap);
 }
 
 /*
@@ -1473,10 +1472,7 @@ static int ad2s1210_setup_gpios(struct ad2s1210_state *st)
 
 		bitmap[0] = st->resolution;
 
-		ret = gpiod_set_array_value(resolution_gpios->ndescs,
-					    resolution_gpios->desc,
-					    resolution_gpios->info,
-					    bitmap);
+		ret = gpiod_multi_set_value_cansleep(resolution_gpios, bitmap);
 		if (ret < 0)
 			return dev_err_probe(dev, ret,
 					     "failed to set resolution gpios\n");

-- 
2.43.0

