From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH 0/3] If an IRQ is a GPIO, request and configure it
Date: Fri, 5 Aug 2011 10:40:17 +0100
Message-ID: <20110805094017.GC20575@n2100.arm.linux.org.uk>
References: <1312498820-2275-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36215 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766Ab1HEJlB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Aug 2011 05:41:01 -0400
Content-Disposition: inline
In-Reply-To: <1312498820-2275-1-git-send-email-swarren@nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Warren <swarren@nvidia.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Chris Ball <cjb@laptop.org>, ccross@android.com, olof@lixom.net, alsa-devel@alsa-project.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Aug 04, 2011 at 05:00:17PM -0600, Stephen Warren wrote:
> In http://www.spinics.net/lists/linux-tegra/msg01731.html, Mark Brown
> pointed out that it was a little silly forcing every board or driver
> to gpio_request() a GPIO that is later converted to an IRQ, and passed
> to request_irq. The first patch in this series instead makes the core
> IRQ code perform these calls when appropriate, to avoid duplicating it
> everywhere.

Trying to go from IRQ to GPIO is not a good idea - most of the
IRQ <-> GPIO macros we have today are just plain broken.  Many of them
just add or subtract a constant, which means non-GPIO IRQs have an
apparant GPIO number too.  Couple this with the fact that all positive
GPIO numbers are valid, and this is a recipe for wrong GPIOs getting
used and GPIOs being requested for non-GPIO IRQs.

I think this was also discussed in the past, and the conclusion was that
IRQs should be kept separate from GPIOs.  Maybe views have changed since
then...

However, if we do want to do this, then it would be much better to provide
a new API for requesting GPIO IRQs, eg:

gpio_request_irq()

which would wrap around request_threaded_irq(), takes a GPIO number,
does the GPIO->IRQ conversion internally, and whatever GPIO setup is
required.  Something like this:

int gpio_request_threaded_irq(int gpio, irq_handler_t handler,
	irq_handler_t thread_fn, unsigned long flags, const char *name,
	void *dev)
{
	int ret;

	if (!gpio_valid(gpio))
		return -EINVAL;

	ret = gpio_request_one(gpio, GPIOF_IN, name);
	if (ret)
		return ret;

	ret = request_threaded_irq(gpio_to_irq(gpio), handler, thread_fn,
				flags, name, dev);
	if (ret)
		gpio_free(gpio);

	return ret;
}

This then limits the exposure of the GPIO<->IRQ conversion macros to just
GPIOs, where the buggy nature of the existing conversions won't impact on
non-GPIO IRQs.
