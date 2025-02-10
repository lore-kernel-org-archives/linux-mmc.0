Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0EB261372
	for <linux-mmc@vger.kernel.org>; Mon, 10 Feb 2025 22:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739227086; cv=none; b=SSwZRxTT1FOhU1NVOaLe4HpnD2ZcGJrilHL9aA7IQDhgGPiezChfA0Zj8Hegw/kHe4XMAIAN+CNX8D/JbM8uGTZs+aRrxCsvzixZ7G8MwRsrQ4vcP93pfB6x8d3yZnEjdVC6UNG3laPm67R7HKS5Far9o04DjySmlfbXJ/50jO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739227086; c=relaxed/simple;
	bh=HaFWSgBdfXggpkPiEPQivtzXY7Xojib1tG2MzfPUdgM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uOKbPH5VymE+TqCmCa7xTrAjq/e4bMSBfaa31DuvTcG9eEzHYR/v7afe8bpbSdW4Z78af4eHrR9sUqCfpdDWRfF4XHjQmaE37yxqC3YK7QzQhHp/Ed5VcCvo16zKGKC8DX4x4hbcFnb4ZhDcVdCbduph8FbC409ZyuDjMdBqs8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dvT7bBar; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dvT7bBar"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3f3b927b88aso373321b6e.3
        for <linux-mmc@vger.kernel.org>; Mon, 10 Feb 2025 14:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739227084; x=1739831884; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hnz0az7lntDGiOpb5KMBiHYUt+/ZN1SFQQir1JT9FNk=;
        b=dvT7bBarIKuEWBzaSXQSY+SnArGsqGr/slLKnVFFZomy3o8Y7mA0cJYOeuqEF8ebQ5
         EYjWEFTAsMlN8wUjpBXVRZJ4c+9sfmhTPhJARW0U9roz14XLV8uumAVN7Y4jQfNDt+Mx
         4VsoXxl3N2f/veqPjFziqBFyN2fRoP9igA0vAQGZa9VpTK7akEoPfDtAOkq7aw1zoabj
         3DXbgv9RD9VrFaEutLLzROGEcDyjB/5zKDPh/FwpDAlDAs8vmg4uISd+0qNZd0Z8E062
         M5zOhNCFsU5ajmPnD42Xq9RfJsENLoSkUPInqDccieECrnEeZIN9EzBY+oXsOedDWPq+
         qZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739227084; x=1739831884;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hnz0az7lntDGiOpb5KMBiHYUt+/ZN1SFQQir1JT9FNk=;
        b=LyJXfn0Y2p5rzkR0CXqanFjJzuNzqy1eNK7BWbJ/U+GP/2IZ9YkUDMkLT7MBmpr2VD
         hD9R/CJAFOyoKOSUXw4VEYjfaeoqscffROiLiwvqaCofd7fCBARGXq6seYBqitydYpQ4
         YaLm2zWZrIfO2Tq5oK+/8Q2geNiUzMF9rcxIo708GpDSTOY+n4yuDNz2ZUTDlt6m7XqZ
         QjurIeQJvOO/j4pvz9Q3UOMwnTcwvulCxycvbg5bQK0VdxKg8mf+/f9+0tH1RQwSLknr
         iI1jOJ7iIvx8rTvCF3/E7eaauxeVnFiutxhKubOj0XPCjz+q2hpmpSRyl8p7P/+qWTVz
         UrEA==
X-Forwarded-Encrypted: i=1; AJvYcCWUHBT5dS/ISLeiyqoeSfDYr2xBW/EHnZkm18vncREYddUNNN1uFKsRPOiDj6/sbVz/6zzXgj5L7Hk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSiG6aLCd3UQse3ltDKGmiQuOQUacifxewgRBhouZ40/r3l6Qj
	oNhtmMW9GGw74BuCL89/QeZch5voKmAmh1764Izdk08EpZHpHdirfiwD8UunzAM=
X-Gm-Gg: ASbGncufAdYi/S0kFvk3diRyofjxqAIRnO5LY6myKKwUqgD1KqQV0vDdn+0e9BVpJm3
	2UGBAfTOHJvZLEZYxnNvUVB4YxYmcnsvC9uzGBq/Kzui4nuqSmkL1a8arWp6w0ECVc0IqTcXtGg
	8SW18S+/k2oEbEcdvCPhZrl5P4+2EEf+OzRyl21BejMl0o6DEJclewI8o+tskta5O/KOkP9BFAa
	5bzblCHGH6HhH0dtQJabyNeupV9zME2slPUV2HBI4Avhb65Sy95g0D8CiDkv4IMiRuwo9jUvcXV
	HpxY6KFKA+LWuHuiyQwXd2jKyUv+H8zvLhd2Y4CFFtCrjQo=
X-Google-Smtp-Source: AGHT+IHyCAwDYiRcWVzrn7K/Vx60yNjdpFZhmlXwDMeVTAgENeKIRtjDdhXHEsiUOrCJ2abC/Ga6Zw==
X-Received: by 2002:a05:6808:2209:b0:3f3:ba53:1e11 with SMTP id 5614622812f47-3f3ba53229amr2521701b6e.6.1739227084078;
        Mon, 10 Feb 2025 14:38:04 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f389ed1ca2sm2521820b6e.11.2025.02.10.14.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 14:38:02 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 10 Feb 2025 16:33:37 -0600
Subject: [PATCH v3 11/15] mmc: pwrseq_simple: use
 gpiod_multi_set_value_cansleep
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-gpio-set-array-helper-v3-11-d6a673674da8@baylibre.com>
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

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/mmc/core/pwrseq_simple.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
index 37cd858df0f4d7123683e1fe23a4c3fcd7817d13..4b47e6c3b04b99dc328a8b063665a76340a8e0d0 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -54,8 +54,7 @@ static void mmc_pwrseq_simple_set_gpios_value(struct mmc_pwrseq_simple *pwrseq,
 		else
 			bitmap_zero(values, nvalues);
 
-		gpiod_set_array_value_cansleep(nvalues, reset_gpios->desc,
-					       reset_gpios->info, values);
+		gpiod_multi_set_value_cansleep(reset_gpios, values);
 
 		bitmap_free(values);
 	}

-- 
2.43.0

