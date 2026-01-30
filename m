Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D55035DCED
	for <linux-mmc@vger.kernel.org>; Fri, 30 Jan 2026 10:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769768944; cv=pass; b=UAYi25jCFEi5tPpKeFlGo+6wxbJY8Q+UrzMXl4aF/blk8a3Mu5btIh0f2Xaz8uid9YTJv9RmJthuIufgW5W9XD9RWrCWwbmYbITJA/B3Ga7DqhAXKSbXFV+9Ua0vg47PW56t/HZFLm6si4a1w/q96XeEW8TQQybiqMt1y0kcpzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769768944; c=relaxed/simple;
	bh=4IZOypoh2mxenIel1BEB+3XJOHnFitDgJDIz3Q5JdHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d3KZZjAlxeU/wlYCaJGtagiR+Puo0AeuPcVF2xSUKoJSLOXHP8NExL9WoWS7DIp8pupTfPMzLOEI9hHbvo5+Xai3tLw7jE8a+SVVhdxJRj5Bx30xcAOOqMTGlct51HcMvq0P28ZndzNjwG6NnHJKAudpGCJ0bJs+D8DzcJAZAI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oln1L8NE; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oln1L8NE"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59b6c13b68dso2783379e87.0
        for <linux-mmc@vger.kernel.org>; Fri, 30 Jan 2026 02:29:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769768940; cv=none;
        d=google.com; s=arc-20240605;
        b=ViJ+SgBwpIWvWMZNaLbIn6thbilxv6Lk+91oybU9UqI1ra5pQVWTkHZwK60+hJOa+K
         DOJ0n+vcAMWc4vxyIa1g65k5HBDrz3qgnH7i8wCaqjciSfQLkFOT9bt8zqqyTrehZawD
         RKE34inuizM/SGm7CuguTYRZeRy8LvqTjmfymoASELyQz2pEI7hmZVAYbpLThIMEU7GM
         Ig5v2jhsU9vwko9dsJqA3g7SDMB89bkm6wDh2T2lK/H5As1C0vd/fd2KIzr1RsBFplpX
         5yvVVQitCX27qdMCiifvkfbuHFmQYRK/bJYZJrns0N5Td+KeZl5ksCmNdHpxgzae6TNQ
         TAUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UyyRc5JdnkROBEHu+xYdCyJ2Awi4tcsQvb7pPKheNS8=;
        fh=/rbB3AQMyxpXU3T0l4mGeohDoAhBbegw5u897oZzz9c=;
        b=O+6oL7ixJeZADDVHO3jl9ioEZECTyZcFQzCL71R8h+WBOoJQtLGADhurz1V2sVukwy
         aAeaJ/SqYOeZ9OIGwmMbroctmPncg5cohh6hutzzcI/hEatjezc+20cr4I5a+u1xU/xn
         mcy+4Cp31KFcAjmwdhTErJIlRv94J1+twoB1yOHnlYxsMDYZ6dQ76GUV781qY9TMHYfc
         25wCk7YOV/n7yPM3AAEe2/WjMsuNLqoAKcJDXomV5MN/WHVqtjP/gHpPfbTa9ZvYDiw8
         2s5t7WUaQcYNk56POxZ4s6s0ESVWp5rCpOoYXiVmduMP7DCJP9xeaNE0og3LFqdZMidL
         /25g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769768940; x=1770373740; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UyyRc5JdnkROBEHu+xYdCyJ2Awi4tcsQvb7pPKheNS8=;
        b=oln1L8NESX4rFb4aQJM6o8+hQcZgtNvlDrkk5mWrDRGAqBdlUxeNxMcw2eX8cve9/k
         /B/tgoSqfiLOIQ6n5A7FGYAnfj5EkEFL8G5PmeCNy5FvfcKTZeeYcb2oSeEK7SPS4D8e
         AveR4t8N/Rp88C06eoXuFV1HaAjukzyQGL78WB1q/NBX2S2iW4b37uTbndAiZcD8Y53S
         yszc4WtoiN/tvRc5QBRssoUdiZyxH0VsMZ2fxnhKCwbFVUuo7ahbde+gcZ+cU5/AhEdd
         giiAjMR47BZz/ObY0X3fCnsdeDveajpO1Ikp0KpWblJ/09ymDA34ELw6z8uXK7gTFL4x
         OZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769768940; x=1770373740;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UyyRc5JdnkROBEHu+xYdCyJ2Awi4tcsQvb7pPKheNS8=;
        b=jVwbLRbQEcOisD0BHI25cAuLE1T1JOTRILnmtlx5tuXafbylJr9OR/BBolOZHhtgdA
         gExlww3KHa2CSgFzDVHcRqcZpI6wER01xb/XXU3dKgd2T1uSiz3CmuPpuu/aKVhUnNw9
         HpV+KdGon1uWqSue2xFUlgJxPNItbOj5/bUky3T/AYbhImHr+wMcUzJDLb+OguBhoxgb
         Sbvsm9TMlnmJaV3kKRxHuyiEhKs4JMkyzKHfNExdGXYExfu4RvNc/Ze4efZcczrTA37y
         XlKaJuC4+5l/Yy/Oh39PcdGC8iBHYZLt+y0LEpy0v5vrElvlM+CJGpKlzUXkoSi0u3RL
         yGtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhvLRsubSVAr/8TU4zGPL0Y3yyhyZiFIeGlc6Of4ZhWtwB4VzolILldFaklAGyb4t0mfMyceVRtHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjfQ8VZxpMIrVSP1FXlJ7FoXzwkNxGtYqqXW+C1IlLsrdz5Pkv
	5AeTGUXz8YcVUY/bncg8pyEcS9bcQim0qO3RDTCfej1cj16n+8LD8D3HIjVP7jjgGs4B12L7sgg
	HasZ4fdGDNFVoaUX0mln+8soC+//5h5TJsKYCqg88uA==
