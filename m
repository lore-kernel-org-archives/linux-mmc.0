Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63AEC433EF
	for <linux-mmc@archiver.kernel.org>; Thu,  7 Apr 2022 11:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiDGLCW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 7 Apr 2022 07:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbiDGLCW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Apr 2022 07:02:22 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD3A15A2F
        for <linux-mmc@vger.kernel.org>; Thu,  7 Apr 2022 04:00:19 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-2eafabbc80aso56767947b3.11
        for <linux-mmc@vger.kernel.org>; Thu, 07 Apr 2022 04:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lKR+g1RRHl4Cc7327VO2HHV+dqts0j7ZDDb38Ygj+ek=;
        b=qQnvrxDOTWn7LoVIxziLWVxI70A/nG5JV5WAMcZySADnDD/nGCGP3ss6qkg1Rgywu1
         KzqT06/i6w8SH/ih6v34ev78TCMmn861x3CRNN5BulfMHzhCByapMZbqoMVnyrTk/DnX
         +DshHV1juDEsojztDVsQIScge/cuh+iFDRYNaEem2G36BAxqt2MmbenWZSKkvBdkREO9
         L5VcueN53sMaCP9pAMqRmjFiqcW6qSNEgWMWrGQfWQnvLuoowqFWBxk862AmCb2kUIPQ
         VvG3lIkogn9nvdzvzyM0DwEjN8i+DYOEcpLHazzggtkdjx1yFLxNLipgQTRI1mTeyjN8
         pQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lKR+g1RRHl4Cc7327VO2HHV+dqts0j7ZDDb38Ygj+ek=;
        b=NRf9CSJB3R30fHqU0M3HZYKQFAxsZc6stHhaMSsg2PZZIJYj7cG514jMKgt6wjIoEz
         267NOLha67Yplco1VDzquYuukEt0B/e56D1ftxFznFEuQW82K8IjLZUK+VFAkGFU8Yw/
         zNxTvrQKUpOvZ8SnGXFDisdVvU3vJXsVYbgztohmS9/mVyeD0hM9w0tqiCMZogrIZCV0
         oj+szY6ibKyjxk1Bic7mhqMeA8kNQRL7BH2mfDjkSo+bHV78lm8upCw1ZSxGFWj+NMua
         Mpm8s7fAvFakLStywhaQsZ+GpSmwHmKecUAGYZipk5gqWjmONc8SsTBavwgKnoDz4kv0
         OqMQ==
X-Gm-Message-State: AOAM530JwqqmWpTVKtO34WxJqFmEqZ0y+hVXcMR/S9Pq1t7Mbi1cn0ka
        lc54Qh6SwOEIJK5OqvT2d/IunPJEqBSiUURSKXg=
X-Google-Smtp-Source: ABdhPJzDGvwBAG7qF/QBNYIQS6k3+wMNWh33gciKTSTyySfnrNpbOHx4qew5AGfWlcpbLtCY1y1+2g/65r6FVKPfTc0=
X-Received: by 2002:a81:9201:0:b0:2eb:c207:288a with SMTP id
 j1-20020a819201000000b002ebc207288amr3121530ywg.19.1649329218543; Thu, 07 Apr
 2022 04:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220222033931.237638-1-jasonlai.genesyslogic@gmail.com>
 <20220222033931.237638-8-jasonlai.genesyslogic@gmail.com> <CAPDyKFoOxZqf7YB5nFSuGCYs1+pjYC4eVZkYQ_um9j8PCm3YFg@mail.gmail.com>
In-Reply-To: <CAPDyKFoOxZqf7YB5nFSuGCYs1+pjYC4eVZkYQ_um9j8PCm3YFg@mail.gmail.com>
From:   Lai Jason <jasonlai.genesyslogic@gmail.com>
Date:   Thu, 7 Apr 2022 19:00:07 +0800
Message-ID: <CAG0XXUHnEcrjXOqE1rH=pYLK9AzqtMryfdCT0P5T9fTVDKjv2Q@mail.gmail.com>
Subject: Re: [PATCH V3 7/7] mmc: core: Support UHS-II card access
To:     Ulf Hansson <ulf.hansson@linaro.org>
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

Hi Uffe,

