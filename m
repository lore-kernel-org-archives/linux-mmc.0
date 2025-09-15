Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D2123D7E7
	for <linux-mmc@vger.kernel.org>; Mon, 15 Sep 2025 12:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757938656; cv=none; b=dv/8fo0CR5G5AGOhVxOIdM4AGgnW+bmeMi75GdVYkovVXC/qAkZ6lu2448MCorQfZ5xe6AM36Phk0MwIR6HDyfFrHaXDs01sXf+BJ0SxI28fJB6p6N/gLd/CbTYYxXvQ2BRFODV0TsIMFINyeXoeEdrGQpd86tDkxoIiTyHMTHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757938656; c=relaxed/simple;
	bh=OH2pSDZVq7mZ1XL0CX+/gXNgPtcPWm0mh+xd4mJyHnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GllP3LgT7xXAwG64dIGAqp1VADlsVtxsKOjwuQwAoIebqnAc937hq3SmcZnAD81oWkk7TtFZ/qhf+8JoJmZlZBP3tV4hlyMXSAQXkLM868kQIkpIgSI4bMgZSvPV00/At2h+gBvCTE7CkHrIoHkCb7dstmSnBV5xnx6kr32r3Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qOke44T1; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qOke44T1"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71d5fb5e34cso43543087b3.0
        for <linux-mmc@vger.kernel.org>; Mon, 15 Sep 2025 05:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757938653; x=1758543453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SpUzwsaZy0zO+ISxYADmCP7BUhnv9GAFZ54j6bF2STY=;
        b=qOke44T1ggQ8XxQ7KwPedLhCcJxmW5G5E5GXG2UXOhjFIjjOqUuZqkdBUUAinEMjeQ
         bJLAJI/VD8vdYft2v2MCBcZjyI/pcVQCsCgaoYTGK4r8yxbxJLlObmWgvIWU53vS097j
         XHM/SJkBIUyR13LsgteUM11cNplFxuzs1mXh6mVzplqGO3DJtvtaoFpQpJ1U8pLQaMhG
         xfbHnH24Dfkp564ekt1CDFsUWC6rKjD05+41VgTlhlkbQjgMDmxVsJW//Siy7J7p+RRB
         9ejsFxcl8gJLx7PrukpmMA02YLvJWiyVQpuiyOqAYY5LAk3ylR0lJWbt47MNFLCYMe8C
         LGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757938653; x=1758543453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SpUzwsaZy0zO+ISxYADmCP7BUhnv9GAFZ54j6bF2STY=;
        b=pW76s/EDTUuArg3ebCbe6yFvBFuA4C7wgjnYjlovi2HyXK3wCfT4cJOqDUHzMWjtZL
         sAXUfDOg1tE6iU2MJWpAbsvUJbZXDzBvnsTfGRekooBPWvWa0MJAxCk3ugTu5zpnURdH
         H+vi9t5ktWsAMGJ6b6UzftuxKPu1fW8WSSfQa4zUENRy21wJpPha5bXIYPj5EnsB6wyd
         GAttHDRgWjZ3dTm72/VQk9sLy1GanFP6R9dfj4MuDamywY5N3akSE0k02WHyYeCnqCSc
         cF9VluVFu0iouDBTM6PSSx4wtXhJX9TCZ0agPJTlgta3bsq4Fp1h1E4hC8fCzrUEmsL8
         Ym1Q==
X-Gm-Message-State: AOJu0Yx/eXxv+2FAD034QK3Dpx5MZEniDW0NWr3x9H3kQW69eckph9Ur
	P4Fp2JePEjsrcTl+9baMFpmbOp2HVrqXmH+CP2FGdx5OT1lkx7A0JpeYLXeppGAo1uNvVHSaFov
	T0rQf57h+Jf2xU36jslOdGk3MZzDQJXahwMVAotTfZNe5yP6Fv0/FIEo=
X-Gm-Gg: ASbGncsBn23EiXm4kygz4IiXLQWKFcaks3rLBfcAUkmwz3Xk8+wPUzkHGpI++r3zJg/
	z5xNjbs8iuGqrAjLOYC5PQdhH4E5tkO3ahVSg59k+4hRs7pvnnVwz7Tmrq40EsRnlbezinSTp92
	C3L8Vy0VF26vHxVZsgqj0LU+VvQhGKPqV8JRWNOMaqxfiegNeM3lJAacPQ+zzzvRrixm8brq+sJ
	tIISxBCltsCsUXIwLM=
