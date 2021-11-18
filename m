Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFB8C433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 18 Nov 2021 10:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B53FC61B29
	for <linux-mmc@archiver.kernel.org>; Thu, 18 Nov 2021 10:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343543AbhKRKyW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 18 Nov 2021 05:54:22 -0500
Received: from smtp2.axis.com ([195.60.68.18]:38086 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343539AbhKRKyP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 18 Nov 2021 05:54:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1637232675;
  x=1668768675;
  h=date:to:cc:subject:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:from;
  bh=rIgrlw/pN9WZgQsPO1JjFWXJZrf2Pt1b2/OWKm0R9nM=;
  b=GzSv6h4Y38nw1p4LzAtsMPKyqlM6TgDf09CBNPnUP20Mh8icoAvq/HCN
   eqpf1wQqIN+vXrTowsOHYn/QFCiOEp30YU6/p0rRIuPoYOAN7Xu1zpxmL
   4cqO/3nf2LPpoRy9OvjZdBNdThNELOY/JXWmhmZCwsfTdgcswwNBHdJmB
   IZZ+hCE3zZ4eESWsZCwdjzj6Fyjohtah5ZEFDAUuWNvQHf2Q7rNgwo175
   Kd6n1kj6hM7qeaNkZKePpWGHHzGuU9yzobeplS1QkN4VYfCYJToxqdoiI
   qIdLsM+gZN+wFPsQan6CF6B97Nsd8cMMmUQV2+C3Ul16EcvqIrStQ7yuB
   Q==;
Date:   Thu, 18 Nov 2021 11:51:13 +0100
To:     Doug Anderson <dianders@google.com>
CC:     =?iso-8859-1?Q?M=E5rten?= Lindahl <Marten.Lindahl@axis.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, kernel <kernel@axis.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH v4] mmc: dw_mmc: Allow lower TMOUT value than maximum
Message-ID: <20211118105113.GA3708@axis.com>
References: <20211117160859.8732-1-marten.lindahl@axis.com>
 <CAD=FV=WWF9W=cXQWkcvQAgXjGZjBzgvV3jB90nZ35JYdi8YA-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=WWF9W=cXQWkcvQAgXjGZjBzgvV3jB90nZ35JYdi8YA-w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
From:   Marten Lindahl <martenli@axis.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Nov 18, 2021 at 12:29:46AM +0100, Doug Anderson wrote:

Hi Doug!

> Hi,
> 
> On Wed, Nov 17, 2021 at 8:09 AM Mårten Lindahl <marten.lindahl@axis.com> wrote:
> >
> > The TMOUT register is always set with a full value for every transfer,
> > which (with a 200MHz clock) will give a full DRTO of ~84 milliseconds.
> > This is normally good enough to complete the request, but setting a full
> > value makes it impossible to test shorter timeouts, when for example
> > testing data read times on different SD cards.
> >
> > Add a function to set any value smaller than the maximum of 0xFFFFFF.
> >
> > Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> > ---
> >
> > v2:
> >  - Calculate new value before checking boundaries
> >  - Include CLKDIV register to get proper value
> >
> > v3:
> >  - Use 'if-else' instead of 'goto'
> >  - Don't touch response field when maximize data field
> >
> > v4:
> >  - Prevent 32bit divider overflow by splitting the operation
> >  - Changed %06x to %#08x as suggested by Doug
> >  - Rephrased commit msg as suggested by Doug
> >
> >  drivers/mmc/host/dw_mmc.c | 28 +++++++++++++++++++++++++++-
> >  1 file changed, 27 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> > index d977f34f6b55..8e9d33e1b96c 100644
> > --- a/drivers/mmc/host/dw_mmc.c
> > +++ b/drivers/mmc/host/dw_mmc.c
> > @@ -1283,6 +1283,32 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
> >         mci_writel(host, CTYPE, (slot->ctype << slot->id));
> >  }
> >
> > +static void dw_mci_set_data_timeout(struct dw_mci *host,
> > +                                   unsigned int timeout_ns)
> > +{
> > +       unsigned int clk_div, tmp, tmout;
> 
> didn't notice before, but nit that I usually make it a policy that
> things that represent cpu registers are the "sized" types. Thus I'd
> rather see these locals as u32 even though the parameter (which
> represents a logical value and not a CPU register) stays as "unsigned
> int").
>

Thanks, will fix.

> 
> > +       clk_div = (mci_readl(host, CLKDIV) & 0xFF) * 2;
> > +       if (clk_div == 0)
> > +               clk_div = 1;
> > +
> > +       tmp = DIV_ROUND_UP_ULL((u64)timeout_ns * host->bus_hz, NSEC_PER_SEC);
> > +       tmp = DIV_ROUND_UP(tmp, clk_div);
> 
> I guess in some extreme cases you still have an overflow. Not sure how
> many people really use "div", but...
> 
> The case I'm thinking of is if the timeout is 80 ms, the bus_hz is 200
> MHz, and clk_div is 20 (register contains 10). I think that would mean
> you're feeding the controller a 4GHz clock which it probably couldn't
> _really_ handle, so maybe this isn't super realistic. In any case, I
> think the first statement would be the equivalent of 80 * 200MHz =
> 0x3b9aca000 and that blows out the 32-bit "tmp" variable.

I'm sorry but I fail to follow your calculation here. With 80ms timeout
and 200MHz bus_hz, I get:

80000000 * 200000000 / 1000000000 = 0xF42400

The only way I manage to get an overflow of tmp is with:

timeout = INT_MAX * bus_hz = (value greater than 1000000000) / 1000000000

So my reasoning is that tmp = DIV_ROUND_UP(tmp, clk_div) is safe within
these values, but I can of course make tmp an unsigned long, and in that
case do the clk_div division as:

tmp = DIV_ROUND_UP_ULL(tmp, clk_div)

Kind regards
Mårten

> 
> Why not just keep it as 64-bit until you're done dividing to be safe?
> 
> -Doug
