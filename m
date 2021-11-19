Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708C5C433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 19 Nov 2021 15:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55A93613DB
	for <linux-mmc@archiver.kernel.org>; Fri, 19 Nov 2021 15:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbhKSPoB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 19 Nov 2021 10:44:01 -0500
Received: from smtp2.axis.com ([195.60.68.18]:14282 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235475AbhKSPoB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 19 Nov 2021 10:44:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1637336459;
  x=1668872459;
  h=date:to:cc:subject:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:from;
  bh=1jZlkYlAioT47ElX7djx3WiF2zN7W0GO4kTkv8pv3Cg=;
  b=gsK4Uo3VjDDnLA6cHS1rhZgLZBfU/mGAV7z0AA9ET3SFjE4ScryKzgI6
   mwOrIK0y/Ma09YWntZldTSUnWFm02rszsdLq0IvolVtn1muxSv51SY4HO
   c0VkT3MVNLzn32pdonaAdAahasI/2U5J0zEza6B/UUKeDuNsxxZBhC1mZ
   Bd8FMDXgj1BXl3xCQHV22U/SwuFd24Y8dZ7E0QB1mLJ9nD/lz9mTxaP13
   ymkcnJxWO1a4aSfR99B5FLLP2nh5vn458EouMxpoc9rr898xG6PzYtxDP
   djwodpIjdaWEUrCXJ5t3WUdrgC//nYfSGCn02TSOER9AC7FFqu2WWxTET
   w==;
Date:   Fri, 19 Nov 2021 16:40:58 +0100
To:     Doug Anderson <dianders@google.com>
CC:     =?iso-8859-1?Q?M=E5rten?= Lindahl <Marten.Lindahl@axis.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, kernel <kernel@axis.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH v4] mmc: dw_mmc: Allow lower TMOUT value than maximum
Message-ID: <20211119154058.GA25676@axis.com>
References: <20211117160859.8732-1-marten.lindahl@axis.com>
 <CAD=FV=WWF9W=cXQWkcvQAgXjGZjBzgvV3jB90nZ35JYdi8YA-w@mail.gmail.com>
 <20211118105113.GA3708@axis.com>
 <CAD=FV=Xkez1iEme2npVfz1MBXurz0Vm2L9akHTFAwr_Tec0X2g@mail.gmail.com>
 <20211119153037.GA20316@axis.com>
 <CAD=FV=UP6k14dbwa26ZT_k_JbRRTG7sPtO433rgETBhjWSPuQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=UP6k14dbwa26ZT_k_JbRRTG7sPtO433rgETBhjWSPuQQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
