From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: avoid using dmaengine_terminate_all
Date: Tue, 29 Mar 2016 10:19:41 +0900
Message-ID: <56F9D82D.4010305@samsung.com>
References: <1457490886-18092-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:44481 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753373AbcC2BTo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Mar 2016 21:19:44 -0400
In-reply-to: <1457490886-18092-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Shawn,

Sorry for applying late.
Applied on my repository.

Best Regards,
Jaehoon Chung

On 03/09/2016 11:34 AM, Shawn Lin wrote:
> dmaengine_terminate_all is deprecated and should be
> replaced by more explicit synchronous and asynchronous
> terminate functions. This change is based on the
> commit b36f09c3c441 ("dmaengine: Add transfer termination
> synchronization support"). Currently dw_mci_stop_dma
> may be called under the spinlock, let's migrate
> dmaengine_terminate_all to async terminate. This could
> avoid the race condition of use-after-free resouce of
> dmaengine once slave-dma driver implement the synchronize
> method.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  drivers/mmc/host/dw_mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 242f9a0..45a406f 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -680,7 +680,7 @@ static const struct dw_mci_dma_ops dw_mci_idmac_ops = {
>  
>  static void dw_mci_edmac_stop_dma(struct dw_mci *host)
>  {
> -	dmaengine_terminate_all(host->dms->ch);
> +	dmaengine_terminate_async(host->dms->ch);
>  }
>  
>  static int dw_mci_edmac_start_dma(struct dw_mci *host,
> 

