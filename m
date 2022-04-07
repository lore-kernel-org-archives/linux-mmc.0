Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA0FC433F5
	for <linux-mmc@archiver.kernel.org>; Thu,  7 Apr 2022 15:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbiDGPXs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 7 Apr 2022 11:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235575AbiDGPXr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Apr 2022 11:23:47 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CE820216A
        for <linux-mmc@vger.kernel.org>; Thu,  7 Apr 2022 08:21:46 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id p15so10226239lfk.8
        for <linux-mmc@vger.kernel.org>; Thu, 07 Apr 2022 08:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lVkm9qWZaxkSOk1edwSKzBnvsIAgiibtRlbXNRFG43k=;
        b=FZtHbnOitKxj13t1VMazZHmSOqMQqgIs0T/8m2cxTO5Pwh5/hb1QhN9pslTJR0wTvp
         jhfOeNaC8dRRxyXvfkMRe5PlDArz7+Izfl6bG01uT6N7QUpNxxIpfRrh1CqhFFNG4RT2
         Bt+CWdgx05DlNb8kpvNV+WgPTbaAfZmvSTFG0hZQYT+Op3PV3dh3is66AjxniXuCjDnZ
         AM2OYvKOa34uW+ITrDR/69t5FOuLsWsQBXEZVJSI3MtP6gUfxClsp4eXbLcp93jdBTmJ
         BfpQ20J+xJNxnR3GOgrSBpWHR4PjdpHsihnRDYElxWAnSiZ+jKDzivE4nbcz5O+t3p9X
         FLHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lVkm9qWZaxkSOk1edwSKzBnvsIAgiibtRlbXNRFG43k=;
        b=yGYX01Bvv7WvCTlSYpWoOMUvB15rqAZAO3v5d559mG4nWCF+bA3zcfz6DfkM/mfmcy
         5bBDvfxab+BnyTn3jxKgeaT47CGTUqMoWT/TKYSwJl2rOrDg44wESssv5WiOtqWe4CkI
         N4ytH7Uf4uSWzvSmiQ6yx/fvK62d4vAVbv6epPvIfwnwzFMRpoBay3et5XgekwZVv7/q
         gNhdwWVv04UVGiZR0jiXTyKJTaK4SXJJU/w8vglRJStnCNiaLuQzTRnVoZfAfIXJmCuW
         8QoxiSOycR2lFq/jZXkjA0uFDb0EiRGD7jvPny3CTqaPcJJckUT/iN7y6+14sX4sJXJY
         bbTQ==
X-Gm-Message-State: AOAM530YvVLmKy9Eul93l8htAymzC6vmFzkd3rj6pVHenJwOlBdoVN/k
        XYD2HpBkDDbN417VBNdMj91MUfqTKKQsugwNPY0LSOG4EpMPrw==
X-Google-Smtp-Source: ABdhPJxGxSU8cTRbDWah9/Qh28l4wjtJ6mpdIiiPuBEo4FfFD49gVrQzVQzQAjtcYMxDKKMsZQ0c9Ws/phAYmt33yMw=
X-Received: by 2002:a19:5012:0:b0:44a:a22d:2d49 with SMTP id
 e18-20020a195012000000b0044aa22d2d49mr9928140lfb.254.1649344905008; Thu, 07
 Apr 2022 08:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220222033931.237638-1-jasonlai.genesyslogic@gmail.com>
 <20220222033931.237638-8-jasonlai.genesyslogic@gmail.com> <CAPDyKFoOxZqf7YB5nFSuGCYs1+pjYC4eVZkYQ_um9j8PCm3YFg@mail.gmail.com>
 <CAG0XXUHnEcrjXOqE1rH=pYLK9AzqtMryfdCT0P5T9fTVDKjv2Q@mail.gmail.com>
