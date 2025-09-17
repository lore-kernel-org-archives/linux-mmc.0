Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6455B238D5A
	for <linux-mmc@vger.kernel.org>; Wed, 17 Sep 2025 07:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758094281; cv=none; b=moPBJV/z5tM3fe3LmMhkL1T5oocxYLWOpzmvudX2JE3/g47w5MyW4wT771L7jm31Qn9He+mCJfFMWbrAfPxdw2US5q04Hi0ywdNykzHonDVcSnTMxY43rn66SbEuJchEY+aojH4onnyOunb2VDRNq2htzT2/Yl6Zr2qy3ETMg8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758094281; c=relaxed/simple;
	bh=i7yMny7mmiAF2GgUdMisqEAhgu61l4K8x/cqszPlqCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o0WJdKXdeFPLQFZgfbyKydoX0RG/41NsR4ZupRrLnS8TeigLyiOqGXlvsn0SR8o3VJIKl2gucnETZTE9T5sS/dLT+eydLDlW9CQNEbN57CEKnCgzBeHNk15CV61kDXXzERm3YpsxviKJCfHb4LIGryaV8kBkRgzJzKPIFetZAqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YgybVlRz; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgybVlRz"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b5229007f31so4322953a12.2
        for <linux-mmc@vger.kernel.org>; Wed, 17 Sep 2025 00:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758094279; x=1758699079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jlioZI11AaDeh9oLRW20OK/qyEq3tkdovXIz93wpQDg=;
        b=YgybVlRzXSwDgtsf7ninxVE+pjCC0HWqgZAhLj558TCp8IPhXU58D3zVxVoQpVJpAw
         g9OjUTqx3Z+n3TV7b5e0q8PnTVQAVQw9nsZuhsk/kCw+oprgWG1L2q8aMETOCpEVMjQp
         /fvXzKEqREwMeJdZbeX+Uh5x/aU9QK9yK2lnxLi1bHzKmvE/s90525U7dRHzZUzM8Ije
         6z8MCII+icz2E8Vnb9w+AwNoFaFQqqbrI4MmwTY2qE5MQDfsHVpRZ3OsYHrPFIuYV6ML
         QLjQD48cJ8ewuXEoeoUu1g4o5kMi3NXGgCGt0GzUdHu8JfzuUtirUy1B34BBzFUdajWL
         +yIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758094279; x=1758699079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jlioZI11AaDeh9oLRW20OK/qyEq3tkdovXIz93wpQDg=;
        b=oGiI9q9IQ8Q9y0eaWEg2BxXjtwewwEzsGNdfJEe+g0Gt1oLLGjt/lP8X8kJtlFOVkt
         mzzD1kls1Wshq9jaWWqZkm0wCmV6SUes9fzOr7JH+EmLYRWYUquxeavYG345Zu3JbKup
         c9R2i40jD0NUQQIcqjpgJ7NaIK4ifSzREYEPx2bn1KtBsKUOr6p1LSiUTG9vmsWCF/GC
         6qhsqSknmqGF/FRoPToo5yMuZyM5cto3AmH0fbmZhA1HCiOXXoaN98YbE4pqoIsbdFaJ
         AHYWHaxk+q0rgpWU9houy5BaOxlZTlloCtinA+2Jyjr1eaM9d2TApf8YLYeC2xwAPvZU
         41Uw==
X-Gm-Message-State: AOJu0YzUnrsoAuKYaG42Q4J/vE4LqooPA9H1AuKRHiwIxkcT65fuilhy
	cvxubcZ5+Ml499cB0zOt+MNw9heJ0v2w5bFK2VbaH/lMXWYomLW62946k9efh0RJ6nrKaeTzntH
	jkTK1RH2L1/pS3iElHSUWxc9CY7O8rkS1yo+iMgE=
X-Gm-Gg: ASbGncvHIS24VKDhPAVi7ltCi4/O6u/UbVLstWu4mu2RO2CB/TgNzD1wm7/u0HPJWzv
	neNlXWjkqkPgJbLiYLDQkseQZEeD8E5wdmVIonW+hD04MoMkvdLlHdmz67WL9Y4iSemZ64Z6RFU
	IhDp6Z1Q4KiSbfeYT0LBR3fxykfxiT7DN94dQ3Ygq1ucWeMDFy5w3E1HFPj4m8EcrN+hVmP5Hme
	9183KCMQK/qdQG/1Qvy9LN563Ho2E8quTeWK7O1WBEpjNdEmeo=
