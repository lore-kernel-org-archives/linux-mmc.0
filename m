Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BC32DB7B7
	for <linux-mmc@vger.kernel.org>; Mon,  9 Feb 2026 08:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770624809; cv=none; b=S1FEdfrj7cqyk3QHctDUxSJHPGzXW6kWkycHdMFMQ9p0wbj5XikfIcA63ALxrvxPMIuu8EqZT2jLks1Gv/zBiM+tncv277EfgAECp3qTKaaYGeHm4xtzg6ijS63Pb50rd/mtN/qkGO0/mpglyzeKN608C89akk7fs3D30uznv4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770624809; c=relaxed/simple;
	bh=jGnKFIqAqLu+rNpANBkHFw8kJ3LdtX3G4oazBBlCuPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UMtP6I6EelNep1BZmNTGLGhddxoeehNPSoofnUMGfVjTmYjGjK45OpSDKY3yPnJOphbrIcOg+4aWZxI4zdby0fEno2YH7zLURptgCv2cEguS8YM9YaJbi4HB/nMxYOQI4DVrb3q+2JJsHDKFKLs88kWU4/10hbL7zAMWxij3Z1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-503347e8715so34059961cf.2
        for <linux-mmc@vger.kernel.org>; Mon, 09 Feb 2026 00:13:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770624808; x=1771229608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l9pK4QYIZutXAE3AMWeCiy3lF4Ku+2UbgC78kdie5tY=;
        b=QI5R4YA2V+XE5EEdGERGFM/3s6u1M9LaBTlsjcPAIxKOLVgUA1mjB0KbiHrucWI9GP
         s5jZFvL6tQOOEgPTOceqBj/t4Z/5oTF4QsIW6jJlkoUEO/nSazCpfxOtjuPbAUktsELN
         psX0o7V/4anBTE6sCD1XQctDfzIWrD/dfQKsIEdwVr14PuJsxfO0UWz8IjIuW0sJIsqC
         XrkaL5M0t/TCI9IGWGC6+WNxhvaIq9iZZLYH3dYBROhADOY/jZbuEA8EW2//Iio+ZLUp
         LVD0SYa7rBonRhr3ED9vfOnRsRuYONXLJ5QSjYzX1CO/Llc1qB9+Fs955w7ZuN02BNli
         AJow==
X-Forwarded-Encrypted: i=1; AJvYcCV5AQkRkhTyhebANXYa+6n/Q/oVDvOJrH1LsuvJaxYxuoDJ7hbaLmTdkDgP87v+R/oR9rks2Vgstxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIc4WTAfguzFiWuR6dQjzxSxMIQyzQd2oU5yPVe3Yd54/YnSUd
	kVbDOdgkWVQV9SavHLPdfFOrQkvqPdjO0izqlMtKAlMgOQc2KNFAT7sdMTJoAcnU
X-Gm-Gg: AZuq6aLl+Jwpn09IKxKb1JFskUTS1Byjv9tHcY8iujkPegklzvAey8P7OtFNQYYRJEy
	TnnYZTyCcx6w+45vKnVjjMJ0E8uWsmpY/BfVLkGdhLmjMSxm8xWTs+w+/6ZPE+NzI6z2uPkhG82
	BMAuKBdRXi2tfy3kha4TWLwNZWvmLADdFMze4z9rN9wBTGG3QO/jUGCfaqzyYGvKJ6cGf0u9HCV
	kMD7rvJPF4GeBsLs0Tj5696mAwlv9p4C69A/qsaw7q8mXZuiHblmLUB7hEVkpTAmhMlLDwvr/7H
	LfiNpTPFO1rnPxVN081mFeZIhk4RpPBTeu71R8+lB4lS3TnlvKJuVm0MJIK9Nh/cpRABEB2b8vI
	dlwvsDUhM3Z02aZeWBsznA7QhbqJMZyyZ5hEZNvk+JXAm++QeesefUHucAjY4vnaj5XVFwOfEiw
	XpbPT4zUIQCg2dWq4yaO4fhLCqgfGeB5Ml1SS0Thtw41AOnlOcQ3js2Ih2CoU=