In-Reply-To: <CAG0XXUHnEcrjXOqE1rH=pYLK9AzqtMryfdCT0P5T9fTVDKjv2Q@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 7 Apr 2022 17:21:08 +0200
Message-ID: <CAPDyKFqBzLo95Rie4HUrxQS_=EwJp1sEJNRoQWy=MgV+N6q9Yw@mail.gmail.com>
Subject: Re: [PATCH V3 7/7] mmc: core: Support UHS-II card access
To:     Lai Jason <jasonlai.genesyslogic@gmail.com>
Cc:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>, dlunev@chromium.org,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        =?UTF-8?B?R3JlZ1R1W+adnOWVn+i7kl0=?= <greg.tu@genesyslogic.com.tw>,
        Jason Lai <Jason.Lai@genesyslogic.com.tw>,
        otis.wu@genesyslogic.com.tw
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 7 Apr 2022 at 13:00, Lai Jason <jasonlai.genesyslogic@gmail.com> wrote:
>
> Hi Uffe,
>
> On Thu, Mar 24, 2022 at 12:23 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Tue, 22 Feb 2022 at 04:40, Jason Lai <jasonlai.genesyslogic@gmail.com> wrote:
> > >
> > > From: Jason Lai <jason.lai@genesyslogic.com.tw>
> > >
> > > Embed UHS-II access functionality into the MMC request processing flow.
> > >
> > > Signed-off-by: Jason Lai <jason.lai@genesyslogic.com.tw>
> > > ---
> > >  drivers/mmc/core/core.c | 26 ++++++++++++++++++++++++--
> > >  1 file changed, 24 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > > index fc3d8d61a97c..d2dcaa64bf27 100644
> > > --- a/drivers/mmc/core/core.c
> > > +++ b/drivers/mmc/core/core.c
> > > @@ -31,6 +31,7 @@
> > >  #include <linux/mmc/mmc.h>
> > >  #include <linux/mmc/sd.h>
> > >  #include <linux/mmc/slot-gpio.h>
> > > +#include <linux/mmc/sd_uhs2.h>
> > >
> > >  #define CREATE_TRACE_POINTS
> > >  #include <trace/events/mmc.h>
> > > @@ -42,6 +43,7 @@
> > >  #include "host.h"
> > >  #include "sdio_bus.h"
> > >  #include "pwrseq.h"
> > > +#include "sd_uhs2.h"
> > >
> > >  #include "mmc_ops.h"
> > >  #include "sd_ops.h"
> > > @@ -335,6 +337,8 @@ static int mmc_mrq_prep(struct mmc_host *host, struct mmc_request *mrq)
> > >
> > >  int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
> > >  {
> > > +       struct uhs2_command uhs2_cmd;
> > > +       u32 payload[4]; /* for maximum size */
> > >         int err;
> > >
> > >         init_completion(&mrq->cmd_completion);
> > > @@ -352,6 +356,13 @@ int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
> > >         if (err)
> > >                 return err;
> > >
> > > +       if (host->uhs2_caps.flags & MMC_UHS2_SUPPORT &&
> > > +           host->uhs2_caps.flags & MMC_UHS2_INITIALIZED) {
> > > +               uhs2_cmd.payload = payload;
> > > +               mrq->cmd->uhs2_cmd = &uhs2_cmd;
> > > +               sd_uhs2_prepare_cmd(host, mrq);
> > > +       }
> > > +
> > >         led_trigger_event(host->led, LED_FULL);
> > >         __mmc_start_request(host, mrq);
> > >
> > > @@ -431,6 +442,8 @@ EXPORT_SYMBOL(mmc_wait_for_req_done);
> > >   */
> > >  int mmc_cqe_start_req(struct mmc_host *host, struct mmc_request *mrq)
> > >  {
> > > +       struct uhs2_command uhs2_cmd;
> > > +       u32 payload[4]; /* for maximum size */
> > >         int err;
> > >
> > >         /*
> > > @@ -451,6 +464,13 @@ int mmc_cqe_start_req(struct mmc_host *host, struct mmc_request *mrq)
> > >         if (err)
> > >                 goto out_err;
> > >
> > > +       if (host->uhs2_caps.flags & MMC_UHS2_SUPPORT &&
> > > +           host->uhs2_caps.flags & MMC_UHS2_INITIALIZED) {
> > > +               uhs2_cmd.payload = payload;
> > > +               mrq->cmd->uhs2_cmd = &uhs2_cmd;
> > > +               sd_uhs2_prepare_cmd(host, mrq);
> > > +       }
> > > +
> > >         err = host->cqe_ops->cqe_request(host, mrq);
> > >         if (err)
> > >                 goto out_err;
> > > @@ -899,8 +919,10 @@ static inline void mmc_set_ios(struct mmc_host *host)
> > >   */
> > >  void mmc_set_chip_select(struct mmc_host *host, int mode)
> > >  {
> > > -       host->ios.chip_select = mode;
> > > -       mmc_set_ios(host);
> > > +       if (!(host->uhs2_caps.flags & MMC_UHS2_INITIALIZED)) {
> > > +               host->ios.chip_select = mode;
> > > +               mmc_set_ios(host);
> > > +       }
> >
> > As I stated for patch6, rather than having these hacks spread out into
> > the legacy code, we must not allow the ->set_ios() ops to be invoked
> > when UHS-II is being used/initialized.
> >
>
> After checking sd_uhs2.c, mmc_set_chip_select() is called in mmc_go_idle()
> and mmc_go_idle() is called in sd_uhs2_legacy_init(). Hence, I issue CMD0
> directly in sd_uhs2_legacy_init().

That works as a simple solution. But an even better option would be to
re-factor mmc_go_idle(), which then can avoid the open coding. Along
the lines like this:

1) Add a new function, _mmc_go_idle(struct mmc_host *host, bool
chip_select) - which is in principle the same as mmc_go_idle() as
today.
2) From mmc_go_idle() call _mmc_go_idle(host, true).
3) From uhs2 specific code, call  _mmc_go_idle(host, false).

[...]

Kind regards
Uffe
