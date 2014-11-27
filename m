From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/3] ARM: edma: Rename header file for
 dmaengine filter function definition
Date: Thu, 27 Nov 2014 16:23:31 +0200
Message-ID: <547733E3.3020408@ti.com>
References: <1417084891-17990-1-git-send-email-peter.ujfalusi@ti.com>
 <1417084891-17990-3-git-send-email-peter.ujfalusi@ti.com>
 <8235185.7qUDHu9jso@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <8235185.7qUDHu9jso@wuerfel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, vinod.koul@intel.com, linux-mmc@vger.kernel.org, nsekhar@ti.com, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, khilman@deeprootsystems.com, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@kernel.org>, chris@printf.net, dmaengine@vger.kernel.org, ulf.hansson@linaro.org, linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 11/27/2014 01:14 PM, Arnd Bergmann wrote:
> On Thursday 27 November 2014 12:41:30 Peter Ujfalusi wrote:
>> diff --git a/include/linux/edma-dmaengine.h b/include/linux/edma-dmaengi=
ne.h
>> new file mode 100644
>> index 000000000000..8a2602809a77
>> --- /dev/null
>> +++ b/include/linux/edma-dmaengine.h
>> @@ -0,0 +1,29 @@
>> +struct dma_chan;
>> +
>> +#if defined(CONFIG_TI_EDMA) || defined(CONFIG_TI_EDMA_MODULE)
>> +bool edma_filter_fn(struct dma_chan *, void *);
>> +#else
>> +static inline bool edma_filter_fn(struct dma_chan *chan, void *param)
>> +{
>> +	return false;
>> +}
>> +#endif
>> +
>> +#endif
> =

> It's better not to hardcode the name of the filter function in a driver,
> better move the filter function into platform code and pass it down
> to the driver in the platform_data pointer in davinci_mmc_config and
> davinci_spi_platform_data to get rid of this dependency.
> =

> Something roughly like the patch below.

This will only work in case of legacy boot. When booting with DT we do not
have pdata and after this patch in dt boot we are not going to be able to g=
et
the DMA resources either.

I think if we want to do something like this, it has to be done within the
dmaengine framework. The dma controller's of_dma_filter_info already have
.filter_fn which could be used by the framework.

On the other hand the davinci_mmc (and spi-davinci) is only going to work on
davinci devices, so I don't really see issue with 'hard coding' davinci
related callback in the code.

-- =

P=E9ter

> =

> 	Arnd
> =

> =

> ---
> [DRAFT] ARM: davinci: pass dma config through platform data
> =

> DMA slave drivers are supposed to be written independent of the dma engine
> driver, which means that the mmc and spi drivers on davinci should not
> reference the edma_filter_fn or know about the specific format of the
> data passed into it.
> =

> This changes the channel data from a resource into a void pointer and
> passes it as platform data along with the filter function.
> =

> TODO: do the same thing for SPI, and adapt the filter function for the
> new format.
> =

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> =

>  arch/arm/mach-davinci/devices-da8xx.c     | 26 ++++++--------------------
>  arch/arm/mach-davinci/devices.c           | 22 ++++++----------------
>  drivers/mmc/host/davinci_mmc.c            | 27 +++++++++++--------------=
--
>  include/linux/platform_data/mmc-davinci.h |  5 +++++
>  4 files changed, 28 insertions(+), 52 deletions(-)
> =

> diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinc=
i/devices-da8xx.c
> index b85b781b05fd..4aa872dc6dc3 100644
> --- a/arch/arm/mach-davinci/devices-da8xx.c
> +++ b/arch/arm/mach-davinci/devices-da8xx.c
> @@ -671,16 +671,6 @@ static struct resource da8xx_mmcsd0_resources[] =3D {
>  		.end	=3D IRQ_DA8XX_MMCSDINT0,
>  		.flags	=3D IORESOURCE_IRQ,
>  	},
> -	{		/* DMA RX */
> -		.start	=3D DA8XX_DMA_MMCSD0_RX,
> -		.end	=3D DA8XX_DMA_MMCSD0_RX,
> -		.flags	=3D IORESOURCE_DMA,
> -	},
> -	{		/* DMA TX */
> -		.start	=3D DA8XX_DMA_MMCSD0_TX,
> -		.end	=3D DA8XX_DMA_MMCSD0_TX,
> -		.flags	=3D IORESOURCE_DMA,
> -	},
>  };
>  =

