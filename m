From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v11 2/8] ARM: edma: Add DT and runtime PM support to the
	private EDMA API
Date: Tue, 18 Jun 2013 15:09:47 +0530
Message-ID: <51C02AE3.5030603@ti.com>
References: <1371537499-12970-1-git-send-email-joelagnel@ti.com>
	<1371537499-12970-3-git-send-email-joelagnel@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1371537499-12970-3-git-send-email-joelagnel-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Joel A Fernandes <joelagnel-l0cyMroinI0@public.gmane.org>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Koen Kooi <koen-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org


On 6/18/2013 12:08 PM, Joel A Fernandes wrote:
> From: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
> 
> Adds support for parsing the TI EDMA DT data into the required EDMA
> private API platform data. Enables runtime PM support to initialize
> the EDMA hwmod. Enables build on OMAP.
> 
> Changes by Joel:
> * Setup default one-to-one mapping for queue_priority and queue_tc
> mapping as discussed in [1].
> * Split out xbar stuff to separate patch. [1]
> 
> [1] https://patchwork.kernel.org/patch/2226761/
> 
> Signed-off-by: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
> Acked-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Joel A Fernandes <joelagnel-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/common/edma.c             |  190 +++++++++++++++++++++++++++++++++---
>  arch/arm/mach-omap2/Kconfig        |    1 +
>  include/linux/platform_data/edma.h |    4 +-
>  3 files changed, 181 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
> index a1db6cd..9823b79 100644
> --- a/arch/arm/common/edma.c
> +++ b/arch/arm/common/edma.c
> @@ -24,6 +24,13 @@
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
>  #include <linux/slab.h>
> +#include <linux/edma.h>
> +#include <linux/err.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/of_dma.h>
> +#include <linux/of_irq.h>
> +#include <linux/pm_runtime.h>
>  
>  #include <linux/platform_data/edma.h>
>  
> @@ -1369,31 +1376,173 @@ void edma_clear_event(unsigned channel)
>  EXPORT_SYMBOL(edma_clear_event);
>  
>  /*-----------------------------------------------------------------------*/
> +static int edma_of_read_u32_to_s8_array(const struct device_node *np,
> +					 const char *propname, s8 *out_values,
> +					 size_t sz)
> +{
> +	int ret;
> +
> +	ret = of_property_read_u8_array(np, propname, out_values, sz);
> +	if (ret)
> +		return ret;
> +
> +	/* Terminate it */
> +	*out_values++ = -1;
> +	*out_values++ = -1;
> +
> +	return 0;
> +}
> +
> +static int edma_of_read_u32_to_s16_array(const struct device_node *np,
> +					 const char *propname, s16 *out_values,
> +					 size_t sz)
> +{
> +	int ret;
> +
> +	ret = of_property_read_u16_array(np, propname, out_values, sz);
> +	if (ret)
> +		return ret;
> +
> +	/* Terminate it */
> +	*out_values++ = -1;
> +	*out_values++ = -1;
> +
> +	return 0;
> +}

These functions dont get used here. Can you introduce them when you
actually need them?

>  
> -static int __init edma_probe(struct platform_device *pdev)
> +static int edma_of_parse_dt(struct device *dev,
> +			    struct device_node *node,
> +			    struct edma_soc_info *pdata)
> +{
> +	int ret = 0, i;
> +	u32 value;
> +	struct property *prop;
> +	size_t sz;
> +	struct edma_rsv_info *rsv_info;
> +	const s16 (*rsv_chans)[2], (*rsv_slots)[2];

rsv_slots is unused. You get an unused variable warning here. rsv_chans
is also unused.

> +	s8 (*queue_tc_map)[2], (*queue_priority_map)[2];
> +
> +	memset(pdata, 0, sizeof(struct edma_soc_info));
> +
> +	ret = of_property_read_u32(node, "dma-channels", &value);
> +	if (ret < 0)
> +		return ret;
> +	pdata->n_channel = value;
> +
> +	ret = of_property_read_u32(node, "ti,edma-regions", &value);
> +	if (ret < 0)
> +		return ret;
> +	pdata->n_region = value;
> +
> +	ret = of_property_read_u32(node, "ti,edma-slots", &value);
> +	if (ret < 0)
> +		return ret;
> +	pdata->n_slot = value;
> +
> +	pdata->n_cc = 1;
> +	pdata->n_tc = 3;

n_tc is not used in the driver AFAICS. You can drop this line and also
possibly remove the platform data member as well.

> +
> +	rsv_info =
> +		devm_kzalloc(dev, sizeof(struct edma_rsv_info), GFP_KERNEL);
> +	if (!rsv_info)
> +		return -ENOMEM;
> +	pdata->rsv = rsv_info;
> +
> +	queue_tc_map = devm_kzalloc(dev, 8*sizeof(s8), GFP_KERNEL);
> +	if (!queue_tc_map)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < 3; i++)
> +		queue_tc_map[i][0] = queue_tc_map[i][1] = i;
> +	queue_tc_map[i][0] = queue_tc_map[i][1] = -1;
> +
> +	pdata->queue_tc_mapping = queue_tc_map;
> +
> +	queue_priority_map = devm_kzalloc(dev, 8*sizeof(s8), GFP_KERNEL);
> +	if (!queue_priority_map)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < 3; i++)
> +		queue_priority_map[i][0] = queue_priority_map[i][1] = i;
> +	queue_priority_map[i][0] = queue_priority_map[i][1] = -1;
> +
> +	pdata->queue_priority_mapping = queue_priority_map;
> +
> +	pdata->default_queue = 0;
> +
> +

