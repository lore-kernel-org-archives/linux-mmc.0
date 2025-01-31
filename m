Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6307C1F427A
	for <linux-mmc@vger.kernel.org>; Fri, 31 Jan 2025 20:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738355095; cv=none; b=Dci3WrMOAp/4/+987Yd/pOasz/q41q6lR4OhVo/IEDP+/F3Nsef4nc7Gtl3zZ30VPj6miJZAR0yc/snKqN0/E95McAHCFw0h1fRiFI4qE3/vgbnH7Lvqfm3zm7iMANuwelqkgS3GgSElqsT6OFumgsSJhDlDgUuk16Y656G6u5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738355095; c=relaxed/simple;
	bh=rw0sTpvokUQNOxXktkwUiVgyBWFEQak6z7kbvwC+d0k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ciI3H7YICjpvo34qVKAnMWPVNK5MI/gSfo+AWmxJ+E2fwG5oFEFSHLy93FPipKj4xJxP22OESBabyu52Tz5aw4qQBuNLwEZMUMFQCSYCF1Mcx8bnA1EGZVctCR4NfihR3D11M74An8jmuykfAywzSd1LIu47JS2XGAmi2M80XWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ig2spnB5; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ig2spnB5"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-71e15717a2dso1266635a34.3
        for <linux-mmc@vger.kernel.org>; Fri, 31 Jan 2025 12:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738355091; x=1738959891; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Y1Uq2vC9ngxtabj+o6Gf/0MmnPKx34MFqyZVe1ZJHY=;
        b=ig2spnB5ORsHBPO9Y7nXycafF0XrCNtyHpbBQiJlFhRCJzhD+P63NHG7Yc3+rie4wo
         Mr917YqOD9SDmep54TVk1MQRWPTZklSbZHJI0otG2bBK7sL8CU+OGhyYSPEut98gL4Am
         /OamnTc89XUpnCD9s8nMCU1Yp2t50dPGzeYwrwj4B0whOWNhTdqOgAGsfB57FU3Q7ibZ
         +D2hbdgSPZW/fxOr2hN2CCrhN6U1bEW+MkJXEhvm7iZ0xdvgqfME5m+uCnNVxhEQEJMH
         Lx2W6FXmvSWHlwbKU0a4TJ/gjeqx78VIr5vzW4+lr6aucRQxdzZvzXh+n5sjyaEunDVz
         5L8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738355091; x=1738959891;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Y1Uq2vC9ngxtabj+o6Gf/0MmnPKx34MFqyZVe1ZJHY=;
        b=ngri5mmgRGEPYCOeH0iLL+GKKQvsmTIpiTJMm5wUkkh5pNpuGMe1tdAq4YVBVCbgvS
         Vq/0xRcx/T1zxV6tQe4LhmjUSd1MMXPbXd1Pi1H4kckJsi98Hw+BPN0Ujv9COpvQcBkd
         GkOiWqvXmnHaIE9BToY2NHjssc/m3gNITlla+vS8SsZXIFuja8kpinoy/9P+ZIdPAjpv
         TlK6nnguph60wOtQ0SjG/tIWZhPqoypisO0HvrbAdaXhQJDp3wTb2JSZx0c+7I0Nm43K
         wl6Li3gIZER6cWLVYWBlShYBXmGfBPHXFA5gUsNUoZNgpfYW7gyCe2v16ETbxsEPT+eG
         Ht+A==
X-Forwarded-Encrypted: i=1; AJvYcCVFnwpNE/7L3TslkZG5kcXEkAanUw6og8UAZmcyd24WkqGoW85GhN/LcmeFPMtgJf/HmwP9C9tQKb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF3MJa74/p/qBMthSE96T1r7H5bmf/n6YWWl9wFd3GqgeloMau
	LMTZD91RtHrKjAZv9Mkon73OHoI7V83z8ZNKxEVmoqNAMWYdm4jwrp7/dgTEiew=
X-Gm-Gg: ASbGncuMqZ/tK/lx6MaLrc3HxRAK6cG63t3H+E8ypSbNJ1f7NLs91qL4HiNlSBcg0FC
	RMOmiD0Otjf36j3aR83wpNmV2g9VsRrHYTg1xE4I+9e72zpeJSocDDvCE/Fubcp8qJcScja9yq6
	EpL3ObF8Pi5qTvzNNsLdH//UECr0p4SZI8PXFUuaNn+GUzwYPit7+OS3pakGQORLeY7RwicfRIw
	blCy4bHpnXvTIE3EBUS56UftqY0lm6FnMsLbVZtMj2Gh6hJgphxJDypWaACy6UROyJWHW3QGEs9
	SsmFzaI8jYR/W9qK/MN06jHuMXANQ//nywOJsKJpRxgFJm4=
X-Google-Smtp-Source: AGHT+IHpL9OiC+7p99DGjWrddY5GvJC4qVZT5ABdvIbOzG8MeWG3IwFdHaR/KYiBNOSR8xIQZbb8jw==
X-Received: by 2002:a05:6870:ff46:b0:29f:ecfc:32df with SMTP id 586e51a60fabf-2b32f02152dmr8447581fac.14.1738355091503;
        Fri, 31 Jan 2025 12:24:51 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b35623d2ffsm1403157fac.22.2025.01.31.12.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 12:24:50 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 31 Jan 2025 14:24:42 -0600
Subject: [PATCH 02/13] auxdisplay: seg-led-gpio: use
 gpiods_set_array_value_cansleep
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250131-gpio-set-array-helper-v1-2-991c8ccb4d6e@baylibre.com>
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
 drivers/auxdisplay/seg-led-gpio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/auxdisplay/seg-led-gpio.c b/drivers/auxdisplay/seg-led-gpio.c
index f10c25e6bf126cfaac3e4c353f8bfc6639d94a60..c158b2c2827415e75d0b122914b8b18c043e8c76 100644
--- a/drivers/auxdisplay/seg-led-gpio.c
+++ b/drivers/auxdisplay/seg-led-gpio.c
@@ -36,8 +36,7 @@ static void seg_led_update(struct work_struct *work)
 
 	bitmap_set_value8(values, map_to_seg7(&map->map.seg7, linedisp->buf[0]), 0);
 
-	gpiod_set_array_value_cansleep(priv->segment_gpios->ndescs, priv->segment_gpios->desc,
-				       priv->segment_gpios->info, values);
+	gpiods_set_array_value_cansleep(priv->segment_gpios, values);
 }
 
 static int seg_led_linedisp_get_map_type(struct linedisp *linedisp)

-- 
2.43.0

