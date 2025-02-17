Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD3C21C9E1
	for <linux-mmc@vger.kernel.org>; Mon, 17 Feb 2025 13:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739798706; cv=none; b=JKUIGLLHz2/YfHG9ut6NNCGZKQDKxWUe65Jc4OkRg4jY/pTFb7TwO1gQgwt62tYTcROt24kd4esVOwFJSHsIKNRRw6azLzyujRAuHhQxE4kHydcrSctfnK1OyRbkKY1woPkDvuVmqZMpPn3ZFbasaHhIWSdrUd3Bv8fJhQibVOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739798706; c=relaxed/simple;
	bh=/IxJ3NIw21C6bPgo5OoXJUUJgi1LWRyeVZJoDftgUuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mQyZKhXudpNVSQMz45RWu8EkJ52AVALa9NetVb4Q56bT5EjilU+criCWdfO3oh14zH+kmJ0N6GhUFOD72iWizNBFYsjijIsbHIR5qUawzRfJY4HAOiYVv7ybRPYfg3vCBJfYuSA4J7HCuF7uYoq6F/c9xMDrR1w3VyW5sntj3kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=eyTAC92q; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="eyTAC92q"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5461a485aa2so1253004e87.2
        for <linux-mmc@vger.kernel.org>; Mon, 17 Feb 2025 05:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739798702; x=1740403502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QiVy1LLX/U1j468xBgrLR30ZUfJCR/waZMXhb8yr69M=;
        b=eyTAC92quW21+ZsY2EpTqJJPuo+/qjonIFQnTJaQ7o6RvbJfyt13pZLuXlznWnNZMt
         4TAIllzj/JN3sN8WdMjxCqg04WYOo88xL2tWznMiMTL3HqTk6rgrl2KBQxD2zKbgWEam
         uW6GmAY0SYML9jXE7HjYQ6Fnf+JnsQl+XnWVTy6EcwqvNvyA9B/vJ+EkQhPcpVecW+7A
         GWcs1kD7Nf4C5GUrcJvd/IUJJ59YJbQJAmGyVQAkqqZ8aT6xudq7kg0g8rHVWKm6H35Q
         b/CziyXb53YcIjZb+ktUTSxCqKjCeWH9E1h4w92KEGQNSk793OfDsh0YhaxyGsukU2g3
         6cVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739798702; x=1740403502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QiVy1LLX/U1j468xBgrLR30ZUfJCR/waZMXhb8yr69M=;
        b=QNDKaGfEptzVT9+th8tn5+BpZgMW1yRHQFS2mirvjxsfGI3wxJuTSSFfKZSiV4VaK4
         SIBo+O2UKX5ttoESxrN3m0E/PqLtFoYi5B1DnEjN/MUhA3c19eLl1oV1qZTcHV4R11E/
         CvjPbSw3m8HfoLYpQ9LanhHJyW7GLBWgfZnGB4iVRZy66YkOJaw2xF0qQlhZ8wCVhPYM
         Cp4earPNIPKOZYKT6zqQkfGDv817h/NQCvvgiHFN2P5eMqhxVFy/bFtqsRl7qA5XkBPb
         BqrtTKF7LQXqfGDjC/rEH0yHMa6O2LohvzIS+12yZK10sOVofDsSGGltDTiDW0PzZY/x
         kdbg==
X-Forwarded-Encrypted: i=1; AJvYcCW7fJ2GegLvTVd/MItAfQ3/x8+utkKNnHBt4oqmUfrWMqXyHaZUYybo1bIg1MTzxZsBG2w5wGhR7Bc=@vger.kernel.org
X-Gm-Message-State: AOJu0YylYa6wHuydn2mrEqJBEahJXBBXjzGmA8etihp3jgc5kDkguliw
	R/o5ojwGgegMJ30adtNeCnh2xeQykJYMejMtsAA3w/xLaD3WFwrKkCfgLmKmbDVBxfyvrhAP21I
	117gdHtJb00VQNwkIhdRA26APu2fmpgRDTzA+5g==
X-Gm-Gg: ASbGncs/6mi5MqvUT4JVTZ6t9YyAyb24gqSxmVws/80u9SN53/p5G+5dQky/HPaKrVc
	twI9uqEeDxhMAt8F2cxqHtn0rvjyhy6E7vlkCs7VIB+J8Pfy6PQ9GcspPGb2hrsTGHu2V672edB
	j06dMqx4slRL4d+c8i28wB0Cp1Zg==
