From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [RFC PATCH] mmc: remove the MMC_DATA_STREAM flag
Date: Fri, 15 Jan 2016 18:01:48 +0100
Message-ID: <20160115170148.GA10663@odux.rfo.atmel.com>
References: <56978FBF.1080509@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:51959 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752205AbcAORBi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Jan 2016 12:01:38 -0500
Content-Disposition: inline
In-Reply-To: <56978FBF.1080509@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Ludovic Desroches <ludovic.desroches@atmel.com>, Sonic Zhang <sonic.zhang@analog.com>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Fabio Estevam <fabio.estevam@freescale.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Ben Dooks <ben-linux@fluff.org>, Hans de Goede <hdegoede@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>

On Thu, Jan 14, 2016 at 09:08:31PM +0900, Jaehoon Chung wrote:
> It's not set to MMC_DATA_STREAM anywhere.
> It seems that it had used with CMD11/20. But now CMD11/20 didn't also use.
> I didn't know what is exactly, so i sent the patch as just RFC. 
> If i get some comments for this, i will resend the patch after separate to each host controller.
> 
> If MMC_DATA_STREAM can be removed, then flags of data should be then one of MMC_DATA_READ and MMC_DATA_WRITE.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  drivers/mmc/card/block.c       |  6 +++---
>  drivers/mmc/host/atmel-mci.c   |  9 ++-------

Hi,

Since I don't have use case in mind of data stream instead of blocks and
it became dead code, you can add my
Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

for atmel-mci.c.

Regards

Ludovic

