From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2] mmc: dw_mmc: read all data in FIFO after Data transfer
 over interrupt in pio mode
Date: Tue, 22 Jan 2013 11:35:12 +0900
Message-ID: <50FDFAE0.4050101@samsung.com>
References: <001c01cdf7d2$e1385290$a3a8f7b0$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:42197 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752447Ab3AVCfX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Jan 2013 21:35:23 -0500
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MH000GE79TJJL10@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 22 Jan 2013 11:35:21 +0900 (KST)
Received: from [10.90.51.55] by mmp2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0MH0002W49UWR6H0@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 22 Jan 2013 11:35:21 +0900 (KST)
In-reply-to: <001c01cdf7d2$e1385290$a3a8f7b0$%kim@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kyoungil Kim <ki0351.kim@samsung.com>
Cc: linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, 'Seungwon Jeon' <tgih.jun@samsung.com>

Hi, 

i didn't test with this patch. But it makes sense.
Just i have minor comment.

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

On 01/21/2013 09:28 PM, Kyoungil Kim wrote:
> In dwc manual, the below contents are described.
> "During end of packet, interrupt is not generated if threshold
> programming is larger than any remaining data. It is responsibility
> of host to read remaining bytes on seeing Data Transfer Done
> interrupt"
> We also have seen the data cannot be read fully
> when "sg_miter->length" is less than FIFO size.
> 
> Signed-off-by: Kyoungil Kim <ki0351.kim@samsung.com>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c |   11 +++++++----
>  1 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 323c502..064c010 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1430,7 +1430,7 @@ static void dw_mci_pull_data(struct dw_mci *host, void *buf, int cnt)
>  	host->pull_data(host, buf, cnt);
>  }
>  
> -static void dw_mci_read_data_pio(struct dw_mci *host)
> +static void dw_mci_read_data_pio(struct dw_mci *host, bool int_data_over)
>  {
>  	struct sg_mapping_iter *sg_miter = &host->sg_miter;
>  	void *buf;
> @@ -1465,7 +1465,10 @@ static void dw_mci_read_data_pio(struct dw_mci *host)
>  		sg_miter->consumed = offset;
>  		status = mci_readl(host, MINTSTS);
>  		mci_writel(host, RINTSTS, SDMMC_INT_RXDR);
> -	} while (status & SDMMC_INT_RXDR); /*if the RXDR is ready read again*/
> +	/* if the RXDR is ready read again */
> +	} while ((status & SDMMC_INT_RXDR) ||
> +			(int_data_over &&
> +			 SDMMC_GET_FCNT(mci_readl(host, STATUS))));
If you can change int_data_over, we can use the one line.

Best Regards,
Jaehoon Chung
>  	data->bytes_xfered += nbytes;
>  
>  	if (!remain) {
> @@ -1597,7 +1600,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>  			smp_wmb();
>  			if (host->dir_status == DW_MCI_RECV_STATUS) {
>  				if (host->sg != NULL)
> -					dw_mci_read_data_pio(host);
> +					dw_mci_read_data_pio(host, 1);
>  			}
>  			set_bit(EVENT_DATA_COMPLETE, &host->pending_events);
>  			tasklet_schedule(&host->tasklet);
> @@ -1606,7 +1609,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>  		if (pending & SDMMC_INT_RXDR) {
>  			mci_writel(host, RINTSTS, SDMMC_INT_RXDR);
>  			if (host->dir_status == DW_MCI_RECV_STATUS && host->sg)
> -				dw_mci_read_data_pio(host);
> +				dw_mci_read_data_pio(host, 0);
>  		}
>  
>  		if (pending & SDMMC_INT_TXDR) {
> 