X-Google-Smtp-Source: AGHT+IEb6JHw/5PakMZCVTYAlw84c60jmNtNM9WQpCnIP/Vmd74RSHMRaGMUWCimKY7la7twkBPZRBodM2VgArHLkgI=
X-Received: by 2002:a05:6512:2396:b0:545:bb6:8e32 with SMTP id
 2adb3069b0e04-5452fe2eb21mr2817688e87.12.1739798702259; Mon, 17 Feb 2025
 05:25:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210-gpio-set-array-helper-v3-0-d6a673674da8@baylibre.com>
 <173952845012.57797.11986673064009251713.b4-ty@linaro.org>
 <CAHp75VcjAFEdaDQAMXVMO96uxwz5byWZvybhq2fdL9ur4WP3rg@mail.gmail.com>
 <CAMRc=MefPRs-REL=OpuUFJe=MVbmeqqodp+wCxLCE8CQqdL4gQ@mail.gmail.com>
 <20250216142313.743af564@jic23-huawei> <CAMRc=Meq639NMz6TuOw=xQ_A8VDwA5OXoXU47JNt7x0C7jDtGQ@mail.gmail.com>
 <20250217131110.5803b68b@jic23-huawei>
In-Reply-To: <20250217131110.5803b68b@jic23-huawei>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 17 Feb 2025 14:24:51 +0100
X-Gm-Features: AWEUYZmts5pHMv-WTAD5H0ycHChA4PeALdc-KhHeVO2LZrBUG0P1He-nzm1gLUk
Message-ID: <CAMRc=McM-f3NKGGPs9UCzDyOO2Fw_N+2HzyTPajcZiPTAUXDUw@mail.gmail.com>
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

On Mon, Feb 17, 2025 at 2:11=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Sun, 16 Feb 2025 16:55:04 +0100
> Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> > On Sun, Feb 16, 2025 at 3:23=E2=80=AFPM Jonathan Cameron <jic23@kernel.=
org> wrote:
> > >
> > > On Fri, 14 Feb 2025 15:37:48 +0100
> > > Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > >
> > > > On Fri, Feb 14, 2025 at 3:35=E2=80=AFPM Andy Shevchenko
> > > > <andy.shevchenko@gmail.com> wrote:
> > > > >
> > > > > On Fri, Feb 14, 2025 at 12:21=E2=80=AFPM Bartosz Golaszewski <brg=
l@bgdev.pl> wrote:
> > > > > > On Mon, 10 Feb 2025 16:33:26 -0600, David Lechner wrote:
> > > > > > > This series was inspired by some minor annoyance I have exper=
ienced a
> > > > > > > few times in recent reviews.
> > > > >
> > > > > ...
> > > > >
> > > > > > [07/15] iio: adc: ad7606: use gpiod_multi_set_value_cansleep
> > > > > >         commit: 8203bc81f025a3fb084357a3d8a6eb3053bc613a
> > > > > > [08/15] iio: amplifiers: hmc425a: use gpiod_multi_set_value_can=
sleep
> > > > > >         commit: e18d359b0a132eb6619836d1bf701f5b3b53299b
> > > > > > [09/15] iio: resolver: ad2s1210: use gpiod_multi_set_value_cans=
leep
> > > > > >         commit: 7920df29f0dd3aae3acd8a7115d5a25414eed68f
> > > > > > [10/15] iio: resolver: ad2s1210: use bitmap_write
> > > > > >         commit: a67e45055ea90048372066811da7c7fe2d91f9aa
> > > > >
> > > > > FWIW, Jonathan usually takes care of patch queue on weekends.
> > > > > But whatever, it's not my business after all :-)
> > > > >
> > > >
> > > > Too many conflicting suggestions. I just picked up all Acked patche=
s. =C2=AF\_(=E3=83=84)_/=C2=AF
> > >
> > > Resolution of any issues 'should' be easy enough. Let's keep an eye o=
n how
> > > it goes as other series hit Linux next.  Might be a little work to be=
 done there
> > > and by Linus in next merge window.
> > >
> > > Jonathan
> > >
> >
> > I'm totally fine with removing the iio commits from my queue if you
> > prefer to take them.
> >
> Hi Bartosz,
>
> That's probably going to prove slightly less painful, so please do.
> I'll merge in that immutable tag and pick them up once you've dropped the=
m.
>

Done, you can push your branch out and the next "next" should be ok now.

Bart
