Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0225314D20
	for <linux-mmc@vger.kernel.org>; Thu, 23 Oct 2025 13:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761226024; cv=none; b=Lv5Bg2G6GJfk+z671Vko2c9e3d1aRsjUTv8Du74THovEdKZK8yzcRfviUK89vtqCpNTFRS60A053ZSZSag0F/CB+iMjoPf5GX0ICJhf4aNDtb59nBuutagHj+it1wxgHd6A/ZNkyKnIupCd0Q+UGHQpxS97I+fO+64dWkqh3JMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761226024; c=relaxed/simple;
	bh=M/oAMP0uTJte95JsmrGl+a2ZMg/I9SR7eUc5gqd+kHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a7vQ1pCcOivT120l4tbRmDXvCSxUlZDcnd3nJXjHUWvs2OwwmYo+sF75bkWaVJ2M+tkv3bK/rMWv6dXDRkjaLM8ruyGfNpT4pikgMvQw1ubCN20o+Kzv3PjYZ5febDrAdItMm49N0LzjxeEADpJN2qfwpKPFEzrIQvDyhF7JuHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bIAjFpHz; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bIAjFpHz"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-63e1591183bso804599d50.0
        for <linux-mmc@vger.kernel.org>; Thu, 23 Oct 2025 06:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761226022; x=1761830822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdHbeL9FMaeSWSN+4vnII7Xys0y/cUm4mKiv/1TKOUw=;
        b=bIAjFpHzYl1WESg2DIxmu9NZgpr7FVlWZETBfMkCwVYlSdHKJVaOrbkip4hvAV2bER
         at7srUyh7hoMlpjR4WykXjIkB6vpLIl0mBEv2zbtKaR6RCOLVQrANaKsV0OHPJ1LXY6G
         +AxvdL6njmCbViC3CklHO5fp+mwVoxlmHGj32y4tbpwVeQsJuXmXxmlRIiDjTsLnPNHJ
         ltTlrPNoRc3B3OEi7viSMP0I7hgiGDLIyMOcCOamV70Ny6hxPgtAY7H/HA9Y4vPbGPz+
         MbX30DjYAmIUgrKsTUgVaeAk6JAcpKdsN+05bbO1WT4Dt1yljcIMZ0P1LuPRzuVIxFYF
         O8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761226022; x=1761830822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdHbeL9FMaeSWSN+4vnII7Xys0y/cUm4mKiv/1TKOUw=;
        b=l62gB9MJ7o9iuvMbrIm9ETdilvLvnMEGKnPk6ZnxSVt4lye1qyQ0jS44PtveNYGLR1
         Adnvj9Di+vpZ/L8T63Qrea6R62sn95W89ZdVmk/Sqv4zbXATKr7oLuxAyy5rrGWU9dNZ
         QBvO8cO9e8Rg99UAJNyiqftnlloDSd0PMOwg8zvsywTGMWVng4NwqOkh6FMklqod6KGK
         GunZzwsu0cm2YCsekpFIURR5fWHVxhzIPyFHkh+sWZnPDPwRCSR/eu8GO2xAUeUMgp/x
         axBzF/DGuZbsZ+8hcuoRjQAPLc+f67xqQGdgQCNu7OjzXUepSxhA76dYOcKLuebiPmyV
         d0LA==
X-Gm-Message-State: AOJu0Yw8opCQdCpkmRIgB6wu65W3qQZbXS/+IU07Pha8Be2uHgk/HyaX
	TST8v/TEAUxk12bh3idthJ2kXeweHOl2ChxvDlyPc5Kpq5eSY2hZrZECe+1jGQUGzIqXe1FJekO
	SQB8N6FqI5egfH/Ga0JnT3rhNTfWI89cNg/cZM2383qAos5d+lPns73A=
X-Gm-Gg: ASbGnctUdxr6wkd4MDN61ag+aGhYk3QQPlZcnAuhBmx7iWqrs0YmSzBl3DuELsQZChs
	eTxWT3oIPR+64b5MY5QYmvhDGP5Q6r6/305c8RwkGDLivvxkLZrend7e6QpvTuCOt96+EkbhZHK
	5RgrPT3yRzWbGdWpovS6nrYp1DdhYxWFovKRb+lxIs/ws5kzdXmncQsDpJnaLQGHNNdOtaqriqx
	0Jmek9pnodXcr5q6BTEica9c+AdEAo0mQui8rZk7Nce+T/4ZwIHScglurkfsA==
