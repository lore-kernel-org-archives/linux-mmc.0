Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B1340DFBB
	for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2026 16:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782835628; cv=none; b=hmJU/X6pXhJuDfc6c6GXwMGJOzkPm2Imgf5mPd/NDZbx/n6vll3kRzkx9wgi87RgQg7epMAKSGfNyeGIjfgYhjIVtAodsTQBhnnPewpna0cuLl0zSjhk5zYatXqgaDtoWM2l4Bec1xVy18ZgEnppjCXT7llN+eqoefkKN/iHNsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782835628; c=relaxed/simple;
	bh=y9uuZkEeJae++MbeR+TNLsbet2X1rPdv40pKLNu47dg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wh1zOeyufbDaI64JnATz2HoMiYXKuK0wB7HKltQyIWO4n7ih42m0uU5U5f5TagTQSplvxSbKrYQiYerCZxPAssP2Efg+dPNun+zZGPWqPvnN9VpwCTNUU7XDvXpqg1b5GsiB0YfWq6eG66Y+1rOBPsmBj0zzOPhL2xNgiefak9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-37e1607f7faso2200828a91.1
        for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2026 09:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782835626; x=1783440426;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqnNDF5VKQ+E0vRBcJ/LtO+JWbWwBxQUs2IGvWvjH/Q=;
        b=WCnVCjX813aYMsFq3I1JTzct3+SdeR5XEYwA853v8+VoFgNGh6aVWT4b2CvApnBtfo
         J8MvUImnmCWEBAzCr7aLSABvD4YYxRx6bgTA1GgkNgz/HYQmzoBSTm44zLhfQ56mfb/i
         Q8Np6onoUSnX9AoX+tU+EDssusm5jCXU7v/Is9KWoSIkrG3Xo9uO5tBf42AdPDirffyZ
         YVvdjRnNFc0nzs2JWZis/DbAy+thRsprABmmULjqGUahBDXW21GwPi6j2asCJ4WBdlWU
         KskKu4RY8fXPmH0morVorKDbUiJpUVGIMTBMHU6cDOtP/ifYJWIjo+EYHZkVIFXEl2VB
         8DUw==
X-Forwarded-Encrypted: i=1; AHgh+RqiqMHf3OZy6TS7Dz5IHemnLjnVN592u30wB3/br+SevJXZXs/LARyNvWsQI7IOzFeDEttFfqXSXeo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpyw9WqlLjEuFBySjm2YlRFkZbbLKumO49ODjYltRU2RvInyH1
	goCpCMW/IkYJvul61oMD6wCm04I5M2bFktkx2lJ3rvvFH1cwPYWUOWrQZjva/smo1A0=
X-Gm-Gg: AfdE7ckCUQbz7mMUozi5KBkkuu75K+fkcm/uAmzN/3ape1rf74V2li2mc5m1az8p6FO
	+KIh2Kym8gi0BSomgsa0RCwNkynz+SJ5aSD/IYnOpqBcxw/BqjsKxkahPXX3lCPafXGr1G0H1G4
	7FGKhaVBZ2bY71egBlL++ft+ldk5tXjZNIRidCpe5Wkl97yPLYbU22VXCNIgsIpGL1XgWKAiSqY
	DVTH0UclQeSxUXoJOJTv9TmXNvxYh6w47NqEDHIhTD1s5t8D7QniFDg5kIKWqNfgMgovJAEpXoX
	HbRZim41C2ltFJAwhY3jIOYXwPOS1WfoQv4l7ULFfHUn4QmKgCoFFdlH2VRz2g6KEBcYOcL84ZD
	kZjUW05yjOnIudev4SCOE7lnNjO0bj50sLOcCFuFjMU+AMawLEFB6z9Oxjd0IN8mKa6DsGEgueO
	8RGxezrZ+kybSDmwRPowghQ7wbAsSgwYjZHRfTYBeW5hOf5sy3Zo22
