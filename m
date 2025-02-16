Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AD3C8E0
	for <linux-mmc@vger.kernel.org>; Sun, 16 Feb 2025 15:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739721319; cv=none; b=qy3qeV38Z0cPaHdv8oSujxHX6KVlYS0Oh6oqonD8qu51nUa+v4a58Pd7HDNHqAxd4MFTqf14ORE8EECVzbUiMLP06MOR10bBG5txXc6vSGaEX4AbxraFnMwPZ4BMtzbx9EnIPkKPEni3w4aaJz2UMYQbo7c7avW0+akwTOpB1mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739721319; c=relaxed/simple;
	bh=fmKJhAkPeYFVEblE7yGmDKB1vPuz4ognRbo9aIWQDQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n7Qwp2hlJRhm1854swfXyF4GF7vS+c15BWgPR7qZkOjCk3TVyavqLj3V//knc78q1VjgoepeAfaL6fm3lZCszSx0wxKTpAhx6F5JEZRX/3uyFgpSqQrB25w/8xY4Nhg1zfdZaRdDrk7Cwc+VmjqSByIAsKLrfMicJ3hZSZat/6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=u86vVIsY; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="u86vVIsY"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-546202d633dso246821e87.2
        for <linux-mmc@vger.kernel.org>; Sun, 16 Feb 2025 07:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739721316; x=1740326116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkW3Uzq4pFyxE3zKB7NeWEe8NL5/OGKMv8Mar8FWkgQ=;
        b=u86vVIsYDx9zfwa3/ZhSypq++5AbM/V257JopekX0hLcIC4BYNt3Kl8zNNr905sUjs
         8C5IE/Gajx0Jr3Drzdn2hD+qxpej2YX30QNNItS/bJpK1D5zVstdlfNDcKygOYlgnuJ9
         DRmMJoHs2oecxWqG6llTcp0vuJ8p67FHjJxyQ9U95z9btpw3eylcbftbZ9eamtOpDdh4
         pHEsgIhZsqegEAN9IX/Ulo5IM3vvJ7ML8aTumKDzoRWg0OfkpipXYoWKTX2oTInxEg/+
         bxKpn9UdzEUEGYblJLRKdD7jx5iQdZ1QAGHRp3IFJun4+tX91uWR2HL+Us2YaolE0fun
         ShKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739721316; x=1740326116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkW3Uzq4pFyxE3zKB7NeWEe8NL5/OGKMv8Mar8FWkgQ=;
        b=uJkMql/VVsqHUMqm4VIhZzLiBsQOVk8k4hk9SE/AB/vYMO9d/SFtDFOBO8Ep4E8N76
         AiELFCeGPk66D5rYx6dPI0aQcNKmI3At/uQXMYEZ7NU7AK9Ooqa/j2Lh0UMkjSna00kw
         MIyf2Z/A8CivDh1U4NYdAywvgCdOFLZYT5tvOaK4wD/4X4uSfVahTCO28aa+e9bN4m4N
         +dBypzr93SlXsMuNugN++JXUFkTpAitD7Hd1pZL2++IYGLKbZbU2LZZ+9S09nf0E6T4J
         QR2TaxFZNpmjQErLVJsTUdLWYR+YHEerr+ER3Vg8waQi2XEFAXon7an78fcHPw7H37NX
         EYew==
X-Forwarded-Encrypted: i=1; AJvYcCU00G/bUdXFuet/kolrjSG+QU7QN322ms5cjEUkurQKgP4DF7MXEyhRCzIogCcbVC9XQeFc3V+xeTs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt2zo3/LtMcjMCjAlPH0fcPc4EBvEushEH7wIxgJ+/fIl86qFE
	q/uyVOKCxJtytX8CCBG7qPT3NobF4zSQx8Ttw09zKg281O4MoXhYCy2clku95l1rwSm7DYk+xJk
	ZEHjl1CjEZpdZb7f3ajaftRTS/tottaMe3yBpfg==
