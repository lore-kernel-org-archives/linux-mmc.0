From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH v2 1/2] mmc: atmel-mci: restore dma on AVR32
Date: Mon, 11 Jan 2016 15:22:55 +0100
Message-ID: <20160111142255.GH10307@odux.rfo.atmel.com>
References: <1452343511-11164-1-git-send-email-mans@mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:20822 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992AbcAKOWs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Jan 2016 09:22:48 -0500
Content-Disposition: inline
In-Reply-To: <1452343511-11164-1-git-send-email-mans@mansr.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mans Rullgard <mans@mansr.com>
Cc: Haavard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Ludovic Desroches <ludovic.desroches@atmel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

Hi Mans,

On Sat, Jan 09, 2016 at 12:45:10PM +0000, Mans Rullgard wrote:
> Commit ecb89f2f5f3e7 ("mmc: atmel-mci: remove compat for non DT board
> when requesting dma chan") broke dma on AVR32 and any other boards not
> using DT.  This restores a fallback mechanism for such cases.
> 
> Signed-off-by: Mans Rullgard <mans@mansr.com>

Thanks I submitted a draft (I have no AVR board) to fix that some time ago but
I get no feedback.

I would have split this patch to get one for mmc subsystem and one for
avr but it is up to maintainers to discuss about that.

Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Regards

Ludovic

> ---
> Changes:
> - rebase onto v4.4-rc8: no change to this patch
> ---
>  arch/avr32/mach-at32ap/at32ap700x.c | 16 ++++++++++++++++
>  drivers/mmc/host/atmel-mci.c        | 17 +++++++++++++++++
>  include/linux/atmel-mci.h           |  2 ++
>  3 files changed, 35 insertions(+)
> 
> diff --git a/arch/avr32/mach-at32ap/at32ap700x.c b/arch/avr32/mach-at32ap/at32ap700x.c
> index b4cb3bd89d8a..6e906172dc33 100644
> --- a/arch/avr32/mach-at32ap/at32ap700x.c
> +++ b/arch/avr32/mach-at32ap/at32ap700x.c
> @@ -1321,6 +1321,21 @@ static struct clk atmel_mci0_pclk = {
>  	.index		= 9,
>  };
>  
> +static bool at32_mci_dma_filter(struct dma_chan *chan, void *pdata)
> +{
> +	struct mci_dma_data *sl = pdata;
> +
> +	if (!sl)
> +		return false;
> +
> +	if (find_slave_dev(sl) == chan->device->dev) {
> +		chan->private = slave_data_ptr(sl);
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
>  struct platform_device *__init
>  at32_add_device_mci(unsigned int id, struct mci_platform_data *data)
>  {
> @@ -1355,6 +1370,7 @@ at32_add_device_mci(unsigned int id, struct mci_platform_data *data)
>  	slave->sdata.dst_master = 0;
>  
>  	data->dma_slave = slave;
> +	data->dma_filter = at32_mci_dma_filter;
>  
>  	if (platform_device_add_data(pdev, data,
>  				sizeof(struct mci_platform_data)))
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index bf62e429f7fc..070dffc4699e 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -2280,6 +2280,23 @@ static int atmci_configure_dma(struct atmel_mci *host)
>  {
>  	host->dma.chan = dma_request_slave_channel_reason(&host->pdev->dev,
>  							"rxtx");
> +
> +	if (PTR_ERR(host->dma.chan) == -ENODEV) {
> +		struct mci_platform_data *pdata = host->pdev->dev.platform_data;
> +		dma_cap_mask_t mask;
> +
> +		if (!pdata->dma_filter)
> +			return -ENODEV;
> +
> +		dma_cap_zero(mask);
> +		dma_cap_set(DMA_SLAVE, mask);
> +
> +		host->dma.chan = dma_request_channel(mask, pdata->dma_filter,
> +						     pdata->dma_slave);
> +		if (!host->dma.chan)
> +			host->dma.chan = ERR_PTR(-ENODEV);
> +	}
> +
>  	if (IS_ERR(host->dma.chan))
>  		return PTR_ERR(host->dma.chan);
>  
> diff --git a/include/linux/atmel-mci.h b/include/linux/atmel-mci.h
> index 9177947bf032..e753062b9355 100644
> --- a/include/linux/atmel-mci.h
> +++ b/include/linux/atmel-mci.h
> @@ -2,6 +2,7 @@
>  #define __LINUX_ATMEL_MCI_H
>  
>  #include <linux/types.h>
> +#include <linux/dmaengine.h>
>  
>  #define ATMCI_MAX_NR_SLOTS	2
>  
> @@ -37,6 +38,7 @@ struct mci_slot_pdata {
>   */
>  struct mci_platform_data {
>  	struct mci_dma_data	*dma_slave;
> +	dma_filter_fn		dma_filter;
>  	struct mci_slot_pdata	slot[ATMCI_MAX_NR_SLOTS];
>  };
>  
> -- 
> 2.7.0
> 
