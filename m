From: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] at_hdmac: move to generic DMA binding
Date: Tue, 16 Apr 2013 12:03:45 +0200
Message-ID: <516D2201.8030002@atmel.com>
References: <1366028217-5037-1-git-send-email-ludovic.desroches@atmel.com> <1366028217-5037-2-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1366028217-5037-2-git-send-email-ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 04/15/2013 02:16 PM, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org :
> From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> 
> Update at_hdmac driver to support generic DMA device tree binding. Devices
> can still request channel with dma_request_channel() then it doesn't break
> DMA for non DT boards.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Some minor comments but the overall is good: so, after adding a little
more explanation to documentation:

Acked-by: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Very nice and concise patch for adding such an important feature: kudos!


> ---
>  .../devicetree/bindings/dma/atmel-dma.txt          | 26 +++++-
>  arch/arm/boot/dts/sama5d3.dtsi                     |  4 +-

Maybe we can have a separate patch for .dtsi modifications.

>  drivers/dma/at_hdmac.c                             | 93 ++++++++++++++++++++--
>  drivers/dma/at_hdmac_regs.h                        |  4 +
>  4 files changed, 117 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/atmel-dma.txt b/Documentation/devicetree/bindings/dma/atmel-dma.txt
> index 3c046ee..4179bd2 100644
> --- a/Documentation/devicetree/bindings/dma/atmel-dma.txt
> +++ b/Documentation/devicetree/bindings/dma/atmel-dma.txt
> @@ -4,11 +4,33 @@ Required properties:
>  - compatible: Should be "atmel,<chip>-dma"
>  - reg: Should contain DMA registers location and length
>  - interrupts: Should contain DMA interrupt
> +- #dma-cells: Must be <2>

Maybe add some explanation (taken from pl330): "used to represent the
number of integer cells in the dmas property of client device."



