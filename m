Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E3A260A3A
	for <linux-mmc@vger.kernel.org>; Mon, 10 Feb 2025 22:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739227083; cv=none; b=aygxOsBKN2lLuEICyeIrA2OtHl1uuVOVEtnc1MZGu6lf8KmhbQbHMLYNFIf1enC8agc0A1cCKxFC7HGo1yA2QZRzJmok4bvCAa23B8hzBWpY1FcH/b8JUX36PSKGckZ9hsMgVlChTMkbtI5zVg3zWb5BkVl/gh2By11oDPIBimY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739227083; c=relaxed/simple;
	bh=0Dd/TwIMPTa1NXxF+RDclsVv0WgpIYcbyrIZrxifJTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lLXkh1YPZEk+r+m2JA77kaTgP2LjcTFc7mMNPQYDmCRHm/jBESE8XR0qYCf+jebvSbJ+zmNQKGmaxf9E8B2rVU3FoCfw5CUP2xIQkKACHjlD7aMuOsLaOc/8QmrIeJSg/8eN41BqL0zy62y8RDqISsh7EtT1hXfJQJeRqKN2LwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=M3WvfM8y; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="M3WvfM8y"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3f3bac262f9so587026b6e.1
        for <linux-mmc@vger.kernel.org>; Mon, 10 Feb 2025 14:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739227081; x=1739831881; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7aQTsUJHgsqLkUdzEeUSjaVO0EDwfbxDIRSr93MsbW4=;
        b=M3WvfM8ymctecf7QYdHpg7RaqGEsSScrBBIP+Sm8JoWZiIhr1YQWZYm4I49UrOti0X
         4XZ/AUUmkJVqIyITioaWP9A2CIByRnd15BMVkg+7lgnMkbw9e1PIV9+2Kt3Iu/s/YCiV
         dNixT0lIbp9WZ5zStWkZdKDOerMk4C+L9IdKdMBpUWGi0zEJMhewdOnwbmz6kNLOLWvk
         8RTyGRZ8WMcsHMAyw99dkawyekVFF3t9u34sR/jrDW0m9l6Jw+N44mdF4HncsBbkQ75c
         jwxpbxNm8EbtpTyE3mfHY9oauY6l3DGauHoaF8WcpP0vnq5E/AxtLGqmSMospizOgeNA
         qAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739227081; x=1739831881;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7aQTsUJHgsqLkUdzEeUSjaVO0EDwfbxDIRSr93MsbW4=;
        b=b8Cm1NadQpO0XvrW0JwrfUhTSiNWu1Lc+4/q4MGwdKD5/MryiZw5PoflB1ZhTZ9jHK
         9nf39Ad47ij1IhHD4IbAnWDnzBGUSKdX7N0RAAniaqZFRPPqh4RLA1Qq9m/7JjRZDDSE
         5B7o3ehW+I30YDLHkrcU228W0ZFNwOr/UxEcI6izmDVfCnRGNYiKmecL9hT/qGKUlEZw
         lvleni0ACWKefAI6+WcDwy98W00pSeb6dR/6ewT8raZbM34O6Z5hU2iFsXjhagZXIi2K
         62Ji8Pnmk0XZwSxM6xLj+gOWfDgEpQlN9YMxu7wLjBIeh1vcRQAIzw8xlfRDz5F1kQCk
         o8Zw==
X-Forwarded-Encrypted: i=1; AJvYcCWCVETgxnILmGekxHV5+7cw1jpIbLzU4Epo2Dw3RxlqVeTLXq2dTSeLfR+6T0Mu9pWvGCoL7uX+MSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzeDBkJLxr7ESqTReB8wSZTSLaGUheifM6fPITEDgFTkNSsDi6
	j2Cg9594N7u0PL3sLcOzBeSNZkBkddvpmEDu0fDD7LRmI6ZDBMxBz66me/9ri+g=
X-Gm-Gg: ASbGnctOZXMcEP5+3il/d4XgEJ78f3IN7Uhob05cC+BeDVXJnsHSnT1+lSYe7DHs4Ck
	bi/8JMweL+cyJrK0Fc3Kf7bUbRC93DqovMuRIRjwPu8iISQeU3wodihdso8N837wXyXrrczYdkI
	E535WyhPmUXuki0QQ27KfLXN4qV4HJfbaPelsJIFrexptTQ7j6SZU0EjN2PD6KMCyTjgPCawtku
	eULSEhhZ96Jem+2dfheZJzT4JXJ4aVi6L8lncJ0uq3Yn+cEQW6o1whF6N4Kzv2W1quvYF3zBOUR
	k8oVRlNla70DFr6F/X4rXUqkhI/CdM3tlpAAiWEw3CwIgv0=
X-Google-Smtp-Source: AGHT+IGzPPZHWL9nm38yMUud0RRSbV/Ra+QmKEWIgQuJSF5KnPaRf3ayet85Wv9392Tvxy5qCKs2yQ==
X-Received: by 2002:a05:6808:3c8a:b0:3eb:4681:a895 with SMTP id 5614622812f47-3f3921f0b9cmr10552910b6e.7.1739227080875;
        Mon, 10 Feb 2025 14:38:00 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f389ed1ca2sm2521820b6e.11.2025.02.10.14.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 14:37:59 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 10 Feb 2025 16:33:36 -0600
Subject: [PATCH v3 10/15] iio: resolver: ad2s1210: use bitmap_write
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-gpio-set-array-helper-v3-10-d6a673674da8@baylibre.com>
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

Replace bitmap array access with bitmap_write.

Accessing the bitmap array directly is not recommended and now there is
a helper function that can be used.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/resolver/ad2s1210.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/resolver/ad2s1210.c b/drivers/iio/resolver/ad2s1210.c
index 7f18df790157f1e411fb70de193a49f0677c999f..04879e6d538bce664469c5f6759d8b1cedea16e9 100644
--- a/drivers/iio/resolver/ad2s1210.c
+++ b/drivers/iio/resolver/ad2s1210.c
@@ -46,6 +46,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/bitmap.h>
 #include <linux/bits.h>
 #include <linux/cleanup.h>
 #include <linux/clk.h>
@@ -180,7 +181,7 @@ static int ad2s1210_set_mode(struct ad2s1210_state *st, enum ad2s1210_mode mode)
 	if (!gpios)
 		return mode == st->fixed_mode ? 0 : -EOPNOTSUPP;
 
-	bitmap[0] = mode;
+	bitmap_write(bitmap, mode, 0, 2);
 
 	return gpiod_multi_set_value_cansleep(gpios, bitmap);
 }
@@ -1470,7 +1471,7 @@ static int ad2s1210_setup_gpios(struct ad2s1210_state *st)
 			return dev_err_probe(dev, -EINVAL,
 				      "requires exactly 2 resolution-gpios\n");
 
-		bitmap[0] = st->resolution;
+		bitmap_write(bitmap, st->resolution, 0, 2);
 
 		ret = gpiod_multi_set_value_cansleep(resolution_gpios, bitmap);
 		if (ret < 0)

-- 
2.43.0

