From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RESEND] initialise DMA engine before MMC
Date: Fri, 27 Aug 2010 13:02:33 -0700
Message-ID: <20100827130233.893e7151.akpm@linux-foundation.org>
References: <Pine.LNX.4.64.1006071312060.12965@axis700.grange>
	<20100827194939.GJ23079@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20100827194939.GJ23079@void.printf.net>
Sender: linux-sh-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-kernel@vger.kernel.org, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Fri, 27 Aug 2010 20:49:39 +0100
Chris Ball <cjb@laptop.org> wrote:

> Hi,
> 
> Andrew, mind taking this one?
> 
> From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Date: Mon, 7 Jun 2010 13:16:36 +0200 (CEST)
> 
> To use DMA engine based DMA with MMC in a non-modular build, the DMA 
> engine has to initialise before MMC.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Acked-by: Dan Williams <dan.j.williams@intel.com>
> ---
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 91874e0..b713e75 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -92,6 +92,7 @@ obj-$(CONFIG_EISA)		+= eisa/
>  obj-y				+= lguest/
>  obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
>  obj-$(CONFIG_CPU_IDLE)		+= cpuidle/
> +obj-$(CONFIG_DMA_ENGINE)	+= dma/
>  obj-$(CONFIG_MMC)		+= mmc/
>  obj-$(CONFIG_MEMSTICK)		+= memstick/
>  obj-$(CONFIG_NEW_LEDS)		+= leds/
> @@ -102,7 +103,6 @@ obj-$(CONFIG_CRYPTO)		+= crypto/
>  obj-$(CONFIG_SUPERH)		+= sh/
>  obj-$(CONFIG_ARCH_SHMOBILE)	+= sh/
>  obj-$(CONFIG_GENERIC_TIME)	+= clocksource/
> -obj-$(CONFIG_DMA_ENGINE)	+= dma/
>  obj-$(CONFIG_DCA)		+= dca/
>  obj-$(CONFIG_HID)		+= hid/
>  obj-$(CONFIG_PPC_PS3)		+= ps3/

erk, doing this via link ordering isn't nice.

It would be better to express this dependency via initcall levels -
core_initcall() or something.