X-Google-Smtp-Source: AGHT+IGfZ3YWJCOXZ5teozdsBO0il7tlmpHWMpggbNK4Fx26WJjBIMfv+wNLzLnAaFfjlyruAP0QkQmH7hX6fOj6EU0=
X-Received: by 2002:a05:690c:768a:b0:731:1bc7:782d with SMTP id
 00721157ae682-7311bc77c12mr86198447b3.18.1757938652817; Mon, 15 Sep 2025
 05:17:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250824084736.172222-1-dexterkidd@gmail.com> <CAPDyKFpobot01WBzvMUH0_85aUELhtijF9Yv9giEJSworObnbA@mail.gmail.com>
 <nyiodgyzyb6f2kkjlvjdlfflfkdccr2lgnij2uxkdm4mrpznf5@srcxlmdh47da> <cb4iqeqwac7pv35wbs2cwkyvdztgrfke3bzmic3nnsbuulhchv@xdfrinxazr7p>
In-Reply-To: <cb4iqeqwac7pv35wbs2cwkyvdztgrfke3bzmic3nnsbuulhchv@xdfrinxazr7p>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 15 Sep 2025 14:16:56 +0200
X-Gm-Features: Ac12FXyW41sRopRjG3tdmCADpsB7mBFyJGwZYi9S8L2w1u9AhDjZTbzkO1lfTH0
Message-ID: <CAPDyKFodoD58zG3tN0_WT5Ab+hH2wXkpBTCCzSXp=_-ntc4SfQ@mail.gmail.com>
Subject: Re: [PATCH] mmc_spi: Fix cd-gpios for SPI SD card insertion/removal detection
To: cuu <dexterkidd@gmail.com>
Cc: linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 12 Sept 2025 at 18:45, cuu <dexterkidd@gmail.com> wrote:
>
> On 25/09/13 12:23=E4=B8=8A=E5=8D=88, cuu wrote:
> > On 25/09/12 01:59=E4=B8=8B=E5=8D=88, Ulf Hansson wrote:
> > > On Sun, 24 Aug 2025 at 10:50, cuu <dexterkidd@gmail.com> wrote:
> > > >
> > > > Previously, SD cards using pure SPI protocol with mmc_spi could not
> > > > reliably detect card removal via cd-gpios. This patch fixes the iss=
ue
> > > > by extending the card alive check in _mmc_detect_card_removed() to
> > > > include cd-gpios detection.
> > > >
> > > > Additionally, mmc_rescan() now includes a status probing function
> > > > specific to SPI SD cards to ensure the card state is correctly upda=
ted
> > > > on insertion and removal events.
> > >
> > > Sorry, I don't get this.
> > >
> > > What is so special with SPI cards here that makes the regular card
> > > detection/removal procedures not to work?
> > >
> > > Is there something wrong with mmc_sd_alive()?
> > >
> > > >
> > > > Signed-off-by: cuu <dexterkidd@gmail.com>
> > >
> > > Please use a proper name for your sob line. I assume "cuu" is an alia=
s, no?
> > >
> > > Kind regards
> > > Uffe
> > >
> > > > ---
> > > >  drivers/mmc/core/core.c | 15 ++++++++++++---
> > > >  drivers/mmc/core/core.h |  1 +
> > > >  drivers/mmc/core/mmc.c  |  8 ++++++++
> > > >  3 files changed, 21 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > > > index 874c6fe92855..e028ec8fbf46 100644
> > > > --- a/drivers/mmc/core/core.c
> > > > +++ b/drivers/mmc/core/core.c
> > > > @@ -2123,6 +2123,11 @@ int _mmc_detect_card_removed(struct mmc_host=
 *host)
