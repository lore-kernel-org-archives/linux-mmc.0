From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH/RFC 2/3] mmc: sh_mobile_sdhi: Add tuning support
Date: Thu, 12 May 2016 08:13:27 +0900
Message-ID: <20160511231327.GB15521@verge.net.au>
References: <1462859524-28522-1-git-send-email-horms+renesas@verge.net.au>
 <1462859524-28522-3-git-send-email-horms+renesas@verge.net.au>
 <8760ummo36.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8760ummo36.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Ian Molton <ian@mnementh.co.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Ben Hutchings <ben.hutchings@codethink.co.uk>
List-Id: linux-mmc@vger.kernel.org

On Tue, May 10, 2016 at 06:25:58AM +0000, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> Some question/comment from me
> 
> about new flags "TMIO_MMC_HAS_UHS_SCC",
> you added it on [1/3] patch with this comment
> "Remove unused TMIO_MMC_HAS_UHS_SCC define"
> but, [1/3] patch adds it, not removed ?

Thanks, the comment got out of sync with the code at some point.

> > +static void sh_mobile_sdhi_hw_reset(struct tmio_mmc_host *host)
> > +{
> > +	struct tmio_mmc_data *pdata = host->pdata;
> > +
> > +	if (pdata->flags & TMIO_MMC_HAS_UHS_SCC) {
> > +		/* Reset SCC */
> (snip)
> > +	if (mmc_data->capabilities & MMC_CAP_UHS_SDR104) {
> > +		mmc_data->capabilities |= MMC_CAP_HW_RESET;
> > +		mmc_data->flags |= TMIO_MMC_HAS_UHS_SCC;
> > +	}
> 
> And, how about this on sh_mobile_sdhi_hw_reset() ?
> We can avoid to add new flags TMIO_MMC_HAS_UHS_SCC ?
> 
> static void sh_mobile_sdhi_hw_reset(struct tmio_mmc_host *host)
> {
> 	...
> 
> 	if (pdata->capabilities & MMC_CAP_UHS_SDR104) {
> 		...
> 	}

That seems reasonable, I'll see if I can get it to work.

> > +static inline void sd_scc_write32(struct tmio_mmc_host *host, int addr,
> > +				  u32 val)
> > +{
> > +	struct platform_device *pdev = host->pdev;
> > +	const struct of_device_id *of_id =
> > +		of_match_device(sh_mobile_sdhi_of_match, &pdev->dev);
> > +	const struct sh_mobile_sdhi_of_data *of_data = of_id->data;
> > +
> > +	writel(val, host->ctl + of_data->scc_offset +
> > +	       (addr << host->bus_shift));
> > +}
> (snip)
> >  static const struct sh_mobile_sdhi_of_data of_rcar_gen2_compatible = {
> >  	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE |
> >  			  TMIO_MMC_CLK_ACTUAL | TMIO_MMC_MIN_RCAR2,
> >  	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
> >  	.dma_buswidth	= DMA_SLAVE_BUSWIDTH_4_BYTES,
> >  	.dma_rx_offset	= 0x2000,
> > +	.scc_offset	= 0x0300,
> > +	.taps		= rcar_gen2_scc_taps,
> > +	.taps_num	= ARRAY_SIZE(rcar_gen2_scc_taps),
> >  };
> (snip)
> > +	host->set_clk_div	= sh_mobile_sdhi_set_clk_div;
> >  	host->dma		= dma_priv;
> >  	host->write16_hook	= sh_mobile_sdhi_write16_hook;
> >  	host->clk_enable	= sh_mobile_sdhi_clk_enable;
> > @@ -364,6 +596,12 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
> >  	host->clk_disable	= sh_mobile_sdhi_clk_disable;
> >  	host->multi_io_quirk	= sh_mobile_sdhi_multi_io_quirk;
> >  	host->start_signal_voltage_switch = sh_mobile_sdhi_start_signal_voltage_switch;
> > +	host->inquiry_tuning	= sh_mobile_sdhi_inquiry_tuning;
> > +	host->init_tuning	= sh_mobile_sdhi_init_tuning;
> > +	host->prepare_tuning	= sh_mobile_sdhi_prepare_tuning;
> > +	host->select_tuning	= sh_mobile_sdhi_select_tuning;
> > +	host->retuning		= sh_mobile_sdhi_retuning;
> > +	host->hw_reset		= sh_mobile_sdhi_hw_reset;
> 
> You registered new callback functions on this driver,
> and it is using sd_scc_read/write function, and it is based on "scc_offset".
> This driver is used from not only Gen2, but also Gen1/Gen3/SH-Mobile.
> But you added .scc_offset only on of_rcar_gen2_compatible.
> What's happen on Gen1/Gen3/SH-Mobile ?

Probably not much good :(

I'll work on correcting that.

> > +static bool sh_mobile_sdhi_inquiry_tuning(struct tmio_mmc_host *host)
> > +{
> > +	/* SDHI should be tuning only SDR104 */
> > +	if (host->mmc->ios.timing == MMC_TIMING_UHS_SDR104)
> > +		return true;
> > +	else
> > +		return false;
> > +}
> 
> How about this ?
> 
> 	return (host->mmc->ios.timing == MMC_TIMING_UHS_SDR104);

Sure, thanks for the suggestion.
