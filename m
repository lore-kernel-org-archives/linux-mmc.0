From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH 2/3] mmc: core: remove the invalid message in
 mmc_select_timing
Date: Thu, 28 Apr 2016 22:58:06 +0800
Message-ID: <20160428145806.GF27560@shlinux2.ap.freescale.net>
References: <1461171092-30631-1-git-send-email-aisheng.dong@nxp.com>
 <1461171092-30631-2-git-send-email-aisheng.dong@nxp.com>
 <CAPDyKFqvXTtbZsaWJ1gr7gm-jTpWwL0hAYxDje+LsC4ScyF2bQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33975 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837AbcD1PF7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Apr 2016 11:05:59 -0400
Received: by mail-pf0-f194.google.com with SMTP id 145so9722645pfz.1
        for <linux-mmc@vger.kernel.org>; Thu, 28 Apr 2016 08:05:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPDyKFqvXTtbZsaWJ1gr7gm-jTpWwL0hAYxDje+LsC4ScyF2bQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Shawn Guo <shawnguo@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Haibo Chen <haibo.chen@nxp.com>

On Thu, Apr 28, 2016 at 11:24:07AM +0200, Ulf Hansson wrote:
> On 20 April 2016 at 18:51, Dong Aisheng <aisheng.dong@nxp.com> wrote:
> > mmc_select_hs200() and mmc_select_hs() will keep the timing
> > as before if switch fails. So it's meaningless to print the
> > failed switched mode outside based on the current host timing.
> >
> > Furthermore, the original print is wrong, it should be:
> > pr_warn("%s: switch to %s failed\n",
> >         mmc_hostname(card->host),
> >         mmc_card_hs(card) ? "high-speed" :
> >         (mmc_card_hs200(card) ? "hs200" : ""));
> >
> > Since we already have error message in mmc_select_hs200(),
> > simply remove it outside.
> >
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> >  drivers/mmc/core/mmc.c | 10 +---------
> >  1 file changed, 1 insertion(+), 9 deletions(-)
> >
> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > index f6683a9..55c8201 100644
> > --- a/drivers/mmc/core/mmc.c
> > +++ b/drivers/mmc/core/mmc.c
> > @@ -1321,21 +1321,13 @@ static int mmc_select_timing(struct mmc_card *card)
> >         if (err && err != -EBADMSG)
> >                 return err;
> >
> > -       if (err) {
> > -               pr_warn("%s: switch to %s failed\n",
> > -                       mmc_card_hs(card) ? "high-speed" :
> > -                       (mmc_card_hs200(card) ? "hs200" : ""),
> > -                       mmc_hostname(card->host));
> > -               err = 0;
> > -       }
> > -
> 
> No, this is not correct.
> 
> First, in patch1/3, you change to return an error code immediately
> when __mmc_set_signal_voltage() fails, instead of using the "goto
> err". Thus there will be no error printed for this case any more.
> 

I noticed this issue when i made up this patch.
Why i simply return is because i want to avoid write the following code:
static int mmc_select_hs200(struct mmc_card *card)
{
...
	err = voltage_switch();
        /* If fails try again during next card power cycle */
        if (err)
                goto err;
....
		/* swith HS TIMING */
                err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
                                   EXT_CSD_HS_TIMING, val,
                                   card->ext_csd.generic_cmd6_time,
                                   true, send_status, true);
                if (err)
                        goto err2;
..........

err2:
        if (err) {
                /* fall back to the old signal voltage, if fails report error */
                if (__mmc_set_signal_voltage(host, old_signal_voltage))
                        err = -EIO;
        }

err:
        if (err)
                pr_err("%s: %s failed, error %d\n", mmc_hostname(card->host),
                       __func__, err);

        return err;
}

Because if first signal switch fails, we don't need fall back to original
voltage. But HS timing switch needs.

goto err makes the code a bit ugly.
So i choose to avoid it and simply return since it's not so important
and most host driver may already implement their debug IO switch debug info.

Do you think if we can accept it?

> Second, mmc_select_hs() may fail and there is no print done within
> that function which is why above print is also needed.
> 

The same as above, i think this print is not so important.
And __mmc_switch already has a err warn.

And the most important reason is the original print outside is
meaningless because it intends to print out the speed mode it
wants to switch, however,it actually prints out the restored
original speed mode.

> On the other hand I agree with you, it doesn't seems necessary to
> print two messages when mmc_select_hs200() fails. One should be
> enough. Can we change this so *only* mmc_select_timing() will deal
> with the print at all errors?
> 

Yes, i agree with your idea.
I also thought about it before, but it seems after patch 3,
it may not be so necessary.
Can you help check it?

> >  bus_speed:
> >         /*
> >          * Set the bus speed to the selected bus timing.
> >          * If timing is not selected, backward compatible is the default.
> >          */
> >         mmc_set_bus_speed(card);
> > -       return err;
> > +       return 0;
> >  }
> >
> >  /*
> > --
> > 1.9.1
> >
> 
> Kind regards
> Uffe

Regards
Dong Aisheng
