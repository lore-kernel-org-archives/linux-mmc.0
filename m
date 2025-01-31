Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E95B1F666E
	for <linux-mmc@vger.kernel.org>; Fri, 31 Jan 2025 20:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738355107; cv=none; b=rtykUP51KFJP71eggRwya568NyKIft4HHGd6fxA+KVOqz7OrBLHk/EwM5jMDSz6rvcZKAxidHC42AwX/Fpc6US5wwmWkqV0PznBReXpNQGsLFaFLLEt/qG2eIxLf+Z6Wsz+ZnNgxpjGxWEVvty7ClLRuGvlhbVdv21Fm73vfkV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738355107; c=relaxed/simple;
	bh=a4UCT4/NNPETnikiY/3/IXvAqgQyANJWQskJKLdiZxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W4SqokMLoVrfHZwItZeZm9CyScIH2Rxr5FsJvyGHgY8D6K5TwNTwJCkn6GGl3pdwDv7KYThIdip+uvf040lgCvzcsDuLDufPZGeljcuY5FZ3iYnrnaMo0RXLysjWGGQe4QxGSGaWv2yCtvcC78cthft+Bb987nKe1t138rHdYSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=i3p50MoR; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="i3p50MoR"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2a3d8857a2bso1235840fac.1
        for <linux-mmc@vger.kernel.org>; Fri, 31 Jan 2025 12:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738355104; x=1738959904; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WNU4SR73NkzT5flFO6XZzV58Nb+8n8xP048rFGpOLNA=;
        b=i3p50MoRqTck66HqRmjce02FFEVCLPd1WryuRoM8Vuk+27DcmPvbT5L1dLrth8Rspe
         SEJB+O8mrL3HlRbKg5VFYWuQCDhd9iOd4J+Lt4BFQJljF4pHcQrCLAKdvLDtw0FlJGV1
         7dEVAyPkdLMXt20S1aFiNAknpOWcDXQLBiMeQMF6UQLyyjAzwVOLhiheBRWtvlGJLrkT
         YS2GUkU7S1H9uADGOi9+20YUVkUG5taerhoyFL8T8fFl/7yBhswxXr+dFp1bwdy7n38P
         1IXFmSQrGkvfN+yZ77Yu/R9POZDUUjLQtzpE/7EtjT2Db+Ut9M+aCRHdVkFBw5e8e1N8
         FszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738355104; x=1738959904;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNU4SR73NkzT5flFO6XZzV58Nb+8n8xP048rFGpOLNA=;
        b=HjsBGCkHpRvjffh7mkircxjUhj8bBQDfKKbW+6ATJsxisKzgFnkwh+Fh4H/lRtjgvP
         YemBi5XIUHObMn35kbgkysJNFzSYRBglW+5WF///f4e+u9YIoh2vpLfUMAkrGsHscwuH
         78h5iB/mRjmiFnniBSZnWGjRPFL1rGnGV5F7ewDpJ3+58OO5yxm+iWRlV9GWLGvOpQmd
         a4JF6HZk2thCX0BsX3UcJfthJuurzogNOfnQM92aUTZbMGrpTzy9rQrxcDpfA6wlU3/b
         8zWZBPYUWtCJAt+b6/se1Gq92oxE28X6QXiI2sU5eAkaRqFTAnxMJYCZSlmSCtX2tUOG
         mzEg==
X-Forwarded-Encrypted: i=1; AJvYcCWU13g4i+NahMfZ1MumoysxVvrMDaUB+fHxgmWZPoD71qJBauHZgtLx4sWsbqdE71pTc4pBc/HM0+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZjxB7bRmXCO9u3MRMqJYGFj2nsheQ+V/wVcYT1cQ8y37Zza1d
	9H3FFMGhwzDGa9KjJhpY44BlbxkyJrBL5OhHlQkVdkPv0A9uPyQrnXxQGM2a4NQ=
X-Gm-Gg: ASbGncs2mfPvGzLVh34HwHORecG3LGHQ9Gq6TvElYrHcMHjobgxqQpnQRY/sFEoRWcu
	zJWR7BThdQuLV0oKoooQG41WMsfSwoxVgEEpcO6TRHt8RrjBW07VDjPL8VHJRXZfONfCXR2PLG5
	StJCNHguCbrW/GcGa687kirOeScyeo7MTyTnsklWyXMII7zjjZuZaKuP3vLiNtNS8W62ir6L9H7
	v2BFZ1lGdBIe1CJfGwIPYAbSase7poxOYh5eBgEq0AHsEcxzQBdq1+djdOe0P6+UPp+7XgeJLuS
	gewNojK38zKsJW5GAm8ze4yyAGHjbv1+Yo8RVUMjwqd/rP8=
X-Google-Smtp-Source: AGHT+IEjjM8UkUItH0qBBqM7/8yjcARln6tFWMQk1I1vtwY7yg+bjxT3tjK0CN1AwA297vbCg45WVA==
X-Received: by 2002:a05:6871:7891:b0:29e:48d6:2e62 with SMTP id 586e51a60fabf-2b32f06986amr8146491fac.9.1738355104164;
        Fri, 31 Jan 2025 12:25:04 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b35623d2ffsm1403157fac.22.2025.01.31.12.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 12:25:02 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 31 Jan 2025 14:24:47 -0600
Subject: [PATCH 07/13] iio: amplifiers: hmc425a: use
 gpiods_set_array_value_cansleep
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250131-gpio-set-array-helper-v1-7-991c8ccb4d6e@baylibre.com>
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

Passing NULL as the 3rd argument to gpiod_set_array_value_cansleep()
only needs to be done if the array was constructed manually, which is
not the case here. This change effectively replaces that argument with
st->gpios->array_info. The possible side effect of this change is that
it could make setting the GPIOs more efficient.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/amplifiers/hmc425a.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/amplifiers/hmc425a.c b/drivers/iio/amplifiers/hmc425a.c
index 2ee4c0d70281e24c1c818249b86d89ebe06d4876..e8c67c8145b1b9ccb9b70ccd3ce4f5de08f96e69 100644
--- a/drivers/iio/amplifiers/hmc425a.c
+++ b/drivers/iio/amplifiers/hmc425a.c
@@ -161,8 +161,7 @@ static int hmc425a_write(struct iio_dev *indio_dev, u32 value)
 
 	values[0] = value;
 
-	gpiod_set_array_value_cansleep(st->gpios->ndescs, st->gpios->desc,
-				       NULL, values);
+	gpiods_set_array_value_cansleep(st->gpios, values);
 	return 0;
 }
 

-- 
2.43.0

