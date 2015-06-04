From: David Jander <david@protonic.nl>
Subject: Re: [PATCH] mmc: core: Fix off-by-one error in
 mmc_do_calc_max_discard()
Date: Thu, 4 Jun 2015 10:24:06 +0200
Message-ID: <20150604102406.02924c4f@archvile>
References: <1433150435-19997-1-git-send-email-david@protonic.nl>
	<556C35BD.4050809@intel.com>
	<20150601133200.79ff41e2@archvile>
	<556C4717.4000202@intel.com>
	<20150601143007.7bb284a0@archvile>
	<556C525B.7070304@intel.com>
	<20150601153246.7b74acbb@archvile>
	<CAPDyKFpDcSr=z0wfQk_e85jcSMf9sJ9RbiyeAoeYzxn6W6tvSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:23875 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936AbbFDIYI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Jun 2015 04:24:08 -0400
In-Reply-To: <CAPDyKFpDcSr=z0wfQk_e85jcSMf9sJ9RbiyeAoeYzxn6W6tvSQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Sascha Hauer <s.hauer@pengutronix.de>, Johan Rudholm <johan.rudholm@axis.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, 4 Jun 2015 10:15:28 +0200
Ulf Hansson <ulf.hansson@linaro.org> wrote:

> On 1 June 2015 at 15:32, David Jander <david@protonic.nl> wrote:
> > On Mon, 01 Jun 2015 15:38:51 +0300
> > Adrian Hunter <adrian.hunter@intel.com> wrote:
> >
> >> On 01/06/15 15:30, David Jander wrote:
> >> > On Mon, 01 Jun 2015 14:50:47 +0300
> >> > Adrian Hunter <adrian.hunter@intel.com> wrote:
> >> >
> >> >> On 01/06/15 14:32, David Jander wrote:
> >> >>> On Mon, 01 Jun 2015 13:36:45 +0300
> >> >>> Adrian Hunter <adrian.hunter@intel.com> wrote:
> >> >>>
> >> >>>> On 01/06/15 12:20, David Jander wrote:
> >> >>>>> qty is the maximum number of discard that _do_ fit in the timeout,
> >> >>>>> not the first amount that does _not_ fit anymore.
> >> >>>>> This seemingly harmless error has a very severe performance impact
> >> >>>>> when the timeout value is enough for only 1 erase group.
> >> >>>>>
> >> >>>>> Signed-off-by: David Jander <david@protonic.nl>
> >> >>>>> ---
> >> >>>>>  drivers/mmc/core/core.c | 7 ++-----
> >> >>>>>  1 file changed, 2 insertions(+), 5 deletions(-)
> >> >>>>>
> >> >>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> >> >>>>> index 92e7671..1f9573b 100644
> >> >>>>> --- a/drivers/mmc/core/core.c
> >> >>>>> +++ b/drivers/mmc/core/core.c
> >> >>>>> @@ -2234,16 +2234,13 @@ static unsigned int
> >> >>>>> mmc_do_calc_max_discard(struct mmc_card *card, if (!qty)
> >> >>>>>                 return 0;
> >> >>>>>
> >> >>>>> -       if (qty == 1)
> >> >>>>> -               return 1;
> >> >>>>> -
> >> >>>>>         /* Convert qty to sectors */
> >> >>>>>         if (card->erase_shift)
> >> >>>>> -               max_discard = --qty << card->erase_shift;
> >> >>>>> +               max_discard = qty << card->erase_shift;
> >> >>>>>         else if (mmc_card_sd(card))
> >> >>>>>                 max_discard = qty;
> >> >>>>>         else
> >> >>>>> -               max_discard = --qty * card->erase_size;
> >> >>>>> +               max_discard = qty * card->erase_size;
> >> >>>>>
> >> >>>>>         return max_discard;
> >> >>>>>  }
> >> >>>>>
> >> >>>>
> >> >>>> This keeps coming up but there is more to it than that.  See here:
> >> >>>>
> >> >>>>  http://marc.info/?l=linux-mmc&m=142504164427546
> >> >>>>
> >> >>>
> >> >>> Thanks for the link. I think it is time to put a comment on that
> >> >>> piece of code to clarify this.
> >> >>> Also, this code badly needs optimizing. I happen to have one of those
> >> >>> unfortunate cases, where the maximum timeout of the MMC controller
> >> >>> (Freescale i.MX6 uSDHCI) is 5.4 seconds, and the eMMC device (Micron
> >> >>> 16GB eMMC) TRIM_MULT is 15 (4.5 seconds). As a result
> >> >>> mmc_do_calc_max_discard() returns 1 and mkfs.ext4 takes several
> >> >>> hours!! I think it is pretty clear that this is unacceptable and
> >> >>> needs to be fixed. AFAICS, the "correct fix" for this would implicate
> >> >>> that discard knows about the erase-group boundaries... something that
> >> >>> could reach into the block-layer even... right?
> >> >>
> >> >> Not necessarily. You could regard the "can only do 1 erase block at a
> >> >> time" case as special, flag it, and in that case have mmc_erase() split
> >> >> along erase block boundaries and call mmc_do_erase() multiple times.
> >> >> Then you could set max_discard to something arbitrarily bigger.
> >> >
> >> > Right. I was just looking at mmc_erase() and thought about splitting the
> >> > erase at the next boundary if it was not aligned. That way my patch
> >> > could be used in every case, since we would ensure that mmc_do_erase()
> >> > will always start erase-group aligned. Would you agree to such a
> >> > solution?
> >>
> >> Why would people who don't have your problem want their erase performance
> >> potentially degraded by unnecessary splitting.
> >
> > This penalty would exist only when erasing a small amount of sectors. If we
> > approach the timeout limit, this penalty is canceled-out by the gain of
> > being able to erase double the amount of sectors in one operation. I have
> > no idea what the typical workload of this function will be, so I take your
> > hint and treat the "can only do 1 erase block at a time" case as special.
> >
> >>[...]
> >> >>> Has anybody even started to look into this?
> >> >>
> >> >> Ulf was looking at supporting R1 response instead of R1b response from
> >> >> the erase command and using a software timeout instead of the host
> >> >> controller's hardware timeout.
> >> >
> >> > That would also be an option, specially if the TRIM_MULT becomes larger
> >> > than what the controller can handle!
> >> > @Ulf: How far are you with this?
> 
> It's been forever in my TODO list. It would be great if you could take
> a closer look, I will happily review your patches.
> 
> As note, a while ago I fixed similar busy timeout issues for the
> switch commands (CMD6). You can likely be influenced by that to find
> out what makes sense for the erase command.

Thanks for commenting. I don't know if I can find the time to tackle that case
also. In the meantime, did you see my proposed patch to optimize the "can only
do 1 erase block at a time" case following the suggestion of Adrian?

Best regards,

-- 
David Jander
Protonic Holland.
