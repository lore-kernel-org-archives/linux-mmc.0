Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A469CC433EF
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Nov 2021 10:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89E4E61355
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Nov 2021 10:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238081AbhKHKd2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Nov 2021 05:33:28 -0500
Received: from smtp1.axis.com ([195.60.68.17]:40182 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238021AbhKHKd1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 8 Nov 2021 05:33:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1636367444;
  x=1667903444;
  h=date:to:cc:subject:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:from;
  bh=jcvr+8FwHp05abelF9JKosyLHvMrxeXcnnzcoFj30ek=;
  b=crf9qHvxh1dYbnfmjIddpy3jOxP0Itb8p6LNomLmxaymue88POsjSupD
   ircHCzwajV9yvbVNdS7EBlqDwgY05+PKJoucF0r2X+51nUmBStfDqT3fZ
   82OCwhQ4FMPyVC5+vvYI/pZeCSpFdxhbWXE/Fi2tfDQCvnmJ2cP6ryTPK
   PxIHJ1VuruZn3STGYv4/7issztIY/Pd68nQlxHZVe5PbhF/1Ju634BJa0
   En/Lh1YllA0P/WSsDltXZPNfMijimWUyGCcwIN/PC7yFyt1Acyc0zd5/2
   LCo1yJcFHaABZe3a4CLIATw7oirMrqngln3uwh610BNoRR3QewLKK3NgU
   w==;
Date:   Mon, 8 Nov 2021 11:30:42 +0100
To:     Doug Anderson <dianders@google.com>
CC:     =?iso-8859-1?Q?M=E5rten?= Lindahl <Marten.Lindahl@axis.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, kernel <kernel@axis.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH] mmc: dw_mmc: Allow lower TMOUT value than maximum
Message-ID: <20211108103042.GA28891@axis.com>
References: <20211103152359.24699-1-marten.lindahl@axis.com>
 <CAD=FV=WsSPcs3ggGWNp5J288B+TBoSYuY7JmEWDii05w4tTdgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=WsSPcs3ggGWNp5J288B+TBoSYuY7JmEWDii05w4tTdgw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
From:   Marten Lindahl <martenli@axis.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, Nov 06, 2021 at 01:14:48AM +0100, Doug Anderson wrote:
> Hi,

Hi Doug!

> 
> On Wed, Nov 3, 2021 at 8:24 AM Mårten Lindahl <marten.lindahl@axis.com> wrote:
> >
> > The TMOUT register is always set with a full value for every transfer,
> > which (with a 200MHz clock) will give a full DRTO of ~84 milliseconds.
> > Since the software dto_timer acts as a backup in cases when this timeout
> > is not long enough, it is normally not a problem. But setting a full
> > value makes it impossible to test shorter timeouts, when for example
> > testing data read times on different SD cards.
> >
> > Add a function to set any value smaller than the maximum of 0xFFFFFF.
> >
> > Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> > ---
> >  drivers/mmc/host/dw_mmc.c | 29 ++++++++++++++++++++++++++++-
> >  1 file changed, 28 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> > index 6578cc64ae9e..0d23b8ed9403 100644
> > --- a/drivers/mmc/host/dw_mmc.c
> > +++ b/drivers/mmc/host/dw_mmc.c
> > @@ -54,6 +54,7 @@
> >
> >  #define DW_MCI_FREQ_MAX        200000000       /* unit: HZ */
> >  #define DW_MCI_FREQ_MIN        100000          /* unit: HZ */
> > +#define DW_MCI_DATA_TMOUT_NS_MAX       83886075
> >
> >  #define IDMAC_INT_CLR          (SDMMC_IDMAC_INT_AI | SDMMC_IDMAC_INT_NI | \
> >                                  SDMMC_IDMAC_INT_CES | SDMMC_IDMAC_INT_DU | \
> > @@ -1283,6 +1284,32 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
> >         mci_writel(host, CTYPE, (slot->ctype << slot->id));
> >  }
> >
> > +static void dw_mci_set_data_timeout(struct dw_mci *host, u32 timeout_ns)
> 
> The type of "timeout_ns" should match `struct mmc_data`, which is
> unsigned int, not u32.

Will fix.

> 
> 
> > +{
> > +       u32 timeout, freq_mhz, tmp, tmout;
> > +
> > +       if (!timeout_ns || timeout_ns > DW_MCI_DATA_TMOUT_NS_MAX) {
> > +               /* Set maximum */
> > +               tmout = 0xFFFFFFFF;
> > +               goto tmout_done;
> > +       }
> 
> I don't think that the above is right. If the card clock is 50 Hz
> instead of 200 Hz then 0xffffffff is actually ~83 ms * 4 = ~332 ms. It
> would be better to attempt to program it correctly.
> 
> Can you just do the math below and if the number is greater than can
> be represented then you can just put in the max?
> 

Yes. Good point. Much better way to do it.

> Interestingly enough, in `struct mmc_data` this is documented as a max
> of 80 ms, though I don't think your code should care about that. Just
> cap to the maximum value after your math.
> 
> 
> > +       timeout = timeout_ns;
> > +       freq_mhz = DIV_ROUND_UP(host->bus_hz, NSEC_PER_MSEC);
> > +
> > +       /* TMOUT[7:0] (RESPONSE_TIMEOUT) */
> > +       tmout = 0xFF; /* Set maximum */
> > +
> > +       /* TMOUT[31:8] (DATA_TIMEOUT) */
> > +       tmp = DIV_ROUND_UP_ULL((u64)timeout * freq_mhz, MSEC_PER_SEC);
> > +       tmout |= (tmp & 0xFFFFFF) << 8;
> 
> Combining your two calculations, I guess you have:
> 
> tmp = timeout * (bus_hz / 1000000) / 1000
> 
> Why isn't this just:
> 
> tmp = (timeout * bus_hz) / 1000000000
> 
> Since you're doing 64-bit math anyway I don't think you need to worry
> about that calculation overflowing. Multiplying two 32-bit numbers
> can't exceed 64-bits, right?

Will do so.
> 
> 
> Also: I think "bus_hz" is the wrong thing to be using here. You need
> to take CLKDIV into account like dw_mci_set_drto() does.
> 

Will do so.
Good comments. Thanks!

Kind regards
Mårten
> 
> -Doug