X-Gm-Gg: ASbGncuXVxeLPMf0Xu4JKDjH6762l/mvvB4b/PmfLRqR3R3ww4sakxFYg/49gK8UOT3
	fE/MVbjSKg/wl4NYb7YDjQ5Bj/gKkSDbeBNop4Ix6agyu8+RyHw0gRm+rzBCdLQ1ePL6ZZMw6zf
	UlhMZbz3CMm0kTM0/WEF1rY/nK4gcN
X-Google-Smtp-Source: AGHT+IG2BEfJtto7vZKlWMr7rwzaPz49+FDMar4oAHkHlYmVolmXyGHpWwSYEsdEq+L5tztvS5LmTmktUkAulacIOqw=
X-Received: by 2002:a05:6512:3dab:b0:545:d72:95e5 with SMTP id
 2adb3069b0e04-5452fe2e42cmr2095090e87.7.1739721315922; Sun, 16 Feb 2025
 07:55:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210-gpio-set-array-helper-v3-0-d6a673674da8@baylibre.com>
 <173952845012.57797.11986673064009251713.b4-ty@linaro.org>
 <CAHp75VcjAFEdaDQAMXVMO96uxwz5byWZvybhq2fdL9ur4WP3rg@mail.gmail.com>
 <CAMRc=MefPRs-REL=OpuUFJe=MVbmeqqodp+wCxLCE8CQqdL4gQ@mail.gmail.com> <20250216142313.743af564@jic23-huawei>
In-Reply-To: <20250216142313.743af564@jic23-huawei>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Sun, 16 Feb 2025 16:55:04 +0100
X-Gm-Features: AWEUYZm8mDhVubH4-WZdsHqF8a_56E8frsslpTDc00yv0WTOnH25v97UXrDvKPg
Message-ID: <CAMRc=Meq639NMz6TuOw=xQ_A8VDwA5OXoXU47JNt7x0C7jDtGQ@mail.gmail.com>
Subject: Re: (subset) [PATCH v3 00/15] gpiolib: add gpiod_multi_set_value_cansleep
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andy@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Peter Rosin <peda@axentia.se>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, David Lechner <dlechner@baylibre.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-mmc@vger.kernel.org, netdev@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-sound@vger.kernel.org, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2025 at 3:23=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Fri, 14 Feb 2025 15:37:48 +0100
> Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> > On Fri, Feb 14, 2025 at 3:35=E2=80=AFPM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > >
> > > On Fri, Feb 14, 2025 at 12:21=E2=80=AFPM Bartosz Golaszewski <brgl@bg=
dev.pl> wrote:
> > > > On Mon, 10 Feb 2025 16:33:26 -0600, David Lechner wrote:
> > > > > This series was inspired by some minor annoyance I have experienc=
ed a
> > > > > few times in recent reviews.
> > >
> > > ...
> > >
> > > > [07/15] iio: adc: ad7606: use gpiod_multi_set_value_cansleep
> > > >         commit: 8203bc81f025a3fb084357a3d8a6eb3053bc613a
> > > > [08/15] iio: amplifiers: hmc425a: use gpiod_multi_set_value_canslee=
p
> > > >         commit: e18d359b0a132eb6619836d1bf701f5b3b53299b
> > > > [09/15] iio: resolver: ad2s1210: use gpiod_multi_set_value_cansleep
> > > >         commit: 7920df29f0dd3aae3acd8a7115d5a25414eed68f
> > > > [10/15] iio: resolver: ad2s1210: use bitmap_write
> > > >         commit: a67e45055ea90048372066811da7c7fe2d91f9aa
> > >
> > > FWIW, Jonathan usually takes care of patch queue on weekends.
> > > But whatever, it's not my business after all :-)
> > >
> >
> > Too many conflicting suggestions. I just picked up all Acked patches. =
=C2=AF\_(=E3=83=84)_/=C2=AF
>
> Resolution of any issues 'should' be easy enough. Let's keep an eye on ho=
w
> it goes as other series hit Linux next.  Might be a little work to be don=
e there
> and by Linus in next merge window.
>
> Jonathan
>

I'm totally fine with removing the iio commits from my queue if you
prefer to take them.

Bartosz
