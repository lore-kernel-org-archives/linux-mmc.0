From: Ben Hutchings <ben.hutchings-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Subject: Re: [RFC PATCH 1/7] mmc: tmio: Add UHS-I mode support
Date: Mon, 11 May 2015 15:04:36 +0100
Message-ID: <1431353076.4222.104.camel@xylophone.i.decadent.org.uk>
References: <1430396995.5802.39.camel@xylophone.i.decadent.org.uk>
	 <1430397051.5802.40.camel@xylophone.i.decadent.org.uk>
	 <87egmn4wfo.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87egmn4wfo.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Ian Molton <ian-zdned+2MO1+9FHfhHBbuYA@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-81qHHgoATdFT9dQujB1mzip2UmYkHbXO@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Mon, 2015-05-11 at 03:38 +0000, Kuninori Morimoto wrote:
> Hi Ben
> 
> Thank you for your patch
> 
> > Based on work by Shinobu Uehara and Ben Dooks.  This adds the
> > voltage switch operation needed for all UHS-I modes, but not
> > the tuning needed for SDR-104 which will come later.
> > 
> > XXX The card_busy implementation is a bit of a guess.
> > 
> > Signed-off-by: Ben Hutchings <ben.hutchings-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
> 
> If original patch was created by Shinobu/Ben Dooks,
> and you updated it, I prefer to add these guys on Signed-off-by line.
> 
> >  static const struct mmc_host_ops tmio_mmc_ops = {
> >  	.request	= tmio_mmc_request,
> >  	.set_ios	= tmio_mmc_set_ios,
> >  	.get_ro         = tmio_mmc_get_ro,
> >  	.get_cd		= mmc_gpio_get_cd,
> >  	.enable_sdio_irq = tmio_mmc_enable_sdio_irq,
> > +	.start_signal_voltage_switch
> > +			= tmio_mmc_start_signal_voltage_switch,
> > +	.card_busy	= tmio_mmc_card_busy,
> >  	.multi_io_quirk	= tmio_multi_io_quirk,
> >  };
> 
> I prefer to separate this patch for these 2 new callbacks if possible.

They are both used only by mmc_set_signal_voltage(), which warns if only
start_signal_voltage_switch is implemented.  So it doesn't make sense to
add them separately.

Ben.


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
