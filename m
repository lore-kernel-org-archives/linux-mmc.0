From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH] mmc: dw_mmc: Add support for pre_req and post_req
Date: Wed, 25 Jan 2012 14:12:31 +0900
Message-ID: <002301ccdb1f$f0c84e70$d258eb50$%jun@samsung.com>
References: <002401ccd728$af5504b0$0dff0e10$%jun@samsung.com>
 <4F191389.6040003@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:19951 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734Ab2AYFMd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Jan 2012 00:12:33 -0500
Received: from epcpsbgm1.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LYC00BRT94V6BC0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 25 Jan 2012 14:12:31 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp1.samsung.com (Oracle Communications Messaging Exchange Server 7u4-19.01
 64bit (built Sep  7 2010)) with ESMTPA id <0LYC00AWV94VVZ70@mmp1.samsung.com>
 for linux-mmc@vger.kernel.org; Wed, 25 Jan 2012 14:12:31 +0900 (KST)
In-reply-to: <4F191389.6040003@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Jaehoon Chung' <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>

Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Hi Mr Jeon..
> 
> Are Pre_req and post_req used with only the IDMAC..?
Currently internal dma is considered.
Do you use system dma operation?

> 
> On 01/20/2012 01:05 PM, Seungwon Jeon wrote:
> 
> > This patch implements pre_req and post_req in dw_mmc
> > to support asynchronous mmc request.
> >
> > Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> > ---
> > NOTE:
> >     Performance gains the following.
> >     Sequential read and write improve 23% and 5% respectively.
> >
> >  drivers/mmc/host/dw_mmc.c |  136 ++++++++++++++++++++++++++++++++++++---------
> >  1 files changed, 109 insertions(+), 27 deletions(-)
> >
> > diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> > index 0e34279..1fb8114 100644
> > --- a/drivers/mmc/host/dw_mmc.c
> > +++ b/drivers/mmc/host/dw_mmc.c
> > @@ -297,14 +297,24 @@ static void dw_mci_stop_dma(struct dw_mci *host)
> >  }
> >
> >  #ifdef CONFIG_MMC_DW_IDMAC
> > +static int dw_mci_get_dma_dir(struct mmc_data *data)
> > +{
> > +	if (data->flags & MMC_DATA_WRITE)
> > +		return DMA_TO_DEVICE;
> > +	else
> > +		return DMA_FROM_DEVICE;
> > +}
> > +
> >  static void dw_mci_dma_cleanup(struct dw_mci *host)
> >  {
> >  	struct mmc_data *data = host->data;
> >
> >  	if (data)
> > -		dma_unmap_sg(&host->pdev->dev, data->sg, data->sg_len,
> > -			     ((data->flags & MMC_DATA_WRITE)
> > -			      ? DMA_TO_DEVICE : DMA_FROM_DEVICE));
> > +		if (!data->host_cookie)
> > +			dma_unmap_sg(&host->pdev->dev,
> > +				     data->sg,
> > +				     data->sg_len,
> > +				     dw_mci_get_dma_dir(data));
> >  }
> 
> 		if (!data->host_cookie)
> 			dma_unmap_sg(&host->pdev->dev,
> 				     data->sg, data->sg_len,
> 				     dw_mci_get_dma_dir(data));
> also the below code..
Sorry... What's mean?