X-Google-Smtp-Source: AGHT+IFA+E4zMXWQCg3OTlVW3Hg1cKaSuw8HU6zBWYfX5HaiWPLod33XUvXOvwiPqLRHDmT4b/5WsDlZQRIyvTk7ttg=
X-Received: by 2002:a17:903:1b43:b0:269:6811:4e5d with SMTP id
 d9443c01a7336-2696811519cmr1501395ad.30.1758094278439; Wed, 17 Sep 2025
 00:31:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250824084736.172222-1-dexterkidd@gmail.com> <CAPDyKFpobot01WBzvMUH0_85aUELhtijF9Yv9giEJSworObnbA@mail.gmail.com>
 <nyiodgyzyb6f2kkjlvjdlfflfkdccr2lgnij2uxkdm4mrpznf5@srcxlmdh47da>
 <cb4iqeqwac7pv35wbs2cwkyvdztgrfke3bzmic3nnsbuulhchv@xdfrinxazr7p> <CAPDyKFodoD58zG3tN0_WT5Ab+hH2wXkpBTCCzSXp=_-ntc4SfQ@mail.gmail.com>
In-Reply-To: <CAPDyKFodoD58zG3tN0_WT5Ab+hH2wXkpBTCCzSXp=_-ntc4SfQ@mail.gmail.com>
From: dexter K <dexterkidd@gmail.com>
Date: Wed, 17 Sep 2025 15:31:07 +0800
X-Gm-Features: AS18NWCki35N6aMiZuuO_0o2ysL2ReUITNjg8k9ooURyaM9_pAHSAEsG0z33jdo
Message-ID: <CAJQg_LrB8RmfbzmrHLHEmTJYUfyVGU5a2wxx=BdAOYssi42fvQ@mail.gmail.com>
Subject: Re: [PATCH] mmc_spi: Fix cd-gpios for SPI SD card insertion/removal detection
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 8:17=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Fri, 12 Sept 2025 at 18:45, cuu <dexterkidd@gmail.com> wrote:
> >
> > On 25/09/13 12:23=E4=B8=8A=E5=8D=88, cuu wrote:
> > > On 25/09/12 01:59=E4=B8=8B=E5=8D=88, Ulf Hansson wrote:
> > > > On Sun, 24 Aug 2025 at 10:50, cuu <dexterkidd@gmail.com> wrote:
> > > > >
> > > > > Previously, SD cards using pure SPI protocol with mmc_spi could n=
ot
> > > > > reliably detect card removal via cd-gpios. This patch fixes the i=
ssue
> > > > > by extending the card alive check in _mmc_detect_card_removed() t=
o
> > > > > include cd-gpios detection.
> > > > >
> > > > > Additionally, mmc_rescan() now includes a status probing function
> > > > > specific to SPI SD cards to ensure the card state is correctly up=
dated
> > > > > on insertion and removal events.
> > > >
> > > > Sorry, I don't get this.
> > > >
> > > > What is so special with SPI cards here that makes the regular card
> > > > detection/removal procedures not to work?
> > > >
> > > > Is there something wrong with mmc_sd_alive()?
> > > >
> > > > >
> > > > > Signed-off-by: cuu <dexterkidd@gmail.com>
> > > >
> > > > Please use a proper name for your sob line. I assume "cuu" is an al=
ias, no?
> > > >
> > > > Kind regards
> > > > Uffe
> > > >
> > > > > ---
> > > > >  drivers/mmc/core/core.c | 15 ++++++++++++---
> > > > >  drivers/mmc/core/core.h |  1 +
> > > > >  drivers/mmc/core/mmc.c  |  8 ++++++++
> > > > >  3 files changed, 21 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > > > > index 874c6fe92855..e028ec8fbf46 100644
> > > > > --- a/drivers/mmc/core/core.c
> > > > > +++ b/drivers/mmc/core/core.c
> > > > > @@ -2123,6 +2123,11 @@ int _mmc_detect_card_removed(struct mmc_ho=
st *host)
> > > > >
> > > > >         ret =3D host->bus_ops->alive(host);
> > > > >
> > > > > +        if(mmc_host_is_spi(host)) {
> > > > > +               if(host->ops->get_cd){
> > > > > +                               ret =3D !host->ops->get_cd(host);
> > > > > +                }
> > > > > +        }
> > > > >         /*
> > > > >          * Card detect status and alive check may be out of sync =
if card is
> > > > >          * removed slowly, when card detect switch changes while =
card/slot
> > > > > @@ -2238,9 +2243,13 @@ void mmc_rescan(struct work_struct *work)
> > > > >         }
> > > > >
> > > > >         /* Verify a registered card to be functional, else remove=
 it. */