X-Received: by 2002:a05:622a:1aa4:b0:501:8643:aed3 with SMTP id d75a77b69052e-506398b4586mr139165811cf.35.1770624808516;
        Mon, 09 Feb 2026 00:13:28 -0800 (PST)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com. [209.85.219.49])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-506392c1d4esm72692201cf.27.2026.02.09.00.13.27
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 00:13:27 -0800 (PST)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-89473dca8aaso39137246d6.0
        for <linux-mmc@vger.kernel.org>; Mon, 09 Feb 2026 00:13:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUGnPuuvYliak3c9ipbCyinVqgpNQQMLE3DFPjVbI0xR+K5n7w/BSAzB437HxlHw6w4YwdhGDJvWTo=@vger.kernel.org
X-Received: by 2002:a05:6102:3747:b0:5f8:e2d3:c463 with SMTP id
 ada2fe7eead31-5fae8a3b31bmr2934943137.3.1770624379360; Mon, 09 Feb 2026
 00:06:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203-rz-sdio-mux-v8-0-024ea405863e@solid-run.com>
 <20260203-rz-sdio-mux-v8-3-024ea405863e@solid-run.com> <b7dcb374-b79c-4e9f-ac30-2f507127cfb3@solid-run.com>
In-Reply-To: <b7dcb374-b79c-4e9f-ac30-2f507127cfb3@solid-run.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 9 Feb 2026 09:06:08 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU01vwif4H6H-cYUfW0Y56fN6Anp9F4Ru7q3fveNqqoXA@mail.gmail.com>
X-Gm-Features: AZwV_QiiqRuDaFts73-z5beOOIXm-WRqeTDAQV4zcAAegTI5YGKcuRUZfqXMUrE
Message-ID: <CAMuHMdU01vwif4H6H-cYUfW0Y56fN6Anp9F4Ru7q3fveNqqoXA@mail.gmail.com>
Subject: Re: [PATCH v8 3/7] mux: add help text for MULTIPLEXER config option
To: Josua Mayer <josua@solid-run.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Peter Rosin <peda@axentia.se>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
	Mikhail Anikin <mikhail.anikin@solid-run.com>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, 
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Josua,

On Sun, 8 Feb 2026 at 16:16, Josua Mayer <josua@solid-run.com> wrote:
> On 03/02/2026 15:01, Josua Mayer wrote:
> > Add prompt and help text for CONFIG_MULTIPLEXER to allow enabling this
> > option thorugh the kernel configuration without explicit "select" drive=
r
> > dependencies.
> >
> > Select it by default when COMPILE_TEST is set for better coverage.
> >
> > Signed-off-by: Josua Mayer <josua@solid-run.com>
> > ---
> >   drivers/mux/Kconfig | 8 +++++++-
> >   1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
> > index c68132e38138..e31c46820bdf 100644
> > --- a/drivers/mux/Kconfig
> > +++ b/drivers/mux/Kconfig
> > @@ -4,7 +4,13 @@
> >   #
> >
> >   config MULTIPLEXER
> > -     tristate
> > +     tristate "Generic Multiplexer Support" if COMPILE_TEST
>
> This didn't do what I thought it would.
> It was my intention to allow enabling this through menuconfig / .config.
>
> With the syntax above menuconfig shows:
>
> =E2=94=82 Symbol: MULTIPLEXER [=3Dn]
> =E2=94=82 Type  : tristate
> =E2=94=82 Defined at drivers/mux/Kconfig:6
> =E2=94=82   Prompt: Generic Multiplexer Support
> =E2=94=82   Visible if: COMPILE_TEST [=3Dn]
>
> This means it cannot be selected.

Looks like you haven't enabled COMPILE_TEST first?

> Instead I (think I) should use
> default m if COMPILE_TEST

No, merely enabling COMPILE_TEST must not enable additional
functionality.

> Since my patch-set broke x86_64 allmodconfig and failed merge into
> linux-next,
> this presents an opportunity to change the above as well with v9.

Ulf has already applied this series to mmc/next.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