X-Google-Smtp-Source: AGHT+IEMCb9HfPz7XG+HjbZgDoNRWiJzb0/mTZNpyD6Pv32WQGbfwbBd4bBZApAg4OtimiBn4lSRgB/jGQtkfHHWsMo=
X-Received: by 2002:a53:adc2:0:b0:63c:f5a6:f2e2 with SMTP id
 956f58d0204a3-63e162702dcmr13709344d50.68.1761226021478; Thu, 23 Oct 2025
 06:27:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250824084736.172222-1-dexterkidd@gmail.com> <CAPDyKFpobot01WBzvMUH0_85aUELhtijF9Yv9giEJSworObnbA@mail.gmail.com>
 <nyiodgyzyb6f2kkjlvjdlfflfkdccr2lgnij2uxkdm4mrpznf5@srcxlmdh47da>
 <cb4iqeqwac7pv35wbs2cwkyvdztgrfke3bzmic3nnsbuulhchv@xdfrinxazr7p>
 <CAPDyKFodoD58zG3tN0_WT5Ab+hH2wXkpBTCCzSXp=_-ntc4SfQ@mail.gmail.com> <CAJQg_LrB8RmfbzmrHLHEmTJYUfyVGU5a2wxx=BdAOYssi42fvQ@mail.gmail.com>
In-Reply-To: <CAJQg_LrB8RmfbzmrHLHEmTJYUfyVGU5a2wxx=BdAOYssi42fvQ@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 23 Oct 2025 15:26:24 +0200
X-Gm-Features: AS18NWBETm0qH9UiMd3gcHjUPsPOaUQtsjiJI8pw5oQR04PvPuXextzbv5Dvgt0
Message-ID: <CAPDyKFp2FOBLy-VWmHxAm8odcW3st4uh3BMqzKuSTuZ-W+KN8A@mail.gmail.com>
Subject: Re: [PATCH] mmc_spi: Fix cd-gpios for SPI SD card insertion/removal detection
To: dexter K <dexterkidd@gmail.com>
Cc: linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Sept 2025 at 09:31, dexter K <dexterkidd@gmail.com> wrote:
>
> On Mon, Sep 15, 2025 at 8:17=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> >
> > On Fri, 12 Sept 2025 at 18:45, cuu <dexterkidd@gmail.com> wrote:
> > >
> > > On 25/09/13 12:23=E4=B8=8A=E5=8D=88, cuu wrote:
> > > > On 25/09/12 01:59=E4=B8=8B=E5=8D=88, Ulf Hansson wrote:
> > > > > On Sun, 24 Aug 2025 at 10:50, cuu <dexterkidd@gmail.com> wrote:
> > > > > >
> > > > > > Previously, SD cards using pure SPI protocol with mmc_spi could=
 not
> > > > > > reliably detect card removal via cd-gpios. This patch fixes the=
 issue
> > > > > > by extending the card alive check in _mmc_detect_card_removed()=
 to