X-Received: by 2002:a17:90b:3cc7:b0:37d:ee77:78ac with SMTP id 98e67ed59e1d1-380527ba6d8mr2991859a91.19.1782835625939;
        Tue, 30 Jun 2026 09:07:05 -0700 (PDT)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com. [74.125.82.172])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3805bf15594sm992098a91.2.2026.06.30.09.07.05
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 09:07:05 -0700 (PDT)
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-30bf8b2bd20so9127114eec.0
        for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2026 09:07:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RonYo3yOW/yEmPLY9FMowFGG9VtYSxtYF7U4mVwTpheggHIAeJQRxkl150hVKQrZo6DrEMcTqMmYho=@vger.kernel.org
X-Received: by 2002:a05:6102:598c:b0:738:9dd5:9b03 with SMTP id
 ada2fe7eead31-73a38838db6mr1792608137.20.1782835280090; Tue, 30 Jun 2026
 09:01:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629135917.1308621-1-arnd@kernel.org> <CAMuHMdXhsM4JzArRuB=A46N-Ogbn2Fans+PVJVA-hEytFq=DeQ@mail.gmail.com>
 <ff4d7043-1929-4fa1-ba5e-f28403ad6fcc@app.fastmail.com>
In-Reply-To: <ff4d7043-1929-4fa1-ba5e-f28403ad6fcc@app.fastmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Jun 2026 18:01:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWhv8i6tkmOJU_ee9LAV7mMcQHe9FXgqTHCjGiEMWvn8Q@mail.gmail.com>
X-Gm-Features: AVVi8Cc-rLKbwzFvmIKs2_rpHMNLxVULzvudUQINxHMw-KOr8IArAqRSnLCM1D8
Message-ID: <CAMuHMdWhv8i6tkmOJU_ee9LAV7mMcQHe9FXgqTHCjGiEMWvn8Q@mail.gmail.com>
Subject: Re: [PATCH] [RFC] gpiolib: introduce gpio_name() helper
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Andy Shevchenko <andy@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ulf Hansson <ulfh@kernel.org>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, dri-devel@lists.freedesktop.org, 
	linux-i2c@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-input@vger.kernel.org, 
	"linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Arnd,

On Mon, 29 Jun 2026 at 19:54, Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Jun 29, 2026, at 17:29, Geert Uytterhoeven wrote:
> > On Mon, 29 Jun 2026 at 15:59, Arnd Bergmann <arnd@kernel.org> wrote:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >>
> >> Most remaining users of desc_to_gpio() only call it for printing debug
> >> information.
> >>
> >> Replace this with a new gpiod_name() helper that returns the
> >> gpio_desc->name string after checking the gpio_desc pointer.
> >>
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

> >> --- a/drivers/gpio/gpio-aggregator.c
> >> +++ b/drivers/gpio/gpio-aggregator.c
> >> @@ -758,8 +758,8 @@ int gpiochip_fwd_desc_add(struct gpiochip_fwd *fwd, struct gpio_desc *desc,
> >>
> >>         fwd->descs[offset] = desc;
> >>
> >> -       dev_dbg(chip->parent, "%u => gpio %d irq %d\n", offset,
> >> -               desc_to_gpio(desc), gpiod_to_irq(desc));
> >> +       dev_dbg(chip->parent, "%u => gpio %s irq %d\n", offset,
> >> +               gpiod_name(desc), gpiod_to_irq(desc));
> >>
> >>         return 0;
> >>  }
> >
> > Before, this printed:
> >
> >     gpio-aggregator gpio-aggregator.1: 0 => gpio 589 irq 188
> >     gpio-aggregator gpio-aggregator.1: 1 => gpio 590 irq 189
> >
> > After, this prints:
> >
> >     gpio-aggregator gpio-aggregator.1: 0 => gpio (null) irq 188
> >     gpio-aggregator gpio-aggregator.1: 1 => gpio (null) irq 189
> >
> > Same results for instantiation using sysfs or configfs[1], although
> > the latter does have optional support for specifying the name.
>
> I wonder how many of the other instances have the same problem
> then. Would it be appropriate for gpiochip_fwd_desc_add() to set
> a name itself to address this one?

I don't think it would be appropriate for the GPIO aggregator to set
that name.  What we want to print here (for debugging) is the physical
GPIO that an aggregator's GPIO is mapped to, not some consumer or line
name (which is not guaranteed to be unique).
E.g. "<chip-name>.<offset>" would be fine.  As gpiod_name() can only
return a fixed string or an existing string, it can't return such a
formatted string, though. And consumers don't have access to chip info?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
