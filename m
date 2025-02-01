Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE7A1C3C10
	for <linux-mmc@vger.kernel.org>; Sat,  1 Feb 2025 16:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738426462; cv=none; b=cnoZCgMOlfqQq7J+PBKYFldXdMdqWq6lJIfnOL3VKirjnyPq5cgkFM/Gyu0+EKvdngOjQXFpTy0kpWFL3Ye0GVXoMZ0Sfb7hq7eWSy2Jx63eZzTqT/2FyAQhLyYrm23CKLYPLZ2JVo1v8i1VhzgaPsirDkK+RrIFKQr7qEEY3Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738426462; c=relaxed/simple;
	bh=xNz1P4fn6SHLp6Se+/Xd8y5hZ3fQaq8gKIv1BgEs6ZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vc3ocOyqNZvxY8Z1d3xie6s5/4riuuQjvMCPCgMY7blcs5YUeZ0Vz2yOHYNi0dNgRcG9MUSvvzGUSe8X1DgzhPnU7sYmaziXRBaYQzmtUULKKScUVYxqos1YWm5W7YlRrREPcw+FkZdsKWH0mLqz0I3GiuXM1a81pprMeMpRS10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=M7ogcfy7; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="M7ogcfy7"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-304e4562516so29647511fa.1
        for <linux-mmc@vger.kernel.org>; Sat, 01 Feb 2025 08:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1738426458; x=1739031258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNz1P4fn6SHLp6Se+/Xd8y5hZ3fQaq8gKIv1BgEs6ZU=;
        b=M7ogcfy7Z1oXYS2ppduYeeuUVINP11wL+/CJeSYxlg+W+QrNeY+i7GG70556ju4vVA
         ZQC9m+V+4+4+pM20RZJjNtrkHotAXYGFu4Z/rB1CLnef9gV907turt+nFH7SC55Gaevk
         Z5sKYzgWOEKEcW1nDV4V5SPyAtnlriJv4HxPKE/VzLoMhasiQiIbANQ96ijO1UbyJlhM
         zhIfZUCJbkHEYTlLD/j1/JCZRyMcuImT2nrcBq7Vlm/kctxpfyFqw2bbGPQwBA5vJrRg
         zaZla9ca+rEBl5jNvbEZUeXWETv498KwE10lyuUrs0Gt1c6EraiLx53KW4ArYeyAf2Xc
         326A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738426458; x=1739031258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xNz1P4fn6SHLp6Se+/Xd8y5hZ3fQaq8gKIv1BgEs6ZU=;
        b=DoClD8dOE1ic/F8wc+i6rmdTdJyxDafhCJ1PIuFvci4JHbzIg3cOjCk6H9mMsIORrR
         rlolELNWWa9ngB66c/8KSgD/V3tnWGrpracu3thrk0FdVrTIayrs4ZqIwKIkxZZD/vJ8
         mhIgfrh98kKkGRVp/MbcOqYY4/XWPWQH4+IEj2bkBc5qozfpQZ2QC7tm63fxSsvJOTiq
         3VVzNCLAxT+ajtVtCEc4K0YmWK+OcnivOX7JXwU7BKIVitIqVb0JJC2h8KwAKSMKU1+o
         eUMzSlWb2E97VLGGd4lvsw3veEx4T07F3SPYnlpb1KUvpmqhcyqygyPPS658pQuvctvU
         PO+A==
X-Forwarded-Encrypted: i=1; AJvYcCWZjMuE+wgibVKts8nUGVfueRd4QFeI+ioTAFIva4FrpoGP82P7Ijx5KSOHeXJlkRQTLfO5lzT8mXc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1sluHc5PxVXob9QmO/Sho7wggR5cgKGt5L1OtbOlcRG+qjsQp
	UqWWr0GCNLHaAh+kYtyc41Peo7YVhRvcmGlTe4MSITHUnGDy24/SC/13jDB7bnQC3qv9qaTDI2b
	45D7SkfdX/lkkB/6xBNWbn18pfiuyCQB7Ynx7mg==
X-Gm-Gg: ASbGnct0fmBNy0QwFG2Q1E41iMMDd8Im7xZATOdgfIE+AwiY72751HI86Fpt3+X9EeY
	1m5+qu9QOnjFSQlUQ9zelLi0Crx1Cq0Bu4rAZm1jbix+uFjeX/SkAe4gArgDvovKYZJoYC+u8
X-Google-Smtp-Source: AGHT+IGlv2R3jtX2X1VFHTPpZpLbOQdApeKMA2CRHsCTqn123m8l/Z4mj83w+N6PPjEJM/2MUw/JdE1JvqkdgQxw2Mg=
X-Received: by 2002:a2e:a986:0:b0:2ff:5d45:883d with SMTP id
 38308e7fff4ca-307a1126c46mr32671401fa.13.1738426458577; Sat, 01 Feb 2025
 08:14:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131-gpio-set-array-helper-v1-0-991c8ccb4d6e@baylibre.com>
 <CAMRc=MdwQL8dWU5zF5fp+KUbC2RA2Q264by8HGXMg2k1rxhsTA@mail.gmail.com> <9931433b-5cde-4819-ac96-eea4f1f0f1f2@baylibre.com>
In-Reply-To: <9931433b-5cde-4819-ac96-eea4f1f0f1f2@baylibre.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Sat, 1 Feb 2025 17:14:07 +0100
X-Gm-Features: AWEUYZnn5tAerJ98yOvgMfMy8eGRnDAVRVuV8JcXFwp2t0YOLgaRfMmHkesJgpU
Message-ID: <CAMRc=McEdcDs01BAKN5vg9POg_xxJBY1k8bfgiDN60C1-e_jow@mail.gmail.com>
Subject: Re: [PATCH 00/13] gpiolib: add gpiods_set_array_value_cansleep
To: David Lechner <dlechner@baylibre.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org, netdev@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-sound@vger.kernel.org, 
	Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andy@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Peter Rosin <peda@axentia.se>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 1, 2025 at 5:09=E2=80=AFPM David Lechner <dlechner@baylibre.com=
> wrote:
>
> On 2/1/25 4:36 AM, Bartosz Golaszewski wrote:
> >
> > This looks good to me except for one thing: the function prefix. I woul=
d
> > really appreciate it if we could stay within the existing gpiod_ namesp=
ace and
> > not add a new one in the form of gpiods_.
> >
> > Maybe: gpiod_multiple_set_ or gpiod_collected_set...?
> >
> > Bartosz
>
> I was waiting for someone to complain about the naming. ;-)
>
> I was going for as short as possible, but OK, the most obvious prefix to =
me
> would be `gpio_descs_...` (to match the first parameter). Any objections =
to
> that?
>

Yes, objection! As far as any exported interfaces go: in my book
"gpio_" is the prefix for legacy symbols we want to go away and
"gpiod_" is the prefix for current, descriptor-based API. Anything
else is a no-go. I prefer a longer name that starts with gpiod_ over
anything that's shorter but doesn't.

Bartosz
