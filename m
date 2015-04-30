From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: init desc in dw_mci_idmac_init
Date: Thu, 30 Apr 2015 17:01:03 +0900
Message-ID: <5541E13F.2070908@samsung.com>
References: <1430314316-15971-1-git-send-email-zhangfei.gao@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:60574 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbbD3IBE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Apr 2015 04:01:04 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NNM00F6O0XRZV10@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 30 Apr 2015 17:01:03 +0900 (KST)
In-reply-to: <1430314316-15971-1-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhangfei Gao <zhangfei.gao@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Fei Wang <w.f@huawei.com>, CPGS <cpgs@samsung.com>

Hi.

On 04/29/2015 10:31 PM, Zhangfei Gao wrote:
> Set 0 to des1 in 32bit case.
> Otherwise the random value of des1 will be used in
> dw_mci_translate_sglist: IDMAC_64ADDR_SET_BUFFER1_SIZE(desc, length)

I'm not understanding this comment.
how does it use the IDMAC_64ADDR_SET_BUFFER1_SIZE(desc, length)?

Best Regards,
Jaehoon Chung
> 
> Signed-off-by: Fei Wang <w.f@huawei.com>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>  drivers/mmc/host/dw_mmc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 241454f..488a8af 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -589,9 +589,11 @@ static int dw_mci_idmac_init(struct dw_mci *host)
>  		host->ring_size = PAGE_SIZE / sizeof(struct idmac_desc);
>  
>  		/* Forward link the descriptor list */
> -		for (i = 0, p = host->sg_cpu; i < host->ring_size - 1; i++, p++)
> +		for (i = 0, p = host->sg_cpu; i < host->ring_size - 1; i++, p++) {
>  			p->des3 = cpu_to_le32(host->sg_dma +
>  					(sizeof(struct idmac_desc) * (i + 1)));
> +			p->des1 = 0;
> +		}
>  
>  		/* Set the last descriptor as the end-of-ring descriptor */
>  		p->des3 = cpu_to_le32(host->sg_dma);
> 

