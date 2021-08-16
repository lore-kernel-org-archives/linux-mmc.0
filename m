Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770E6C4320A
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Aug 2021 12:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A4CA61C19
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Aug 2021 12:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbhHPM1U (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Aug 2021 08:27:20 -0400
Received: from smtp2.axis.com ([195.60.68.18]:53498 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231420AbhHPM1U (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 16 Aug 2021 08:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1629116809;
  x=1660652809;
  h=date:to:cc:subject:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:from;
  bh=OhV0BsQqlrqeJOpMV5tM7Pow/ETvx11850wh0NgLiqw=;
  b=gRFdlLinsAXru6/Ek42Rns27no8DcpZ/l90zkOIAjPTcoYU+bMweVGj6
   0XJBGgmovgcWS7mTUGfRQSlC+gEXm2LUqoCooWTaAmk56vYsUpV/Xv9Cv
   2nOmUUgH1BCkurO1ZQvZcw5xfBhsxzRdHtWkGZbIg3wZ8fk5oVoW9ceMy
   RyXnDPeiOxM/vkmWYY2S09I89ggOPF0HysCYmmLEkM04Xr1a+s3JTjXpl
   8bQybidkTgAYM4re0FFztZ+y3EdnFLClhMT8C0h/njcIKBY0DsyDKsQ4E
   jSPZhAYdsCzR0+bsBx85Ca4yERI08VHhak8zmqANdXsXNyH7plB0tEii3
   Q==;
Date:   Mon, 16 Aug 2021 14:26:47 +0200
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     =?iso-8859-1?Q?M=E5rten?= Lindahl <Marten.Lindahl@axis.com>,
        "Jesper Nilsson" <Jesper.Nilsson@axis.com>,
        Lars Persson <Lars.Persson@axis.com>, kernel <kernel@axis.com>,
        linux-arm-kernel <linux-arm-kernel@axis.com>,
        linux-mmc <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH] mmc: usdhi6rol0: Implement card_busy function
Message-ID: <20210816122645.GA7881@axis.com>
References: <20210812145056.11916-1-marten.lindahl@axis.com>
 <CAPDyKFqp=savCgoUTRYbMG106zSkGshX9OiwAXMxb4VsPKUXsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPDyKFqp=savCgoUTRYbMG106zSkGshX9OiwAXMxb4VsPKUXsg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
From:   Marten Lindahl <martenli@axis.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ulf!

Thank you for your comments! I will update the patch.

On Fri, Aug 13, 2021 at 11:25:35AM +0200, Ulf Hansson wrote:
> On Thu, 12 Aug 2021 at 16:51, Mårten Lindahl <marten.lindahl@axis.com> wrote:
> >
> > When switching card voltage to UHS voltage the mmc framework tries to
> > check that the card is driving pins CMD, and DAT[0-3] low before the
> > switch is made. Drivers that does not implement the card_busy function
> > will manage to do the switch anyway, but the framework will print a
> > warning about not being able to verify the voltage signal.
> >
> > Implement card_busy function. Renesas host interface only exposes pins
> > DAT[0] and DAT[3] for reading the busy state, which is why only these
> > two pins are checked.
> >
> > Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> > ---
> >  drivers/mmc/host/usdhi6rol0.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
> > index b9b79b1089a0..e400a646e675 100644
> > --- a/drivers/mmc/host/usdhi6rol0.c
> > +++ b/drivers/mmc/host/usdhi6rol0.c
> > @@ -77,6 +77,7 @@
> >  #define USDHI6_SD_INFO1_WP             BIT(7)
> >  #define USDHI6_SD_INFO1_D3_CARD_OUT    BIT(8)
> >  #define USDHI6_SD_INFO1_D3_CARD_IN     BIT(9)
> > +#define USDHI6_SD_INFO1_SDDAT3         BIT(10)
> >
> >  #define USDHI6_SD_INFO2_CMD_ERR                BIT(0)
> >  #define USDHI6_SD_INFO2_CRC_ERR                BIT(1)
> > @@ -1186,6 +1187,21 @@ static int usdhi6_sig_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
> >         return ret;
> >  }
> >
> > +static int usdhi6_card_busy(struct mmc_host *mmc)
> > +{
> > +       struct usdhi6_host *host = mmc_priv(mmc);
> > +       u32 info1 = usdhi6_read(host, USDHI6_SD_INFO1);
> > +       u32 info2 = usdhi6_read(host, USDHI6_SD_INFO2);
> > +
> > +       /* Check if the SD bus is processing a command */
> 
> Hmm, this sounds a bit confusing to me. Don't you want to say
> something like "the clock logic is enabled".
> 
> The point is, from the mmc core point of view, ->card_busy() is called
> to poll for busy completion *after* a command has been processed.
> 

Thanks. After reading the SD specification my understanding is that it
should be enough to solely check DAT0 in this case. I will remove the
check for SCLKDIVEN.

> > +       if (!(info2 & USDHI6_SD_INFO2_SCLKDIVEN))
> > +               return 0;
> > +
> > +       /* Card is busy if it is pulling dat[0] & dat[3] low */
> > +       return !(info2 & USDHI6_SD_INFO2_SDDAT0 ||
> > +                info1 & USDHI6_SD_INFO1_SDDAT3);
> 
> In fact, it's sufficient to monitor any one of the DATA lines to check
> for busy for the UHS-I switch, according to the SD spec.
> 
> However, since we are using ->card_busy() to monitor also other busy
> signal scenarios, like for some commands with R1B responses that
> assert only DAT0 to signal busy (at least according to specs), I think
> it's better to monitor solely DAT0 here.
> 

I will remove the check for DAT3.

> I realize that the comment for the ->card_busy() callback in
> include/linux/mmc/host.h needs to be updated to clarify this as well.
> 

I will update the card_busy callback comment to DAT0 only.

Kind regards
Mårten

> > +}
> > +
> >  static const struct mmc_host_ops usdhi6_ops = {
> >         .request        = usdhi6_request,
> >         .set_ios        = usdhi6_set_ios,
> > @@ -1193,6 +1209,7 @@ static const struct mmc_host_ops usdhi6_ops = {
> >         .get_ro         = usdhi6_get_ro,
> >         .enable_sdio_irq = usdhi6_enable_sdio_irq,
> >         .start_signal_voltage_switch = usdhi6_sig_volt_switch,
> > +       .card_busy = usdhi6_card_busy,
> >  };
> >
> >  /*                     State machine handlers                          */
> > --
> > 2.20.1
> >
> 
> Kind regards
> Uffe
