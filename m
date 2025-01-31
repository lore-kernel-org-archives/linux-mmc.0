Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E431F76A1
	for <linux-mmc@vger.kernel.org>; Fri, 31 Jan 2025 20:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738355112; cv=none; b=mwH/3MAWLujODvSfnNAFZtj3sFYNh7ABe3F/KftsY+Twy/xuG3kitA+EE1Pd941YQN8sPfyeBD/FGUGazIXjpcQ1C4QgK+vum/DObqFHgDkvavN4MCDtlSQCotZs4QqzuzMirKEeykn2DB0b/7IrNCYPwDSEEMx6UFOyKeG6LMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738355112; c=relaxed/simple;
	bh=MK0Ks2Di2rJVvigp/s/vAkyxV2Ps9hTBvb2TEAom5M0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bQ2GIfaah1wjGLldLOWlNd5T1GECbYPks0zlkwTaJOveHIKIB1aiGo2QcRGX4XepvJJ0xtc//Wg3w3x7M2ceX9RzwuWKveRvLoqsfq95GD92pDHPILZz6eMA8qRfPnkZpCtkymApAuiQKEAlPGhO83DHZWCNcLrW7dMawPWOtLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TvKooawx; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TvKooawx"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7231e2ac9e4so637190a34.0
        for <linux-mmc@vger.kernel.org>; Fri, 31 Jan 2025 12:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738355109; x=1738959909; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lwWNVnhNlJbHZ/NQhMSjzQrpqbMeo/6h41DdX1Qvb2w=;
        b=TvKooawxk3ek74wKtIXI5KaEKZulBtQxUrB6kT0RHQ8XQ5TNLQejFlCawjYv5dJxKP
         QmA0sG4JSA4gCGhiV44hp1U4iN0rC9D0ZGD6wp3VOQdc+WLXeUfK4cBDwc+pjyGzfk/7
         pIVDcxasgxQJ2GQFj2lxnW02DL477FldSm5uh+zU/Fgw1W+FRvpN4rRejYXzpHxzzQSq
         iCG1ZxCO27hKzZQIg5uybXovgC0OSu8/fCgzH4gIlDI1w2BuG2YhRlRuDEC39pO9u22J
         zfw/1OapEiNvUatIPZ5hKMapWz2jItA1s2EfzhfSeHtmWGsEuE8dHTerIIfQDTMKhuZ/
         0yHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738355109; x=1738959909;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lwWNVnhNlJbHZ/NQhMSjzQrpqbMeo/6h41DdX1Qvb2w=;
        b=Hhd1QZgiq98eO5jkA937Y4172NGt8xjOG8w4r1akwhpdZHPMxzIMVPzf4q7cEEocKK
         a7hSe9TKUkCswqCpyIIAUPro08bxYWlbsOyNe+nP0vwwkaIIWfo+VY0snBqrIVoK+HvX
         9Iho7s4QkI1xHmiFMzr1Fiv0rkN4NpR3KOUr7RRMqHh3DpnOMfSCEKxkR+OkAbsYIxo1
         GSgQJRo82D9yBnm1q7YoVE/5w6l0WIKdfYVmEPd3fqNmS8X7KMO4S+CIHBHKAp9waOrp
         SsISE1KqBKh7YmGeVZ+8CvRvOZRgIWSISMykAMoLYpgB6ABgStmTqW7Fn7OXif2Z4Vuj
         755A==
X-Forwarded-Encrypted: i=1; AJvYcCXSemDd65lGUKLt1sOwlLDVSQaxFEc9BdU5Fac5UE14/Aboy6Sq7+yHDtGWB5jmPqd9mqQlOp/VNgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP8yr7Gptoqpy71/2zm3JMWoKky7wTiIN+ymHo8GX/NVbwS0WR
	yDembj2Fzc3ifO9YjG8LUJEtEPBKVo9qksxBufyF8oyIXu9H8jy/Fk0FvMiAygY=
X-Gm-Gg: ASbGncvc4YqDkVfKmwout1bftghXqgSaV+I1PTJ3AeTKZppsd01R4KalDnANl9AxXHO
	eS7Da5kzMVeVRQ+dMueIgs3WA+KKLz0OtFSlhavCgSvizY3+p4inDFXlMfJotVXmEfhn9kZvUZQ
	fiWliByydgTPQYGtgqfUrUxop36oSmJtgZJBkr7vIxkbpPiFzDqHRBVyS+b1LpyQEmj6nrBOrnK
	qRE6paH+kLOhIXs/5IBElomvDI+ny6ivFr24eCLHpfefWjNq8shhik7XFatq71BVVrt+udJT5uc
	u2bScThWMYj2V9ReK2iRgpyt1GRnQ+vbmKx27QAUV3R1WtU=
X-Google-Smtp-Source: AGHT+IHQyjQ8y3Rtu7NlfkeMw/zOxhLdOk/J2rb/TrRaSbO1InYUF9KwbynHBq+Y9XgpJsj8OqBDUw==
X-Received: by 2002:a05:6870:7186:b0:296:aef8:fe9a with SMTP id 586e51a60fabf-2b32efdc7b9mr8033858fac.7.1738355109312;
        Fri, 31 Jan 2025 12:25:09 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b35623d2ffsm1403157fac.22.2025.01.31.12.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 12:25:08 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 31 Jan 2025 14:24:49 -0600
Subject: [PATCH 09/13] mmc: pwrseq_simple: use
 gpiods_set_array_value_cansleep
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250131-gpio-set-array-helper-v1-9-991c8ccb4d6e@baylibre.com>
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
 drivers/mmc/core/pwrseq_simple.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
index 37cd858df0f4d7123683e1fe23a4c3fcd7817d13..b3a6d053c826741005f1484ad81df30b6bf75bbc 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -54,8 +54,7 @@ static void mmc_pwrseq_simple_set_gpios_value(struct mmc_pwrseq_simple *pwrseq,
 		else
 			bitmap_zero(values, nvalues);
 
-		gpiod_set_array_value_cansleep(nvalues, reset_gpios->desc,
-					       reset_gpios->info, values);
+		gpiods_set_array_value_cansleep(reset_gpios, values);
 
 		bitmap_free(values);
 	}

-- 
2.43.0

