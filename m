From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH 1/3] irq: If an IRQ is a GPIO, request and configure it
Date: Fri, 2 Sep 2011 08:34:43 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04B327A55E@HQMAIL01.nvidia.com>
References: <1312498820-2275-1-git-send-email-swarren@nvidia.com>
 <1312498820-2275-2-git-send-email-swarren@nvidia.com>
 <alpine.LFD.2.02.1109021027360.2723@ionos>
 <74CDBE0F657A3D45AFBB94109FB122FF04B327A55C@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF04B327A55C-C7FfzLzN0UxDw2glCA4ptUEOCMrvLtNR@public.gmane.org>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, "ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org" <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, "olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org" <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Stephen Warren wrote at Friday, September 02, 2011 9:25 AM:
> Thomas Gleixner wrote at Friday, September 02, 2011 2:37 AM:
> > On Thu, 4 Aug 2011, Stephen Warren wrote:
> >
> > > Many IRQs are associated with GPIO pins. When the pin is used as an IRQ,
> > > it can't be used as anything else; it should be requested. Enhance the
> > > core interrupt code to call gpio_request() and gpio_direction_input() for
> > > any IRQ that is also a GPIO. This prevents duplication of these calls in
> > > each driver that uses an IRQ.
> >
> > This is very much the wrong approach. If you think it through then the
> > irq setup code might end up with tons of other subsystem specific
> > setup thingies, e.g. PCI .....
> >
> > The right thing to do is to add a irq_configure() function pointer to
> > the irq chip and provide a common function for gpios in gpiolib, which
> > is then used by the particular GPIO irq chip implementation.
> 
> Sorry, could you expand on this some more.

Uggh. Sorry; just ignore this response; I got it confused with the responses
to my proposed I2C changes. I've long-since dropped the patch that you
responded to.

-- 
nvpublic
