Return-Path: <SRS0=v+1n=B7=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F50C433E1
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Aug 2020 09:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57CDE208DB
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Aug 2020 09:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tic4VOYG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgHUJTM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 21 Aug 2020 05:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgHUJTK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Aug 2020 05:19:10 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0110C061385;
        Fri, 21 Aug 2020 02:19:10 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id m200so684531ybf.10;
        Fri, 21 Aug 2020 02:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=giJS01C2uRmkcBNmO7mS9KtwK43uwMA7OS6WWAjaKvI=;
        b=tic4VOYGe4Kp/x0I7VNK3QiuSOWdPzpfxMoWOnXJ7e6FPgCzwBT6zhRkB8aHSTTxFL
         c4AbcRvayex5ykHsbjxYAZoj5+zn8vnCKpk+8ii04gzff2VztDe2vUGgMb5A/NWyBFvN
         P6dCv3/xd3c8/n0VJgC2zrcLjm6JFoj/m0PiIiz2uqmnDtialqv4NtdDY7sYfLaakT/M
         3TnlBC1fiHHbRHgAeMf5a2RSWvjM4beJGpzXGpk3Izqc/6efsK/QC1tpgvuVVFU87F7S
         vTESbFSddJN8Wb+dTeI02MzC95cWqPqDkMQxyOvkp2m9KdvtKQDvRtV0ElOkmXHH6UpH
         yhvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=giJS01C2uRmkcBNmO7mS9KtwK43uwMA7OS6WWAjaKvI=;
        b=eUdcV1tA8i5ozZ9kMczI9CawZxSU+ir6Ip6ota8egq0e5rCL+UUZto5AObB+yHJwmh
         NefvtBrDW2rsWGjn6RBG8Be0KHF89F/vO429GQsG93HJIQJgTxZ8g9qIWzb2+LVBjhbz
         JarbfHCUTJJZZKK7Xg8RTec2XX0y71txzbzjNQmu6uvoFMjv0LgBy/5Y6Xc5jgu554Mw
         5bdBsHg6yhLQXMQ7d2bayhXKehk3QEYNL1AKBXFoeXz+45lmMp83/MHAeRolLrkv0Uau
         ptqFjOwr50zJDmJPqkTCjudLMGrZVfWmm3Giw95parufmXMG2rBLO29oBL9lJwSzUCVX
         N7qA==
X-Gm-Message-State: AOAM531AF/KNufxdnqtDE2AQTnO0aB2LoOYO+QADaS/fVuGy4tyEUz3v
        uhuHVZCbRPGwTYhVO7a2bVG6lUo4dJksy3le7Uc=
X-Google-Smtp-Source: ABdhPJzIgpqXFC8gbAcWn5p5M0LTP7U4xnkTWUlz29pKX9vsKGxNrpgUbSpg27/nBWhaPt/n0NvrA5eLtoF0eDDeVXs=
X-Received: by 2002:a5b:d08:: with SMTP id y8mr2654456ybp.476.1598001549861;
 Fri, 21 Aug 2020 02:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200710110819.28965-1-benchuanggli@gmail.com>
 <CAPDyKFrvzZSYWkqD_JgZSCmF8p+Bj7JXfdbZ5D=OsszTPsSDdw@mail.gmail.com>
 <CACT4zj989TsK9CMtPwEVOwBr-HtLVqQyt_EPAdkEexGuGNfatQ@mail.gmail.com> <CAPDyKFqpy-+sL-8ai2v-Br1n8MC88u3wTF7r=8Lt3qyLwCxRKg@mail.gmail.com>
In-Reply-To: <CAPDyKFqpy-+sL-8ai2v-Br1n8MC88u3wTF7r=8Lt3qyLwCxRKg@mail.gmail.com>
From:   Ben Chuang <benchuanggli@gmail.com>
Date:   Fri, 21 Aug 2020 17:18:58 +0800
Message-ID: <CACT4zj-W2EECQgMTQ=VoaFZdQfVgWer-sEWqnqpfNG25FT-xLw@mail.gmail.com>
Subject: Re: [RFC PATCH V3 02/21] mmc: core: UHS-II support, modify power-up sequence
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Takahiro Akashi <takahiro.akashi@linaro.org>,
        greg.tu@genesyslogic.com.tw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Jul 24, 2020 at 8:36 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 24 Jul 2020 at 13:11, Ben Chuang <benchuanggli@gmail.com> wrote:
