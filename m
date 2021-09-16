Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61D6C433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Sep 2021 10:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C6026120F
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Sep 2021 10:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbhIPKqe (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Sep 2021 06:46:34 -0400
Received: from smtp2.axis.com ([195.60.68.18]:56180 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236509AbhIPKqd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 16 Sep 2021 06:46:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1631789113;
  x=1663325113;
  h=date:to:cc:subject:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:from;
  bh=Nf730HP8PPkU9KwlQcIiM4/oIX/cGINz9ZMOpwaiI/Y=;
  b=Wxmoq8bIA6RUiIyR8/tVNqFLXDD8eylziw5K3OC3NG8S98jY4YhU+XzA
   uTPQgeVAq0GmHxHcWSEeyFxu8kjeMD8G80lAxx0wnBiNQ5w40poKiZFSW
   Soqou4hesQ2imtgkR4977aqcHI7oCgIn41W5T5iJ+choP8NKrQCmW0Ova
   1MxqZ9mp2mdaPgzUz8N0vRTKKawycrlnwO3tt1tXgMOAt9YiuHgiJE6P9
   Rbz98q2e756Qj/HVd7+8tdoahUWYD8iGBWtThyOUfc20qW6uYvcMlkLSd
   oUWAHDCyjWTmrka2hNEzF9qn6wCEcSMv9g8TOP/mo83w62jknKzGytwli
   g==;
Date:   Thu, 16 Sep 2021 12:45:10 +0200
To:     Doug Anderson <dianders@google.com>
CC:     =?iso-8859-1?Q?M=E5rten?= Lindahl <Marten.Lindahl@axis.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, kernel <kernel@axis.com>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Vincent Whitchurch <Vincent.Whitchurch@axis.com>,
        Brian Norris <briannorris@chromium.org>,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH] mmc: dw_mmc: Support more time for data read timeouts
Message-ID: <20210916104510.GA5458@axis.com>
References: <20210827085634.21225-1-marten.lindahl@axis.com>
 <CAD=FV=Vg9mGxjP4g7y89TXXF=ox3pKzHSMgag=L=q76fv6e9Wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=Vg9mGxjP4g7y89TXXF=ox3pKzHSMgag=L=q76fv6e9Wg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
From:   Marten Lindahl <martenli@axis.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Sep 10, 2021 at 10:53:43PM +0200, Doug Anderson wrote:

Hi Doug!

Thanks for your feedback.

> Hi,
> 
> My brain is pretty far away from dw_mmc these days. I touched it sorta
> recently when uprevving the kernel on some rk3288 boards over a year
> ago (so sorta recent?) but mostly it's paged out. Adding Brian and
> Chen-Yu who might be able to test more since I think they're currently
> working on an uprev of some rk3399 boards. Hopefully Shawn will be
> able to chime in too.
> 
> On Fri, Aug 27, 2021 at 1:57 AM Mårten Lindahl <marten.lindahl@axis.com> wrote:
> >
> > For data read transfers a data transfer over timer (dto_timer) is
> > started to make sure the data command can be completed in cases the Data
> > Transfer Over (DTO) interrupt does not come. This timer was originally
> > introduced as a quirk in commit 57e104864bc48 ("mmc: dw_mmc: add quirk
> > for broken data transfer over scheme"), but is since a while back part
> > of the running code.
> >
> > The dto timer picks the DATA_TIMEOUT value in the TMOUT register for its
> > timeout, which will give a max timeout of approximately 84 + (10 spare)
> > milliseconds on a 200MHz clock. But this register is not intended to be
> > used like that, since it is a counter for data read timeouts (DRTO) and
> > response timeouts (RTO), which will result in error interrupts in case
> > of data read and response delays.
> 
> I'm not quite following your argument here. Are you just saying that
> the math is wrong (because your version seems to have something
> special for bits 10:8--see below) or are you saying that fundamentally
> the DATA_TIMEOUT shouldn't be used for setting this timeout?  As far
> as I understand it, the original problem we were trying to solve was
> that on Rockchip SoCs sometimes we simply weren't getting the data
> timeout interrupt from hardware. As far as I understood, the data
> timeout interrupt that was missing was the one controlled by the
> "DATA_TIMEOUT" value. We added a software fallback for it.
> 
I understand the reason for having the software timeout. And after reading
the documentation for the rk3399 TRM it came clear to me why the current
code looks the way it is. However, the Samsung manual (which is the one
I have) does not follow the (standard?) TMOUT:DATA_TIMEOUT field definition,
but instead it states:

  For card data read timeout (DRTO):
   [31:8]: ((TMOUT[10:8]-1)*0xffffff + TMOUT[31:11] * 8) cycle

  For host starvation timeout (HTO): TMOUT[31:8] cycle 

We will ask Samsung about this.

> 
> > The TMOUT register is always set with a full value for every transfer,
> 
> Yeah, it's always been weird that TMOUT was just hardcoded to
> 0xffffffff. It was always in the back of my mind that it should be
> fixed but I never saw any serious problems with it being 0xffffffff so
> it never trickled to the top of the queue.
> 
> 
> > which according to the manual (and with 200MHz clock) will give a full
> > DRTO of:
> > ((TMOUT[10:8] -1) * 0xFFFFFF + TMOUT[31:11] * 8) / 200000000 => ~587 ms
> 
> I wonder if perhaps you have a newer and/or customized version of this
> controller. This doesn't match my definition of this register. I
> searched for "rk3399 TRM" just now and found this:
> 
> https://www.t-firefly.com/download/Firefly-RK3399/docs/TRM/Rockchip%20RK3399TRM%20V1.3%20Part2.pdf
> 
> It's stamped full of "Rockchip Confidential" on it so maybe it'll go
> away now that I've pointed it out, but at least you can see what I
> mean. You can find "SDMMC_TMOUT" there defined as:
> 
> * 31:8 Value for Data Read Timeout and Data Starvation by Host
> timeout. Value is in number of card output clocks (cclk_out) of
> selected card.
> 
> * 7:0 Response timeout value. Also in card output clocks (cclk_out)
> 
> ...so I don't see anything talking about 0xffffff nor about the bits
> 10:8 being something different.
> 
> I'll also mention that the DesignWare databook (2.80a) for dwmmc
> matches what I see in the Rockchip TRM.
> 
> One last note is that the manual indicates that if we ever need a
> value of > ~100 ms that we should disable the hardware timeout and
> _only_ use the software timeout. Presumably this is because of the
> fact that ~83 ms is the maximum value you can program here. ;-)
> 
Yes, that was one of my intentions with this patch, but clearly I
stumbled on the DATA_TIMEOUT bits, which (at least with the Samsung
version) I thought could give us much more time. Unfortunately I don't
have access to the original DesignWare dwmmc manual, which would of course
bring more light to this.

> 
> It seems like you'll almost certainly need a quirk or some type of
> function override for your version of the driver instead of changing
> this for everyone.
> 
Agree. But we will ask Samsung before uploading a patch for this.

> 
> > But as the same register is used for the dto_timer, the dto_timer will
> > always have a fixed timeout.
> >
> > Instead of always setting a fixed value in TMOUT register, we can use
> > data->timeout_ns for the DRTO interrupts that actually matches what was
> > provided per requested command. Likewise we can also use timeout_ns for
> > the dto_timer, which will allow a max timeout of 587 ms, instead of the
> > fixed 94 ms.
> 
> In general it feels like you should be breaking this up. First, a
> patch to fix it so that TMOUT isn't always programmed ot 0xffffff.
> Another patch to fix it so that it handles your special hardware and
> how it handles bits 10:8. Once you do that then all of a sudden we
> _won't_ have a fixed timeout for the dto_timer. Now the
> dw_mci_set_drto() should read TMOUT and program a proper fallback
> software delay. Done, right? If you want to add a feature to disable
> the hardware timer and rely on the software timer for timeouts > ~84
> ms (other dw_mmc) or > ~587 ms (your dw_mmc) then that should be yet
> another separate patch.
> 
Agree. Good point. Vincent also suggested splitting it into three
different patches.

> 
> > Furthermore, if a data error interrupt comes, it shouldn't
> > be necessary to wait for the dto_timer before we finish the command, but
> > instead we can handle it in the interrupt handler.
> 
> You'll need to be really careful here to make sure there aren't races.
> I'll comment below.
> 
> 
> > @@ -390,6 +391,23 @@ static inline void dw_mci_set_cto(struct dw_mci *host)
> >         spin_unlock_irqrestore(&host->irq_lock, irqflags);
> >  }
> >
> > +static void dw_mci_set_dto(struct dw_mci *host, u32 timeout_ns)
> > +{
> > +       unsigned int dto_ns;
> > +       unsigned long irqflags;
> > +
> > +       if (!timeout_ns || timeout_ns > DW_MCI_DATA_TMOUT_NS_MAX)
> > +               dto_ns = DW_MCI_DATA_TMOUT_NS_MAX;
> > +       else
> > +               dto_ns = timeout_ns;
> > +
> > +       spin_lock_irqsave(&host->irq_lock, irqflags);
> > +       if (!test_bit(EVENT_DATA_COMPLETE, &host->pending_events))
> > +               mod_timer(&host->dto_timer,
> > +                         jiffies + nsecs_to_jiffies(dto_ns));
> > +       spin_unlock_irqrestore(&host->irq_lock, irqflags);
> > +}
> 
> You got rid of the extra 10 ms "slop". Assuming that the hardware
> timer is "mostly reliable" like it was on Rockchip SoCs (it fired
> properly at least 90% of the time from my memory) it pretty much means
> that you're _always_ going to get both timeouts firing at the exact
> same time, which seems like a bit of a waste. Having some extra slop
> in there was nice because it gave the normal path a chance to run.

