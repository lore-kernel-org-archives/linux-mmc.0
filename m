From: Tony Prisk <linux@prisktech.co.nz>
Subject: Re: [PATCH -next] mmc: wmt-sdmmc: remove unused variable in
 wmt_complete_data_request()
Date: Tue, 12 Mar 2013 17:03:48 +1300
Message-ID: <1363061028.23051.1.camel@gitbox>
References: <CAPgLHd-7nVD3=83wpNtw1cBmkr+xs5iD7tuxZM+PdxWPLtwZsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from server.prisktech.co.nz ([115.188.14.127]:59731 "EHLO
	server.prisktech.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752342Ab3CLEDh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Mar 2013 00:03:37 -0400
In-Reply-To: <CAPgLHd-7nVD3=83wpNtw1cBmkr+xs5iD7tuxZM+PdxWPLtwZsQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, yongjun_wei@trendmicro.com.cn, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

On Mon, 2013-03-11 at 22:36 +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> The variable 'mmc' is initialized but never used
> otherwise, so remove the unused variable.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  drivers/mmc/host/wmt-sdmmc.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
> index 154f0e8..41d5802 100644
> --- a/drivers/mmc/host/wmt-sdmmc.c
> +++ b/drivers/mmc/host/wmt-sdmmc.c
> @@ -348,13 +348,11 @@ static void wmt_complete_data_request(struct wmt_mci_priv *priv)
>  
>  static irqreturn_t wmt_mci_dma_isr(int irq_num, void *data)
>  {
> -	struct mmc_host *mmc;
>  	struct wmt_mci_priv *priv;
>  
>  	int status;
>  
>  	priv = (struct wmt_mci_priv *)data;
> -	mmc = priv->mmc;
>  
>  	status = readl(priv->sdmmc_base + SDDMA_CCR) & 0x0F;
>  
> 

Acked-by: Tony Prisk <linux@prisktech.co.nz>