> -Examples:
> +Example:
>  
> -dma@ffffec00 {
> +dma0: dma@ffffec00 {
>  	compatible = "atmel,at91sam9g45-dma";
>  	reg = <0xffffec00 0x200>;
>  	interrupts = <21>;
> +	#dma-cells = <2>;
> +};
> +
> +DMA clients connected to the Atmel DMA controller must use the format
> +described in the dma.txt file, using a three-cell specifier for each channel

(to establish the link with the #dma-cells property:)
"
using a three-cell specifier for each channel: a phandle plus two
integer cells.
"

> +The three cells in order are:
> +
> +1. A phandle pointing to the DMA controller
> +2. The memory interface (16 most significant bits), the peripheral interface
> +(16 less significant bits)
> +3. The peripheral identifier (can be different for tx and rx)

Yes but the peripheral identifier needs more explanation: what about:
"
Peripheral identifier for the hardware handshaking interface. The
identifier can be different for tx and rx.
"

> +
> +Example:
> +
> +i2c0@i2c@f8010000 {
> +	compatible = "atmel,at91sam9x5-i2c";
> +	reg = <0xf8010000 0x100>;
> +	interrupts = <9 4 6>;
> +	dmas = <&dma0 1 7>,
> +	       <&dma0 1 8>;
> +	dma-names = "tx", "rx"
>  };
> diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
> index 39b0458..95c00a3 100644
> --- a/arch/arm/boot/dts/sama5d3.dtsi
> +++ b/arch/arm/boot/dts/sama5d3.dtsi

Ditto.

> @@ -348,14 +348,14 @@
>  				compatible = "atmel,at91sam9g45-dma";
>  				reg = <0xffffe600 0x200>;
>  				interrupts = <30 4 0>;
> -				#dma-cells = <1>;
> +				#dma-cells = <2>;
>  			};
>  
>  			dma1: dma-controller@ffffe800 {
>  				compatible = "atmel,at91sam9g45-dma";
>  				reg = <0xffffe800 0x200>;
>  				interrupts = <31 4 0>;
> -				#dma-cells = <1>;
> +				#dma-cells = <2>;
>  			};
>  
>  			ramc0: ramc@ffffea00 {
> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> index 8415467..d5f7a1b 100644
> --- a/drivers/dma/at_hdmac.c
> +++ b/drivers/dma/at_hdmac.c
> @@ -24,6 +24,7 @@
>  #include <linux/slab.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/of_dma.h>
>  
>  #include "at_hdmac_regs.h"
>  #include "dmaengine.h"
> @@ -676,7 +677,7 @@ atc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>  		ctrlb |=  ATC_DST_ADDR_MODE_FIXED
>  			| ATC_SRC_ADDR_MODE_INCR
>  			| ATC_FC_MEM2PER
> -			| ATC_SIF(AT_DMA_MEM_IF) | ATC_DIF(AT_DMA_PER_IF);
> +			| ATC_SIF(atchan->mem_if) | ATC_DIF(atchan->per_if);
>  		reg = sconfig->dst_addr;
>  		for_each_sg(sgl, sg, sg_len, i) {
>  			struct at_desc	*desc;
> @@ -715,7 +716,7 @@ atc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>  		ctrlb |=  ATC_DST_ADDR_MODE_INCR
>  			| ATC_SRC_ADDR_MODE_FIXED
>  			| ATC_FC_PER2MEM
> -			| ATC_SIF(AT_DMA_PER_IF) | ATC_DIF(AT_DMA_MEM_IF);
> +			| ATC_SIF(atchan->per_if) | ATC_DIF(atchan->mem_if);
>  
>  		reg = sconfig->src_addr;
>  		for_each_sg(sgl, sg, sg_len, i) {
> @@ -821,8 +822,8 @@ atc_dma_cyclic_fill_desc(struct dma_chan *chan, struct at_desc *desc,
>  		desc->lli.ctrlb = ATC_DST_ADDR_MODE_FIXED
>  				| ATC_SRC_ADDR_MODE_INCR
>  				| ATC_FC_MEM2PER
> -				| ATC_SIF(AT_DMA_MEM_IF)
> -				| ATC_DIF(AT_DMA_PER_IF);
> +				| ATC_SIF(atchan->mem_if)
> +				| ATC_DIF(atchan->per_if);
>  		break;
>  
>  	case DMA_DEV_TO_MEM:
> @@ -832,8 +833,8 @@ atc_dma_cyclic_fill_desc(struct dma_chan *chan, struct at_desc *desc,
>  		desc->lli.ctrlb = ATC_DST_ADDR_MODE_INCR
>  				| ATC_SRC_ADDR_MODE_FIXED
>  				| ATC_FC_PER2MEM
> -				| ATC_SIF(AT_DMA_PER_IF)
> -				| ATC_DIF(AT_DMA_MEM_IF);
> +				| ATC_SIF(atchan->per_if)
> +				| ATC_DIF(atchan->mem_if);
>  		break;
>  
>  	default:
> @@ -1189,6 +1190,67 @@ static void atc_free_chan_resources(struct dma_chan *chan)
>  	dev_vdbg(chan2dev(chan), "free_chan_resources: done\n");
>  }
>  
> +static bool at_dma_filter(struct dma_chan *chan, void *slave)
> +{
> +	struct at_dma_slave *atslave = slave;
> +
> +	if (atslave->dma_dev == chan->device->dev) {
> +		chan->private = atslave;
> +		return true;
> +	} else {
> +		return false;
> +	}
> +}
> +
> +#ifdef CONFIG_OF
> +static struct dma_chan *at_dma_xlate(struct of_phandle_args *dma_spec,
> +				     struct of_dma *of_dma)
> +{
> +	struct dma_chan *chan;
> +	struct at_dma_chan *atchan;
> +	struct at_dma_slave *atslave;
> +	dma_cap_mask_t mask;
> +	unsigned int per_id;
> +	struct platform_device *dmac_pdev;
> +
> +	if (dma_spec->args_count != 2)
> +		return NULL;
> +
> +	dmac_pdev = of_find_device_by_node(dma_spec->np);
> +
> +	dma_cap_zero(mask);
> +	dma_cap_set(DMA_SLAVE, mask);
> +
> +	atslave = devm_kzalloc(&dmac_pdev->dev, sizeof(*atslave), GFP_KERNEL);
> +	if (!atslave)
> +		return NULL;
> +	/*
> +	 * We can fill both SRC_PER and DST_PER, one of these fields will be
> +	 * ignored depending on DMA transfer direction.
> +	 */
> +	per_id = dma_spec->args[1];
> +	atslave->cfg = ATC_FIFOCFG_HALFFIFO | ATC_DST_H2SEL_HW
> +		      | ATC_SRC_H2SEL_HW | ATC_DST_PER(per_id)
> +		      | ATC_SRC_PER(per_id);
> +	atslave->dma_dev = &dmac_pdev->dev;
> +
> +	chan = dma_request_channel(mask, at_dma_filter, atslave);
> +	if (!chan)
> +		return NULL;
> +
> +	atchan = to_at_dma_chan(chan);
> +	atchan->per_if = dma_spec->args[0] & 0xff;
> +	atchan->mem_if = (dma_spec->args[0] >> 16) & 0xff;
> +
> +	return chan;
> +}
> +#else
> +static struct dma_chan *at_dma_xlate(struct of_phandle_args *dma_spec,
> +				     struct of_dma *of_dma)
> +{
> +	return NULL;
> +}
> +#endif
>  
>  /*--  Module Management  -----------------------------------------------*/
>  
> @@ -1343,6 +1405,8 @@ static int __init at_dma_probe(struct platform_device *pdev)
>  	for (i = 0; i < plat_dat->nr_channels; i++) {
>  		struct at_dma_chan	*atchan = &atdma->chan[i];
>  
> +		atchan->mem_if = AT_DMA_MEM_IF;
> +		atchan->per_if = AT_DMA_PER_IF;
>  		atchan->chan_common.device = &atdma->dma_common;
>  		dma_cookie_init(&atchan->chan_common);
>  		list_add_tail(&atchan->chan_common.device_node,
> @@ -1389,8 +1453,25 @@ static int __init at_dma_probe(struct platform_device *pdev)
>  
>  	dma_async_device_register(&atdma->dma_common);
>  
> +	/*
> +	 * Do not return an error if the dmac node is not present in order to
> +	 * not break the existing way of requesting channel with
> +	 * dma_request_channel().
> +	 */
> +	if (pdev->dev.of_node) {
> +		err = of_dma_controller_register(pdev->dev.of_node,
> +						 at_dma_xlate, atdma);
> +		if (err) {
> +			dev_err(&pdev->dev, "could not register of_dma_controller\n");
> +			goto err_of_dma_controller_register;
> +		}
> +	}
> +
>  	return 0;
>  
> +err_of_dma_controller_register:
> +	dma_async_device_unregister(&atdma->dma_common);
> +	dma_pool_destroy(atdma->dma_desc_pool);
>  err_pool_create:
>  	platform_set_drvdata(pdev, NULL);
>  	free_irq(platform_get_irq(pdev, 0), atdma);
> diff --git a/drivers/dma/at_hdmac_regs.h b/drivers/dma/at_hdmac_regs.h
> index 0eb3c13..c604d26 100644
> --- a/drivers/dma/at_hdmac_regs.h
> +++ b/drivers/dma/at_hdmac_regs.h
> @@ -220,6 +220,8 @@ enum atc_status {
>   * @device: parent device
>   * @ch_regs: memory mapped register base
>   * @mask: channel index in a mask
> + * @per_if: peripheral interface
> + * @mem_if: memory interface
>   * @status: transmit status information from irq/prep* functions
>   *                to tasklet (use atomic operations)
>   * @tasklet: bottom half to finish transaction work
> @@ -238,6 +240,8 @@ struct at_dma_chan {
>  	struct at_dma		*device;
>  	void __iomem		*ch_regs;
>  	u8			mask;
> +	u8			per_if;
> +	u8			mem_if;
>  	unsigned long		status;
>  	struct tasklet_struct	tasklet;
>  	u32			save_cfg;
> 


-- 
Nicolas Ferre
