Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32B7C433F5
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Mar 2022 10:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbiCCKWh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 3 Mar 2022 05:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbiCCKWg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Mar 2022 05:22:36 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A2448E4E
        for <linux-mmc@vger.kernel.org>; Thu,  3 Mar 2022 02:21:50 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id m14so7579680lfu.4
        for <linux-mmc@vger.kernel.org>; Thu, 03 Mar 2022 02:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YzVwY3mEdfiRjeh2nt8836txEmK+uEtk2JZC3Nb2yhk=;
        b=j9gu4Mu0aHrDPXhX9fLc18SmXl5WKdNcVj8zUgG/jHfez5HDyr9OyMW5K/I1w4bV0n
         3FyDjFem2mdqFd/HELZ7FQCZ16utQ2I5Z0/CDl4ifmZceSJL85dgADz05D3Fm0waPatR
         gWtWwWZhpWz/BJZM6C8Vk92O4ir6gZk10aNCluzkdRMPkgM9508C/R22kC3AoF585IN4
         0HNHImtsgHLkeAiz/Zsq8AzGJolAUFXeP7BQNP8+SKWXE7fF1UQvzGu4To+hAIA/d6GJ
         DAfx7RMicH8qS89PmQS+1ClQmTMREGz68SNsPB0y1tuMaruAeBQ6AZVQXaEc+KsoeFS0
         ab/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YzVwY3mEdfiRjeh2nt8836txEmK+uEtk2JZC3Nb2yhk=;
        b=m9Ir2aQyKw9yij2k0OyhgiT67PwHTFnn1u6Pd8xp9YPy8b74hXouCyRVmiNsDyep2G
         x3EFGLuDk1Obn4G0Gd5BCmZrQynKP8NRB3UgoWVgdc0KAVmKSFGNNKCjldCZ2urMEXNI
         v0j9scI+cdSI2Zi4h7mgwvws09hpZrH9dTMQrz+lNlqiIbIce2mj581SvoLhclmnUDJ9
         vCpFimXvvqYRj7Pbs+SQzUTbEegu2SxTpEZ9B2Yz/XrM7yDNus+WHJLTfZnbQINVkLUI
         vQ07dLv65BYUwsdeoMSs047okrMQzYN4++E1lMlN7oe8VEAleuH+sy3KrFS30Kiz3g9X
         TtVw==
X-Gm-Message-State: AOAM532Ehbo83HMKhzJdxXz3mT/TGt4I4cQw6gNvZmk5s7cioqxGYsPx
        AJULmBjnd98Ij91chAs5cC6RI1CSYXyR6E+LS9OxKA==
X-Google-Smtp-Source: ABdhPJyRYePCBmySOF86+bHiB9xM/7SHonPiD0jMfoAj63fevUiSyjjk2EiJRi3fN0UWBQfOhYDVdoWgep3vWddYIPg=
X-Received: by 2002:a05:6512:260b:b0:445:c54c:4157 with SMTP id
 bt11-20020a056512260b00b00445c54c4157mr1496331lfb.254.1646302908794; Thu, 03
 Mar 2022 02:21:48 -0800 (PST)
MIME-Version: 1.0
References: <20220303015151.1711860-1-pgwipeout@gmail.com> <CAPDyKFrk+HCbSZtB7uv6u9tjTgzFDjpB9oP9FYJUqNxcCzQ9iw@mail.gmail.com>
 <CAMdYzYrndAwWJELRRL4kP-BCdWuF6bLVwS2PUMVx_UcJZE=nsQ@mail.gmail.com>
In-Reply-To: <CAMdYzYrndAwWJELRRL4kP-BCdWuF6bLVwS2PUMVx_UcJZE=nsQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 3 Mar 2022 11:21:12 +0100
Message-ID: <CAPDyKFp8tZ-Ty0Wo2jkTjr6Jun83QczQfQRQ1zvFBBCOCWjtng@mail.gmail.com>
Subject: Re: [PATCH] mmc: host: dw-mmc-rockchip: fix handling invalid clock rates
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Addy Ke <addy.ke@rock-chips.com>,
        Doug Anderson <dianders@chromium.org>,
        linux-mmc@vger.kernel.org,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 3 Mar 2022 at 10:49, Peter Geis <pgwipeout@gmail.com> wrote:
>
> On Thu, Mar 3, 2022 at 2:53 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Thu, 3 Mar 2022 at 02:52, Peter Geis <pgwipeout@gmail.com> wrote:
> > >
> > > The Rockchip ciu clock cannot be set as low as the dw-mmc hardware
> > > supports. This leads to a situation during card initialization where the
> > > ciu clock is set lower than the clock driver can support. The
> > > dw-mmc-rockchip driver spews errors when this happens.
> > > For normal operation this only happens a few times during boot, but when
> > > cd-broken is enabled (in cases such as the SoQuartz module) this fires
> > > multiple times each poll cycle.
> > >
> > > Fix this by testing the minimum frequency the clock driver can support
> > > that is within the mmc specification, then divide that by the internal
> > > clock divider. Set the f_min frequency to this value, or if it fails,
> > > set f_min to the downstream driver's default.
> > >
> > > Fixes: f629ba2c04c9 ("mmc: dw_mmc: add support for RK3288")
> > >
> > > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > > ---
> > >  drivers/mmc/host/dw_mmc-rockchip.c | 31 ++++++++++++++++++++++++++----
> > >  1 file changed, 27 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
> > > index 95d0ec0f5f3a..c198590cd74a 100644
> > > --- a/drivers/mmc/host/dw_mmc-rockchip.c
> > > +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> > > @@ -15,7 +15,9 @@
> > >  #include "dw_mmc.h"
> > >  #include "dw_mmc-pltfm.h"
> > >
> > > -#define RK3288_CLKGEN_DIV       2
> > > +#define RK3288_CLKGEN_DIV      2
> > > +#define RK3288_MIN_INIT_FREQ   375000
> > > +#define MMC_MAX_INIT_FREQ      400000
> > >
> > >  struct dw_mci_rockchip_priv_data {
> > >         struct clk              *drv_clk;
> > > @@ -27,6 +29,7 @@ struct dw_mci_rockchip_priv_data {
> > >  static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
> > >  {
> > >         struct dw_mci_rockchip_priv_data *priv = host->priv;
> > > +       struct mmc_host *mmc = mmc_from_priv(host);
> > >         int ret;
> > >         unsigned int cclkin;
> > >         u32 bus_hz;
> > > @@ -34,6 +37,10 @@ static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
> > >         if (ios->clock == 0)
> > >                 return;
> > >
> > > +       /* the clock will fail if below the f_min rate */
> > > +       if (ios->clock < mmc->f_min)
> > > +               ios->clock = mmc->f_min;
> > > +
> >
> > You shouldn't need this. The mmc core should manage this already.
>
> I thought so too, but while setting f_min did reduce the number of
> errors, it didn't stop them completely.
> Each tick I was getting three failures, it turns out mmc core tries
> anyways with 300000, 200000, and 100000.
> Clamping it here was necessary to stop these.

Ohh, that was certainly a surprise to me. Unless the dw_mmc driver
invokes this path on it's own in some odd way, that means the mmc core
has a bug that we need to fix.

Would you mind taking a stack trace or debug this so we understand in
what case the mmc core doesn't respect f_min? It really should.

[...]

Kind regards
Uffe