Thanks,
Seungwon Jeon.
> 
> Best Regards,
> Jaehoon Chung
> 
> >
> >  static void dw_mci_idmac_stop_dma(struct dw_mci *host)
> > @@ -420,26 +430,15 @@ static int dw_mci_idmac_init(struct dw_mci *host)
> >  	return 0;
> >  }
> >
> > -static struct dw_mci_dma_ops dw_mci_idmac_ops = {
> > -	.init = dw_mci_idmac_init,
> > -	.start = dw_mci_idmac_start_dma,
> > -	.stop = dw_mci_idmac_stop_dma,
> > -	.complete = dw_mci_idmac_complete_dma,
> > -	.cleanup = dw_mci_dma_cleanup,
> > -};
> > -#endif /* CONFIG_MMC_DW_IDMAC */
> > -
> > -static int dw_mci_submit_data_dma(struct dw_mci *host, struct mmc_data *data)
> > +static int dw_mci_pre_dma_transfer(struct dw_mci *host,
> > +				   struct mmc_data *data,
> > +				   bool next)
> >  {
> >  	struct scatterlist *sg;
> > -	unsigned int i, direction, sg_len;
> > -	u32 temp;
> > -
> > -	host->using_dma = 0;
> > +	unsigned int i, sg_len;
> >
> > -	/* If we don't have a channel, we can't do DMA */
> > -	if (!host->use_dma)
> > -		return -ENODEV;
> > +	if (!next && data->host_cookie)
> > +		return data->host_cookie;
> >
> >  	/*
> >  	 * We don't do DMA on "complex" transfers, i.e. with
> > @@ -448,6 +447,7 @@ static int dw_mci_submit_data_dma(struct dw_mci *host, struct mmc_data *data)
> >  	 */
> >  	if (data->blocks * data->blksz < DW_MCI_DMA_THRESHOLD)
> >  		return -EINVAL;
> > +
> >  	if (data->blksz & 3)
> >  		return -EINVAL;
> >
> > @@ -456,15 +456,95 @@ static int dw_mci_submit_data_dma(struct dw_mci *host, struct mmc_data *data)
> >  			return -EINVAL;
> >  	}
> >
> > -	host->using_dma = 1;
> > +	sg_len = dma_map_sg(&host->pdev->dev,
> > +			    data->sg,
> > +			    data->sg_len,
> > +			    dw_mci_get_dma_dir(data));
> > +	if (sg_len == 0)
> > +		return -EINVAL;
> >
> > -	if (data->flags & MMC_DATA_READ)
> > -		direction = DMA_FROM_DEVICE;
> > -	else
> > -		direction = DMA_TO_DEVICE;
> > +	if (next)
> > +		data->host_cookie = sg_len;
> > +
> > +	return sg_len;
> > +}
> >
> > -	sg_len = dma_map_sg(&host->pdev->dev, data->sg, data->sg_len,
> > -			    direction);
> > +static void dw_mci_pre_req(struct mmc_host *mmc,
> > +			   struct mmc_request *mrq,
> > +			   bool is_first_req)
> > +{
> > +	struct dw_mci_slot *slot = mmc_priv(mmc);
> > +	struct mmc_data *data = mrq->data;
> > +
> > +	if (!data)
> > +		return;
> > +
> > +	if (data->host_cookie) {
> > +		data->host_cookie = 0;
> > +		return;
> > +	}
> > +
> > +	if (slot->host->use_dma) {
> > +		if (dw_mci_pre_dma_transfer(slot->host, mrq->data, 1) < 0)
> > +			data->host_cookie = 0;
> > +	}
> > +}
> > +
> > +static void dw_mci_post_req(struct mmc_host *mmc,
> > +			    struct mmc_request *mrq,
> > +			    int err)
> > +{
> > +	struct dw_mci_slot *slot = mmc_priv(mmc);
> > +	struct mmc_data *data = mrq->data;
> > +
> > +	if (!data)
> > +		return;
> > +
> > +	if (slot->host->use_dma) {
> > +		if (data->host_cookie)
> > +			dma_unmap_sg(&slot->host->pdev->dev,
> > +				     data->sg,
> > +				     data->sg_len,
> > +				     dw_mci_get_dma_dir(data));
> > +		data->host_cookie = 0;
> > +	}
> > +}
> > +
> > +static struct dw_mci_dma_ops dw_mci_idmac_ops = {
> > +	.init = dw_mci_idmac_init,
> > +	.start = dw_mci_idmac_start_dma,
> > +	.stop = dw_mci_idmac_stop_dma,
> > +	.complete = dw_mci_idmac_complete_dma,
> > +	.cleanup = dw_mci_dma_cleanup,
> > +};
> > +#else
> > +static int dw_mci_pre_dma_transfer(struct dw_mci *host,
> > +				   struct mmc_data *data,
> > +				   bool next)
> > +{
> > +	return -ENOSYS;
> > +}
> > +
> > +#define dw_mci_pre_req	NULL
> > +#define dw_mci_post_req	NULL
> > +#endif /* CONFIG_MMC_DW_IDMAC */
> > +
> > +static int dw_mci_submit_data_dma(struct dw_mci *host, struct mmc_data *data)
> > +{
> > +	int sg_len;
> > +	u32 temp;
> > +
> > +	host->using_dma = 0;
> > +
> > +	/* If we don't have a channel, we can't do DMA */
> > +	if (!host->use_dma)
> > +		return -ENODEV;
> > +
> > +	sg_len = dw_mci_pre_dma_transfer(host, data, 0);
> > +	if (sg_len < 0)
> > +		return sg_len;
> > +
> > +	host->using_dma = 1;
> >
> >  	dev_vdbg(&host->pdev->dev,
> >  		 "sd sg_cpu: %#lx sg_dma: %#lx sg_len: %d\n",
> > @@ -795,6 +875,8 @@ static void dw_mci_enable_sdio_irq(struct mmc_host *mmc, int enb)
> >
> >  static const struct mmc_host_ops dw_mci_ops = {
> >  	.request		= dw_mci_request,
> > +	.pre_req		= dw_mci_pre_req,
> > +	.post_req		= dw_mci_post_req,
> >  	.set_ios		= dw_mci_set_ios,
> >  	.get_ro			= dw_mci_get_ro,
> >  	.get_cd			= dw_mci_get_cd,
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

