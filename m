From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: blk: add emmc cache flush in shutdown callback
Date: Mon, 14 Jul 2014 18:51:20 +0900
Message-ID: <53C3A818.7030107@samsung.com>
References: <1405330459-2335-1-git-send-email-yunpeng.gao@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:62507 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754226AbaGNJvX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Jul 2014 05:51:23 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N8P008TE4PK3O50@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 14 Jul 2014 18:51:20 +0900 (KST)
In-reply-to: <1405330459-2335-1-git-send-email-yunpeng.gao@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yunpeng Gao <yunpeng.gao@intel.com>, linux-mmc@vger.kernel.org

Hi,

On 07/14/2014 06:34 PM, Yunpeng Gao wrote:
> If eMMC Cache feature enabled, we'd better flush
> eMMC cache in the shutdown callback. Otherwise
> data corruption issue may be observed.

I knew mmc_flush_cache() is called into mmc_shutdown() (driver/mmc/core/mmc.c)
Which data corruption is occurred? Could you explain more?

Best Regards,
Jaehoon Chung 

> 
> Signed-off-by: Yunpeng Gao <yunpeng.gao@intel.com>
> ---
>  drivers/mmc/card/block.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 452782b..8a4010e 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -2509,6 +2509,10 @@ static int _mmc_blk_suspend(struct mmc_card *card)
>  static void mmc_blk_shutdown(struct mmc_card *card)
>  {
>  	_mmc_blk_suspend(card);
> +
> +	mmc_claim_host(card->host);
> +	mmc_flush_cache(card);
> +	mmc_release_host(card->host);
>  }
>  
>  #ifdef CONFIG_PM
> 

