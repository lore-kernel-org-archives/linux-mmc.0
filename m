From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH] mmc: dw_mmc: fix status error for Kingston brand SD cards
Date: Fri, 28 Mar 2014 21:32:57 +0900
Message-ID: <000401cf4a81$d9433250$8bc996f0$%jun@samsung.com>
References: <1395957622-3428-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:16549 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbaC1Mc7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Mar 2014 08:32:59 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N35009I6C6XONB0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 28 Mar 2014 21:32:57 +0900 (KST)
In-reply-to: <1395957622-3428-1-git-send-email-dinguyen@altera.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinguyen@altera.com, jh80.chung@samsung.com
Cc: dinh.linux@gmail.com, linux-mmc@vger.kernel.org

Hi Dinh,

On Fri, March 28, 2014, Dinh Nguyen wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> commits [90c2143a8f mmc: dw_mmc: guarantee stop-abort cmd in data errors]
> and [e352c813110 mmc: dw_mmc: rework the code related to cmd/data completion]
> cause the SD/MMC DMA interface to stop working on Kingston brand SD cards.
> 
> ---
> Hi Seungwon,
> 
> I am seeing this error on v3.13 kernel of the dw_mmc driver:
> 
> mmc0: problem reading SD Status register.
> mmc0: error -110 whilst initialising SD card
> 
> I only see this error on a Kingston brand card, although I have heard reports
> that it also fails a Samsung card. Also it only fails when with
> CONFIG_MMC_DW_IDMAC=y.
> 
> The patch below seems to fix it for me. Any chance you have seen this error?
I didn't see but I'll try to find it.
And do you have any analysis for this issue?

> 
> Dinh
> ---
>  drivers/mmc/host/dw_mmc.c |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 7833002..7dcaa30 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1312,7 +1312,8 @@ static void dw_mci_tasklet_func(unsigned long priv)
>  			if (test_and_clear_bit(EVENT_DATA_ERROR,
>  					       &host->pending_events)) {
>  				dw_mci_stop_dma(host);
> -				send_stop_abort(host, data);
> +				if (data->stop)
> +					send_stop_abort(host, data);
This routine is for error handing.
Is it effective to detect card normally?

Thanks,
Seungwon Jeon

>  				state = STATE_DATA_ERROR;
>  				break;
>  			}
> @@ -1334,6 +1335,11 @@ static void dw_mci_tasklet_func(unsigned long priv)
>  			set_bit(EVENT_DATA_COMPLETE, &host->completed_events);
>  			err = dw_mci_data_complete(host, data);
> 
> +			if (!data->stop) {
> +				dw_mci_request_end(host, host->mrq);
> +				goto unlock;
> +			}
> +
>  			if (!err) {
>  				if (!data->stop || mrq->sbc) {
>  					if (mrq->sbc)
> --
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