> > > >
> > > >         ret =3D host->bus_ops->alive(host);
> > > >
> > > > +        if(mmc_host_is_spi(host)) {
> > > > +               if(host->ops->get_cd){
> > > > +                               ret =3D !host->ops->get_cd(host);
> > > > +                }
> > > > +        }
> > > >         /*
> > > >          * Card detect status and alive check may be out of sync if=
 card is
> > > >          * removed slowly, when card detect switch changes while ca=
rd/slot
> > > > @@ -2238,9 +2243,13 @@ void mmc_rescan(struct work_struct *work)
> > > >         }
> > > >
> > > >         /* Verify a registered card to be functional, else remove i=
t. */
> > > > -       if (host->bus_ops)
> > > > -               host->bus_ops->detect(host);
> > > > -
> > > > +       if (host->bus_ops){
> > > > +               if (mmc_host_is_spi(host)){
> > > > +                       mmc_detect_mmc(host);
> > > > +               }else{
> > > > +                       host->bus_ops->detect(host);
> > > > +               }
> > > > +       }
> > > >         host->detect_change =3D 0;
> > > >
> > > >         /* if there still is a card present, stop here */
> > > > diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> > > > index 622085cd766f..5b48c50b5bb5 100644
> > > > --- a/drivers/mmc/core/core.h
> > > > +++ b/drivers/mmc/core/core.h
> > > > @@ -78,6 +78,7 @@ void _mmc_detect_change(struct mmc_host *host, un=
signed long delay,
> > > >  int _mmc_detect_card_removed(struct mmc_host *host);
> > > >  int mmc_detect_card_removed(struct mmc_host *host);
> > > >
> > > > +int mmc_detect_mmc(struct mmc_host *host);
> > > >  int mmc_attach_mmc(struct mmc_host *host);
> > > >  int mmc_attach_sd(struct mmc_host *host);
> > > >  int mmc_attach_sdio(struct mmc_host *host);
> > > > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > > > index 5be9b42d5057..e73de34e072b 100644
> > > > --- a/drivers/mmc/core/mmc.c
> > > > +++ b/drivers/mmc/core/mmc.c
> > > > @@ -2316,6 +2316,14 @@ static const struct mmc_bus_ops mmc_ops =3D =
{
> > > >         .flush_cache =3D _mmc_flush_cache,
> > > >  };
> > > >
> > > > +/*
> > > > + * Export function for mmc detection
> > > > + */
> > > > +int mmc_detect_mmc(struct mmc_host *host){
> > > > +       mmc_detect(host);
> > > > +       return 0;
> > > > +}
> > > > +
> > > >  /*
> > > >   * Starting point for MMC card init.
> > > >   */
> > > > --
> > > > 2.34.1
> > > >
> >
> > Hi Ulf
> >
> > I worked On a PicoCalc board I added an extension board for the Raspber=
ry Pi Zero 2W,
> > while still wanting the Zero 2W to access the PicoCalc=E2=80=99s own SP=
I-connected SD card.
> >
> > Here is the DTS I wrote:
> > ```
> > /dts-v1/;
> > /plugin/;
> >
> > / {
> >     compatible =3D "brcm,bcm2835";
> >
> >     fragment@0 {
> >         target =3D <&spidev0>;
> >         __overlay__ {
> >             status =3D "disabled";
> >         };
> >     };
> >
> >     fragment@1 {
> >         target =3D <&spi1>;
> >         __overlay__ {
> >             status =3D "okay";
> >
> >             #address-cells =3D <1>;
> >             #size-cells =3D <0>;
> >
> >             sdslot@0 {
> >                 compatible =3D "mmc-spi-slot";
> >                 reg =3D <0>;                        // SPI CS0
> >                 voltage-ranges =3D <3300 3300>;
> >                 spi-max-frequency =3D <8000000>;
> >                 gpios =3D <&gpio 6 1>;
> >                 cd-gpios =3D <&gpio 6 1>;
> >             };
> >         };
> >     };
> > };
> > ```

Thanks for sharing this information!

> >
> > With this setup, card insertion is detected, but removal is not.
> > From what I can tell, `mmc_sd_alive()` itself is fine, but it seems doe=
s
> > not check the state of `cd-gpios`.
> >
> > For removable SPI SD cards that provide `cd-gpios`, I believe relying o=
n
> > the `cd-gpios` state may be a more direct and accurate way to determine
> > card presence.

Sending a CMD13 to poll for the card should work as well, I think.

Or maybe there is something specific with SPI here?

> >
> > Therefore, I added a check in `_mmc_detect_card_removed()` to handle
> > the case of SPI-protocol cards with `cd-gpios`, so that removal detecti=
on
> > can work properly.

I see. I am not sure (yet), that this is really the problem.

I had a look at the mmc_spi_probe() and there are problems with the
order of how things are being registered. In general,
mmc_gpiod_request_cd() should be called *before* calling
mmc_add_host(), but I assume there are some legacy reasons as to why
this isn't the case here.

That said, can you check if you are receiving card detect/removal
interrupts and thus mmc_spi_detect_irq() should be invoked, when you
insert/remove the card?

Does the card get detected if you start without a card in the slot
when you boot and insert it later?

If you are not using the card detect interrupt, MMC_CAP_NEEDS_POLL
must be set. Can you check if this is the case?

> >
> > I am not deeply familiar with the Linux kernel, so if I am wrong
> > please  correct me. Thanks a lot.

No worries, I will try to help you as much as I can.

[...]

Kind regards
Uffe