On Thu, Mar 24, 2022 at 12:23 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 22 Feb 2022 at 04:40, Jason Lai <jasonlai.genesyslogic@gmail.com> wrote:
> >
> > From: Jason Lai <jason.lai@genesyslogic.com.tw>
> >
> > Embed UHS-II access functionality into the MMC request processing flow.
> >
> > Signed-off-by: Jason Lai <jason.lai@genesyslogic.com.tw>
> > ---
> >  drivers/mmc/core/core.c | 26 ++++++++++++++++++++++++--
> >  1 file changed, 24 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > index fc3d8d61a97c..d2dcaa64bf27 100644
> > --- a/drivers/mmc/core/core.c
> > +++ b/drivers/mmc/core/core.c
> > @@ -31,6 +31,7 @@
> >  #include <linux/mmc/mmc.h>
> >  #include <linux/mmc/sd.h>
> >  #include <linux/mmc/slot-gpio.h>
> > +#include <linux/mmc/sd_uhs2.h>
> >
> >  #define CREATE_TRACE_POINTS
> >  #include <trace/events/mmc.h>
> > @@ -42,6 +43,7 @@
> >  #include "host.h"
> >  #include "sdio_bus.h"
> >  #include "pwrseq.h"
> > +#include "sd_uhs2.h"
> >
> >  #include "mmc_ops.h"
> >  #include "sd_ops.h"
> > @@ -335,6 +337,8 @@ static int mmc_mrq_prep(struct mmc_host *host, struct mmc_request *mrq)
> >
> >  int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
> >  {
> > +       struct uhs2_command uhs2_cmd;
> > +       u32 payload[4]; /* for maximum size */
> >         int err;
> >
> >         init_completion(&mrq->cmd_completion);
> > @@ -352,6 +356,13 @@ int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
> >         if (err)
> >                 return err;
> >
> > +       if (host->uhs2_caps.flags & MMC_UHS2_SUPPORT &&
> > +           host->uhs2_caps.flags & MMC_UHS2_INITIALIZED) {
> > +               uhs2_cmd.payload = payload;
> > +               mrq->cmd->uhs2_cmd = &uhs2_cmd;
> > +               sd_uhs2_prepare_cmd(host, mrq);
> > +       }
> > +
> >         led_trigger_event(host->led, LED_FULL);
> >         __mmc_start_request(host, mrq);
> >
> > @@ -431,6 +442,8 @@ EXPORT_SYMBOL(mmc_wait_for_req_done);
> >   */
> >  int mmc_cqe_start_req(struct mmc_host *host, struct mmc_request *mrq)
> >  {
> > +       struct uhs2_command uhs2_cmd;
> > +       u32 payload[4]; /* for maximum size */
> >         int err;
> >
> >         /*
> > @@ -451,6 +464,13 @@ int mmc_cqe_start_req(struct mmc_host *host, struct mmc_request *mrq)
> >         if (err)
> >                 goto out_err;
> >
> > +       if (host->uhs2_caps.flags & MMC_UHS2_SUPPORT &&
> > +           host->uhs2_caps.flags & MMC_UHS2_INITIALIZED) {
> > +               uhs2_cmd.payload = payload;
> > +               mrq->cmd->uhs2_cmd = &uhs2_cmd;
> > +               sd_uhs2_prepare_cmd(host, mrq);
> > +       }
> > +
> >         err = host->cqe_ops->cqe_request(host, mrq);
> >         if (err)
> >                 goto out_err;
> > @@ -899,8 +919,10 @@ static inline void mmc_set_ios(struct mmc_host *host)
> >   */
> >  void mmc_set_chip_select(struct mmc_host *host, int mode)
> >  {
> > -       host->ios.chip_select = mode;
> > -       mmc_set_ios(host);
> > +       if (!(host->uhs2_caps.flags & MMC_UHS2_INITIALIZED)) {
> > +               host->ios.chip_select = mode;
> > +               mmc_set_ios(host);
> > +       }
>
> As I stated for patch6, rather than having these hacks spread out into
> the legacy code, we must not allow the ->set_ios() ops to be invoked
> when UHS-II is being used/initialized.
>

After checking sd_uhs2.c, mmc_set_chip_select() is called in mmc_go_idle()
and mmc_go_idle() is called in sd_uhs2_legacy_init(). Hence, I issue CMD0
directly in sd_uhs2_legacy_init().

> >  }
> >
>
> Moreover, I think $subject patch should be squashed into patch6. There
> is really no reason to have them split up like this. Or is there?
>

OK.

Kind regards,
Jason


> I have now walked through the series - and it seems like there are a
> few more pieces that we need to sort out, but it's certainly getting
> better and better.
>
> Kind regards
> Uffe
