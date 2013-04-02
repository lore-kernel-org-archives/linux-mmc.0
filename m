From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v2 4/5] mmc: mxcmmc: enable DMA support on mpc512x
Date: Tue, 2 Apr 2013 08:56:54 +0200
Message-ID: <20130402065654.GC1906@pengutronix.de>
References: <1364768585-5177-1-git-send-email-agust@denx.de>
 <1364768585-5177-5-git-send-email-agust@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44417 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760889Ab3DBG45 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Apr 2013 02:56:57 -0400
Content-Disposition: inline
In-Reply-To: <1364768585-5177-5-git-send-email-agust@denx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Anatolij Gustschin <agust@denx.de>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Markus Pargmann <mpa@pengutronix.de>, devicetree-discuss@lists.ozlabs.org

On Mon, Apr 01, 2013 at 12:23:04AM +0200, Anatolij Gustschin wrote:
> Add SDHC DMA channel description to the mpc512x device
> tree to enable slave channel requesting in the mxcmmc
> driver.
> 
> mpc512x DMA engine doesn't support endianness conversion
> when reading/writing data from peripheral's FIFO, so we
> have to swap data buffers before each DMA write and after
> each DMA read transfer manually.
> 
> Since chained SDHC DMA transfers are not supported on
> mpc512x, limit 'max_segs' tunable parameter to one and
> initialise it to 64 only when running on i.MX platforms.
> 
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> ---
> v2:
>  - only rebased
> 
>  arch/powerpc/boot/dts/mpc5121.dtsi |    2 ++
>  drivers/mmc/host/mxcmmc.c          |   35 +++++++++++++++++++++++++++++++++--
>  2 files changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/mpc5121.dtsi b/arch/powerpc/boot/dts/mpc5121.dtsi
> index d1fe070..712b15a 100644
> --- a/arch/powerpc/boot/dts/mpc5121.dtsi
> +++ b/arch/powerpc/boot/dts/mpc5121.dtsi
> @@ -152,6 +152,8 @@
>  			compatible = "fsl,mpc5121-sdhc";
>  			reg = <0x1500 0x100>;
>  			interrupts = <8 0x8>;
> +			dmas = <&dma0 30>;
> +			dma-names = "rx-tx";
>  		};
>  
>  		i2c@1700 {
> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> index dbacbde..2861e0d 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -301,6 +301,29 @@ static void mxcmci_softreset(struct mxcmci_host *host)
>  }
>  static int mxcmci_setup_dma(struct mmc_host *mmc);
>  
> +#if IS_ENABLED(CONFIG_PPC_MPC512x)
> +static inline void buffer_swap32(u32 *buf, int len)
> +{
> +	int i;
> +
> +	for (i = 0; i < ((len + 3) / 4); i++) {
> +		st_le32(buf, *buf);
> +		buf++;
> +	}
> +}
> +
> +static void mxcmci_fixup_buffers(struct mmc_data *data)
> +{
> +	struct scatterlist *sg;
> +	int i;
> +
> +	for_each_sg(data->sg, sg, data->sg_len, i)
> +		buffer_swap32(sg_virt(sg), sg->length);
> +}
> +#else
> +static inline void mxcmci_fixup_buffers(struct mmc_data *data) {}
> +#endif
> +
>  static int mxcmci_setup_data(struct mxcmci_host *host, struct mmc_data *data)
>  {
>  	unsigned int nob = data->blocks;
> @@ -336,6 +359,8 @@ static int mxcmci_setup_data(struct mxcmci_host *host, struct mmc_data *data)
>  	} else {
>  		host->dma_dir = DMA_TO_DEVICE;
>  		slave_dirn = DMA_MEM_TO_DEV;
> +
> +		mxcmci_fixup_buffers(data);

For the register accesses it's fine the way you did in this version, but
here I think a

	if (is_mpc512x_mmc())
		swap_buffer()

would look better.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