> > > > > -       if (host->bus_ops)
> > > > > -               host->bus_ops->detect(host);
> > > > > -
> > > > > +       if (host->bus_ops){
> > > > > +               if (mmc_host_is_spi(host)){
> > > > > +                       mmc_detect_mmc(host);
> > > > > +               }else{
> > > > > +                       host->bus_ops->detect(host);
> > > > > +               }
> > > > > +       }
> > > > >         host->detect_change =3D 0;
> > > > >
> > > > >         /* if there still is a card present, stop here */
> > > > > diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> > > > > index 622085cd766f..5b48c50b5bb5 100644
> > > > > --- a/drivers/mmc/core/core.h
> > > > > +++ b/drivers/mmc/core/core.h
> > > > > @@ -78,6 +78,7 @@ void _mmc_detect_change(struct mmc_host *host, =
unsigned long delay,
> > > > >  int _mmc_detect_card_removed(struct mmc_host *host);
> > > > >  int mmc_detect_card_removed(struct mmc_host *host);
> > > > >
> > > > > +int mmc_detect_mmc(struct mmc_host *host);
> > > > >  int mmc_attach_mmc(struct mmc_host *host);
> > > > >  int mmc_attach_sd(struct mmc_host *host);
> > > > >  int mmc_attach_sdio(struct mmc_host *host);
> > > > > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > > > > index 5be9b42d5057..e73de34e072b 100644
> > > > > --- a/drivers/mmc/core/mmc.c
> > > > > +++ b/drivers/mmc/core/mmc.c
> > > > > @@ -2316,6 +2316,14 @@ static const struct mmc_bus_ops mmc_ops =
=3D {
> > > > >         .flush_cache =3D _mmc_flush_cache,
> > > > >  };
> > > > >
> > > > > +/*
> > > > > + * Export function for mmc detection
> > > > > + */
> > > > > +int mmc_detect_mmc(struct mmc_host *host){
> > > > > +       mmc_detect(host);
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > >  /*
> > > > >   * Starting point for MMC card init.
> > > > >   */
> > > > > --
> > > > > 2.34.1
> > > > >
> > >
> > > Hi Ulf
> > >
> > > I worked On a PicoCalc board I added an extension board for the Raspb=
erry Pi Zero 2W,
> > > while still wanting the Zero 2W to access the PicoCalc=E2=80=99s own =
SPI-connected SD card.
> > >
> > > Here is the DTS I wrote:
> > > ```
> > > /dts-v1/;
> > > /plugin/;
> > >
> > > / {
> > >     compatible =3D "brcm,bcm2835";
> > >
> > >     fragment@0 {
> > >         target =3D <&spidev0>;
> > >         __overlay__ {
> > >             status =3D "disabled";
> > >         };
> > >     };
> > >
> > >     fragment@1 {
> > >         target =3D <&spi1>;
> > >         __overlay__ {
> > >             status =3D "okay";
> > >
> > >             #address-cells =3D <1>;
> > >             #size-cells =3D <0>;
> > >
> > >             sdslot@0 {
> > >                 compatible =3D "mmc-spi-slot";
> > >                 reg =3D <0>;                        // SPI CS0
> > >                 voltage-ranges =3D <3300 3300>;
> > >                 spi-max-frequency =3D <8000000>;
> > >                 gpios =3D <&gpio 6 1>;
> > >                 cd-gpios =3D <&gpio 6 1>;
> > >             };
> > >         };
> > >     };
> > > };
> > > ```
>
> Thanks for sharing this information!
>
> > >
> > > With this setup, card insertion is detected, but removal is not.
> > > From what I can tell, `mmc_sd_alive()` itself is fine, but it seems d=
oes
> > > not check the state of `cd-gpios`.
> > >
> > > For removable SPI SD cards that provide `cd-gpios`, I believe relying=
 on
> > > the `cd-gpios` state may be a more direct and accurate way to determi=
ne
> > > card presence.
>
> Sending a CMD13 to poll for the card should work as well, I think.
>
> Or maybe there is something specific with SPI here?
>

There is nothing specific with SPI here.
I mentioned pure SPI  because I don't think any SDIO high speed based
sd card will have problems with linux mmc drivers since we used it for
a long time.

But I am facing a simple SPI (4 wire, SDA SCL VCC GND) based card slot
problem  with detecting card removal.

I think CMD13 is not enough since we have cd-gpios here , I guess
CMD13 is like to wait for it to be timeout so that the system will
think the card is gone,right ?
but if we configured cd-gpios,then why wait for CMD13 ?

> > >
> > > Therefore, I added a check in `_mmc_detect_card_removed()` to handle
> > > the case of SPI-protocol cards with `cd-gpios`, so that removal detec=
tion
> > > can work properly.
>
> I see. I am not sure (yet), that this is really the problem.
>
> I had a look at the mmc_spi_probe() and there are problems with the
> order of how things are being registered. In general,
> mmc_gpiod_request_cd() should be called *before* calling
> mmc_add_host(), but I assume there are some legacy reasons as to why
> this isn't the case here.

yeah, I guess so , so my first intention is not to break these legacy codes=
.

> That said, can you check if you are receiving card detect/removal
> interrupts and thus mmc_spi_detect_irq() should be invoked, when you
> insert/remove the card?

In default , mmc_spi_detect_irq() won't be invoked here
I've changed a little of my dts to force IRQ  happen
```
/dts-v1/;
/plugin/;

/ {
    compatible =3D "brcm,bcm2835";

   fragment@0 {
                target =3D <&spidev0>;
                __overlay__ {
                        status =3D "disabled";
                };
   };

    fragment@1 {
        target =3D <&spi1>;
        __overlay__ {
            status =3D "okay";

            #address-cells =3D <1>;
            #size-cells =3D <0>;

            sdslot@0 {
                compatible =3D "mmc-spi-slot";
                reg =3D <0>;                        // SPI CS0
                voltage-ranges =3D <3300 3300>;
                spi-max-frequency =3D <8000000>;
                gpios =3D <&gpio 6 1>;
                cd-gpios =3D <&gpio 6 1>;
                interrupts-extended =3D <&gpio 6 1>;

            };
        };
    };
};
```
added one line `interrupts-extended`
so that we can see interrupts to invoke `mmc_spi_detect_irq` with
different conditions
in dmesg | grep mmc ( I added a pr_info() in  mmc_spi_detect_irq )

* interrupts-extended =3D <&gpio 6 2>;
insert invoked mmc_spi_detect_irq()
eject did not invoke mmc_spi_detect_irq()

* interrupts-extended =3D <&gpio 6 1>;
insert invoked mmc_spi_detect_irq()
eject the first time, won't invoke  mmc_spi_detect_irq()
insert again and eject
now every time when inserting or ejecting, we can get a
mmc_spi_detect_irq() invoked
It is a little bit weird,but that is what happened here
but still, linux did not remove the node /dev/mmcblk2( my spi sd card node)

* interrupts-extended =3D <&gpio 6 3>;
same as above


> Does the card get detected if you start without a card in the slot
> when you boot and insert it later?

Yes, the sd card got detected when I inserted it after the system booted up=
.

> If you are not using the card detect interrupt, MMC_CAP_NEEDS_POLL
> must be set. Can you check if this is the case?

By default MMC_CAP_NEEDS_POLL is not enabled here  so I added one line
```
@@ -1281,6 +1282,8 @@ static int mmc_spi_probe(struct spi_device *spi)
                mmc->caps &=3D ~MMC_CAP_NEEDS_POLL;
                mmc_gpiod_request_cd_irq(mmc);
        }
+       mmc->caps |=3D MMC_CAP_NEEDS_POLL;
+
        mmc_detect_change(mmc, 0);

        /* Index 1 is write protect/read only */
```
in  mmc_spi_probe() to force it to be enabled.
and tested it without IRQ modified dts

dmesg | grep mmc  shows
```
[    9.186471] mmc_spi spi1.0: SD/MMC host mmc2, no WP, no poweroff, cd pol=
ling
[    9.234981] mmc2: host does not support reading read-only switch,
assuming write-enable
[    9.235039] mmc2: new SDHC card on SPI
[    9.238720] mmcblk2: mmc2:0000 LX32G 29.5 GiB
[    9.256975]  mmcblk2: p1 p2
[    9.263982] mmcblk2: mmc2:0000 LX32G 29.5 GiB (quirks 0x40000000)
```
as we can see , cd polling showed up

but polling is not working as we expected
nothing happened when I popped out my card, /dev/mmcblk2p* still
remains in linux.
no more other lines in dmesg ,too

> > >
> > > I am not deeply familiar with the Linux kernel, so if I am wrong
> > > please  correct me. Thanks a lot.
>
> No worries, I will try to help you as much as I can.
>
> [...]
>
> Kind regards
> Uffe

All my testings are under rpi zero 2w with
Linux PicoCalc 6.17.0-rc6-v7+ #2 SMP Wed Sep 17 15:21:08 CST 2025
armv7l GNU/Linux


Kind regards
dexter kidd