X-Gm-Gg: AZuq6aIfj085iFuIJYHOVtDuI6p2qOVyRxTRkrBbQ2LX9cg1C+wjxABKAJ4g+Z2Cwyp
	523NwUt6WqjeOm1jALhWD5clRfwQyrPSCjqx5cfZz/mn36xDYz2QZaVEmIouo4VjgziVjMOPN9S
	uE0i0DaoqtuVB/SfVrPsmI7lhHnHbqP+FJaOxzRLwGBiNrK1YxVFWpGWS+WTzJBfSc1UASN3rSU
	8tjqQkHjNTWiWKicpaVOvEo/H2EyhIHcpwfyIbj6lqOOf+5ANH6weQB76JrnJEpPlz+WHVo
X-Received: by 2002:a05:6512:3090:b0:59e:19f8:e7e5 with SMTP id
 2adb3069b0e04-59e19f8e879mr389940e87.10.1769768940222; Fri, 30 Jan 2026
 02:29:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128-rz-sdio-mux-v7-0-92ebb6da0df8@solid-run.com>
 <20260128-rz-sdio-mux-v7-2-92ebb6da0df8@solid-run.com> <CAPDyKFrBuL+747QUJJUejtcvjm0V7Lt=vHwjvcMdCt_h4=sFwg@mail.gmail.com>
 <CAMuHMdXgLR9yeLa5JKNdAOtNEirJ8263bmn1zRNAnKnmf8F-Sg@mail.gmail.com>
In-Reply-To: <CAMuHMdXgLR9yeLa5JKNdAOtNEirJ8263bmn1zRNAnKnmf8F-Sg@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 30 Jan 2026 11:28:24 +0100
X-Gm-Features: AZwV_QjKt-7WVZ6iCRSlLFm6WIvZGroCu2x79LzMFz95tWuDMfGW172v0QkfhHE
Message-ID: <CAPDyKFrvSp6tmhP=2=9kca1d3+b6MezvxJWwMOW=Gv6D8TKrgA@mail.gmail.com>
Subject: Re: [PATCH v7 2/7] mux: Add helper functions for getting optional and
 selected mux-state
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Josua Mayer <josua@solid-run.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Peter Rosin <peda@axentia.se>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
	Mikhail Anikin <mikhail.anikin@solid-run.com>, linux-can@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 Jan 2026 at 18:46, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Thu, 29 Jan 2026 at 17:06, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > On Wed, 28 Jan 2026 at 15:46, Josua Mayer <josua@solid-run.com> wrote:
