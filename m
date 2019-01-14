From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH 07/11] mmc: mvsdio: handle highmem pages
Date: Mon, 14 Jan 2019 11:29:07 -0500 (EST)
Message-ID: <nycvar.YSQ.7.76.1901141107030.4477@knanqh.ubzr>
References: <20190114095804.27978-1-hch@lst.de> <20190114095804.27978-8-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190114095804.27978-8-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Russell King <linux@armlinux.org.uk>, Aaro Koskinen <aaro.koskinen@iki.fi>, Ben Dooks <ben-linux@fluff.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Mon, 14 Jan 2019, Christoph Hellwig wrote:

> Instead of setting up a kernel pointer to track the current PIO address,
> track the offset in the current page, and do an atomic kmap for the page
> while doing the actual PIO operations.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Just a small suggestion below


> ---
>  drivers/mmc/host/mvsdio.c | 48 +++++++++++++++++++++++----------------
>  1 file changed, 29 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
> index e22bbff89c8d..545e370d6dae 100644
> --- a/drivers/mmc/host/mvsdio.c
> +++ b/drivers/mmc/host/mvsdio.c
> @@ -12,6 +12,7 @@
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
> +#include <linux/highmem.h>
>  #include <linux/platform_device.h>
>  #include <linux/mbus.h>
>  #include <linux/delay.h>
> @@ -42,7 +43,8 @@ struct mvsd_host {
>  	unsigned int intr_en;
>  	unsigned int ctrl;
>  	unsigned int pio_size;
> -	void *pio_ptr;
> +	struct scatterlist *pio_sg;
> +	unsigned int pio_offset; /* offset in words into the segment */
>  	unsigned int sg_frags;
>  	unsigned int ns_per_clk;
>  	unsigned int clock;
> @@ -96,9 +98,9 @@ static int mvsd_setup_data(struct mvsd_host *host, struct mmc_data *data)
>  	if (tmout_index > MVSD_HOST_CTRL_TMOUT_MAX)
>  		tmout_index = MVSD_HOST_CTRL_TMOUT_MAX;
>  
> -	dev_dbg(host->dev, "data %s at 0x%08x: blocks=%d blksz=%d tmout=%u (%d)\n",
> +	dev_dbg(host->dev, "data %s at 0x%08llx: blocks=%d blksz=%d tmout=%u (%d)\n",
>  		(data->flags & MMC_DATA_READ) ? "read" : "write",
> -		(u32)sg_virt(data->sg), data->blocks, data->blksz,
> +		(u64)sg_phys(data->sg), data->blocks, data->blksz,
>  		tmout, tmout_index);
>  
>  	host->ctrl &= ~MVSD_HOST_CTRL_TMOUT_MASK;
> @@ -118,10 +120,11 @@ static int mvsd_setup_data(struct mvsd_host *host, struct mmc_data *data)
>  		 * boundary.
>  		 */
>  		host->pio_size = data->blocks * data->blksz;
> -		host->pio_ptr = sg_virt(data->sg);
> +		host->pio_sg = data->sg;
> +		host->pio_offset = data->sg->offset / 2;
>  		if (!nodma)
> -			dev_dbg(host->dev, "fallback to PIO for data at 0x%p size %d\n",
> -				host->pio_ptr, host->pio_size);
> +			dev_dbg(host->dev, "fallback to PIO for data at 0x%x size %d\n",
> +				host->pio_offset, host->pio_size);
>  		return 1;
>  	} else {
>  		dma_addr_t phys_addr;
> @@ -291,8 +294,9 @@ static u32 mvsd_finish_data(struct mvsd_host *host, struct mmc_data *data,
>  {
>  	void __iomem *iobase = host->base;
>  
> -	if (host->pio_ptr) {
> -		host->pio_ptr = NULL;
> +	if (host->pio_sg) {
> +		host->pio_sg = NULL;
> +		host->pio_offset = 0;
>  		host->pio_size = 0;
>  	} else {
>  		dma_unmap_sg(mmc_dev(host->mmc), data->sg, host->sg_frags,
> @@ -376,11 +380,12 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
>  	if (host->pio_size &&
>  	    (intr_status & host->intr_en &
>  	     (MVSD_NOR_RX_READY | MVSD_NOR_RX_FIFO_8W))) {
> -		u16 *p = host->pio_ptr;
> +		u16 *p = kmap_atomic(sg_page(host->pio_sg));
> +		unsigned int o = host->pio_offset;

To minimize code change, you could do:

		u16 *p0 = kmap_atomic(sg_page(host->pio_sg));
		u16 *p = p0 + host->pio_offset;

and at the end:

		host->pio_offset = p - p0;

leaving the middle code unchanged.

This might also produce slightly better assembly with the post increment 
instructions on ARM if the compiler doesn't figure it out on its own 
otherwise.


Nicolas