>  drivers/mmc/host/bfin_sdh.c    |  3 ---
>  drivers/mmc/host/davinci_mmc.c | 15 +++------------
>  drivers/mmc/host/dw_mmc.c      |  2 --
>  drivers/mmc/host/jz4740_mmc.c  |  2 --
>  drivers/mmc/host/mxcmmc.c      |  3 ---
>  drivers/mmc/host/pxamci.c      |  6 ------
>  drivers/mmc/host/s3cmci.c      |  3 +--
>  drivers/mmc/host/sunxi-mmc.c   |  5 -----
>  include/linux/mmc/core.h       |  1 -
>  11 files changed, 9 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 5914263..e7449cb 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -1525,13 +1525,13 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>  	}
>  	if (rq_data_dir(req) == READ) {
>  		brq->cmd.opcode = readcmd;
> -		brq->data.flags |= MMC_DATA_READ;
> +		brq->data.flags = MMC_DATA_READ;
>  		if (brq->mrq.stop)
>  			brq->stop.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 |
>  					MMC_CMD_AC;
>  	} else {
>  		brq->cmd.opcode = writecmd;
> -		brq->data.flags |= MMC_DATA_WRITE;
> +		brq->data.flags = MMC_DATA_WRITE;
>  		if (brq->mrq.stop)
>  			brq->stop.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B |
>  					MMC_CMD_AC;
> @@ -1800,7 +1800,7 @@ static void mmc_blk_packed_hdr_wrq_prep(struct mmc_queue_req *mqrq,
>  
>  	brq->data.blksz = 512;
>  	brq->data.blocks = packed->blocks + hdr_blocks;
> -	brq->data.flags |= MMC_DATA_WRITE;
> +	brq->data.flags = MMC_DATA_WRITE;
>  
>  	brq->stop.opcode = MMC_STOP_TRANSMISSION;
>  	brq->stop.arg = 0;
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index a36ebda..e0c8c51 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -849,9 +849,7 @@ static u32 atmci_prepare_command(struct mmc_host *mmc,
>  		if (cmd->opcode == SD_IO_RW_EXTENDED) {
>  			cmdr |= ATMCI_CMDR_SDIO_BLOCK;
>  		} else {
> -			if (data->flags & MMC_DATA_STREAM)
> -				cmdr |= ATMCI_CMDR_STREAM;
> -			else if (data->blocks > 1)
> +			if (data->blocks > 1)
>  				cmdr |= ATMCI_CMDR_MULTI_BLOCK;
>  			else
>  				cmdr |= ATMCI_CMDR_BLOCK;
> @@ -1372,10 +1370,7 @@ static void atmci_start_request(struct atmel_mci *host,
>  		host->stop_cmdr |= ATMCI_CMDR_STOP_XFER;
>  		if (!(data->flags & MMC_DATA_WRITE))
>  			host->stop_cmdr |= ATMCI_CMDR_TRDIR_READ;
> -		if (data->flags & MMC_DATA_STREAM)
> -			host->stop_cmdr |= ATMCI_CMDR_STREAM;
> -		else
> -			host->stop_cmdr |= ATMCI_CMDR_MULTI_BLOCK;
> +		host->stop_cmdr |= ATMCI_CMDR_MULTI_BLOCK;
>  	}
>  
>  	/*
> diff --git a/drivers/mmc/host/bfin_sdh.c b/drivers/mmc/host/bfin_sdh.c
> index 2b7f37e..526231e 100644
> --- a/drivers/mmc/host/bfin_sdh.c
> +++ b/drivers/mmc/host/bfin_sdh.c
> @@ -126,9 +126,6 @@ static int sdh_setup_data(struct sdh_host *host, struct mmc_data *data)
>  	length = data->blksz * data->blocks;
>  	bfin_write_SDH_DATA_LGTH(length);
>  
> -	if (data->flags & MMC_DATA_STREAM)
> -		data_ctl |= DTX_MODE;
> -
>  	if (data->flags & MMC_DATA_READ)
>  		data_ctl |= DTX_DIR;
>  	/* Only supports power-of-2 block size */
> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
> index ea2a2eb..693144e 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -346,10 +346,6 @@ static void mmc_davinci_start_command(struct mmc_davinci_host *host,
>  	if (cmd->data)
>  		cmd_reg |= MMCCMD_WDATX;
>  
> -	/* Setting whether stream or block transfer */
> -	if (cmd->flags & MMC_DATA_STREAM)
> -		cmd_reg |= MMCCMD_STRMTP;
> -
>  	/* Setting whether data read or write */
>  	if (host->data_dir == DAVINCI_MMC_DATADIR_WRITE)
>  		cmd_reg |= MMCCMD_DTRW;
> @@ -568,8 +564,7 @@ mmc_davinci_prepare_data(struct mmc_davinci_host *host, struct mmc_request *req)
>  		return;
>  	}
>  
> -	dev_dbg(mmc_dev(host->mmc), "%s %s, %d blocks of %d bytes\n",
> -		(data->flags & MMC_DATA_STREAM) ? "stream" : "block",
> +	dev_dbg(mmc_dev(host->mmc), "%s, %d blocks of %d bytes\n",
>  		(data->flags & MMC_DATA_WRITE) ? "write" : "read",
>  		data->blocks, data->blksz);
>  	dev_dbg(mmc_dev(host->mmc), "  DTO %d cycles + %d ns\n",
> @@ -584,22 +579,18 @@ mmc_davinci_prepare_data(struct mmc_davinci_host *host, struct mmc_request *req)
>  	writel(data->blksz, host->base + DAVINCI_MMCBLEN);
>  
>  	/* Configure the FIFO */
> -	switch (data->flags & MMC_DATA_WRITE) {
> -	case MMC_DATA_WRITE:
> +	if (data->flags & MMC_DATA_WRITE) {
>  		host->data_dir = DAVINCI_MMC_DATADIR_WRITE;
>  		writel(fifo_lev | MMCFIFOCTL_FIFODIR_WR | MMCFIFOCTL_FIFORST,
>  			host->base + DAVINCI_MMCFIFOCTL);
>  		writel(fifo_lev | MMCFIFOCTL_FIFODIR_WR,
>  			host->base + DAVINCI_MMCFIFOCTL);
> -		break;
> -
> -	default:
> +	} else {
>  		host->data_dir = DAVINCI_MMC_DATADIR_READ;
>  		writel(fifo_lev | MMCFIFOCTL_FIFODIR_RD | MMCFIFOCTL_FIFORST,
>  			host->base + DAVINCI_MMCFIFOCTL);
>  		writel(fifo_lev | MMCFIFOCTL_FIFODIR_RD,
>  			host->base + DAVINCI_MMCFIFOCTL);
> -		break;
>  	}
>  
>  	host->buffer = NULL;
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index fddbcb6..b542c42 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -290,8 +290,6 @@ static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
>  	data = cmd->data;
>  	if (data) {
>  		cmdr |= SDMMC_CMD_DAT_EXP;
> -		if (data->flags & MMC_DATA_STREAM)
> -			cmdr |= SDMMC_CMD_STRM_MODE;
>  		if (data->flags & MMC_DATA_WRITE)
>  			cmdr |= SDMMC_CMD_DAT_WR;
>  	}
> diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
> index 76e8bce..03ddf0e 100644
> --- a/drivers/mmc/host/jz4740_mmc.c
> +++ b/drivers/mmc/host/jz4740_mmc.c
> @@ -660,8 +660,6 @@ static void jz4740_mmc_send_command(struct jz4740_mmc_host *host,
>  		cmdat |= JZ_MMC_CMDAT_DATA_EN;
>  		if (cmd->data->flags & MMC_DATA_WRITE)
>  			cmdat |= JZ_MMC_CMDAT_WRITE;
> -		if (cmd->data->flags & MMC_DATA_STREAM)
> -			cmdat |= JZ_MMC_CMDAT_STREAM;
>  		if (host->use_dma)
>  			cmdat |= JZ_MMC_CMDAT_DMA_EN;
>  
> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> index d110f9e..3d1ea5e 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -307,9 +307,6 @@ static int mxcmci_setup_data(struct mxcmci_host *host, struct mmc_data *data)
>  	enum dma_transfer_direction slave_dirn;
>  	int i, nents;
>  
> -	if (data->flags & MMC_DATA_STREAM)
> -		nob = 0xffff;
> -
>  	host->data = data;
>  	data->bytes_xfered = 0;
>  
> diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
> index ce08896..4285d3a 100644
> --- a/drivers/mmc/host/pxamci.c
> +++ b/drivers/mmc/host/pxamci.c
> @@ -191,9 +191,6 @@ static void pxamci_setup_data(struct pxamci_host *host, struct mmc_data *data)
>  
>  	host->data = data;
>  
> -	if (data->flags & MMC_DATA_STREAM)
> -		nob = 0xffff;
> -
>  	writel(nob, host->base + MMC_NOB);
>  	writel(data->blksz, host->base + MMC_BLKLEN);
>  
> @@ -443,9 +440,6 @@ static void pxamci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  		cmdat |= CMDAT_DATAEN | CMDAT_DMAEN;
>  		if (mrq->data->flags & MMC_DATA_WRITE)
>  			cmdat |= CMDAT_WRITE;
> -
> -		if (mrq->data->flags & MMC_DATA_STREAM)
> -			cmdat |= CMDAT_STREAM;
>  	}
>  
>  	pxamci_start_cmd(host, mrq->cmd, cmdat);
> diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
> index 6291d50..39814f3 100644
> --- a/drivers/mmc/host/s3cmci.c
> +++ b/drivers/mmc/host/s3cmci.c
> @@ -1014,8 +1014,7 @@ static int s3cmci_setup_data(struct s3cmci_host *host, struct mmc_data *data)
>  	if (host->bus_width == MMC_BUS_WIDTH_4)
>  		dcon |= S3C2410_SDIDCON_WIDEBUS;
>  
> -	if (!(data->flags & MMC_DATA_STREAM))
> -		dcon |= S3C2410_SDIDCON_BLOCKMODE;
> +	dcon |= S3C2410_SDIDCON_BLOCKMODE;
>  
>  	if (data->flags & MMC_DATA_WRITE) {
>  		dcon |= S3C2410_SDIDCON_TXAFTERRESP;
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 83de82b..d61c58e 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -815,11 +815,6 @@ static void sunxi_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  
>  		if ((cmd->flags & MMC_CMD_MASK) == MMC_CMD_ADTC) {
>  			cmd_val |= SDXC_DATA_EXPIRE | SDXC_WAIT_PRE_OVER;
> -			if (cmd->data->flags & MMC_DATA_STREAM) {
> -				imask |= SDXC_AUTO_COMMAND_DONE;
> -				cmd_val |= SDXC_SEQUENCE_MODE |
> -					   SDXC_SEND_AUTO_STOP;
> -			}
>  
>  			if (cmd->data->stop) {
>  				imask |= SDXC_AUTO_COMMAND_DONE;
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index 37967b6..b01e77d 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -113,7 +113,6 @@ struct mmc_data {
>  
>  #define MMC_DATA_WRITE	(1 << 8)
>  #define MMC_DATA_READ	(1 << 9)
> -#define MMC_DATA_STREAM	(1 << 10)
>  
>  	unsigned int		bytes_xfered;
>  
> -- 
> 1.9.1
