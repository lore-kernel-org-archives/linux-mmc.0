Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D7A32C8B
	for <linux-mmc@vger.kernel.org>; Fri,  7 Feb 2025 09:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738921688; cv=none; b=gV2bydyVgMVr5VqTRgRoTf1ccltcQ7TjiiVXaG92I2ubyq/IrxeBxLOw2I5lnUC4fT0dHnAudv1WZlx+2eH3KLQVCeriBm6ZMfUAevHw8yvHMZ5iNdUMKh1J1QU/X7dcX+UPQYzd6U/sP2YFb/RUe8shryg01k+oWJExx19VoCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738921688; c=relaxed/simple;
	bh=ZJAYWDeAfSNuuTW5xNrl9dA60NGzl85UUJgwVt7HSzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bhDhJgdBGCEREBnjtK7NOBZDsO9O3LahwHFTuHcxjY3hlZ2iV81BCF3CVBdve3sZp4FYsenxX2Dire6lRavYd5NHhIqH8MWV3XWXX+IPuaTZXFZlvIgKVYRJlCBWqJVuvm9+itdh/aWQ2BGbr6l5kQzws11Ycar09oC0g5U01B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AuZiKwZC; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AuZiKwZC"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6f6ca3e8cdbso13688747b3.3
        for <linux-mmc@vger.kernel.org>; Fri, 07 Feb 2025 01:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738921684; x=1739526484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eEK7srIgXJXdQr67Fg7HQYgRLAiGEeTLhNAT3vGh0e4=;
        b=AuZiKwZC05Shr83w87ulFDaS4v5ZirpQW/K6PwRoCZ+MMWO4vRxGyxNa7iJ1cuVIzP
         bypVtP51vqSMlNnXNoeRBK8LWdpzleq+/e/SFMd/TuvWA0HEq/osed9rNKMju9mDqu7h
         25GTZPezUQQYPSWZ7cb6CCTU7DZLOEPBzuEtq8/EgTuiy/UgIjvlyoY8p6tkwMd0+Ewb
         PEJQsq9EXBCC9pXUoEfLukqaldIfNjyTkyy2OAYXbMhO//vf/sF+TWqI5GnZXkKX3WPQ
         3wk/Rn0LiwIBjOrCVe5Whk2ZU6syJ8GSnq3Z59vM2DtPPGYA/pyDqw2jJT5ayJpYq1qM
         Ew+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738921684; x=1739526484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eEK7srIgXJXdQr67Fg7HQYgRLAiGEeTLhNAT3vGh0e4=;
        b=g+bY9i+Dx9hKqurawddDYI8pKlIcitBv0v6ZPOB4RBDA98ibqE5TIJ/rQ2fAs/rxH6
         hLgXmSq/mRWXpeF4dB7D1l8JkHHjZuPJebOKL/rPy+a/BruWNdnPeKIjQuJYyalWSKHk
         1ShdgHPtVFeyeQOpEfJqg213ERd7MdwWuJA8RJ9gjBsFuvs+y4885CW+Pac0O/W9IqGQ
         jwyIK8oVQWdX26+lYqEe6hJOuWj7csZXW3U4+SkyfmlZqK8N33jKKxl7S736A8atxicN
         naorGK77RUU+4VF6oTbaopzBYoLWIukn998+2zn8+LO5FyirjpzwnLq5WQ/pViQAf9RO
         1nuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFVeFJLL5Cy8ZwalOyP1xNlJSJPUQXGvtn8CZJhfrrTiKS7sw5/3xOvVqCGAfly/5gAojWpQt2/jc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhWuOERd6OH+Rnn8qz6xYDKy9IPiR0o8NXQ71dNm78pzzZj7w0
	bWOuND5j6K8DZjPJFuJsV2wrLz/fceQ4m0wkBbutTBoXvZk8sMpeyuU5YklLPnadNmzT4ACay1L
	Tfe8KTi/8gqCJLoOONnoa9iTzlqnvjiYIuiha4w==
X-Gm-Gg: ASbGnctNEgz7TeIvVfujq4mXj0VNJus7CePv0DUzpSkDPJ63Z99Nr/DXVUxEn+DEPQs
	JByQ1NA5TXizFjKsBoh+0CbLdVxMtw4Ynj4/RPhl8RDjxzq6kyTFf1UUbMkgeexZiBKRETavqgg
	==
X-Google-Smtp-Source: AGHT+IGaJbQYks+y9NqxM+qNlDYUH78x9F5VX2tG1O9YPe70PH5B1lWBp0wyp4yxEx4N6batSHVUPkLgj4MGDriydyE=
X-Received: by 2002:a05:690c:6810:b0:6f9:3e3d:3f2e with SMTP id
 00721157ae682-6f9b2a07006mr20703297b3.33.1738921684631; Fri, 07 Feb 2025
 01:48:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206-gpio-set-array-helper-v2-0-1c5f048f79c3@baylibre.com> <CAMRc=Mf9WQjVXvea7tHx0MJG2H8Yqxw=zGqvjp7dfD7+=huDKw@mail.gmail.com>
