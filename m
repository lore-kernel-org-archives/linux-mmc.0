From: Ben Dooks <ben-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Subject: Re: [RFC PATCH 0/3] If an IRQ is a GPIO, request and configure it
Date: Fri, 5 Aug 2011 08:55:00 +0100
Message-ID: <20110805075500.GC28651@trinity.fluff.org>
References: <1312498820-2275-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1312498820-2275-1-git-send-email-swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Aug 04, 2011 at 05:00:17PM -0600, Stephen Warren wrote:
> In http://www.spinics.net/lists/linux-tegra/msg01731.html, Mark Brown
> pointed out that it was a little silly forcing every board or driver
> to gpio_request() a GPIO that is later converted to an IRQ, and passed
> to request_irq. The first patch in this series instead makes the core
> IRQ code perform these calls when appropriate, to avoid duplicating it
> everywhere.

Interesting, as this is not the case across all the ARM systems, as
I believe that many of the s3c24xx do not bother to request the GPIOs
before using them as interrupts.
 
> However, this change has the potential for significant regressions; at
> least some drivers are already calling gpio_request for GPIOs that are
> also used as IRQs. This then causes the gpio_request inside the core IRQ
> code to fail, which causes functional regressions. I'm not sure how wide-
> spread this issue is, but in testing on NVIDIA Tegra, I found two
> instances that needed to be fixed. Perhaps  a failure of gpio_request
> in the core IRQ code should trigger a WARN rather than returning an
> error, to give a grace period for conversion of other code?

Do we really need to request the GPIO? I suppose it is useful to stop
someone else trying to play with it...

Another interesting problem is to do with using an GPIO that has been
assigned to an interrupt as a readable resource in the driver, since
the 

I would also consider that the implementor of the IRQs set_type configure
the specific GPIO to the correct mode for operating as an interrupt when
it is called... this would reduce any problems of passing GPIOs to drivers
(especially if device tree is being used) to avoid having to do any
arch-specific mode calls.
 
> Stephen Warren (3):
>   irq: If an IRQ is a GPIO, request and configure it
>   mmc: tegra: Don't gpio_request GPIOs used as IRQs.
>   ASoC: jack_add_gpios: Don't gpio_request GPIOs used as IRQs.
> 
>  drivers/mmc/host/sdhci-tegra.c |    8 --------
>  kernel/irq/manage.c            |   25 +++++++++++++++++++++++--
>  sound/soc/soc-jack.c           |   13 +------------
>  3 files changed, 24 insertions(+), 22 deletions(-)
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Ben Dooks, ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
