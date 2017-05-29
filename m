From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v3 1/2] mmc: dw_mmc: Use device_property_read instead of
 of_property_read
Date: Mon, 29 May 2017 12:21:35 +0900
Message-ID: <667edf5b-ed1c-1f00-8a00-e2eff7f6205e@samsung.com>
References: <CGME20170527014552epcas2p16b1befaccf5dff3d7ab534dda60f4191@epcas2p1.samsung.com>
        <1495835601-20327-1-git-send-email-dwoods@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:16949 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750837AbdE2DVi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 28 May 2017 23:21:38 -0400
In-reply-to: <1495835601-20327-1-git-send-email-dwoods@mellanox.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Woods <dwoods@mellanox.com>, ulf.hansson@linaro.org, shawn.lin@rock-chips.com, hkallweit1@gmail.com, adrian.hunter@intel.com, cmetcalf@mellanox.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.linux.org

On 05/27/2017 06:53 AM, David Woods wrote:
> Using the device_property interfaces allows the dw_mmc driver to work
> on platforms which run on either device tree or ACPI.
> 
> Signed-off-by: David Woods <dwoods@mellanox.com>
> Reviewed-by: Chris Metcalf <cmetcalf@mellanox.com>
> Cc: stable@vger.linux.org

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
>  drivers/mmc/host/dw_mmc.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index e45129f..efde0f2 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2707,8 +2707,8 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>  	host->slot[id] = slot;
>  
>  	mmc->ops = &dw_mci_ops;
> -	if (of_property_read_u32_array(host->dev->of_node,
> -				       "clock-freq-min-max", freq, 2)) {
> +	if (device_property_read_u32_array(host->dev, "clock-freq-min-max",
> +					   freq, 2)) {
>  		mmc->f_min = DW_MCI_FREQ_MIN;
>  		mmc->f_max = DW_MCI_FREQ_MAX;
>  	} else {
> @@ -2808,7 +2808,6 @@ static void dw_mci_init_dma(struct dw_mci *host)
>  {
>  	int addr_config;
>  	struct device *dev = host->dev;
> -	struct device_node *np = dev->of_node;
>  
>  	/*
>  	* Check tansfer mode from HCON[17:16]
> @@ -2869,8 +2868,9 @@ static void dw_mci_init_dma(struct dw_mci *host)
>  		dev_info(host->dev, "Using internal DMA controller.\n");
>  	} else {
>  		/* TRANS_MODE_EDMAC: check dma bindings again */
> -		if ((of_property_count_strings(np, "dma-names") < 0) ||
> -		    (!of_find_property(np, "dmas", NULL))) {
> +		if ((device_property_read_string_array(dev, "dma-names",
> +						       NULL, 0) < 0) ||
> +		    !device_property_present(dev, "dmas")) {
>  			goto no_dma;
>  		}
>  		host->dma_ops = &dw_mci_edmac_ops;
> @@ -2937,7 +2937,6 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
>  {
>  	struct dw_mci_board *pdata;
>  	struct device *dev = host->dev;
> -	struct device_node *np = dev->of_node;
>  	const struct dw_mci_drv_data *drv_data = host->drv_data;
>  	int ret;
>  	u32 clock_frequency;
> @@ -2954,20 +2953,21 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
>  	}
>  
>  	/* find out number of slots supported */
> -	of_property_read_u32(np, "num-slots", &pdata->num_slots);
> +	device_property_read_u32(dev, "num-slots", &pdata->num_slots);
>  
> -	if (of_property_read_u32(np, "fifo-depth", &pdata->fifo_depth))
> +	if (device_property_read_u32(dev, "fifo-depth", &pdata->fifo_depth))
>  		dev_info(dev,
>  			 "fifo-depth property not found, using value of FIFOTH register as default\n");
>  
> -	of_property_read_u32(np, "card-detect-delay", &pdata->detect_delay_ms);
> +	device_property_read_u32(dev, "card-detect-delay",
> +				 &pdata->detect_delay_ms);
>  
> -	of_property_read_u32(np, "data-addr", &host->data_addr_override);
> +	device_property_read_u32(dev, "data-addr", &host->data_addr_override);
>  
> -	if (of_get_property(np, "fifo-watermark-aligned", NULL))
> +	if (device_property_present(dev, "fifo-watermark-aligned"))
>  		host->wm_aligned = true;
>  
> -	if (!of_property_read_u32(np, "clock-frequency", &clock_frequency))
> +	if (!device_property_read_u32(dev, "clock-frequency", &clock_frequency))
>  		pdata->bus_hz = clock_frequency;
>  
>  	if (drv_data && drv_data->parse_dt) {
> 