>  static struct platform_device da8xx_mmcsd0_device =3D {
> @@ -693,6 +683,9 @@ static struct platform_device da8xx_mmcsd0_device =3D=
 {
>  int __init da8xx_register_mmcsd0(struct davinci_mmc_config *config)
>  {
>  	da8xx_mmcsd0_device.dev.platform_data =3D config;
> +	config->filter =3D edma_filter_fn;
> +	config->rxdma =3D (void *)DA8XX_DMA_MMCSD0_RX;
> +	config->txdma =3D (void *)DA8XX_DMA_MMCSD0_TX;
>  	return platform_device_register(&da8xx_mmcsd0_device);
>  }
>  =

> @@ -708,16 +701,6 @@ static struct resource da850_mmcsd1_resources[] =3D {
>  		.end	=3D IRQ_DA850_MMCSDINT0_1,
>  		.flags	=3D IORESOURCE_IRQ,
>  	},
> -	{		/* DMA RX */
> -		.start	=3D DA850_DMA_MMCSD1_RX,
> -		.end	=3D DA850_DMA_MMCSD1_RX,
> -		.flags	=3D IORESOURCE_DMA,
> -	},
> -	{		/* DMA TX */
> -		.start	=3D DA850_DMA_MMCSD1_TX,
> -		.end	=3D DA850_DMA_MMCSD1_TX,
> -		.flags	=3D IORESOURCE_DMA,
> -	},
>  };
>  =

>  static struct platform_device da850_mmcsd1_device =3D {
> @@ -730,6 +713,9 @@ static struct platform_device da850_mmcsd1_device =3D=
 {
>  int __init da850_register_mmcsd1(struct davinci_mmc_config *config)
>  {
>  	da850_mmcsd1_device.dev.platform_data =3D config;
> +	config->filter =3D edma_filter_fn;
> +	config->rxdma =3D (void *)DA8XX_DMA_MMCSD1_RX;
> +	config->txdma =3D (void *)DA8XX_DMA_MMCSD1_TX;
>  	return platform_device_register(&da850_mmcsd1_device);
>  }
>  #endif
> diff --git a/arch/arm/mach-davinci/devices.c b/arch/arm/mach-davinci/devi=
ces.c
> index 6257aa452568..7b7039d9b079 100644
> --- a/arch/arm/mach-davinci/devices.c
> +++ b/arch/arm/mach-davinci/devices.c
> @@ -144,14 +144,6 @@ static struct resource mmcsd0_resources[] =3D {
>  		.start =3D IRQ_SDIOINT,
>  		.flags =3D IORESOURCE_IRQ,
>  	},
> -	/* DMA channels: RX, then TX */
> -	{
> -		.start =3D EDMA_CTLR_CHAN(0, DAVINCI_DMA_MMCRXEVT),
> -		.flags =3D IORESOURCE_DMA,
> -	}, {
> -		.start =3D EDMA_CTLR_CHAN(0, DAVINCI_DMA_MMCTXEVT),
> -		.flags =3D IORESOURCE_DMA,
> -	},
>  };
>  =

>  static struct platform_device davinci_mmcsd0_device =3D {
> @@ -181,14 +173,6 @@ static struct resource mmcsd1_resources[] =3D {
>  		.start =3D IRQ_DM355_SDIOINT1,
>  		.flags =3D IORESOURCE_IRQ,
>  	},
> -	/* DMA channels: RX, then TX */
> -	{
> -		.start =3D EDMA_CTLR_CHAN(0, 30),	/* rx */
> -		.flags =3D IORESOURCE_DMA,
> -	}, {
> -		.start =3D EDMA_CTLR_CHAN(0, 31),	/* tx */
> -		.flags =3D IORESOURCE_DMA,
> -	},
>  };
>  =

>  static struct platform_device davinci_mmcsd1_device =3D {
> @@ -218,6 +202,9 @@ void __init davinci_setup_mmc(int module, struct davi=
nci_mmc_config *config)
>  	 */
>  	switch (module) {
>  	case 1:
> +		config->filter =3D edma_filter_fn;
> +		config->rxdma =3D (void *)EDMA_CTLR_CHAN(0, DAVINCI_DMA_MMCRXEVT);
> +		config->txdma =3D (void *)EDMA_CTLR_CHAN(0, DAVINCI_DMA_MMCTXEVT);
>  		if (cpu_is_davinci_dm355()) {
>  			/* REVISIT we may not need all these pins if e.g. this
>  			 * is a hard-wired SDIO device...
> @@ -247,6 +234,9 @@ void __init davinci_setup_mmc(int module, struct davi=
nci_mmc_config *config)
>  		pdev =3D &davinci_mmcsd1_device;
>  		break;
>  	case 0:
> +		config->filter =3D edma_filter_fn;
> +		config->rxdma =3D (void *)EDMA_CTLR_CHAN(0, 30);
> +		config->txdma =3D (void *)EDMA_CTLR_CHAN(0, 31);
>  		if (cpu_is_davinci_dm355()) {
>  			mmcsd0_resources[0].start =3D DM355_MMCSD0_BASE;
>  			mmcsd0_resources[0].end =3D DM355_MMCSD0_BASE + SZ_4K - 1;
> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mm=
c.c
> index 1625f908dc70..3f25be9942c8 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -202,7 +202,8 @@ struct mmc_davinci_host {
>  	u32 buffer_bytes_left;
>  	u32 bytes_left;
>  =

> -	u32 rxdma, txdma;
> +	dma_filter_fn filter;
> +	void *rxdma, *txdma;
>  	struct dma_chan *dma_tx;
>  	struct dma_chan *dma_rx;
>  	bool use_dma;
> @@ -524,16 +525,16 @@ static int __init davinci_acquire_dma_channels(stru=
ct mmc_davinci_host *host)
>  	dma_cap_set(DMA_SLAVE, mask);
>  =

>  	host->dma_tx =3D
> -		dma_request_slave_channel_compat(mask, edma_filter_fn,
> -				&host->txdma, mmc_dev(host->mmc), "tx");
> +		dma_request_slave_channel_compat(mask, host->filter,
> +				host->txdma, mmc_dev(host->mmc), "tx");
>  	if (!host->dma_tx) {
>  		dev_err(mmc_dev(host->mmc), "Can't get dma_tx channel\n");
>  		return -ENODEV;
>  	}
>  =

>  	host->dma_rx =3D
> -		dma_request_slave_channel_compat(mask, edma_filter_fn,
> -				&host->rxdma, mmc_dev(host->mmc), "rx");
> +		dma_request_slave_channel_compat(mask, host->filter,
> +				host->rxdma, mmc_dev(host->mmc), "rx");
>  	if (!host->dma_rx) {
>  		dev_err(mmc_dev(host->mmc), "Can't get dma_rx channel\n");
>  		r =3D -ENODEV;
> @@ -1262,17 +1263,11 @@ static int __init davinci_mmcsd_probe(struct plat=
form_device *pdev)
>  	host =3D mmc_priv(mmc);
>  	host->mmc =3D mmc;	/* Important */
>  =

> -	r =3D platform_get_resource(pdev, IORESOURCE_DMA, 0);
> -	if (!r)
> -		dev_warn(&pdev->dev, "RX DMA resource not specified\n");
> -	else
> -		host->rxdma =3D r->start;
> -
> -	r =3D platform_get_resource(pdev, IORESOURCE_DMA, 1);
> -	if (!r)
> -		dev_warn(&pdev->dev, "TX DMA resource not specified\n");
> -	else
> -		host->txdma =3D r->start;
> +	if (pdata) {
> +		host->filter =3D pdata->filter;
> +		host->rxdma  =3D pdata->rxdma;
> +		host->txdma  =3D pdata->txdma;
> +	}
>  =

>  	host->mem_res =3D mem;
>  	host->base =3D ioremap(mem->start, mem_size);
> diff --git a/include/linux/platform_data/mmc-davinci.h b/include/linux/pl=
atform_data/mmc-davinci.h
> index 9cea4ee377b5..0e5809bcaff0 100644
> --- a/include/linux/platform_data/mmc-davinci.h
> +++ b/include/linux/platform_data/mmc-davinci.h
> @@ -25,6 +25,11 @@ struct davinci_mmc_config {
>  =

>  	/* Number of sg segments */
>  	u8	nr_sg;
> +
> +	/* DMA setup */
> +	dma_filter_fn filter;
> +	void	*rxdma;
> +	void	*txdma;
>  };
>  void davinci_setup_mmc(int module, struct davinci_mmc_config *config);
>  =

> =

> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> =
