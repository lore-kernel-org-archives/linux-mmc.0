From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 2/3] mmc: omap_hsmmc: Pin remux workaround to
 support SDIO interrupt on AM335x.
Date: Tue, 26 Nov 2013 10:06:19 -0800
Message-ID: <20131126180619.GH26766@atomide.com>
References: <1385386009-14981-1-git-send-email-afenkart@gmail.com>
 <1385386009-14981-3-git-send-email-afenkart@gmail.com>
 <20131125224601.GX10023@atomide.com>
 <20131126011610.GB21580@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131126011610.GB21580@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Andreas Fenkart <afenkart@gmail.com>, Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>, Balaji T K <balajitk@ti.com>, zonque@gmail.com, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

* Felipe Balbi <balbi@ti.com> [131125 17:17]:
> Hi,
> 
> On Mon, Nov 25, 2013 at 02:46:02PM -0800, Tony Lindgren wrote:
> > * Andreas Fenkart <afenkart@gmail.com> [131125 05:30]:
> > > --- a/drivers/mmc/host/omap_hsmmc.c
> > > +++ b/drivers/mmc/host/omap_hsmmc.c
> > > @@ -452,10 +475,23 @@ static int omap_hsmmc_gpio_init(struct omap_mmc_platform_data *pdata)
> > >  	} else
> > >  		pdata->slots[0].gpio_wp = -EINVAL;
> > >  
> > > +	if (gpio_is_valid(pdata->slots[0].gpio_cirq)) {
> > > +		ret = gpio_request_one(pdata->slots[0].gpio_cirq, GPIOF_DIR_IN,
> > > +				       "sdio_cirq");
> > > +		if (ret)
> > > +			goto err_free_ro;
> > > +
> > > +	} else {
> > > +		pdata->slots[0].gpio_cirq = -EINVAL;
> > > +	}
> > > +
> > > +
> > >  	return 0;
> > >  
> > > +err_free_ro:
> > > +	if (gpio_is_valid(pdata->slots[0].gpio_wp))
> > >  err_free_wp:
> > > -	gpio_free(pdata->slots[0].gpio_wp);
> > > +		gpio_free(pdata->slots[0].gpio_wp);
> > >  err_free_cd:
> > >  	if (gpio_is_valid(pdata->slots[0].switch_pin))
> > >  err_free_sp:
> > 
> > This patch we can now make a bit more generic with the recent addition
> > of interrupts-extended property that's now merged in mainline tree :)
> > 
> > We can optionally pass two interrupts to omap_hsmmc.c where the second
> > interrupt is either the pinctrl-single wake-up interrupt, or the GPIO
> > interrupt.
> > 
> > Both the iochain wake interrupt or the GPIO interrupt are available with
> > request_irq as long as configured in the .dts file. And can both use the
> > SDIO interrupt handler. The only difference is that the GPIO wake-up
> > still needs to do the dynamic remuxing of pins.
> 
> could that be done automatically if DTS provides "suspend" pinctrl
> state ?

Yes based on the compatible flag and the provided named pin states.
 
> Would that be done before or after driver's ->{runtime_,}suspend()
> methods ?

Pins need to remuxed to GPIO input on 33xx in runtime suspend, and then
back to SDIO dat1 in runtime resume. Possibly needs to be done also for
34xx, but that's yet to be seen.
 
> > mmc: mmc@4810abcd {
> > 	compatible = "ti,omap33xx-hsmmc";
> 
> I would rather call it "ti,am33xx-hsmmc" just to make it match marketing
> name of the device.

Except you have both am33xx and dm33xx where the only difference is the
DSP on dm33xx? Other than that, I'm fine with am33xx naming as long as
it's clear to people and does not involve adding dm33xx stuff separately.
 
> > Then the logic of enabling the dynamic remuxing can be done based
> > on the ti,omap33xx-hsmmc compatible flag if there are two interrupts
> > and the needed pin states are defined.
> 
> or maybe dynamic remuxing can be done by calling pinctrl_select_state()
> with appropriate arguments ?

Yes the way to do the remuxing is to call pinctrl_select_state() on the
named state desired.

Regards,

Tony
