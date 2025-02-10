Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348B12586DC
	for <linux-mmc@vger.kernel.org>; Mon, 10 Feb 2025 22:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739227062; cv=none; b=HN1Ki54V9MUeMZYPk7PkaMTsAWVNlByuH879LxJd5apev+9n79XIP/4fLnk1drcLV/BlzNfO0LUhrXB4TbdrL+sVkmCQS+JLmldTXj99tjY3fqrvlf9i5KmXMh/9ABvkt2FVmOIgjAbP4T7OMgGHDmNWkHHopyvjZ1CcQ4TDG98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739227062; c=relaxed/simple;
	bh=SFpLyUrSkeov8lTDekLTl8UML1Z5oaveGJ3pRpViCz0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LWkXVN8jXA5OTmQNWwKqzXs+OlkDlAAa/nCMgZmf8yqPtGMWOsmmpLofUzLffGFUBaNDs4SL8SShDIIzgw0GhBzRpTdBOj2AaKeDGL6DBcg6JzXAbTwDHMHPbyytOwHN0cRNOzJAZMk5Oc/8Q0pE68HzwC80Kl0JjR/I3ddNx0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DLi0qjsC; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DLi0qjsC"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3f3c0abde9eso222235b6e.1
        for <linux-mmc@vger.kernel.org>; Mon, 10 Feb 2025 14:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739227059; x=1739831859; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dI+YClki4Q+OM8j5JXLpkAENpDyF7Cb60VCru1h+I9Y=;
        b=DLi0qjsCM9M4kRFPV0vlUdPq+P6jLzFdtm9bQWFR9JOodzbMazE/Al5tiMqScDd179
         pvG21zG8gsruYL+RhrsqoWBz2CLpUZri9iLyCTr7EfFSboiHU5ObQHmjPiv94bzGs53E
         nt1g1NTy78XMuXkKBbOf0kPO6fFpjjMdwAZ7VMQ3F7ugQGcgLb8RmgfYlP8lmvPZwaQk
         zw0ooUfpLst7YQwUGpU+N6/O9XahJdKy++vUMqsQD6CXFZq+HM9RC+6LGqNFjkH2gYTI
         ze3Re6J/b8pCBOJhbniQUGBkF0OSBApxd08j/OUhCH0VnLe0eDNsXPNekRiOmn9KWXTc
         zhVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739227059; x=1739831859;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dI+YClki4Q+OM8j5JXLpkAENpDyF7Cb60VCru1h+I9Y=;
        b=tsut9F14AjrI6YwbXEjfGsOOcDRLZjDUwLivdBFvgQcbpTp+7M7m7Pt9GOF1a3INjg
         yd7NtMx4vC5R22bVmedqd38OPqLPP46p9wet6Kpo3fiDsFxCuJaLGC46Z5UAw1iUHPAf
         6QK9stMloOZqd/tZBJxoDP3nT4+sjOkXY81HmwQw4AHRFLRiSvBFmGnbXHG3tVdb5knV
         Fq0Xe3kbxZyNvcAX8F3Gt8te4H9xGj31z5YxVuIqjXc7wBdzYBPBlkvSFAMHLapc6q3u
         xUTeF33GNGG3Wla8wWurYyJLAajYg5QlwVb7tW4nE/RqPZN8pze9uU7JbUpIwRyLLvE1
         ZR4g==
X-Forwarded-Encrypted: i=1; AJvYcCXBdGOqwvjGpipMWnebsrzEtOd3BLyz2T295mRxqvTwaNnysuBlz+OIHyY9YgVizTJdyl6tNnFWd0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAArkhn+G2vVR09X7f/Lckj7fwWWDoHVgzdoo4Q4Eh/jZ8f0nh
	LRgpiB+lLUoj7JA/XBkO75Kokz4NTKN81wzo+3mUQDALvFz/Xbz7M6NMz9cJHAE=
X-Gm-Gg: ASbGncsq239Xo+WRaTqfhYLdn6reVDcqUW3Fg6ACS3Y7PQD7q6ZT81/U3QGRkePQrLb
	S3lsuArS4iAWkO/3EMx92/PdYwWvRehlva25bjsvopU/3ki4FriinL6BkohtUrt65AdmmT5zkZe
	Me8MP0E+DKcjhLIRmsW7HWns9oLFIeuk0mse33VIuTB3Tmr7y6jafnQVwI8ZDOKI6K1fEUEhSu4
	8ZrnoVXToEszJvm4uHSGFWC6CXTKMIpxA0mSo0ZvdpOKaesW4SQDWZmq/e8C8z5ArYZiOPmU8b4
	wq1OsIcN0On22U0ggzeXmzXQ/Bqlqr12Wbw+zblvQUrZO4Y=
X-Google-Smtp-Source: AGHT+IFW6c/bCwKZFJx1mUCSPW7GBmt4Y2h9+oGTyfDUlc4EaqeUGtPptBQHkkXiE7A01fG2q4Y7jw==
X-Received: by 2002:a05:6808:3095:b0:3f3:c370:4d65 with SMTP id 5614622812f47-3f3c3704f3cmr548358b6e.20.1739227059360;
        Mon, 10 Feb 2025 14:37:39 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f389ed1ca2sm2521820b6e.11.2025.02.10.14.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 14:37:37 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 10 Feb 2025 16:33:29 -0600
Subject: [PATCH v3 03/15] bus: ts-nbus: validate ts,data-gpios array size
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-gpio-set-array-helper-v3-3-d6a673674da8@baylibre.com>
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

Add validation of ts,data-gpios array size during probe. The driver
later hard-codes 8 as the size of the array when using it, so we should
be validating that the array is actually that big to prevent possible
out of bounds accesses.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/bus/ts-nbus.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bus/ts-nbus.c b/drivers/bus/ts-nbus.c
index 2328c48b9b1260e805c631f2aa7379d620084537..d3ee102a13893c83c50e41f7298821f4d7ae3487 100644
--- a/drivers/bus/ts-nbus.c
+++ b/drivers/bus/ts-nbus.c
@@ -48,6 +48,10 @@ static int ts_nbus_init_pdata(struct platform_device *pdev,
 		return dev_err_probe(&pdev->dev, PTR_ERR(ts_nbus->data),
 				     "failed to retrieve ts,data-gpio from dts\n");
 
+	if (ts_nbus->data->ndescs != 8)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "invalid number of ts,data-gpios\n");
+
 	ts_nbus->csn = devm_gpiod_get(&pdev->dev, "ts,csn", GPIOD_OUT_HIGH);
 	if (IS_ERR(ts_nbus->csn))
 		return dev_err_probe(&pdev->dev, PTR_ERR(ts_nbus->csn),

-- 
2.43.0