Understood.

> 
> I would also say that I kinda liked the fact that the old code based
> the software timeout on the value in the TMOUT register. The whole
> point was that it was a fallback for the hardware timeout not firing.
> Basing it on the same value the hardware timer was supposed to use
> seemed cleaner. Then if there were rounding errors it would affect
> both equally.
> 
> 
> > @@ -1144,9 +1162,10 @@ static void dw_mci_submit_data(struct dw_mci *host, struct mmc_data *data)
> >         host->sg = NULL;
> >         host->data = data;
> >
> > -       if (data->flags & MMC_DATA_READ)
> > +       if (data->flags & MMC_DATA_READ) {
> >                 host->dir_status = DW_MCI_RECV_STATUS;
> > -       else
> > +               dw_mci_set_dto(host, data->timeout_ns);
> 
> Are you sure it's safe to start this timeout right here? Shouldn't you
> start the timeout _after_ you've started the hardware transfer?
> Otherwise what happens if an interrupt storm occurs right after you
> start the timeout but before you started the transfer? The timeout
> could fire even before the transfer starts, right?

Good point. Will look into that.

> 
> 
> > @@ -1277,6 +1296,36 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
> >         mci_writel(host, CTYPE, (slot->ctype << slot->id));
> >  }
> >
> > +static void dw_mci_set_data_timeout(struct dw_mci *host, u32 timeout_ns)
> > +{
> > +       u32 timeout, freq_mhz, tmp, tmout;
> > +
> > +       if (!timeout_ns || timeout_ns > DW_MCI_DATA_TMOUT_NS_MAX) {
> > +               /* Timeout (maximum) */
> > +               mci_writel(host, TMOUT, 0xFFFFFFFF);
> > +               return;
> > +       }
> > +
> > +       timeout = timeout_ns / NSEC_PER_USEC;
> > +       freq_mhz = host->bus_hz / NSEC_PER_MSEC;
> 
> Double check rounding. Presumably you always want the resulting
> timeout rounded _up_. So both of the above should probably be
> "DIV_ROUND_UP", right?

Will do.

> 
> 
> > +       /* TMOUT[7:0] (RESPONSE_TIMEOUT) */
> > +       tmout = 0xFF;
> > +
> > +       /* TMOUT[10:8] (DATA_TIMEOUT) */
> > +       tmp = ((timeout * freq_mhz) / 0xFFFFFF) + 1;
> > +       tmout |= (tmp & 0x7) << 8;
> > +
> > +       /* TMOUT[31:11] (DATA_TIMEOUT) */
> > +       tmp = ((tmp - 1) * 0xFFFFFF) / freq_mhz;
> > +       tmp = (timeout - tmp) * freq_mhz / 8;
> 
> Again, be careful of rounding and make sure you're rounding the
> resulting timeout up. You probably want to calculate the [10:8] value
> first and _then_ subtract it out from the timeout to be sure?
> 
> 
> > @@ -2649,12 +2658,21 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
> >                 }
> >
> >                 if (pending & DW_MCI_DATA_ERROR_FLAGS) {
> > +                       spin_lock(&host->irq_lock);
> > +
> > +                       del_timer(&host->dto_timer);
> > +
> >                         /* if there is an error report DATA_ERROR */
> >                         mci_writel(host, RINTSTS, DW_MCI_DATA_ERROR_FLAGS);
> >                         host->data_status = pending;
> >                         smp_wmb(); /* drain writebuffer */
> >                         set_bit(EVENT_DATA_ERROR, &host->pending_events);
> > +
> > +                       /* In case of error, we cannot expect a DTO */
> > +                       set_bit(EVENT_DATA_COMPLETE, &host->pending_events);
> >                         tasklet_schedule(&host->tasklet);
> > +
> > +                       spin_unlock(&host->irq_lock);
> 
> I'm fairly certain that, at least on hardware I tested on, we _did_
> get a DTO after errors. It's been a long time and my memory could be
> fuzzy, but maybe this is just a quirk of your hardware or something
> that changed in newer versions of dw_mmc?

I always wondered about this. On our hardware we don't always get the DTO
after errors which is why it (to us) seems the driver is relying on the
dto_timer to complete the state machine. So again, yes, it seems we have
a different version of this controller, and a quirk is probably needed
to make this efficient for us.

Kind regards
Mårten
> 
> -Doug