From:   Marten Lindahl <martenli@axis.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Nov 19, 2021 at 04:35:59PM +0100, Doug Anderson wrote:
> Hi,
> 
> On Fri, Nov 19, 2021 at 7:30 AM Marten Lindahl <martenli@axis.com> wrote:
> >
> > On Fri, Nov 19, 2021 at 03:44:16PM +0100, Doug Anderson wrote:
> > > Hi,
> > >
> > > On Thu, Nov 18, 2021 at 2:51 AM Marten Lindahl <martenli@axis.com> wrote:
> > > >
> > > > On Thu, Nov 18, 2021 at 12:29:46AM +0100, Doug Anderson wrote:
> > > >
> > > > Hi Doug!
> > > >
> > > > > Hi,
> > > > >
> > > > > On Wed, Nov 17, 2021 at 8:09 AM Mårten Lindahl <marten.lindahl@axis.com> wrote:
> > > > > >
> > > > > > The TMOUT register is always set with a full value for every transfer,
> > > > > > which (with a 200MHz clock) will give a full DRTO of ~84 milliseconds.
> > > > > > This is normally good enough to complete the request, but setting a full
> > > > > > value makes it impossible to test shorter timeouts, when for example
> > > > > > testing data read times on different SD cards.
> > > > > >
> > > > > > Add a function to set any value smaller than the maximum of 0xFFFFFF.
> > > > > >
> > > > > > Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> > > > > > ---
> > > > > >
> > > > > > v2:
> > > > > >  - Calculate new value before checking boundaries
> > > > > >  - Include CLKDIV register to get proper value
> > > > > >
> > > > > > v3:
> > > > > >  - Use 'if-else' instead of 'goto'
> > > > > >  - Don't touch response field when maximize data field
> > > > > >
> > > > > > v4:
> > > > > >  - Prevent 32bit divider overflow by splitting the operation
> > > > > >  - Changed %06x to %#08x as suggested by Doug
> > > > > >  - Rephrased commit msg as suggested by Doug
> > > > > >
> > > > > >  drivers/mmc/host/dw_mmc.c | 28 +++++++++++++++++++++++++++-
> > > > > >  1 file changed, 27 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> > > > > > index d977f34f6b55..8e9d33e1b96c 100644
> > > > > > --- a/drivers/mmc/host/dw_mmc.c
> > > > > > +++ b/drivers/mmc/host/dw_mmc.c
> > > > > > @@ -1283,6 +1283,32 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
> > > > > >         mci_writel(host, CTYPE, (slot->ctype << slot->id));
> > > > > >  }
> > > > > >
> > > > > > +static void dw_mci_set_data_timeout(struct dw_mci *host,
> > > > > > +                                   unsigned int timeout_ns)
> > > > > > +{
> > > > > > +       unsigned int clk_div, tmp, tmout;
> > > > >
> > > > > didn't notice before, but nit that I usually make it a policy that
> > > > > things that represent cpu registers are the "sized" types. Thus I'd
> > > > > rather see these locals as u32 even though the parameter (which
> > > > > represents a logical value and not a CPU register) stays as "unsigned
> > > > > int").
> > > > >
> > > >
> > > > Thanks, will fix.
> > > >
> > > > >
> > > > > > +       clk_div = (mci_readl(host, CLKDIV) & 0xFF) * 2;
> > > > > > +       if (clk_div == 0)
> > > > > > +               clk_div = 1;
> > > > > > +
> > > > > > +       tmp = DIV_ROUND_UP_ULL((u64)timeout_ns * host->bus_hz, NSEC_PER_SEC);
> > > > > > +       tmp = DIV_ROUND_UP(tmp, clk_div);
> > > > >
> > > > > I guess in some extreme cases you still have an overflow. Not sure how
> > > > > many people really use "div", but...
> > > > >
> > > > > The case I'm thinking of is if the timeout is 80 ms, the bus_hz is 200
> > > > > MHz, and clk_div is 20 (register contains 10). I think that would mean
> > > > > you're feeding the controller a 4GHz clock which it probably couldn't
> > > > > _really_ handle, so maybe this isn't super realistic. In any case, I
> > > > > think the first statement would be the equivalent of 80 * 200MHz =
> > > > > 0x3b9aca000 and that blows out the 32-bit "tmp" variable.
> > > >
> > > > I'm sorry but I fail to follow your calculation here. With 80ms timeout
> > > > and 200MHz bus_hz, I get:
> > > >
> > > > 80000000 * 200000000 / 1000000000 = 0xF42400
> > >
> > > Sorry, it's just my brain not working properly. Yeah, I think you were
> > > fine assuming it was 32-bit. It seems terribly unlikely that bus_hz
> > > could be anywhere approaching 32-bit max. Even if it was, the timeout
> > > is documented to be max on the order of 80 ms:
> > >
> > > /* data timeout (in ns, max 80ms) */
> > >
> > > ...and even if that's wrong and it's 800 ms _and_ bus_hz is the
> > > absurdly large 0xffffffff then we still don't timeout.
> > >
> > > Sorry for getting that wrong. :(
> >
> > No problem. Reviews are for twisting and turning the code.
> >
> > To twist it even more, there is no real need to use DIV_ROUND_UP(_ULL)
> > on the clkdiv division right? I mean the round up has already been made,
> > and it shouldn't be needed twice?
> >
> > So,
> >         tmp = DIV_ROUND_UP_(ULL)(tmp, clk_div);
> >
> > could be a
> >
> >         tmp /= clk_div;
> 
> I think you still need the round up, but I wouldn't swear to it.
> You've divided by one value, but not the other and each division could
> separately need rounding.

Ok, thanks. I'll keep the round up then. I change the unsigned long to
u64 in v6.

Kind regards
Mårten
> 
> -Doug
