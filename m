From: David Jander <david@protonic.nl>
Subject: Re: [RFC PATCH 2/2] mmc: core.c: Add comment to clarify special
 cases of ERASE/TRIM
Date: Thu, 4 Jun 2015 14:19:49 +0200
Message-ID: <20150604141949.01641d76@archvile>
References: <CAPDyKFocxYD+q_CQQ4Kz6ZZ88P+DwWcwfrEGEJJEEgkFT5r+MA@mail.gmail.com>
	<1433413214-21614-1-git-send-email-david@protonic.nl>
	<55703387.8060509@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55703387.8060509@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, Johan Rudholm <johan.rudholm@axis.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


Dear Adrian,

Thanks for reacting.

On Thu, 04 Jun 2015 14:16:23 +0300
Adrian Hunter <adrian.hunter@intel.com> wrote:

> On 04/06/15 13:20, David Jander wrote:
> > Signed-off-by: David Jander <david@protonic.nl>
> 
> Please never send delta patches.  Always send a new version of the whole
> patch.

Sorry for that. This was meant as a separate patch though... the original
would be part 1/2 and this is part 2/2 (as noted in the subject), and I did it
only to get an idea if I understood Ulf correctly (RFC).

> > ---
> >  drivers/mmc/core/core.c | 28 +++++++++++++++++++++++++++-
> >  1 file changed, 27 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > index 6c9611b..b6aa9ad 100644
> > --- a/drivers/mmc/core/core.c
> > +++ b/drivers/mmc/core/core.c
> > @@ -2109,11 +2109,20 @@ int mmc_erase(struct mmc_card *card, unsigned int
> > from, unsigned int nr, !(card->ext_csd.sec_feature_support &
> > EXT_CSD_SEC_GB_CL_EN)) return -EOPNOTSUPP;
> >  
> > +	/*
> > +	 * Sanity check: If we do not erase aligned, whole erase-groups,
> > return
> > +	 * an error, since we intended a "secure" erase, silently not
> > erasing
> > +	 * something would be unacceptable.
> > +	 */
> 
> I am not sure the value of a comment that can anyway be inferred from the
> code.

Neither am I, but Ulf suggested to put some more comments to the code in this
function. At least that's what I understood... I figured it was not so obvious
why we take different approaches to ERASE and SECURE_ERASE, so some explaining
might have been desirable. I even took the time to go through the eMMC
specification to see if there was some recommendation about this...

> >  	if (arg == MMC_SECURE_ERASE_ARG) {
> >  		if (from % card->erase_size || nr % card->erase_size)
> >  			return -EINVAL;
> >  	}
> >  
> > +	/*
> > +	 * Make sure only erase-groups that are fully contained in the
> > erase
> > +	 * region are erased. Silently ignore the rest.
> > +	 */
> 
> Ditto
> 
> >  	if (arg == MMC_ERASE_ARG) {
> >  		rem = from % card->erase_size;
> >  		if (rem) {
> > @@ -2140,6 +2149,14 @@ int mmc_erase(struct mmc_card *card, unsigned int
> > from, unsigned int nr, /* 'from' and 'to' are inclusive */
> >  	to -= 1;
> >  
> > +	/*
> > +	 * Special case where only one erase-group fits in the timout
> > budget:
> 
> timout -> timeout

Oops. Thanks.

> > +	 * If the region crosses an erase-group boundary on this
> > particular
> > +	 * case, we will be trimming more than one erase-group which,
> > does not
> > +	 * fit in the timeout budget of the controller, so we need to
> > split it
> > +	 * and call mmc_do_erase() twice if necessary. This special case
> > is
> > +	 * identified by the card->eg_boundary flag.
> > +	 */
> >  	if ((arg & MMC_TRIM_ARGS) && (card->eg_boundary) &&
> >  	    (from % card->erase_size)) {
> >  		rem = card->erase_size - (from % card->erase_size);
> > @@ -2244,7 +2261,16 @@ static unsigned int mmc_do_calc_max_discard(struct
> > mmc_card *card, if (!qty)
> >  		return 0;
> >  
> > -	/* We can only erase one erase group special case */
> > +	/*
> > +	 * When specifying a sector range to trim, chances are we might
> > cross
> > +	 * an erase-group boundary even if the amount of sectors is less
> > than
> > +	 * one erase-group.
> > +	 * If we can only fit one erase-group in the controller timeout
> > budget,
> > +	 * we have to care that erase-group boundaries are not crossed by
> > a
> > +	 * single trim operation. We flag that special case with
> > "eg_boundary".
> > +	 * In all other cases we can just decrement qty and pretend that
> > we
> > +	 * always touch (qty + 1) erase-groups as a simple optimization.
> 
> The language seems a little odd here. We are setting the max_discard limit
> which does not involve "pretending" or "optimization", it is just a
> calculation.  The important point is that the calculation has to count the
> maximum number of erase blocks affected not the size in erase blocks.  You
> could give an example e.g. if a 2 sector trim crosses an erase block
> boundary then that counts as 2 erase blocks affected.

Sorry to disagree here. Strictly speaking we are not only calculating
max_discard, because max_discard is useless for a function that takes sectors
as arguments, when this value depends on erase-groups and not sectors. There
is no valid function converting from one to the other, so we _need_ to pretend
something. That's what the somewhat obscure "if (qty==1) return 1" trickery
does, together with the magical "--qty" afterwards. The original code pretends
that we always cross an erase-group boundary, hence the --qty. This needs
explaining, because strictly speaking it is not correct because max_discard
can be higher. It just doesn't produce wrong results because we "are on the
safe side". And doing something different for the case qty==1 is definitely an
optimization... which is what the first patch intends to do.
Maybe the name of the function is misleading...?

> > +	 */
> >  	if (qty == 1)
> >  		card->eg_boundary = 1;
> >  	else
> > 
> 

Best regards,

-- 
David Jander
Protonic Holland.
