Return-Path: <SRS0=uUZJ=BD=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3CDC433E0
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Jul 2020 11:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 439B52067D
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Jul 2020 11:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RujcnQvx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgGXLLz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Jul 2020 07:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbgGXLLz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Jul 2020 07:11:55 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56083C0619D3;
        Fri, 24 Jul 2020 04:11:55 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id m200so333333ybf.10;
        Fri, 24 Jul 2020 04:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=htaMFQv6j45WJ6fZ3EjiD70wvvoteJc0c7HebPkEhfg=;
        b=RujcnQvxZ+0p91/6LzmjxdMCg9qgoo1LnOvQ6E9Xn3YVfGuvULZMEqa3hcqyXMKWgg
         gvxS1PBVwmfFT7tFumTekROjlQ6/mh6QGV40pwCFQYUaBsOeRDZgaohKQSuokkIIOH+B
         OBs/0HDIINdtBEhiadXj6X574Z4bpF2l83sxc3SIKrUgdg/deU5IE5FIAr/dRUCSzX6l
         HmUYwjfLv+ZDlawnNy47Oa7odVVwCvbVZWFyljUqOtJM84hWTUYscHtvNROBgPjMUJFK
         dBULMqEAHp+awXF/eEUABKoy92OVWCAvm1FgYgoEftdrrMughNjPOMA3lS4kF9PnMhUr
         8DPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=htaMFQv6j45WJ6fZ3EjiD70wvvoteJc0c7HebPkEhfg=;
        b=ZjPP0PpYCIl9Zyx0V0nhqeERUoY/gKk9LH+AUrS7tpv7qBFlXY1ISt98ox8mzYQZu+
         dGbpIn5vZLtHCdbcUm58c8n15yyrJ6dI9EVUVWlc3k2JlSrkHBq6ATKhyBECl9nd13xO
         XUjY0fAs+EMFyaM9KPLDa5kgzuOlQMchC85Y/63b05cgBUUJzIMl32iv6eBDIiBU6EEB
         TFeA75t6dGO3m3RBzUShfqk+eSo9NtQ+hkRUD0+q1BtqJByrwzFzPCK1j01/c2d8w0TR
         BwhuBrPCUMA7ee8p41Hkc1UT892RD2LSW5A6IiRGsjJ9UTsBy5IBGS8z7VzkJnU4auXf
         JvhA==
X-Gm-Message-State: AOAM533XWkkxDrpWci5YCGXByQua/11lIiMuziABIjo/O0btu2P1pDSY
        /loHuWuDGUI2g0BCpjMnCvEjrYAmb9P4gkMWvyXnu5QLOlo=
X-Google-Smtp-Source: ABdhPJw5lojxc4r8bGD8PdOjcc4Y5hWe8K//DOz17/ak0S0v82nUVyUKE8mZ5gHxAoMx3YsNmmun0b99nkz9zZymKJg=
X-Received: by 2002:a25:7811:: with SMTP id t17mr14123847ybc.48.1595589114372;
 Fri, 24 Jul 2020 04:11:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200710110819.28965-1-benchuanggli@gmail.com> <CAPDyKFrvzZSYWkqD_JgZSCmF8p+Bj7JXfdbZ5D=OsszTPsSDdw@mail.gmail.com>
In-Reply-To: <CAPDyKFrvzZSYWkqD_JgZSCmF8p+Bj7JXfdbZ5D=OsszTPsSDdw@mail.gmail.com>
From:   Ben Chuang <benchuanggli@gmail.com>
Date:   Fri, 24 Jul 2020 19:11:56 +0800
Message-ID: <CACT4zj989TsK9CMtPwEVOwBr-HtLVqQyt_EPAdkEexGuGNfatQ@mail.gmail.com>
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

Hi Ulf,

