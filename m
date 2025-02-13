Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C90B241689
	for <linux-mmc@vger.kernel.org>; Thu, 13 Feb 2025 17:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469502; cv=none; b=JgV8lE6WYt9RSRdbQGQ3kqro7fq0q1j3zOKEvwlR/8ZuSNnMNIHnR2j1xEavmrOgHy0QP6MTWz8H+dpGgJrEmOGbTeDJwEEp1r8SeY5zGoA+2vlmhIJbmqT6HYs8caENf/xN5GoYpohqETimj5MXe0TzB+fKF67wuRgI3UZNmxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469502; c=relaxed/simple;
	bh=T4wEjSRsVSrhRrn2h8DgpJJyTxIWuEpOmyBwmIva9Tw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jqq6K+TtzYDDVPbL01f8SYkBqh9pYRu8WIrlYLbJ8oeFxq/KFv9s/QajKIGuiXFT3nzHcS/XbQmwXwTyKzT3ed5gj8ljIynQscIfb5m/BpiiPMjbFZ501F4aVgxj9kxYQ/zDVH65pgjnQTFCRYQWyHThiGxA6T8u3AcA++ottHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=gh7HbCjo; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="gh7HbCjo"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5450f2959f7so1186819e87.2
        for <linux-mmc@vger.kernel.org>; Thu, 13 Feb 2025 09:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739469495; x=1740074295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hJUq2FWMpiTubsUgXvXpT/cz5xlZO2FuryQMryqjCg=;
        b=gh7HbCjoFmLKwD37kRFalbMy9C8mdaurTyq5yYYJejuNI0lKcrL/NKfzoW9VsjDPDd
         7D4oPc75wZilDRIPWymRHPlb9xApBTn7klBmHMw+4c+xfwRy/awKxTzLZT2n7T6tCRJF
         cwvRNR9rGoVyW2j0xWjD/czYlIDaE2LDNcvLLTKVMF3tYsqJ2ArpRPa2gAUUrmeMRJtM
         UGfda+74pne77pvtLM/a/ke+kgg21rAR69cmnyCBCq9TK8SZ48MMTNB5DacIBQ1xri9c
         FQX0sVHk8Yv70n6abXdyGaZ+b3iyDyNLoej9GzfaXkaKFCaPKd6sOc9Qx2qZba8BoFOs
         zo9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739469495; x=1740074295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hJUq2FWMpiTubsUgXvXpT/cz5xlZO2FuryQMryqjCg=;
        b=AQMkBLXwTDEA3N2mTfEzyMHAfykH5r2a/F2ipRdJTOmba9w3hAbTqLhcyg3lB6zcyN
         y/QQZBTHXew+EOXWanKahyr/EwYbbxcPYP5YrSruCWcV+1gUXQshRKTn7jLONcfKDJJE
         DQGhPq2eIuZXlqvdLmlwdHTyUnOHDJVXmqoLBAKbTBu42NiiCE0dPBUuGyHucx9GDu3U
         uLOblCn1zAsbWKWbs8n6eOj7Y57k6e65gxMLiUwB3bXMIQ73Axg7j/9uxiTCUsZuk1Qs
         lIlbqshgWdjQ6AFMXbDi93hCy59Iv4oSFpXdMhCVLNROFMJP9tz3W2y0ecYyDMBiE1v+
         IvxA==
X-Forwarded-Encrypted: i=1; AJvYcCXJFmW0+hdt0f4ZYhUgg6HOixmXjbLJmKblHS5A9g1Xom9lRDPP3J7slngZcGiP2FudqwcMFvvX6B4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDkdtMpXqo6ra7LVBIPRtrNrb7nt7UpYRI2Ci4Pp4+o9ZFgSxi
	21B+h/W3DkpNVAj3JOJnLRFi2pK800c5x3xACkmrIuc5cdOyr9DDgpY3YIfCPZIOgvFslQsP/x7
	HI1yc2s0wFslfjGKKrKh2KCdbpL+PJp5ozg5ddQ==
X-Gm-Gg: ASbGncubPwoAgCCCa9bFJOM5STpj9KLPA0HU+YT/PvzWpJIX/Y42a1nwQ/KWWfckleE
	TSBQgszlXrZSSha4fYonc2cpFoFIimb3q+GnSQaZyapyKCX+NAw8hYFM5huiIr+IBittAkzqxTk
	3Rdujq1ylO0j/3ujo9aXMqwW8UTfKx
X-Google-Smtp-Source: AGHT+IGvl6mW9n7No7hloQAm0sjQgh6h7QTx9ok6twfTZlsAcsr3IPTDtYgCtgjq9SBpATIzjmWo0SWAoAL/h4h3bA0=
X-Received: by 2002:a05:6512:230d:b0:545:8f7:8597 with SMTP id
 2adb3069b0e04-5451dd953bdmr1828407e87.16.1739469495145; Thu, 13 Feb 2025
 09:58:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210-gpio-set-array-helper-v3-0-d6a673674da8@baylibre.com>
 <173935301204.11039.10193374588878813157.b4-ty@linaro.org>
 <801b5364-129f-42e9-bf9a-a90d9eeb4629@baylibre.com> <CAMRc=MeXTvPnEPjOmPd5Vw0FYKHzndsB0SVjQErA4CY_0MGsMQ@mail.gmail.com>
 <7989a6a0-b761-416c-ad97-69bd23fdc2c4@sirena.org.uk>
In-Reply-To: <7989a6a0-b761-416c-ad97-69bd23fdc2c4@sirena.org.uk>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 13 Feb 2025 18:58:04 +0100
X-Gm-Features: AWEUYZmrRaL2YjTM2r-jpirYN5EOkISNS2cmGOX2GIxOe7L0RqWQ7r8Dpd66z_c
Message-ID: <CAMRc=Mea5imComkraP=v9TKsxLDoBm4XtbLL1QxCbhJ8d4uxcA@mail.gmail.com>
Subject: Re: (subset) [PATCH v3 00/15] gpiolib: add gpiod_multi_set_value_cansleep
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andy@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Peter Rosin <peda@axentia.se>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-mmc@vger.kernel.org, netdev@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-sound@vger.kernel.org, 
	Andy Shevchenko <andy.shevchenko@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 6:53=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Thu, Feb 13, 2025 at 06:42:19PM +0100, Bartosz Golaszewski wrote:
> > On Thu, Feb 13, 2025 at 6:25=E2=80=AFPM David Lechner <dlechner@baylibr=
e.com> wrote:
>
> > > Do you plan to pick up the other patches that have been acked
> > > as well? It seems like most folks were OK with everything going
> > > though the gpio tree since the changes are small.
>
> > Jonathan requested a branch so I made one and sent out a PR. I figured
> > people would just pick the relevant patches into their respective
> > trees? For patches that won't be in next by rc5 - I will take them if
> > Acked - just remind me.
>
> If people are acking things that generally means they're expecting them
> to go along with the rest of the series.  When you didn't apply the ASoC
> patch I did actually put into CI but it was a bit surprising that you
> seemed to be expecting that.

There was no clear consensus. Some patches are still not acked.

No worries, I will take the acked ones. I didn't see any b4
notifications from your side yet, so I assume the patches are still
pending?

Bart