> > > > > > include cd-gpios detection.
> > > > > >
> > > > > > Additionally, mmc_rescan() now includes a status probing functi=
on
> > > > > > specific to SPI SD cards to ensure the card state is correctly =
updated
> > > > > > on insertion and removal events.
> > > > >
> > > > > Sorry, I don't get this.
> > > > >
> > > > > What is so special with SPI cards here that makes the regular car=
d
> > > > > detection/removal procedures not to work?
> > > > >
> > > > > Is there something wrong with mmc_sd_alive()?
> > > > >
> > > > > >
> > > > > > Signed-off-by: cuu <dexterkidd@gmail.com>
> > > > >
> > > > > Please use a proper name for your sob line. I assume "cuu" is an =
alias, no?
> > > > >
> > > > > Kind regards
> > > > > Uffe
> > > > >
> > > > > > ---
> > > > > >  drivers/mmc/core/core.c | 15 ++++++++++++---
> > > > > >  drivers/mmc/core/core.h |  1 +
> > > > > >  drivers/mmc/core/mmc.c  |  8 ++++++++
> > > > > >  3 files changed, 21 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > > > > > index 874c6fe92855..e028ec8fbf46 100644
> > > > > > --- a/drivers/mmc/core/core.c
> > > > > > +++ b/drivers/mmc/core/core.c
> > > > > > @@ -2123,6 +2123,11 @@ int _mmc_detect_card_removed(struct mmc_=
host *host)
> > > > > >
> > > > > >         ret =3D host->bus_ops->alive(host);
> > > > > >
> > > > > > +        if(mmc_host_is_spi(host)) {
> > > > > > +               if(host->ops->get_cd){
> > > > > > +                               ret =3D !host->ops->get_cd(host=
);
> > > > > > +                }
> > > > > > +        }
> > > > > >         /*
> > > > > >          * Card detect status and alive check may be out of syn=
c if card is
> > > > > >          * removed slowly, when card detect switch changes whil=
e card/slot
> > > > > > @@ -2238,9 +2243,13 @@ void mmc_rescan(struct work_struct *work=
)
> > > > > >         }
> > > > > >
> > > > > >         /* Verify a registered card to be functional, else remo=
ve it. */
> > > > > > -       if (host->bus_ops)
> > > > > > -               host->bus_ops->detect(host);
> > > > > > -
> > > > > > +       if (host->bus_ops){
> > > > > > +               if (mmc_host_is_spi(host)){
> > > > > > +                       mmc_detect_mmc(host);
> > > > > > +               }else{
> > > > > > +                       host->bus_ops->detect(host);
> > > > > > +               }
> > > > > > +       }
> > > > > >         host->detect_change =3D 0;
> > > > > >
> > > > > >         /* if there still is a card present, stop here */
> > > > > > diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> > > > > > index 622085cd766f..5b48c50b5bb5 100644
> > > > > > --- a/drivers/mmc/core/core.h
> > > > > > +++ b/drivers/mmc/core/core.h
> > > > > > @@ -78,6 +78,7 @@ void _mmc_detect_change(struct mmc_host *host=
, unsigned long delay,
> > > > > >  int _mmc_detect_card_removed(struct mmc_host *host);
> > > > > >  int mmc_detect_card_removed(struct mmc_host *host);
> > > > > >
> > > > > > +int mmc_detect_mmc(struct mmc_host *host);
> > > > > >  int mmc_attach_mmc(struct mmc_host *host);
> > > > > >  int mmc_attach_sd(struct mmc_host *host);
> > > > > >  int mmc_attach_sdio(struct mmc_host *host);
> > > > > > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > > > > > index 5be9b42d5057..e73de34e072b 100644
> > > > > > --- a/drivers/mmc/core/mmc.c
> > > > > > +++ b/drivers/mmc/core/mmc.c
> > > > > > @@ -2316,6 +2316,14 @@ static const struct mmc_bus_ops mmc_ops =
=3D {
> > > > > >         .flush_cache =3D _mmc_flush_cache,
> > > > > >  };
> > > > > >
> > > > > > +/*
> > > > > > + * Export function for mmc detection
> > > > > > + */
> > > > > > +int mmc_detect_mmc(struct mmc_host *host){
> > > > > > +       mmc_detect(host);
> > > > > > +       return 0;
> > > > > > +}
> > > > > > +
> > > > > >  /*
> > > > > >   * Starting point for MMC card init.
> > > > > >   */
> > > > > > --
> > > > > > 2.34.1
> > > > > >
> > > >
> > > > Hi Ulf
> > > >
> > > > I worked On a PicoCalc board I added an extension board for the Ras=
pberry Pi Zero 2W,
> > > > while still wanting the Zero 2W to access the PicoCalc=E2=80=99s ow=
n SPI-connected SD card.
> > > >
> > > > Here is the DTS I wrote:
> > > > ```
> > > > /dts-v1/;
> > > > /plugin/;
> > > >
> > > > / {
> > > >     compatible =3D "brcm,bcm2835";
> > > >
> > > >     fragment@0 {
> > > >         target =3D <&spidev0>;
> > > >         __overlay__ {
> > > >             status =3D "disabled";
> > > >         };
> > > >     };
> > > >
> > > >     fragment@1 {
> > > >         target =3D <&spi1>;
> > > >         __overlay__ {
> > > >             status =3D "okay";
> > > >
> > > >             #address-cells =3D <1>;
> > > >             #size-cells =3D <0>;
> > > >
> > > >             sdslot@0 {
> > > >                 compatible =3D "mmc-spi-slot";
> > > >                 reg =3D <0>;                        // SPI CS0
> > > >                 voltage-ranges =3D <3300 3300>;
> > > >                 spi-max-frequency =3D <8000000>;
> > > >                 gpios =3D <&gpio 6 1>;
> > > >                 cd-gpios =3D <&gpio 6 1>;
> > > >             };
> > > >         };
> > > >     };
> > > > };
> > > > ```
> >
> > Thanks for sharing this information!
> >
> > > >
> > > > With this setup, card insertion is detected, but removal is not.
> > > > From what I can tell, `mmc_sd_alive()` itself is fine, but it seems=
 does
> > > > not check the state of `cd-gpios`.
> > > >
> > > > For removable SPI SD cards that provide `cd-gpios`, I believe relyi=
ng on
> > > > the `cd-gpios` state may be a more direct and accurate way to deter=
mine
> > > > card presence.
> >
> > Sending a CMD13 to poll for the card should work as well, I think.
> >
> > Or maybe there is something specific with SPI here?
> >
>
> There is nothing specific with SPI here.
> I mentioned pure SPI  because I don't think any SDIO high speed based
> sd card will have problems with linux mmc drivers since we used it for
> a long time.
>
> But I am facing a simple SPI (4 wire, SDA SCL VCC GND) based card slot
> problem  with detecting card removal.
>
> I think CMD13 is not enough since we have cd-gpios here , I guess
> CMD13 is like to wait for it to be timeout so that the system will
> think the card is gone,right ?

Correct!

> but if we configured cd-gpios,then why wait for CMD13 ?

CMD13 should be really quick, even in the timeout case we should only
wait for a few us.

Of course, if there is a problem with the mmc host controller/driver,
the timeout could be longer.

>
> > > >
> > > > Therefore, I added a check in `_mmc_detect_card_removed()` to handl=
e
> > > > the case of SPI-protocol cards with `cd-gpios`, so that removal det=
ection
> > > > can work properly.
> >
> > I see. I am not sure (yet), that this is really the problem.
> >
> > I had a look at the mmc_spi_probe() and there are problems with the
> > order of how things are being registered. In general,
> > mmc_gpiod_request_cd() should be called *before* calling
> > mmc_add_host(), but I assume there are some legacy reasons as to why
> > this isn't the case here.
>
> yeah, I guess so , so my first intention is not to break these legacy cod=
es.
>
> > That said, can you check if you are receiving card detect/removal
> > interrupts and thus mmc_spi_detect_irq() should be invoked, when you
> > insert/remove the card?
>
> In default , mmc_spi_detect_irq() won't be invoked here
> I've changed a little of my dts to force IRQ  happen
> ```
> /dts-v1/;
> /plugin/;
>
> / {
>     compatible =3D "brcm,bcm2835";
>
>    fragment@0 {
>                 target =3D <&spidev0>;
>                 __overlay__ {
>                         status =3D "disabled";
>                 };
>    };
>
>     fragment@1 {
>         target =3D <&spi1>;
>         __overlay__ {
>             status =3D "okay";
>
>             #address-cells =3D <1>;
>             #size-cells =3D <0>;
>
>             sdslot@0 {
>                 compatible =3D "mmc-spi-slot";
>                 reg =3D <0>;                        // SPI CS0
>                 voltage-ranges =3D <3300 3300>;
>                 spi-max-frequency =3D <8000000>;
>                 gpios =3D <&gpio 6 1>;
>                 cd-gpios =3D <&gpio 6 1>;
>                 interrupts-extended =3D <&gpio 6 1>;
>
>             };
>         };
>     };
> };
> ```
> added one line `interrupts-extended`
> so that we can see interrupts to invoke `mmc_spi_detect_irq` with
> different conditions
> in dmesg | grep mmc ( I added a pr_info() in  mmc_spi_detect_irq )
>
> * interrupts-extended =3D <&gpio 6 2>;
> insert invoked mmc_spi_detect_irq()
> eject did not invoke mmc_spi_detect_irq()
>
> * interrupts-extended =3D <&gpio 6 1>;
> insert invoked mmc_spi_detect_irq()
> eject the first time, won't invoke  mmc_spi_detect_irq()
> insert again and eject
> now every time when inserting or ejecting, we can get a
> mmc_spi_detect_irq() invoked
> It is a little bit weird,but that is what happened here
> but still, linux did not remove the node /dev/mmcblk2( my spi sd card nod=
e)

Okay, so if we are not receiving an irq at card-removal this becomes a
problem. If it's because of GPIO or pinctrl settings needs to be
adjusted, I can't tell, because of limited HW knowledge in this case.

Nevertheless, if there are no irq available, we should fallback to
using the polling mode with CMD13 (MMC_CAP_NEEDS_POLL).

That said, to me, it looks like we should start by trying to make the
polling mode work first. If it doesn't, we need to understand why.

>
> * interrupts-extended =3D <&gpio 6 3>;
> same as above
>
>
> > Does the card get detected if you start without a card in the slot
> > when you boot and insert it later?
>
> Yes, the sd card got detected when I inserted it after the system booted =
up.
>
> > If you are not using the card detect interrupt, MMC_CAP_NEEDS_POLL
> > must be set. Can you check if this is the case?
>
> By default MMC_CAP_NEEDS_POLL is not enabled here  so I added one line
> ```
> @@ -1281,6 +1282,8 @@ static int mmc_spi_probe(struct spi_device *spi)
>                 mmc->caps &=3D ~MMC_CAP_NEEDS_POLL;
>                 mmc_gpiod_request_cd_irq(mmc);
>         }
> +       mmc->caps |=3D MMC_CAP_NEEDS_POLL;
> +

This needs to be set before calling mmc_add_host(). And beyond that,
make sure we don't request for GPIO irq (don't call
mmc_gpiod_request_cd_irq()), to make sure we only test polling mode
separately.

Moreover, you may need to make changes in
drivers/mmc/host/of_mmc_spi.c to avoid this too. Huh, this code is
messy, sorry!

>         mmc_detect_change(mmc, 0);
>
>         /* Index 1 is write protect/read only */
> ```
> in  mmc_spi_probe() to force it to be enabled.
> and tested it without IRQ modified dts
>
> dmesg | grep mmc  shows
> ```
> [    9.186471] mmc_spi spi1.0: SD/MMC host mmc2, no WP, no poweroff, cd p=
olling
> [    9.234981] mmc2: host does not support reading read-only switch,
> assuming write-enable
> [    9.235039] mmc2: new SDHC card on SPI
> [    9.238720] mmcblk2: mmc2:0000 LX32G 29.5 GiB
> [    9.256975]  mmcblk2: p1 p2
> [    9.263982] mmcblk2: mmc2:0000 LX32G 29.5 GiB (quirks 0x40000000)
> ```
> as we can see , cd polling showed up
>
> but polling is not working as we expected
> nothing happened when I popped out my card, /dev/mmcblk2p* still
> remains in linux.
> no more other lines in dmesg ,too

Could it be that the CMD13 is hanging when there is no card inserted
in the spi-slot?

>
> > > >
> > > > I am not deeply familiar with the Linux kernel, so if I am wrong
> > > > please  correct me. Thanks a lot.
> >
> > No worries, I will try to help you as much as I can.
> >
> > [...]
> >
> > Kind regards
> > Uffe
>
> All my testings are under rpi zero 2w with
> Linux PicoCalc 6.17.0-rc6-v7+ #2 SMP Wed Sep 17 15:21:08 CST 2025
> armv7l GNU/Linux
>
>
> Kind regards
> dexter kidd

Apologize for the delay!

Kind regards
Uffe