On Fri, Jul 17, 2020 at 7:26 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 10 Jul 2020 at 13:07, Ben Chuang <benchuanggli@gmail.com> wrote:
> >
> > From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >
> > According to Fig. 3-35 in "SD Host Controller Simplified Spec. Ver4.20"=
:
> > - Prepare vdd1, vdd2 and ios.timing for using after/in step (2)
> > - chip_select is not used in UHS-II, used to return to the legacy flow
>
> Thanks for pointing to the spec, but please explain why/what/how for
> the change - as this helps me to review.
>
> I am going to stop commenting on each patch's commit message, beyond
> this patch - as it seems the same comment applies to more patches.
>
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> >  drivers/mmc/core/core.c      | 62 ++++++++++++++++++++++++------------
> >  drivers/mmc/core/regulator.c | 14 ++++++++
> >  2 files changed, 56 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > index 8d2b808e9b58..85c83c82ad0c 100644
> > --- a/drivers/mmc/core/core.c
> > +++ b/drivers/mmc/core/core.c
> > @@ -1315,33 +1315,51 @@ void mmc_power_up(struct mmc_host *host, u32 oc=
r)
> >         if (host->ios.power_mode =3D=3D MMC_POWER_ON)
> >                 return;
> >
> > -       mmc_pwrseq_pre_power_on(host);
> > +       if (host->flags & MMC_UHS2_SUPPORT) {
> > +               /* TODO: handle 'ocr' parameter */
> > +               host->ios.vdd =3D fls(host->ocr_avail) - 1;
> > +               host->ios.vdd2 =3D fls(host->ocr_avail_uhs2) - 1;
> > +               if (mmc_host_is_spi(host))
> > +                       host->ios.chip_select =3D MMC_CS_HIGH;
> > +               else
> > +                       host->ios.chip_select =3D MMC_CS_DONTCARE;
> > +               host->ios.timing =3D MMC_TIMING_UHS2;
>
> If I understand correctly, the intent is to always try to initialize
> the UHS-II interface/phy if that is supported. That doesn't seem
> correct to me. What about if the SD card doesn't support UHS-II, then
> we should use the legacy SD interface instead right?

Please always try UHS-II I/F first, then if UHS-II I/F fails, then
switch to SD I/F.

>
> Or perhaps the MMC_UHS2_SUPPORT bit becomes cleared somewhere in the
> error path when first trying to initialize an UHS-II card, from
> subsequent changes?

Yes, MMC_UHS2_SUPPORT will be cleared in some cases.

>
> So, assuming that is the intent then, I am still not sure about this appr=
oach.
>
> What about if we instead always start with legacy SD initialization?
> When we have read the OCR register, via mmc_send_app_op_cond(), we can
> check if the card supports UHS-II by looking at the UHS-II Card Status
> (bit 29).

UHS-II spec recommends to detect UHS-II first.
Or in Host controller spec, section 3.13.2 card interface detection sequenc=
e,
it also starts from UHS-II path, then go SD legacy path if UHS-II
initialization fails.

The bit29 in response of ACMD41 is defined as =E2=80=9CUHS-II Card Status=
=E2=80=9D,
not UHS-II supported.
We have experience using this value to determine whether a card supports UH=
S-II,
but not every card reports if they support UHS-II by the response of
ACMD41 correctly.

>
> If it turns out that the card supports UHS-II and the host does as
> well, then we do a mmc_power_off() to completely reset the
> card/host/phy. Then we can call into a UHS-II specific path, that
> tries to power on and initialize things according to the UHS-II spec.
>
> In this way, we are going to prioritize initialization of legacy SD
> cards to remain quick, as we won't try to use UHS-II unless the card
> supports it. Moreover, I get the impression that we can keep the
> existing code more as is - and instead introduce UHS-II specifics in a
> separate path. This also also for UHS-II specific optimizations, I
> think.

Agree that we can try to keep the existing code and also need your advice/h=
elp.

>
> > +       } else {
> > +               mmc_pwrseq_pre_power_on(host);
> >
> > -       host->ios.vdd =3D fls(ocr) - 1;
> > -       host->ios.power_mode =3D MMC_POWER_UP;
> > -       /* Set initial state and call mmc_set_ios */
> > -       mmc_set_initial_state(host);
> > +               host->ios.vdd =3D fls(ocr) - 1;
> > +               host->ios.power_mode =3D MMC_POWER_UP;
> > +               /* Set initial state and call mmc_set_ios */
> > +               mmc_set_initial_state(host);
> >
> > -       mmc_set_initial_signal_voltage(host);
> > +               mmc_set_initial_signal_voltage(host);
> >
> > -       /*
> > -        * This delay should be sufficient to allow the power supply
> > -        * to reach the minimum voltage.
> > -        */
> > -       mmc_delay(host->ios.power_delay_ms);
> > -
> > -       mmc_pwrseq_post_power_on(host);
> > +               /*
> > +                * This delay should be sufficient to allow the power s=
upply
> > +                * to reach the minimum voltage.
> > +                */
> > +               mmc_delay(host->ios.power_delay_ms);
> >
> > +               mmc_pwrseq_post_power_on(host);
> > +       }
> >         host->ios.clock =3D host->f_init;
> > -
> >         host->ios.power_mode =3D MMC_POWER_ON;
> > +
> >         mmc_set_ios(host);
> >
> > -       /*
> > -        * This delay must be at least 74 clock sizes, or 1 ms, or the
> > -        * time required to reach a stable voltage.
> > -        */
> > -       mmc_delay(host->ios.power_delay_ms);
> > +       if (host->flags & MMC_UHS2_SUPPORT)
> > +               /*
> > +                * This delay should be sufficient to allow the power s=
upply
> > +                * to reach the minimum voltage.
> > +                */
> > +               /*  TODO: avoid an immediate value */
> > +               mmc_delay(10);
> > +       else
> > +               /*
> > +                * This delay must be at least 74 clock sizes, or 1 ms,=
 or the
> > +                * time required to reach a stable voltage.
> > +                */
> > +               mmc_delay(host->ios.power_delay_ms);
> >  }
> >
> >  void mmc_power_off(struct mmc_host *host)
> > @@ -2307,7 +2325,11 @@ void mmc_start_host(struct mmc_host *host)
> >
> >         if (!(host->caps2 & MMC_CAP2_NO_PRESCAN_POWERUP)) {
> >                 mmc_claim_host(host);
> > -               mmc_power_up(host, host->ocr_avail);
> > +
> > +               /* Power up here will make UHS2 init ugly. */
> > +               if (!(host->caps & MMC_CAP_UHS2))
> > +                       mmc_power_up(host, host->ocr_avail);
> > +
>
> According to my suggestions, then this would not be needed.

This should not be needed. Thank you.

>
> >                 mmc_release_host(host);
> >         }
> >
> > diff --git a/drivers/mmc/core/regulator.c b/drivers/mmc/core/regulator.=
c
> > index 96b1d15045d6..05556225d9ac 100644
> > --- a/drivers/mmc/core/regulator.c
> > +++ b/drivers/mmc/core/regulator.c
> > @@ -247,6 +247,7 @@ int mmc_regulator_get_supply(struct mmc_host *mmc)
> >
> >         mmc->supply.vmmc =3D devm_regulator_get_optional(dev, "vmmc");
> >         mmc->supply.vqmmc =3D devm_regulator_get_optional(dev, "vqmmc")=
;
> > +       mmc->supply.vmmc2 =3D devm_regulator_get_optional(dev, "vmmc2")=
;
>
> Please move the regulator thingy here into a separate patch. Please
> make sure corresponding header file, adding the vmmc2 to it is part of
> that change as well.

Yes. will do it.

>
> >
> >         if (IS_ERR(mmc->supply.vmmc)) {
> >                 if (PTR_ERR(mmc->supply.vmmc) =3D=3D -EPROBE_DEFER)
> > @@ -266,6 +267,19 @@ int mmc_regulator_get_supply(struct mmc_host *mmc)
> >                 dev_dbg(dev, "No vqmmc regulator found\n");
> >         }
> >
> > +       if (IS_ERR(mmc->supply.vmmc2)) {
> > +               if (PTR_ERR(mmc->supply.vmmc2) =3D=3D -EPROBE_DEFER)
> > +                       return -EPROBE_DEFER;
> > +               dev_dbg(dev, "No vmmc2 regulator found\n");
> > +       } else {
> > +               ret =3D mmc_regulator_get_ocrmask(mmc->supply.vmmc2);
> > +               if (ret > 0)
> > +                       mmc->ocr_avail_uhs2 =3D ret;
> > +               else
> > +                       dev_warn(dev, "Failed getting UHS2 OCR mask: %d=
\n",
> > +                                ret);
> > +       }
> > +
> >         return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(mmc_regulator_get_supply);
> > --
> > 2.27.0
> >
>
> Kind regards
> Uffe

Best regards,
Ben