> >
> > Hi Ulf,
> >
> > On Fri, Jul 17, 2020 at 7:26 PM Ulf Hansson <ulf.hansson@linaro.org> wr=
ote:
> > >
> > > On Fri, 10 Jul 2020 at 13:07, Ben Chuang <benchuanggli@gmail.com> wro=
te:
> > > >
> > > > From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > >
> > > > According to Fig. 3-35 in "SD Host Controller Simplified Spec. Ver4=
.20":
> > > > - Prepare vdd1, vdd2 and ios.timing for using after/in step (2)
> > > > - chip_select is not used in UHS-II, used to return to the legacy f=
low
> > >
> > > Thanks for pointing to the spec, but please explain why/what/how for
> > > the change - as this helps me to review.
> > >
> > > I am going to stop commenting on each patch's commit message, beyond
> > > this patch - as it seems the same comment applies to more patches.
> > >
> > > >
> > > > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > > > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > > ---
> > > >  drivers/mmc/core/core.c      | 62 ++++++++++++++++++++++++--------=
----
> > > >  drivers/mmc/core/regulator.c | 14 ++++++++
> > > >  2 files changed, 56 insertions(+), 20 deletions(-)
> > > >
> > > > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > > > index 8d2b808e9b58..85c83c82ad0c 100644
> > > > --- a/drivers/mmc/core/core.c
> > > > +++ b/drivers/mmc/core/core.c
> > > > @@ -1315,33 +1315,51 @@ void mmc_power_up(struct mmc_host *host, u3=
2 ocr)
> > > >         if (host->ios.power_mode =3D=3D MMC_POWER_ON)
> > > >                 return;
> > > >
> > > > -       mmc_pwrseq_pre_power_on(host);
> > > > +       if (host->flags & MMC_UHS2_SUPPORT) {
> > > > +               /* TODO: handle 'ocr' parameter */
> > > > +               host->ios.vdd =3D fls(host->ocr_avail) - 1;
> > > > +               host->ios.vdd2 =3D fls(host->ocr_avail_uhs2) - 1;
> > > > +               if (mmc_host_is_spi(host))
> > > > +                       host->ios.chip_select =3D MMC_CS_HIGH;
> > > > +               else
> > > > +                       host->ios.chip_select =3D MMC_CS_DONTCARE;
> > > > +               host->ios.timing =3D MMC_TIMING_UHS2;
> > >
> > > If I understand correctly, the intent is to always try to initialize
> > > the UHS-II interface/phy if that is supported. That doesn't seem
> > > correct to me. What about if the SD card doesn't support UHS-II, then
> > > we should use the legacy SD interface instead right?
> >
> > Please always try UHS-II I/F first, then if UHS-II I/F fails, then
> > switch to SD I/F.
> >
> > >
> > > Or perhaps the MMC_UHS2_SUPPORT bit becomes cleared somewhere in the
> > > error path when first trying to initialize an UHS-II card, from
> > > subsequent changes?
> >
> > Yes, MMC_UHS2_SUPPORT will be cleared in some cases.
> >
> > >
> > > So, assuming that is the intent then, I am still not sure about this =
approach.
> > >
> > > What about if we instead always start with legacy SD initialization?
> > > When we have read the OCR register, via mmc_send_app_op_cond(), we ca=
n
> > > check if the card supports UHS-II by looking at the UHS-II Card Statu=
s
> > > (bit 29).
> >
> > UHS-II spec recommends to detect UHS-II first.
> > Or in Host controller spec, section 3.13.2 card interface detection seq=
uence,
> > it also starts from UHS-II path, then go SD legacy path if UHS-II
> > initialization fails.
>
> I have carefully read the specs. While you are right, that the flow
> charts seem to prefer to start with UHS-II - I don't think it's a good
> idea.
>
> Have a look at "7.2.3.2 Interface Selection after Power Up", in the
> UHS-II Addendum Version 2.00. This section states this:
>
> "If Host intends to use only Legacy SD interface or detects that
> Legacy SD Card is inserted, it is allowed to supply only VDD1 and
> SDCLK, and issue CMD8 in order to accelerate initialization of Legacy
> SD interface. Note that once UHS-II I/F is disabled, Host requires
> power cycle to enable UHS-II again."
>
> That said, I am also concerned about the case when a bootloader has
> initialized the SD card. When the kernel tries to re-initialize the
> card during boot, it may fail with UHS-II - unless the legacy SD init
> path is tried first.
>
> >
> > The bit29 in response of ACMD41 is defined as =E2=80=9CUHS-II Card Stat=
us=E2=80=9D,
> > not UHS-II supported.
> > We have experience using this value to determine whether a card support=
s UHS-II,
> > but not every card reports if they support UHS-II by the response of
> > ACMD41 correctly.
>
> I see.
>
> If that is the case, I think we should invent an SD quirk for that
> particular card. Along the lines of what already exists for SDIO and
> eMMC.
>
> So, when a card with this kind of quirk is found, we should simply
> bail out in the SD legacy init path and try the UHS-II path instead.
>
> What card have you found missing to set the bit29?

In my hand, two uhs-ii cards, one is a Lexar  card and another is an ADATA =
card.

>
> >
> > >
> > > If it turns out that the card supports UHS-II and the host does as
> > > well, then we do a mmc_power_off() to completely reset the
> > > card/host/phy. Then we can call into a UHS-II specific path, that
> > > tries to power on and initialize things according to the UHS-II spec.
> > >
> > > In this way, we are going to prioritize initialization of legacy SD
> > > cards to remain quick, as we won't try to use UHS-II unless the card
> > > supports it. Moreover, I get the impression that we can keep the
> > > existing code more as is - and instead introduce UHS-II specifics in =
a
> > > separate path. This also also for UHS-II specific optimizations, I
> > > think.
> >
> > Agree that we can try to keep the existing code and also need your advi=
ce/help.
>
> Sure, I will help the best I can.
>
> I will have a look at the next patch in the series as well, but it may
> take some time as I am currently trying to get some time off for
> holidays.
>
> >
> > >
> > > > +       } else {
> > > > +               mmc_pwrseq_pre_power_on(host);
> > > >
> > > > -       host->ios.vdd =3D fls(ocr) - 1;
> > > > -       host->ios.power_mode =3D MMC_POWER_UP;
> > > > -       /* Set initial state and call mmc_set_ios */
> > > > -       mmc_set_initial_state(host);
> > > > +               host->ios.vdd =3D fls(ocr) - 1;
> > > > +               host->ios.power_mode =3D MMC_POWER_UP;
> > > > +               /* Set initial state and call mmc_set_ios */
> > > > +               mmc_set_initial_state(host);
> > > >
> > > > -       mmc_set_initial_signal_voltage(host);
> > > > +               mmc_set_initial_signal_voltage(host);
> > > >
> > > > -       /*
> > > > -        * This delay should be sufficient to allow the power suppl=
y
> > > > -        * to reach the minimum voltage.
> > > > -        */
> > > > -       mmc_delay(host->ios.power_delay_ms);
> > > > -
> > > > -       mmc_pwrseq_post_power_on(host);
> > > > +               /*
> > > > +                * This delay should be sufficient to allow the pow=
er supply
> > > > +                * to reach the minimum voltage.
> > > > +                */
> > > > +               mmc_delay(host->ios.power_delay_ms);
> > > >
> > > > +               mmc_pwrseq_post_power_on(host);
> > > > +       }
> > > >         host->ios.clock =3D host->f_init;
> > > > -
> > > >         host->ios.power_mode =3D MMC_POWER_ON;
> > > > +
> > > >         mmc_set_ios(host);
> > > >
> > > > -       /*
> > > > -        * This delay must be at least 74 clock sizes, or 1 ms, or =
the
> > > > -        * time required to reach a stable voltage.
> > > > -        */
> > > > -       mmc_delay(host->ios.power_delay_ms);
> > > > +       if (host->flags & MMC_UHS2_SUPPORT)
> > > > +               /*
> > > > +                * This delay should be sufficient to allow the pow=
er supply
> > > > +                * to reach the minimum voltage.
> > > > +                */
> > > > +               /*  TODO: avoid an immediate value */
> > > > +               mmc_delay(10);
> > > > +       else
> > > > +               /*
> > > > +                * This delay must be at least 74 clock sizes, or 1=
 ms, or the
> > > > +                * time required to reach a stable voltage.
> > > > +                */
> > > > +               mmc_delay(host->ios.power_delay_ms);
> > > >  }
> > > >
> > > >  void mmc_power_off(struct mmc_host *host)
> > > > @@ -2307,7 +2325,11 @@ void mmc_start_host(struct mmc_host *host)
> > > >
> > > >         if (!(host->caps2 & MMC_CAP2_NO_PRESCAN_POWERUP)) {
> > > >                 mmc_claim_host(host);
> > > > -               mmc_power_up(host, host->ocr_avail);
> > > > +
> > > > +               /* Power up here will make UHS2 init ugly. */
> > > > +               if (!(host->caps & MMC_CAP_UHS2))
> > > > +                       mmc_power_up(host, host->ocr_avail);
> > > > +
> > >
> > > According to my suggestions, then this would not be needed.
> >
> > This should not be needed. Thank you.
> >
> > >
> > > >                 mmc_release_host(host);
> > > >         }
> > > >
> > > > diff --git a/drivers/mmc/core/regulator.c b/drivers/mmc/core/regula=
tor.c
> > > > index 96b1d15045d6..05556225d9ac 100644
> > > > --- a/drivers/mmc/core/regulator.c
> > > > +++ b/drivers/mmc/core/regulator.c
> > > > @@ -247,6 +247,7 @@ int mmc_regulator_get_supply(struct mmc_host *m=
mc)
> > > >
> > > >         mmc->supply.vmmc =3D devm_regulator_get_optional(dev, "vmmc=
");
> > > >         mmc->supply.vqmmc =3D devm_regulator_get_optional(dev, "vqm=
mc");
> > > > +       mmc->supply.vmmc2 =3D devm_regulator_get_optional(dev, "vmm=
c2");
> > >
> > > Please move the regulator thingy here into a separate patch. Please
> > > make sure corresponding header file, adding the vmmc2 to it is part o=
f
> > > that change as well.
> >
> > Yes. will do it.
> >
> > >
> > > >
> > > >         if (IS_ERR(mmc->supply.vmmc)) {
> > > >                 if (PTR_ERR(mmc->supply.vmmc) =3D=3D -EPROBE_DEFER)
> > > > @@ -266,6 +267,19 @@ int mmc_regulator_get_supply(struct mmc_host *=
mmc)
> > > >                 dev_dbg(dev, "No vqmmc regulator found\n");
> > > >         }
> > > >
> > > > +       if (IS_ERR(mmc->supply.vmmc2)) {
> > > > +               if (PTR_ERR(mmc->supply.vmmc2) =3D=3D -EPROBE_DEFER=
)
> > > > +                       return -EPROBE_DEFER;
> > > > +               dev_dbg(dev, "No vmmc2 regulator found\n");
> > > > +       } else {
> > > > +               ret =3D mmc_regulator_get_ocrmask(mmc->supply.vmmc2=
);
> > > > +               if (ret > 0)
> > > > +                       mmc->ocr_avail_uhs2 =3D ret;
> > > > +               else
> > > > +                       dev_warn(dev, "Failed getting UHS2 OCR mask=
: %d\n",
> > > > +                                ret);
> > > > +       }
> > > > +
> > > >         return 0;
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(mmc_regulator_get_supply);
> > > > --
> > > > 2.27.0
> > > >
>
> Kind regards
> Uffe
