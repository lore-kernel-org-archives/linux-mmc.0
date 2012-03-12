From: "Maupin, Chase" <chase.maupin@ti.com>
Subject: RE: [PATCH] mmc: omap_hsmmc: set dto to 14 for all devices
Date: Mon, 12 Mar 2012 14:37:31 +0000
Message-ID: <7D46E86EC0A8354091174257B2FED10131EA2AF0@DFLE34.ent.ti.com>
References: <1330622780-1909-1-git-send-email-Chase.Maupin@ti.com>
 <m2399iqtgf.fsf@bob.laptop.org>
 <alpine.DEB.2.00.1203120435200.11332@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38215 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751535Ab2CLOhr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Mar 2012 10:37:47 -0400
In-Reply-To: <alpine.DEB.2.00.1203120435200.11332@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Chris Ball <cjb@laptop.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "sakoman@gmail.com" <sakoman@gmail.com>

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Monday, March 12, 2012 5:58 AM
> To: Chris Ball
> Cc: Maupin, Chase; linux-omap@vger.kernel.org; linux-
> mmc@vger.kernel.org; sakoman@gmail.com
> Subject: Re: [PATCH] mmc: omap_hsmmc: set dto to 14 for all devices
> 
> + Steve Sakoman
> 
> Hi Chris, Chase,
> 
> Sorry for the late comment on this; I just noticed this thread.
> 
> On Thu, 8 Mar 2012, Chris Ball wrote:
> 
> > On Thu, Mar 01 2012, Chase Maupin wrote:
> > > * With certain SD cards timeouts like the following have been
> seen
> > >   due to an improper calculation of the dto value:
> > >     mmcblk0: error -110 transferring data, sector 4126233, nr
> 8,
> > >     card status 0xc00
> > > * By removing the dto calculation and setting the timeout value
> > >   to the maximum specified by the SD card specification part A2
> > >   section 2.2.15 these timeouts can be avoided.
> > > * This change has been used by beagleboard users as well as the
> > >   Texas Instruments SDK without a negative impact.
> > > * There are multiple discussion threads about this but the most
> > >   relevant ones are:
> > >     *
> http://talk.maemo.org/showthread.php?p=1000707#post1000707
> > >     * http://www.mail-archive.com/linux-
> omap@vger.kernel.org/msg42213.html
> > > * Original proposal for this fix was done by Sukumar Ghoral of
> > >   Texas Instruments
> > >
> > > * Tested using a Texas Instruments AM335x EVM
> > >
> > > Signed-off-by: Chase Maupin <Chase.Maupin@ti.com>
> >
> > Thanks, I've pushed this to mmc-next for 3.4.  (With a trivial
> > indentation fix, below.)
> >
> > diff --git a/drivers/mmc/host/omap_hsmmc.c
> b/drivers/mmc/host/omap_hsmmc.c
> > index 82b400793..9d4ce1c 100644
> > --- a/drivers/mmc/host/omap_hsmmc.c
> > +++ b/drivers/mmc/host/omap_hsmmc.c
> > @@ -1360,7 +1360,7 @@ static void set_data_timeout(struct
> omap_hsmmc_host *host)
> >  	if (clkd == 0)
> >  		clkd = 1;
> >
> > -    /* Use the maximum timeout value allowed in the standard of
> 14 or 0xE */
> > +	/* Use the maximum timeout value allowed in the standard of
> 14 or 0xE */
> >  	dto = 14;
> >
> >  	reg &= ~DTO_MASK;
> 
> I don't think this is the right fix.  Steve Sakoman and I discussed
> this a
> few months ago -- we did some debugging and Steve observed the
> timeouts on
> multiple block writes (0x19):
> 
> hsmmc: command 00000019
> hsmmc: orig_rate = 96000000, div = 2, dto = 11
> hsmmc: using 300000000 ns DTO
> hsmmc: command 0000000d
> mmcblk0: error -110 transferring data, sector 15257840, nr 96, card
> status 0xc00
> 
> So dto = 11 @ 48MHz is a 350ms timeout ((2^(11+13)) / 48000000).
> 
> I don't have an SD bus analyzer, but it looks to me think there are
> some
> SD cards that are not completing the write within the allotted time
> window.  It should be 250ms according to this SD spec:
> 
> https://www.sdcard.org/developers/tech/pls/simplified_specs/Part_1_
> Physical_Layer_Simplified_Specification_Ver_3.01_Final_100518.pdf
> 
> The spec also says "It is strongly recommended for hosts to
> implement more
> than 500ms timeout value even if the card indicates the 250ms
> maximum busy
> length."
> 
> So to me, this should probably be solved in the generic Linux MMC
> layer.
> mmc_set_data_timeout() should presumably be using a huge timeout on
> writes.  Don't know what it should be but the current 300ms goal is
> arbitrary anyway - see commit
> 493890e75d98810a3470b4aae23be628ee5e9667
> ("mmc: increase SD write timeout for crappy cards").
> 
> Otherwise, if we just change the OMAP host controller driver, we
> could run
> into the same problem on other controllers.  While this issue could
> be an
> OMAP specific problem, at the moment I don't see any obvious
> evidence of
> that.
> 
> So perhaps something like the following patch instead?
> Unfortunately, I
> don't have one of these crappy SD cards as far as I know, so I
> can't
> really test it.

I would be OK with that.  I picked the dto=14 because it has worked for us as well as that being the max value I saw defined in section 2 of the spec (section 2.2.15 to be exact).  If you want to pull this up to be more generic I think that makes sense.

> 
> 
> - Paul
> 
> From: Paul Walmsley <paul@pwsan.com>
> Date: Mon, 12 Mar 2012 04:46:29 -0600
> Subject: [PATCH] mmc: use really long write timeout to deal with
> crappy cards
> 
> Several people have noticed that crappy SD cards take much longer
> to
> complete multiple block writes than the 300ms that Linux specifies.
> Try to work around this by using a three second write timeout
> instead.
> 
> <insert Chase's patch description here>
> 
> Not-yet-signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>  drivers/mmc/core/core.c |   10 +++++++---
>  1 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 690255c..0f2caca 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -526,10 +526,14 @@ void mmc_set_data_timeout(struct mmc_data
> *data, const struct mmc_card *card)
> 
>  		if (data->flags & MMC_DATA_WRITE)
>  			/*
> -			 * The limit is really 250 ms, but that is
> -			 * insufficient for some crappy cards.
> +			 * The MMC spec "It is strongly recommended
> +			 * for hosts to implement more than 500ms
> +			 * timeout value even if the card indicates
> +			 * the 250ms maximum busy length."  Even the
> +			 * previous value of 300ms is known to be
> +			 * insufficient for some cards.
>  			 */
> -			limit_us = 300000;
> +			limit_us = 3000000;
>  		else
>  			limit_us = 100000;
> 
> --
> 1.7.9.1

