From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v7 01/10] ARM: davinci: move private EDMA API to arm/common
Date: Sat, 9 Feb 2013 21:35:53 +0530
Message-ID: <511673E1.7000908@ti.com>
References: <1359742975-10421-1-git-send-email-mporter@ti.com>
	<1359742975-10421-2-git-send-email-mporter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1359742975-10421-2-git-send-email-mporter-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Matt,

This version introduces build/bisect issues.

On 2/1/2013 11:52 PM, Matt Porter wrote:
> Move mach-davinci/dma.c to common/edma.c so it can be used
> by OMAP (specifically AM33xx) as well.
> 
> Signed-off-by: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
> Acked-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>

> diff --git a/arch/arm/mach-davinci/dma.c b/arch/arm/common/edma.c

> @@ -25,7 +25,7 @@
>  #include <linux/io.h>
>  #include <linux/slab.h>
>  
> -#include <mach/edma.h>
> +#include <linux/platform_data/edma.h>

>  /*-----------------------------------------------------------------------*/
> +static int edma_of_read_u32_to_s8_array(const struct device_node *np,
> +					 const char *propname, s8 *out_values,
> +					 size_t sz)
> +{
> +	int ret;
> +
> +	ret = of_property_read_u8_array(np, propname, out_values, sz);

This needs <linux/of.h> to be included in this file.

> +static int edma_xbar_event_map(struct device *dev,
> +			       struct device_node *node,
> +			       struct edma_soc_info *pdata, int len)
> +{
> +	int ret = 0;
> +	int i;
> +	struct resource res;
> +	void *xbar;
> +	const s16 (*xbar_chans)[2];
> +	u32 shift, offset, mux;
> +
> +	xbar_chans = devm_kzalloc(dev,
> +				  len/sizeof(s16) + 2*sizeof(s16),
> +				  GFP_KERNEL);
> +	if (!xbar_chans)
> +		return -ENOMEM;
> +
> +	ret = of_address_to_resource(node, 1, &res);

of_address_to_resource() needs <linux/of_address.h>

> +	if (IS_ERR_VALUE(ret))

This needs <linux/err.h>

> +		return -EIO;
> +
> +	xbar = devm_ioremap(dev, res.start, resource_size(&res));
> +	if (!xbar)
> +		return -ENOMEM;
> +
> +	ret = edma_of_read_u32_to_s16_array(node,
> +					    "ti,edma-xbar-event-map",
> +					    (s16 *)xbar_chans,
> +					    len/sizeof(u32));
> +	if (IS_ERR_VALUE(ret))
> +		return -EIO;
> +
> +	for (i = 0; xbar_chans[i][0] != -1; i++) {
> +		shift = (xbar_chans[i][1] % 4) * 8;
> +		offset = xbar_chans[i][1] >> 2;
> +		offset <<= 2;
> +		mux = readl((void *)((u32)xbar + offset));
> +		mux &= ~(0xff << shift);
> +		mux |= xbar_chans[i][0] << shift;
> +		writel(mux, (void *)((u32)xbar + offset));
> +	}
> +
> +	pdata->xbar_chans = xbar_chans;

There is no member xbar_chans ATM. It seems to be introduced in 03/10.

> +
> +static struct of_dma_filter_info edma_filter_info = {

of_dma_filter_info needs <linux/of_dma.h>.

> +	.filter_fn = edma_filter_fn,

edma_filter_fn needs <linux/edma.h>

BTW, I am not sure if you really intended to introduce EDMA DT support
in this patch. I thought 1/10 was supposed to just move EDMA private API
to a common place. If you really want to introduce DT support as well,
that should be noted in the description. I think it is better done in a
later patch.

> diff --git a/sound/soc/davinci/davinci-sffsdr.c b/sound/soc/davinci/davinci-sffsdr.c

> @@ -17,6 +17,7 @@
>  #include <linux/timer.h>
>  #include <linux/interrupt.h>
>  #include <linux/platform_device.h>
> +#include <linux/platform_data/edma.h>
>  #include <linux/gpio.h>
>  #include <sound/core.h>
>  #include <sound/pcm.h>
> @@ -28,12 +29,14 @@
>  #include <asm/plat-sffsdr/sffsdr-fpga.h>
>  #endif
>  
> -#include <mach/edma.h>
>  
>  #include "../codecs/pcm3008.h"
>  #include "davinci-pcm.h"
>  #include "davinci-i2s.h"
>  
> +#define DAVINCI_DMA_MCBSP_TX	2
> +#define DAVINCI_DMA_MCBSP_RX	3
> +
>  /*
>   * CLKX and CLKR are the inputs for the Sample Rate Generator.
>   * FSX and FSR are outputs, driven by the sample Rate Generator.
> @@ -124,7 +127,7 @@ static struct resource sffsdr_snd_resources[] = {
>  
>  static struct evm_snd_platform_data sffsdr_snd_data = {
>  	.tx_dma_ch	= DAVINCI_DMA_MCBSP_TX,
> -	.rx_dma_ch	= DAVINCI_DMA_MCBSP_RX,

> +	.rx_dma_ch	= DAVINCI_DMA_MCBAP_RX,

Typo here. Should be DAVINCI_DMA_MCBSP_RX. Unfortunately
davinci-sffsdr.c seems to be broken already.

Thanks,
Sekhar

------------------------------------------------------------------------------
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb
