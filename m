Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908993E0C53
	for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 15:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747313; cv=none; b=TYt4HsOrGoN2l7db+Eg52iZ3BGNHErB1VTeMQQVjgNW+qKZbKUR1DBSuu0LHsHw4MUmVFjDgoe3jcjD3UQNpYTFRagCFCvxa2o4bduUH/h/gCa9WU8IkjnDVBMpOSkA1pDvC4w7BE2f0/QoF/WfFrVVRcVVR3H/Jh7FEPSpSIYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747313; c=relaxed/simple;
	bh=BODU8nH72xA0ScZ+HzwpHMr8UOUoOL0Z1xiarATGzqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sL8ds+N5rPkdJv3BR+2nBl0X2eQ2c14HAokLnGwH5B8hqHInGKKY63fvqDPILMI3qKzEyYG7x8sZj84BGDh9PDk7vwux/TODxd0YeE6cr94gWfhYAZt62Mh2yyyWnmDd9MY/0uBFBHa8EyJCai3bDijaSSEOgaXym6uhwpc0uxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-69857dc1d5eso2737830a12.3
        for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 08:35:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782747310; x=1783352110;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PSkrSvBcOj2Vfr1tOG9HdESUGrp+uU5X3MHl1xNqsM=;
        b=kS15qOpBx96H9q6fg25p+IiF6vZvcYzGO8VsCLljGGOBN1jX/U6w0GOJtRmEceWuBz
         64HjRv0Fs6TBOjTExo3HzDt3VpviVNuNpB5EZfqGKF7QE8qTELebDe/abVxXDLYNEeyV
         DAi0Kxe0U5Z3qfFXvJQItuMvaylZfiKDmfeFMwk3RDZpH1kJhDVI87ngFsarnNpoQ0XK
         W0FvHebIWvGzb8Bm0OnHxfGXzzaea3I0oIiVqtIjZTbasNoK8EAhRDUKr8me0c58NXJu
         NqmSuhyLTf9r66+Xei0fH1Ec7DS6Gi8kGxKvRTD1BP+NTXLZz0zglXOw6BP9teC6zG6J
         Ug+g==
X-Forwarded-Encrypted: i=1; AHgh+RrFxM+T4j100IKbs431lwC9SiS44teleq5kXU1i3lO5gAvTdPvYat9v62jVyyIwv8hZzP+9YXsFFHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxbEmmJS036urCQPAyouRBlLjlzmjLWRYP2qs9oMd2Vs6gf0D4
	1BLZnd7p9NUDqv6EltE/e8x0ZEgvwA8zQpSWt5lpIcWPtXR9tOSw7FK+sUrJxx0lWKI=
X-Gm-Gg: AfdE7ckz8bs+isRpjijf2GVCVdRNj370xyB7d+rs/76VnvA4P2HdyDThbB2Tc+pjNWf
	GZy+9LNFzuHkx5x87+stTZzl03vVkg1pSAIvTonUPGtLqWXgCbuJsLj3/zL3bgeKLj5lSh3EoFd
	GvP0Y184NAT2hGMG4dGt8wNyuRjxbF5uycOf2SYyfnX5HMjh5+BxtGHfsxzlo5zx8wAGuOeQAmd
	rM5LxBkw7cTb1xK2ABvO8i8pPqsXuMoEfLVWjUKzW680tyKRSsu9H2p9R1U+uhy6BcFhC7oMYQN
	KOP6T2AgzaRwVk0y+MNzcmfbBkL3ITHk99Anbe4HCp8e4yI/u3p/X1l7Xx6DZRCUpNHTvj85R8h
	+27US/UfbGIfEOyeZG27YAPYGk8XJyHdaOApktcC6nJzPxVQfUOvjTMgJEOxA/BBQbi1qbu8uUe
	qDxx8cIxLdoKYVxleRDKs7xT+kQzo3N0xFXqeOyFsIEq8PoN6dlb+IOAv3s3G9
X-Received: by 2002:a17:906:730b:b0:c12:80f6:7fac with SMTP id a640c23a62f3a-c1280f69990mr64102966b.36.1782747309796;
        Mon, 29 Jun 2026 08:35:09 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1276093d8fsm111701266b.13.2026.06.29.08.35.09
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 08:35:09 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4624a44e152so3181810f8f.2
        for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 08:35:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8BCtLE1VqClmgjxLde/cVVyOJosyuqRKocHPZsCshR64wGaF0M1CH2c2dkObpbTHksCxfm6olbtjg=@vger.kernel.org
X-Received: by 2002:a17:907:3c8b:b0:c12:f84:85d4 with SMTP id
 a640c23a62f3a-c120f8487bamr796791266b.24.1782746977928; Mon, 29 Jun 2026
 08:29:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629135917.1308621-1-arnd@kernel.org>
In-Reply-To: <20260629135917.1308621-1-arnd@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Jun 2026 17:29:24 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXhsM4JzArRuB=A46N-Ogbn2Fans+PVJVA-hEytFq=DeQ@mail.gmail.com>
X-Gm-Features: AVVi8CfSSg4DcoB7CGCYddSfqoWpUaOwYUjpkorP-3LR7U8E7vJ9ucbePhiZLD8
Message-ID: <CAMuHMdXhsM4JzArRuB=A46N-Ogbn2Fans+PVJVA-hEytFq=DeQ@mail.gmail.com>
Subject: Re: [PATCH] [RFC] gpiolib: introduce gpio_name() helper
To: Arnd Bergmann <arnd@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Marcel Holtmann <marcel@holtmann.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Andy Shevchenko <andy@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Ulf Hansson <ulfh@kernel.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-i2c@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Arnd,

On Mon, 29 Jun 2026 at 15:59, Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Most remaining users of desc_to_gpio() only call it for printing debug
> information.
>
> Replace this with a new gpiod_name() helper that returns the
> gpio_desc->name string after checking the gpio_desc pointer.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for your patch!

> Not sure if this the way we want to take this, or if the gpio name is
> an appropriate replacement in debug printk.
>
> Since most of the callers of desc_to_gpio() and gpio_to_desc() are
> otherwise in drivers that already depend on CONFIG_GPIOLIB_LEGACY and
> include linux/gpio/legacy.h, only a handful of instances remain that
> are otherwise in files that otherwise only use the descriptor interfaces:

> --- a/drivers/gpio/gpio-aggregator.c
> +++ b/drivers/gpio/gpio-aggregator.c
> @@ -758,8 +758,8 @@ int gpiochip_fwd_desc_add(struct gpiochip_fwd *fwd, struct gpio_desc *desc,
>
>         fwd->descs[offset] = desc;
>
> -       dev_dbg(chip->parent, "%u => gpio %d irq %d\n", offset,
> -               desc_to_gpio(desc), gpiod_to_irq(desc));
> +       dev_dbg(chip->parent, "%u => gpio %s irq %d\n", offset,
> +               gpiod_name(desc), gpiod_to_irq(desc));
>
>         return 0;
>  }

Before, this printed:

    gpio-aggregator gpio-aggregator.1: 0 => gpio 589 irq 188
    gpio-aggregator gpio-aggregator.1: 1 => gpio 590 irq 189

After, this prints:

    gpio-aggregator gpio-aggregator.1: 0 => gpio (null) irq 188
    gpio-aggregator gpio-aggregator.1: 1 => gpio (null) irq 189

Same results for instantiation using sysfs or configfs[1], although
the latter does have optional support for specifying the name.

[1] Documentation/admin-guide/gpio/gpio-aggregator.rst

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
