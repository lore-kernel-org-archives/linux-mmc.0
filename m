From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] [wip] repair mci dma transfers for avr32
Date: Wed, 12 Aug 2015 19:51:23 +0300
Message-ID: <1439398283.29746.241.camel@linux.intel.com>
References: <1437998010-12036-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1439394548-1020-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:2426 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932153AbbHLRKq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 12 Aug 2015 13:10:46 -0400
In-Reply-To: <1439394548-1020-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, arnd@arndb.de, hskinnemoen@gmail.com, egtvedt@samfundet.no, nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com

On Wed, 2015-08-12 at 17:49 +0200, Ludovic Desroches wrote:
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
> 
> Hi,
> 
> Here is a rough draft to fix the regression. I have only compiled it. 
> I will
> update all the boards later.
> 
> I have removed the mci_dma_data since it is no more used for ARM 
> platforms.

I will test it later, though few comments below.

> 
>  arch/avr32/boards/atngw100/setup.c          |  1 +
>  arch/avr32/mach-at32ap/at32ap700x.c         | 31 
> +++++++++++++++++++++--------
>  arch/avr32/mach-at32ap/include/mach/board.h |  2 ++
>  drivers/mmc/host/atmel-mci.c                | 16 +++++++++++++--
>  include/linux/atmel-mci.h                   |  2 ++
>  include/linux/platform_data/mmc-atmel-mci.h | 22 -------------------
> -
>  6 files changed, 42 insertions(+), 32 deletions(-)
>  delete mode 100644 include/linux/platform_data/mmc-atmel-mci.h
> 
> diff --git a/arch/avr32/boards/atngw100/setup.c 
> b/arch/avr32/boards/atngw100/setup.c
> index afeae89..8b4f3d1 100644
> --- a/arch/avr32/boards/atngw100/setup.c
> +++ b/arch/avr32/boards/atngw100/setup.c
> @@ -131,6 +131,7 @@ static struct mci_platform_data __initdata 
> mci0_data = {
>  		.wp_pin		= GPIO_PIN_PE(0),
>  #endif
>  	},
> +	.dma_filter = &atmci_filter,
>  };
>  
>  static struct usba_platform_data atngw100_usba_data __initdata = {
> diff --git a/arch/avr32/mach-at32ap/at32ap700x.c b/arch/avr32/mach
> -at32ap/at32ap700x.c
> index 1d8b147..8c6f77e 100644
> --- a/arch/avr32/mach-at32ap/at32ap700x.c
> +++ b/arch/avr32/mach-at32ap/at32ap700x.c
> @@ -7,6 +7,7 @@
>   */
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> +#include <linux/dmaengine.h>
>  #include <linux/platform_data/dma-dw.h>
>  #include <linux/fb.h>
>  #include <linux/init.h>
> @@ -17,7 +18,6 @@
>  #include <linux/spi/spi.h>
>  #include <linux/usb/atmel_usba_udc.h>
>  
> -#include <linux/platform_data/mmc-atmel-mci.h>
>  #include <linux/atmel-mci.h>
>  
>  #include <asm/io.h>
> @@ -1332,7 +1332,7 @@ struct platform_device *__init
>  at32_add_device_mci(unsigned int id, struct mci_platform_data *data)
>  {
>  	struct platform_device		*pdev;
> -	struct mci_dma_data	        *slave;
> +	struct dw_dma_slave     	*slave;


>  	u32				pioa_mask;
>  	u32				piob_mask;
>  
> @@ -1351,15 +1351,15 @@ at32_add_device_mci(unsigned int id, struct 
> mci_platform_data *data)
>  				ARRAY_SIZE(atmel_mci0_resource)))
>  		goto fail;
>  
> -	slave = kzalloc(sizeof(struct mci_dma_data), GFP_KERNEL);
> +	slave = kzalloc(sizeof(*slave), GFP_KERNEL);
>  	if (!slave)
>  		goto fail;
>  
> -	slave->sdata.dma_dev = &dw_dmac0_device.dev;
> -	slave->sdata.src_id = 0;
> -	slave->sdata.dst_id = 1;
> -	slave->sdata.src_master = 1;
> -	slave->sdata.dst_master = 0;
> +	slave->dma_dev = &dw_dmac0_device.dev;
> +	slave->src_id = 0;
> +	slave->dst_id = 1;
> +	slave->src_master = 1;
> +	slave->dst_master = 0;
>  
>  	data->dma_slave = slave;
>  
> @@ -1435,6 +1435,21 @@ fail:
>  	return NULL;
>  }
>  
> +bool atmci_filter(struct dma_chan *chan, void *pdata)
> +{
> +	struct dw_dma_slave *sl_pdata = pdata;

I would prefer dws name for struct dw_dma_slave here.

> +	if (!sl_pdata)
> +		return false;
> +
> +	if (sl_pdata->dma_dev == chan->device->dev) {
> +		chan->private = sl_pdata;
> +		return true;
> +	} else {
> +		return false;
> +	}
> +}
> +
>  /* -----------------------------------------------------------------
> ---
>   *  LCDC
>   * -----------------------------------------------------------------
> --- */
> diff --git a/arch/avr32/mach-at32ap/include/mach/board.h 
> b/arch/avr32/mach-at32ap/include/mach/board.h
> index f1a316d..e6f9e56 100644
> --- a/arch/avr32/mach-at32ap/include/mach/board.h
> +++ b/arch/avr32/mach-at32ap/include/mach/board.h
> @@ -4,6 +4,7 @@
>  #ifndef __ASM_ARCH_BOARD_H
>  #define __ASM_ARCH_BOARD_H
>  
> +#include <linux/dmaengine.h>
>  #include <linux/types.h>
>  #include <linux/serial.h>
>  #include <linux/platform_data/macb.h>
> @@ -86,6 +87,7 @@ struct platform_device 
> *at32_add_device_twi(unsigned int id,
>  struct mci_platform_data;
>  struct platform_device *
>  at32_add_device_mci(unsigned int id, struct mci_platform_data 
> *data);
> +bool atmci_filter(struct dma_chan *chan, void *pdata);

Maybe at32_mci_filter() ?

>  
>  struct ac97c_platform_data;
>  struct platform_device *
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel
> -mci.c
> index 9a39e0b..1d80135 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -30,7 +30,6 @@
>  #include <linux/stat.h>
>  #include <linux/types.h>
>  #include <linux/platform_data/atmel.h>
> -#include <linux/platform_data/mmc-atmel-mci.h>
>  
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/sdio.h>
> @@ -2281,8 +2280,21 @@ static int atmci_configure_dma(struct 
> atmel_mci *host)
>  {
>  	host->dma.chan = dma_request_slave_channel_reason(&host
> ->pdev->dev,
>  							"rxtx");
> -	if (IS_ERR(host->dma.chan))
> +	if (IS_ERR(host->dma.chan) == -ENODEV) {

IS_ERR() returns boolean. It wouldn't be comparable with -Exxx.

> +		dma_cap_mask_t mask;
> +		struct mci_platform_data *pdata = host->pdev
> ->dev.platform_data;
> +		/*  */
> +		dma_cap_zero(mask);
> +		dma_cap_set(DMA_SLAVE, mask);
> +
> +		host->dma.chan = dma_request_channel(mask,
> +						     pdata
> ->dma_filter,
> +						     pdata
> ->dma_slave);
> +		if (!host->dma.chan)
> +			return -ENODEV;
> +	} else {
>  		return PTR_ERR(host->dma.chan);
> +	}
>  
>  	dev_info(&host->pdev->dev, "using %s for DMA transfers\n",
>  		 dma_chan_name(host->dma.chan));
> diff --git a/include/linux/atmel-mci.h b/include/linux/atmel-mci.h
> index 9177947..fe5d72f 100644
> --- a/include/linux/atmel-mci.h
> +++ b/include/linux/atmel-mci.h
> @@ -1,6 +1,7 @@
>  #ifndef __LINUX_ATMEL_MCI_H
>  #define __LINUX_ATMEL_MCI_H
>  
> +#include <linux/dmaengine.h>

You need only struct dma_chan. Why not

struct dma_chan;

?

>  #include <linux/types.h>
>  
>  #define ATMCI_MAX_NR_SLOTS	2
> @@ -38,6 +39,7 @@ struct mci_slot_pdata {
>  struct mci_platform_data {
>  	struct mci_dma_data	*dma_slave;

Should be above line left?

>  	struct mci_slot_pdata	slot[ATMCI_MAX_NR_SLOTS];
> +	bool (*dma_filter) 	(struct dma_chan *chan, void 
> *pdata);
>  };
>  
>  #endif /* __LINUX_ATMEL_MCI_H */
> diff --git a/include/linux/platform_data/mmc-atmel-mci.h 
> b/include/linux/platform_data/mmc-atmel-mci.h
> deleted file mode 100644
> index 399a2d5..0000000
> --- a/include/linux/platform_data/mmc-atmel-mci.h
> +++ /dev/null
> @@ -1,22 +0,0 @@
> -#ifndef __MMC_ATMEL_MCI_H
> -#define __MMC_ATMEL_MCI_H
> -
> -#include <linux/platform_data/dma-atmel.h>
> -#include <linux/platform_data/dma-dw.h>
> -
> -/**
> - * struct mci_dma_data - DMA data for MCI interface
> - */
> -struct mci_dma_data {
> -#ifdef CONFIG_ARM
> -	struct at_dma_slave     sdata;
> -#else
> -	struct dw_dma_slave     sdata;
> -#endif
> -};
> -
> -/* accessor macros */
> -#define	slave_data_ptr(s)	(&(s)->sdata)
> -#define find_slave_dev(s)	((s)->sdata.dma_dev)
> -
> -#endif /* __MMC_ATMEL_MCI_H */

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
