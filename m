Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE32C4338F
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Aug 2021 14:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC67961052
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Aug 2021 14:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhHPOJe (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Aug 2021 10:09:34 -0400
Received: from smtp2.axis.com ([195.60.68.18]:12506 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236731AbhHPOJT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 16 Aug 2021 10:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1629122928;
  x=1660658928;
  h=date:to:cc:subject:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:from;
  bh=8HQi74HJwMB/8peDyEMFsOl9XA4uU2O8ngqMsvMdOvI=;
  b=KcfVZYxlFfbS1kmoJQ7tYF53XSZUmySmZCVJAgeU3g9Ej4I8+q8jT+Vy
   bIbaLQgY3WOwJWE4Sqxx2QpgmJM7txuZrdZTSXt5XZ2Qeo9GZiGnTFO+C
   wK/hGaQKnDw6x9fKLWlxDTSYDEkCeUN3tj8r2UYn5louYErDloXb69wG+
   tCPrlCLaxNP4b+X99BC77RKCQr5iQymwOsVwBG6mFWXpxzihZnLqSOps1
   2gUFYMcsweRumTGrBX/Z0rnXu/gi3GjwZgxVE7T0rjlmeeAZPSX0PxlgE
   d4EAelVRD+CppLbMWYeOlFGoRcRjxEzShsG37MgaT+ljtJMOmHJcfr/u/
   A==;
Date:   Mon, 16 Aug 2021 16:08:46 +0200
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     =?iso-8859-1?Q?M=E5rten?= Lindahl <Marten.Lindahl@axis.com>,
        "Jesper Nilsson" <Jesper.Nilsson@axis.com>,
        Lars Persson <Lars.Persson@axis.com>, kernel <kernel@axis.com>,
        linux-arm-kernel <linux-arm-kernel@axis.com>,
        linux-mmc <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH v2] mmc: usdhi6rol0: Implement card_busy function
Message-ID: <20210816140844.GA16328@axis.com>
References: <20210816125243.11623-1-marten.lindahl@axis.com>
 <CAPDyKFpLCAvV3VqSiLJYUQJ6eWMJyqA4JpZg_JVYVbcT-gPXyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPDyKFpLCAvV3VqSiLJYUQJ6eWMJyqA4JpZg_JVYVbcT-gPXyw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
From:   Marten Lindahl <martenli@axis.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Aug 16, 2021 at 03:57:18PM +0200, Ulf Hansson wrote:
> On Mon, 16 Aug 2021 at 14:53, Mårten Lindahl <marten.lindahl@axis.com> wrote:
> >
> > When switching card voltage to UHS voltage the mmc framework tries to
> > check the card busy signal, meaning the card pulling DAT0 line low,
> > before the switch is made. Drivers that does not implement the card_busy
> > function will manage to do the switch anyway, but the framework will
> > print a warning about not being able to verify the voltage signal.
> >
> > Implement card_busy function.
> >
> > Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> > ---
> >
> > v2:
> >  - Update commit message, since interface limitation for checking DAT
> >    lines is not valid for this fix.
> >  - Skip check of SCLKDIVEN bit, and skip check of DAT3 line since SD
> >    specification only points out checking DAT0 for busy signal.
> >  - Update comment about card_busy callback.
> >
> >  drivers/mmc/host/usdhi6rol0.c | 10 ++++++++++
> >  include/linux/mmc/host.h      |  2 +-
> 
> The change looks good to me, but I would be even happier if you could
> split this into two patches. Would you mind?
> 
> Kind regards
> Uffe

Ok, yes I can do that. I will send a separate patch for updating the
header file.

Kind regards
Mårten

> 
> >  2 files changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
> > index b9b79b1089a0..b5ab133e9add 100644
> > --- a/drivers/mmc/host/usdhi6rol0.c
> > +++ b/drivers/mmc/host/usdhi6rol0.c
> > @@ -1186,6 +1186,15 @@ static int usdhi6_sig_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
> >         return ret;
> >  }
> >
> > +static int usdhi6_card_busy(struct mmc_host *mmc)
> > +{
> > +       struct usdhi6_host *host = mmc_priv(mmc);
> > +       u32 tmp = usdhi6_read(host, USDHI6_SD_INFO2);
> > +
> > +       /* Card is busy if it is pulling dat[0] low */
> > +       return !(tmp & USDHI6_SD_INFO2_SDDAT0);
> > +}
> > +
> >  static const struct mmc_host_ops usdhi6_ops = {
> >         .request        = usdhi6_request,
> >         .set_ios        = usdhi6_set_ios,
> > @@ -1193,6 +1202,7 @@ static const struct mmc_host_ops usdhi6_ops = {
> >         .get_ro         = usdhi6_get_ro,
> >         .enable_sdio_irq = usdhi6_enable_sdio_irq,
> >         .start_signal_voltage_switch = usdhi6_sig_volt_switch,
> > +       .card_busy = usdhi6_card_busy,
> >  };
> >
> >  /*                     State machine handlers                          */
> > diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> > index 0abd47e9ef9b..ff1a251bb0bc 100644
> > --- a/include/linux/mmc/host.h
> > +++ b/include/linux/mmc/host.h
> > @@ -153,7 +153,7 @@ struct mmc_host_ops {
> >
> >         int     (*start_signal_voltage_switch)(struct mmc_host *host, struct mmc_ios *ios);
> >
> > -       /* Check if the card is pulling dat[0:3] low */
> > +       /* Check if the card is pulling dat[0] low */
> >         int     (*card_busy)(struct mmc_host *host);
> >
> >         /* The tuning command opcode value is different for SD and eMMC cards */
> > --
> > 2.20.1
> >
