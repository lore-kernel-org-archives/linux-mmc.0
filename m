Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C121C43461
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Apr 2021 18:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 292D7601FC
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Apr 2021 18:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236278AbhDAS1X (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 1 Apr 2021 14:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234651AbhDASVF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Apr 2021 14:21:05 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7774C02259A;
        Thu,  1 Apr 2021 08:23:32 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id b10so2585657iot.4;
        Thu, 01 Apr 2021 08:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vx2Zm40GpoQXIGWSyhXgEsbGdSJ2UlNy5Co5SqD5faA=;
        b=cPACo/4g9NO8OMR7+5BrAd5ie57tOrjM7cwUv7G6r12qP6IK3RyjsYVegXy5ekvk2D
         GPpLT+REh/4iKj0swU9PpgBkWlaUla2ZBVNri/8N8v6Y3RqCXSlrWJQ+MAIqKfr5oubv
         38y6+mrNoY527f+1Goub7+MaF+DqLgNIo4XSquc97l7dahtFTR1s3myaTkrn292Ju7PE
         lS/b7ukSmNa1y+XqY27eiY8E0D0ZcEes5GG1vb3ufwq4GjozuyvWazdlwWUQdwR2HXAz
         svJsfHahHNBbIwgMyyDzOOoLiwIxWMOwUkTYdAQkbOf8xm79M9DeU3AtomQzSuW7ET0d
         d2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vx2Zm40GpoQXIGWSyhXgEsbGdSJ2UlNy5Co5SqD5faA=;
        b=LnJXJ0zAAmLIyyfgDktM63TfuYKVdAX2LZE+dYNLxQCGEszQC9z1LurjHPvOOJkh2U
         5HGO3rOQ0gSp0kEFELpQ4gfTSfk9+CCARdzYDkSrJlIPxpOMjjTHpfbPBN4amrJUMjIc
         wcxatLHG0R8kSsbwZz41sFo6n+atdDQ+h3TrV+da7kY8cJAPm9CojNmzpHgbSO8N9YF3
         ALKMgHULLG3+jW8BWC19mxEmHnWViHC6YDXW5cxMGAG7CWhjjDOGs+z3ui6NKa9Icsf7
         EBVVa9reUdHWUt1EOauKlga7c+qP7GwM3OMDRPNxutVdt6xfH/sVKvWB0MhzXw5fTbZm
         cZPA==
X-Gm-Message-State: AOAM532ydVZYvmhZ2Jb6NlxXtIm6y51GwXxkmFVALq9gaPrlF68TEaKE
        si8rRiwTn5KLIvsp5nRpaol2eg2fTmkpMacNiq8=
X-Google-Smtp-Source: ABdhPJwZpj7cQXPzU+FufA5B4amLrzxDD62b8BAP9GW38X1JPaYKGXOU0i40Mj7ZBNv3Y5B3gUSqFvh+tBSfbCr5akM=
X-Received: by 2002:a5d:9d01:: with SMTP id j1mr7105410ioj.195.1617290612006;
 Thu, 01 Apr 2021 08:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210322185816.27582-1-nsaenz@kernel.org> <20210322185816.27582-5-nsaenz@kernel.org>
 <401100ea-90ad-57b1-50da-967118a090da@i2se.com> <78dec30c052e9bb76e52c38f3da5af371e5d65f5.camel@suse.de>
 <2d2a2638-8213-5d6e-0a3a-927ed5bb2ed7@i2se.com> <c7c8e20d3d11c7d6cd203797c5faffa8a4d202a6.camel@suse.de>
In-Reply-To: <c7c8e20d3d11c7d6cd203797c5faffa8a4d202a6.camel@suse.de>
From:   Alan Cooper <alcooperx@gmail.com>
Date:   Thu, 1 Apr 2021 11:23:20 -0400
Message-ID: <CAOGqxeUxOA_s6=KUh_XWFtRF_EWZgQH_y2MEdxUeDQTYMeb+3A@mail.gmail.com>
Subject: Re: [PATCH 4/4] ARM: dts: Fix-up EMMC2 controller's frequency
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>, phil@raspberrypi.com,
        Tim Gover <tim.gover@raspberrypi.com>,
        Scott Branden <sbranden@broadcom.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        ": Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Nicolas,

Sorry, I just noticed this thread.
This is a known bug in some newer Arasan cores.
The problem happens when the difference between the core clock and the
bus clock is too great.
Limiting the clock to 200KHz minimum should be a good fix.
In my experience, it's only eMMC that needs the clock to be retried
below 400KHz and not SD or SDIO. That's because the CMD signal for
eMMC starts out as open-drain during identification and the size of
the pull-up on the CMD signal can require the <400KHz clock. Once eMMC
is out of identification mode the CMD signal is switched to push-pull
and can run at much higher clock rates.
I don't think that SD and SDIO have any open-drain signals, so they
shouldn't need to retry at slower clock speeds.
I'm trying to get more detail on the bug, like the exact ratio of core
clock to bus clock that causes the problem. When I first found this
bug I was told that the failure would not happen at 200KHz, but we
were using a 405MHz core clock.

One other question. Why are you using polling for the SD card, this
newer controller supports the interrupt driven "Card Inserted" signal
and avoids wasting time polling?

Al


On Fri, Mar 26, 2021 at 12:17 PM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> On Thu, 2021-03-25 at 20:11 +0100, Stefan Wahren wrote:
> > Am 24.03.21 um 16:34 schrieb Nicolas Saenz Julienne:
> > > Hi Stefan,
> > >
> > > On Wed, 2021-03-24 at 16:16 +0100, Stefan Wahren wrote:
> > > > Hi Nicolas,
> > > >
> > > > Am 22.03.21 um 19:58 schrieb Nicolas Saenz Julienne:
> > > > > From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > > > >
> > > > > Force emmc2's frequency to 150MHz as the default 100MHz (set by FW)
> > > > > seems to interfere with the VPU clock when setup at frequencies bigger
> > > > > than 500MHz (a pretty common case). This ends up causing unwarranted
> > > > > SDHCI CMD hangs  when no SD card is present.
> > > > >
> > > > > Signed-off-by: Nicolas Saenz Julienne <nsaenz@kernel.org>
> > > > > ---
> > > > >  arch/arm/boot/dts/bcm2711-rpi-4-b.dts | 6 ++++++
> > > > >  1 file changed, 6 insertions(+)
> > > > >
> > > > > diff --git a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> > > > > index 3b4ab947492a..9aa8408d9960 100644
> > > > > --- a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> > > > > +++ b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> > > > > @@ -257,6 +257,12 @@ &emmc2 {
> > > > >         vqmmc-supply = <&sd_io_1v8_reg>;
> > > > >         vmmc-supply = <&sd_vcc_reg>;
> > > > >         broken-cd;
> > > > > +       /*
> > > > > +        * Force the frequency to 150MHz as the default 100MHz seems to
> > > > > +        * interfere with the VPU clock when setup at frequencies bigger than
> > > > > +        * 500MHz, causing unwarranted CMD hangs.
> > > > > +        */
> > > > > +       clock-frequency = <150000000>;
> > > > i don't want to bike-shed here, but is there any chance to solve this in
> > > > clk-bcm2835 in a less hacky way?
> > > What do you have in mind?
> > Sorry, nothing specific.
> > >
> > > All I can think of is adding some kind of heuristic to the clock's prepare()
> > > callback. That said, I don't feel it would be a better solution than this.
> >
> > Based on my limited knowledge and an old SD card specification, all
> > possibly connected devices could have different frequencies. So my
> > concern here is, that in case we limit the frequency to a specific value
> > we could break things just to suppress a warning.
>
> SDHCI should be able to handle up to 233MHz IIRC, and there are divisors
> available, it depends on the implementation but the worst kind provide /2^n.
> Not perfect, but good enough for things to work.
>
> Now, I've been having a deeper look into how clocks are handled, and found two
> new clues:
>
>  - First of all RPi4's sdhci-iproc needs SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
>    that is, the controller isn't properly identifying the clock frequency fed
>    into it, and defaults to saying it's configured at 100MHz. I'm not an SDHCI
>    expert, so it's possible changing frequencies also needs a special operation
>    to recalculate this variable. But this was making all internal calculations
>    wrong when paired with this series.
>
>  - With this flag set SDHCI's core now properly calculates divisor values based
>    on whatever clock frequency I set in DT. And guess what, the issue reappears
>    even when running on 150MHz. It turns out, as I had some debugging enabled,
>    the issue only happens when the controller is configured at 100KHz (that
>    only happens while running the card detect thread).
>
> So, I can now do this (note that for card detection try to communicate with the
> card starting at 400KHz down to 100KHz in 100KHz steps):
>
> ----->8-----
>
> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
> index 536c382e2486..e5a5de63f347 100644
> --- a/drivers/mmc/host/sdhci-iproc.c
> +++ b/drivers/mmc/host/sdhci-iproc.c
> @@ -173,6 +173,11 @@ static unsigned int sdhci_iproc_get_max_clock(struct sdhci_host *host)
>                 return pltfm_host->clock;
>  }
>
> +static unsigned int sdhci_iproc_bcm2711_get_min_clock(struct sdhci_host *host)
> +{
> +       return 200000;
> +}
> +
>  static const struct sdhci_ops sdhci_iproc_ops = {
>         .set_clock = sdhci_set_clock,
>         .get_max_clock = sdhci_iproc_get_max_clock,
> @@ -271,13 +276,15 @@ static const struct sdhci_ops sdhci_iproc_bcm2711_ops = {
>         .set_clock = sdhci_set_clock,
>         .set_power = sdhci_set_power_and_bus_voltage,
>         .get_max_clock = sdhci_iproc_get_max_clock,
> +       .get_min_clock = sdhci_iproc_bcm2711_get_min_clock,
>         .set_bus_width = sdhci_set_bus_width,
>         .reset = sdhci_reset,
>         .set_uhs_signaling = sdhci_set_uhs_signaling,
>  };
>
> ----->8-----
>
>  Which is rather nicer than what this series introduces. But I can't still
>  explain why configuring the controller at 100KHz is causing the hangs (while
>  having the core clock setup at 500MHz), and I'm not sure if excluding 100KHz
>  from the polling frequency list is going to break support for older SD cards.
>
>  Regards,
>  Nicolas
>
>
