From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH 1/3] irq: If an IRQ is a GPIO, request and configure it
Date: Thu, 4 Aug 2011 20:53:34 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF049F171EC1@HQMAIL01.nvidia.com>
References: <1312498820-2275-1-git-send-email-swarren@nvidia.com>
 <1312498820-2275-2-git-send-email-swarren@nvidia.com>
 <20110805000148.GB13321@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110805000148.GB13321-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, "ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org" <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, "olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org" <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Mark Brown wrote at Thursday, August 04, 2011 6:02 PM:
> On Thu, Aug 04, 2011 at 05:00:18PM -0600, Stephen Warren wrote:
> 
> > +	} else {
> > +		gpio = irq_to_gpio(irq);
> > +		if (gpio_is_valid(gpio)) {
> > +			ret = gpio_request(gpio, new->name);
> > +			if (ret < 0)
> > +				goto out_mask;
> > +			ret = gpio_direction_input(gpio);
> > +			if (ret < 0)
> > +				goto out_mask;
> > +		}
> 
> If you treat failures as an error what happens when a driver is using a
> GPIO as both an interrupt and a GPIO?  For example a driver which
> monitors the level on a GPIO and uses edge triggered IRQs to be notified
> of state changes.

Well, things break. This is essentially the problem I was describing in
the PATCH 0 email, just with a slightly different motivation.

I suppose that an alternative here would be to simply ignore any errors
from gpio_request. This might have the benefit of removing the need for
the other two patches I posted in the series. However, it seems a little
dirty; one benefit of the IRQ code calling gpio_request and honoring
errors would be to detect when some completely unrelated code had a bug
and had called gpio_request on the GPIO before. Such detection would be
non-existent if we don't error out on gpio_request. Perhaps some mechanism
is needed to indicate that the driver has explicitly already called
gpio_request for a legitimate shared purpose, and only then ignore
errors?

--
nvpublic