In-Reply-To: <CAMRc=Mf9WQjVXvea7tHx0MJG2H8Yqxw=zGqvjp7dfD7+=huDKw@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 7 Feb 2025 10:47:28 +0100
X-Gm-Features: AWEUYZnfTmLhFuLgJjE2ppjqoqNxz5h92L1nmRlGKxGgOfCbaSg6_8WxaR2gtUA
Message-ID: <CAPDyKFoNuXpTEm1rLPvAgib+ugqr7XyETZhfrNr6ypOOKRwjXQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] gpiolib: add gpiod_multi_set_value_cansleep
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: David Lechner <dlechner@baylibre.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andy@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Peter Rosin <peda@axentia.se>, Andrew Lunn <andrew@lunn.ch>, 
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

On Fri, 7 Feb 2025 at 08:49, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> On Thu, Feb 6, 2025 at 11:48=E2=80=AFPM David Lechner <dlechner@baylibre.=
com> wrote:
> >
> > This series was inspired by some minor annoyance I have experienced a
> > few times in recent reviews.
> >
> > Calling gpiod_set_array_value_cansleep() can be quite verbose due to
> > having so many parameters. In most cases, we already have a struct
> > gpio_descs that contains the first 3 parameters so we end up with 3 (or
> > often even 6) pointer indirections at each call site. Also, people have
> > a tendency to want to hard-code the first argument instead of using
> > struct gpio_descs.ndescs, often without checking that ndescs >=3D the
> > hard-coded value.
> >
> > So I'm proposing that we add a gpiod_multi_set_value_cansleep()
> > function that is a wrapper around gpiod_set_array_value_cansleep()
> > that has struct gpio_descs as the first parameter to make it a bit
> > easier to read the code and avoid the hard-coding temptation.
> >
> > I've just done gpiod_multi_set_value_cansleep() for now since there
> > were over 10 callers of this one. There aren't as many callers of
> > the get and atomic variants, but we can add those too if this seems
> > like a useful thing to do.
> >
> > Maintainers, if you prefer to have this go through the gpio tree, pleas=
e
> > give your Acked-by:, otherwise I will resend what is left after the nex=
t
> > kernel release.
> >
> > ---
> > Changes in v2:
> > - Renamed new function from gpiods_multi_set_value_cansleep() to
> >   gpiod_multi_set_value_cansleep()
> > - Fixed typo in name of replaced function in all commit messages.
> > - Picked up trailers.
> > - Link to v1: https://lore.kernel.org/r/20250131-gpio-set-array-helper-=
v1-0-991c8ccb4d6e@baylibre.com
> >
> > ---
> > David Lechner (13):
> >       gpiolib: add gpiod_multi_set_value_cansleep()
> >       auxdisplay: seg-led-gpio: use gpiod_multi_set_value_cansleep
> >       bus: ts-nbus: validate ts,data-gpios array size
> >       bus: ts-nbus: use gpiod_multi_set_value_cansleep
> >       gpio: max3191x: use gpiod_multi_set_value_cansleep
> >       iio: adc: ad7606: use gpiod_multi_set_value_cansleep
> >       iio: amplifiers: hmc425a: use gpiod_multi_set_value_cansleep
> >       iio: resolver: ad2s1210: use gpiod_multi_set_value_cansleep
> >       mmc: pwrseq_simple: use gpiod_multi_set_value_cansleep
> >       mux: gpio: use gpiod_multi_set_value_cansleep
> >       net: mdio: mux-gpio: use gpiod_multi_set_value_cansleep
> >       phy: mapphone-mdm6600: use gpiod_multi_set_value_cansleep
> >       ASoC: adau1701: use gpiod_multi_set_value_cansleep
> >
> >  drivers/auxdisplay/seg-led-gpio.c           |  3 +--
> >  drivers/bus/ts-nbus.c                       | 10 ++++++----
> >  drivers/gpio/gpio-max3191x.c                | 18 +++++++-----------
> >  drivers/iio/adc/ad7606.c                    |  3 +--
> >  drivers/iio/adc/ad7606_spi.c                |  3 +--
> >  drivers/iio/amplifiers/hmc425a.c            |  3 +--
> >  drivers/iio/resolver/ad2s1210.c             |  8 ++------
> >  drivers/mmc/core/pwrseq_simple.c            |  3 +--
> >  drivers/mux/gpio.c                          |  4 +---
> >  drivers/net/mdio/mdio-mux-gpio.c            |  3 +--
> >  drivers/phy/motorola/phy-mapphone-mdm6600.c |  4 +---
> >  include/linux/gpio/consumer.h               |  7 +++++++
> >  sound/soc/codecs/adau1701.c                 |  4 +---
> >  13 files changed, 31 insertions(+), 42 deletions(-)
> > ---
> > base-commit: df4b2bbff898227db0c14264ac7edd634e79f755
> > change-id: 20250131-gpio-set-array-helper-bd4a328370d3
> >
> > Best regards,
> > --
> > David Lechner <dlechner@baylibre.com>
> >
>
> I can provide an immutable branch for the entire series for everyone
> to pull or I can apply patch one, provide an immutable branch and
> every subsystem can take their respective patches. What do you prefer?

The changes look small and trivial to me. I wouldn't mind if you take
them all (at least for mmc). An immutable branch would be good, if it
turns out that we need to pull them.

Kind regards
Uffe
