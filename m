Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAE222F388
	for <linux-mmc@vger.kernel.org>; Fri, 14 Feb 2025 09:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739524968; cv=none; b=s7o8ZjJMIY9g9syQ0NTSRN/3ADpt/+aAPzDnuWbEsE171bBx8Dp4+LD15u4KQJWJZs8afpreFU4gi+fgPrE6H38oerxhQnWShO1sB7IMqzs2kVcCXp7ef48XobO8l+zrlBfdpbpnRqreZMWiZ/V/HlBTd2924V8ByjDTPsgLJ1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739524968; c=relaxed/simple;
	bh=oxMUts7eWUQNpSiCjwqXyusGkP80n8S1cBGWOAZkDbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T/DlQLmaZD2R5+XOE5oKRBtFS9J8WkOkvczNdvkGcddifHi9/Eg91DldKBNsiYn20hijieYerOzixuR2A+jwMHEUs1Sw7+Z437+lcXa017H+qXMABGpAMzZdFVYhpGgMWwHE84HAk8byMtqF//uxdE/S7zNbDeE8/Th2OoYywTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sxLoVUKX; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sxLoVUKX"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5450f2959f7so1810442e87.2
        for <linux-mmc@vger.kernel.org>; Fri, 14 Feb 2025 01:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739524964; x=1740129764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oxMUts7eWUQNpSiCjwqXyusGkP80n8S1cBGWOAZkDbI=;
        b=sxLoVUKXY3c9adxLBukNyoU8KOeprTw/VgAZfAUNhRUEovcbN6eRmMWti80c++buGs
         8rJEgUTWjQ0qY7N+qW2ddYzlThcXQ17FCv58hHDtgtjiP7iM/ASj1Y8L8KnHr2x0Sk++
         yx/EvvweXcgD+SP+daaEUIXAvGoymPrcgszaF+qcoaqEspVLtNsrDIEVUe+8f22mqM7Y
         HzP8AInZXEcunT+OX9UTtn40R1jgmlz+RhyXvyT14nGpttrw5ILZ/DieEXYHmbL1ra96
         R0IpGhJMsKgik8AES1m31K8ylU5CNce9Z+Atmc2pZbsfZwDAC9s5xDU2IKtcIJwQGdTX
         iz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739524964; x=1740129764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oxMUts7eWUQNpSiCjwqXyusGkP80n8S1cBGWOAZkDbI=;
        b=cc/jGDerBHoKBp7BzkI4Jk8AAlPS0O0ODiPbPFVQEsAh8cjPAcBIBCH14EuBSyjsew
         DdV6DLR52uLC5RhknsyrvRDiSgMJPnMaPuOkzSEPFksr0fz94U369zjTZtsR/IEICFiR
         jMLttEcQddFHjSdSQYd2hBkAGUlVRFcJQa3FVfko/y8cB/kXvTp+5V+lNbzb94lUbMBS
         YhmQJSwB0Pjls4IqmW4S62hyM7tgIZyhd8uMJpDfprOYylcVSlUyPgjLZ7C4od5asY0D
         AhuU6A+e7C1fjff7k53epimY6FipqpNxTwl5Df12qVujtL2DNzeQ2TfRmGl0dtIL36TL
         TKSw==
X-Forwarded-Encrypted: i=1; AJvYcCU504yiJP9RqlLnicnO1PqlVBkVDd+RBIYQbnjp4o3tbXt7A75QFSR68EVU8h+TPQFujf5vilsmgts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf6mIUHlJz9ZVZWdU2QOofTBmqY+GBaE/9sGm3XDRoyCiDKw+X
	5a6M9lpuWUbYd2HR4E0Sm5X0hQD9Wjd9fcjwtCTCRRmrlh70L2/qBJshCHOAE8Vi0o2V4yxu2tZ
	sw9OTGUh7ZLA9rVXX6k/qmTLxOyoJZE39eSmTtA==
X-Gm-Gg: ASbGncvXJquE+XVmybZBaZO9LKVEarCtQECa/LhB8wJXcDriSBK2+NOGmYncNHM7tyR
	t2xh73efz7VC0JL4XLsMJxipP2w6/4pJ6XtzWQ4SMVko3FRRCDewSKBZzOIcqL7Xw/J3EUvTT
X-Google-Smtp-Source: AGHT+IGhgPoczR2D2T/lX4ZwT5MXW34OlqN0/zugo7LmPWwgdRCMXTLpmWVB2HL50zhjB2U06JaZCumERKR34vwpUjQ=
X-Received: by 2002:a05:6512:a90:b0:545:d72:95e5 with SMTP id
 2adb3069b0e04-5451dd8c4aemr2339063e87.7.1739524963708; Fri, 14 Feb 2025
 01:22:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210-gpio-set-array-helper-v3-0-d6a673674da8@baylibre.com> <20250210-gpio-set-array-helper-v3-1-d6a673674da8@baylibre.com>
In-Reply-To: <20250210-gpio-set-array-helper-v3-1-d6a673674da8@baylibre.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Feb 2025 10:22:32 +0100
X-Gm-Features: AWEUYZlSujurAxnS1uFvnjJLAGMoYJmFWbRh7MCeJl2DAGBRy4U6U-3ZBycEwbU
Message-ID: <CACRpkdY2PtRhmTKJUFmkTViQOLfMBbqR1bD94SzasoGAoHUQcQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/15] gpiolib: add gpiod_multi_set_value_cansleep()
To: David Lechner <dlechner@baylibre.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Peter Rosin <peda@axentia.se>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-mmc@vger.kernel.org, netdev@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 11:37=E2=80=AFPM David Lechner <dlechner@baylibre.c=
om> wrote:

> Add a new gpiod_multi_set_value_cansleep() helper function with fewer
> parameters than gpiod_set_array_value_cansleep().
>
> Calling gpiod_set_array_value_cansleep() can get quite verbose. In many
> cases, the first arguments all come from the same struct gpio_descs, so
> having a separate function where we can just pass that cuts down on the
> boilerplate.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