> > >
> > > In-tree phy-can-transceiver driver has already implemented a local
> > > version of devm_mux_state_get_optional.
> > >
> > > The omap-i2c driver gets and selects an optional mux in its probe
> > > function without using any helper.
> > >
> > > Add new helper functions covering both aforementioned use-cases:
> > >
> > > - mux_control_get_optional:
> > >   Get a mux-control if specified in dt, return NULL otherwise.
> > > - devm_mux_state_get_optional:
> > >   Get a mux-state if specified in dt, return NULL otherwise.
> > > - devm_mux_state_get_selected:
> > >   Get and select a mux-state specified in dt, return error otherwise.
> > > - devm_mux_state_get_optional_selected:
> > >   Get and select a mux-state if specified in dt, return error or NULL.
> > >
> > > Existing mux_get helper function is changed to take an extra argument
> > > indicating whether the mux is optional.
> > > In this case no error is printed, and NULL returned in case of ENOENT.
> > >
> > > Calling code is adapted to handle NULL return case, and to pass optional
> > > argument as required.
> > >
> > > To support automatic deselect for _selected helper, a new structure is
> > > created storing an exit pointer similar to clock core which is called on
> > > release.
> > >
> > > To facilitate code sharing between optional/mandatory/selected helpers,
> > > a new internal helper function is added to handle quiet (optional) and
> > > verbose (mandatory) errors, as well as storing the correct callback for
> > > devm release: __devm_mux_state_get
> > >
> > > Due to this structure devm_mux_state_get_*_selected can no longer print
> > > a useful error message when select fails. Instead callers should print
> > > errors where needed.
> > >
> > > Commit e153fdea9db04 ("phy: can-transceiver: Re-instate "mux-states"
> > > property presence check") noted that "mux_get() always prints an error
> > > message in case of an error, including when the property is not present,
> > > confusing the user."
> > >
> > > The first error message covers the case that a mux name is not matched
> > > in dt. The second error message is based on of_parse_phandle_with_args
> > > return value.
> > >
> > > In optional case no error is printed and NULL is returned.
> > > This ensures that the new helper functions will not confuse the user
> > > either.
> > >
> > > With the addition of optional helper functions it became clear that
> > > drivers should compile and link even if CONFIG_MULTIPLEXER was not enabled.
> > > Add stubs for all symbols exported by mux core.
> > >
> > > Signed-off-by: Josua Mayer <josua@solid-run.com>
> > > ---
> > >  drivers/mux/core.c           | 178 ++++++++++++++++++++++++++++++++++++-------
> > >  include/linux/mux/consumer.h | 108 +++++++++++++++++++++++++-
> > >  2 files changed, 253 insertions(+), 33 deletions(-)
> > >
> > > diff --git a/drivers/mux/core.c b/drivers/mux/core.c
> > > index a3840fe0995f..b01ec126caaf 100644
> > > --- a/drivers/mux/core.c
> > > +++ b/drivers/mux/core.c
> >
> > [...]
> >
> > >  static void devm_mux_state_release(struct device *dev, void *res)
> > >  {
> > > -       struct mux_state *mstate = *(struct mux_state **)res;
> > > +       struct devm_mux_state_state *devm_state = res;
> > >
> > > -       mux_state_put(mstate);
> > > +       if (devm_state->exit)
> > > +               devm_state->exit(devm_state->mstate);
> > > +
> > > +       mux_state_put(devm_state->mstate);
> > >  }
> > >
> > >  /**
> > > - * devm_mux_state_get() - Get the mux-state for a device, with resource
> > > - *                       management.
> > > - * @dev: The device that needs a mux-control.
> > > - * @mux_name: The name identifying the mux-control.
> > > + * __devm_mux_state_get() - Get the optional mux-state for a device,
> > > + *                         with resource management.
> > > + * @dev: The device that needs a mux-state.
> > > + * @mux_name: The name identifying the mux-state.
> > > + * @optional: Whether to return NULL and silence errors when mux doesn't exist.
> > > + * @init: Optional function pointer for mux-state object initialisation.
> > > + * @exit: Optional function pointer for mux-state object cleanup on release.
> > >   *
> > >   * Return: Pointer to the mux-state, or an ERR_PTR with a negative errno.
> > >   */
> > > -struct mux_state *devm_mux_state_get(struct device *dev,
> > > -                                    const char *mux_name)
> > > +static struct mux_state *__devm_mux_state_get(struct device *dev, const char *mux_name,
> > > +                                             bool optional,
> > > +                                             int (*init)(struct mux_state *mstate),
> > > +                                             int (*exit)(struct mux_state *mstate))
> > >  {
> > > -       struct mux_state **ptr, *mstate;
> > > +       struct devm_mux_state_state *devm_state;
> > > +       struct mux_state *mstate;
> > > +       int ret;
> > >
> > > -       ptr = devres_alloc(devm_mux_state_release, sizeof(*ptr), GFP_KERNEL);
> > > -       if (!ptr)
> > > +       devm_state = devres_alloc(devm_mux_state_release, sizeof(*devm_state), GFP_KERNEL);
> > > +       if (!devm_state)
> > >                 return ERR_PTR(-ENOMEM);
> > >
> > > -       mstate = mux_state_get(dev, mux_name);
> > > -       if (IS_ERR(mstate)) {
> > > -               devres_free(ptr);
> > > -               return mstate;
> > > +       mstate = mux_state_get(dev, mux_name, optional);
> > > +       if (IS_ERR_OR_NULL(mstate)) {
> > > +               ret = PTR_ERR(mstate);
> >
> > Should this be PTR_ERR_OR_ZERO?
>
> "mux_state_get() never returns NULL"
> https://lore.kernel.org/202601221036.J0kR78Uw-lkp@intel.com

By looking at the code in mux_state_get() and mux_get() that $subject
patch changes, it intends to add a "bool optional" as in-parameter. If
it's set, it looks like the intent is to allow returning NULL, which
makes sense to me.

Anyway, there seems to be some additional smatch warnings to fix
before this is ready to go.

[...]

Kind regards
Uffe
