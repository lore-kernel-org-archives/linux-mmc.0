From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [RFC PATCH 0/3] If an IRQ is a GPIO, request and configure it
Date: Fri, 5 Aug 2011 11:30:46 +0100
Message-ID: <20110805103045.GG28651@trinity.fluff.org>
References: <1312498820-2275-1-git-send-email-swarren@nvidia.com> <20110805094017.GC20575@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110805094017.GC20575-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Aug 05, 2011 at 10:40:17AM +0100, Russell King - ARM Linux wrote:
> On Thu, Aug 04, 2011 at 05:00:17PM -0600, Stephen Warren wrote:
> > In http://www.spinics.net/lists/linux-tegra/msg01731.html, Mark Brown
> > pointed out that it was a little silly forcing every board or driver
> > to gpio_request() a GPIO that is later converted to an IRQ, and passed
> > to request_irq. The first patch in this series instead makes the core
> > IRQ code perform these calls when appropriate, to avoid duplicating it
> > everywhere.
> 
> Trying to go from IRQ to GPIO is not a good idea - most of the
> IRQ <-> GPIO macros we have today are just plain broken.  Many of them
> just add or subtract a constant, which means non-GPIO IRQs have an
> apparant GPIO number too.  Couple this with the fact that all positive
> GPIO numbers are valid, and this is a recipe for wrong GPIOs getting
> used and GPIOs being requested for non-GPIO IRQs.

Yes, and there's a pile without these defined/
 
> I think this was also discussed in the past, and the conclusion was that
> IRQs should be kept separate from GPIOs.  Maybe views have changed since
> then...
> 
> However, if we do want to do this, then it would be much better to provide
> a new API for requesting GPIO IRQs, eg:
> 
> gpio_request_irq()
> 
> which would wrap around request_threaded_irq(), takes a GPIO number,
> does the GPIO->IRQ conversion internally, and whatever GPIO setup is
> required.  Something like this:
> 
> int gpio_request_threaded_irq(int gpio, irq_handler_t handler,
> 	irq_handler_t thread_fn, unsigned long flags, const char *name,
> 	void *dev)
> {
> 	int ret;
> 
> 	if (!gpio_valid(gpio))
> 		return -EINVAL;
> 
> 	ret = gpio_request_one(gpio, GPIOF_IN, name);
> 	if (ret)
> 		return ret;
> 
> 	ret = request_threaded_irq(gpio_to_irq(gpio), handler, thread_fn,
> 				flags, name, dev);
> 	if (ret)
> 		gpio_free(gpio);
> 
> 	return ret;
> }
> 
> This then limits the exposure of the GPIO<->IRQ conversion macros to just
> GPIOs, where the buggy nature of the existing conversions won't impact on
> non-GPIO IRQs.

What about the case where we need to turn GPIO numbers into interrupts
to pass to other drivers? In the case where we have a gpio chip that is
providing interrupt services to other drivers (such as serial chip).

Having looked at a couple of IIO drivers, it seems that the need to use
irq_to_gpio() seems to be to check if the device needs to be service. It
would be useful to see if this is due to a problem with the threadder IRQ
handler (and if so, may need fixing for the general case).

-- 
Ben Dooks, ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