Extra empty line here.

> +	return ret;
> +}

Usage of devres APIs in this function is nice, but, there is no check
for return value of edma_of_parse_dt() in the probe down below. So in
effect it leaks memory on error.

> +
> +static struct of_dma_filter_info edma_filter_info = {
> +	.filter_fn = edma_filter_fn,
> +};
> +
> +static int edma_probe(struct platform_device *pdev)
>  {
>  	struct edma_soc_info	**info = pdev->dev.platform_data;
> -	const s8		(*queue_priority_mapping)[2];
> -	const s8		(*queue_tc_mapping)[2];
> +	struct edma_soc_info	*ninfo[EDMA_MAX_CC] = {NULL, NULL};

Nit: just {NULL} is enough.

> +	struct edma_soc_info	tmpinfo;
> +	s8		(*queue_priority_mapping)[2];
> +	s8		(*queue_tc_mapping)[2];
>  	int			i, j, off, ln, found = 0;
>  	int			status = -1;
>  	const s16		(*rsv_chans)[2];
>  	const s16		(*rsv_slots)[2];
>  	int			irq[EDMA_MAX_CC] = {0, 0};
>  	int			err_irq[EDMA_MAX_CC] = {0, 0};
> -	struct resource		*r[EDMA_MAX_CC] = {NULL};
> +	struct resource		*r[EDMA_MAX_CC] = {NULL, NULL};

No need for this change. C array initialization will initialize missing
values to 0.

> +	struct resource		res[EDMA_MAX_CC];
>  	resource_size_t		len[EDMA_MAX_CC];

res and len should disappear once you rebase to Prabhakar's patch. That
patch is present in v3.11/soc-2 branch of my tree. Please rebase your
series to that.

> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index f49cd51..f91b07f 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -17,6 +17,7 @@ config ARCH_OMAP2PLUS
>  	select PROC_DEVICETREE if PROC_FS
>  	select SOC_BUS
>  	select SPARSE_IRQ
> +	select TI_PRIV_EDMA
>  	select USE_OF
>  	help
>  	  Systems based on OMAP2, OMAP3, OMAP4 or OMAP5

This hunk doesnt really belong here. You can merge it with the patch
which introduces EDMA support to AM335x.

> diff --git a/include/linux/platform_data/edma.h b/include/linux/platform_data/edma.h
> index 2344ea2..317f2be 100644
> --- a/include/linux/platform_data/edma.h
> +++ b/include/linux/platform_data/edma.h
> @@ -175,8 +175,8 @@ struct edma_soc_info {
>  	/* Resource reservation for other cores */
>  	struct edma_rsv_info	*rsv;
>  
> -	const s8	(*queue_tc_mapping)[2];
> -	const s8	(*queue_priority_mapping)[2];
> +	s8	(*queue_tc_mapping)[2];
> +	s8	(*queue_priority_mapping)[2];

This causes a bunch of gcc and sparse warnings in devices-da8xx.c (and
probably elsewhere in mach-davinci). Can you please check those and fix?

See: http://paste.ubuntu.com/5776604/

Thanks,
Sekhar
