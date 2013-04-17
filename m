From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: mmci: Allow MMCI to request channels with information acquired from DT
Date: Wed, 17 Apr 2013 15:50:55 +0200
Message-ID: <201304171550.56037.arnd@arndb.de>
References: <1366205534-25079-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:52491 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966116Ab3DQNvT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Apr 2013 09:51:19 -0400
In-Reply-To: <1366205534-25079-1-git-send-email-lee.jones@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linus.walleij@stericsson.com, Russell King <linux@arm.linux.org.uk>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Wednesday 17 April 2013, Lee Jones wrote:

>  #ifdef CONFIG_DMA_ENGINE
> -static void mmci_dma_setup(struct mmci_host *host)
> +static void mmci_dma_setup(struct amba_device *dev,
> +			   struct mmci_host *host)
>  {
> +	struct device_node *np = dev->dev.of_node;
>  	struct mmci_platform_data *plat = host->plat;
>  	const char *rxname, *txname;
>  	dma_cap_mask_t mask;
> +	const char *chan_name;
> +	int count, i;
> +	bool do_tx = false, do_rx = false;
>  
>  	if (!plat || !plat->dma_filter) {
> -		dev_info(mmc_dev(host->mmc), "no DMA platform data\n");
> -		return;
> +		if (np) {
> +			count = of_property_count_strings(np, "dma-names");
> +			for (i = 0; i < count; i++) {
> +				of_property_read_string_index(np, "dma-names",
> +							      i, &chan_name);
> +				if (strcmp(chan_name, "tx"))
> +					do_tx = true;
> +				else if (strcmp(chan_name, "rx"))
> +					do_rx = true;
> +			}
> +		} else {
> +			dev_info(mmc_dev(host->mmc), "no DMA platform data\n");
> +			return;
> +		}
>  	}

This looks unnecessarily complex.

>  	/* initialize pre request cookie */
> @@ -321,19 +338,21 @@ static void mmci_dma_setup(struct mmci_host *host)
>  	 * attempt to use it bidirectionally, however if it is
>  	 * is specified but cannot be located, DMA will be disabled.
>  	 */
> -	if (plat->dma_rx_param) {
> -		host->dma_rx_channel = dma_request_channel(mask,
> -							   plat->dma_filter,
> -							   plat->dma_rx_param);
> +	if (plat->dma_rx_param || do_rx) {
> +		host->dma_rx_channel = dma_request_slave_channel_compat(mask,
> +					(plat) ? plat->dma_filter : NULL,
> +					(plat) ? plat->dma_rx_param : NULL,
> +					&dev->dev, "rx");
>  		/* E.g if no DMA hardware is present */
>  		if (!host->dma_rx_channel)
>  			dev_err(mmc_dev(host->mmc), "no RX DMA channel\n");
>  	}

Why not just do dma_request_slave_channel_compat() unconditionally here?
It's not an error for MMCI if that fails. If you want to keep the warning
in the case dma_rx_channel is provided by not working, you can do it like

	host->dma_rx_channel = dma_request_slave_channel(dev, "rx");
	if (!host->dma_rx_channel && plat->dma_rx_param) {
		host->dma_rx_channel = dma_request_channel(mask,
							   plat->dma_filter,
							   plat->dma_rx_param);
		...
	}

	Arnd
