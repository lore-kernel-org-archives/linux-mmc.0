From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: Use pr_info instead of printk
Date: Thu, 28 Mar 2013 13:47:55 +0900
Message-ID: <5153CB7B.1010504@samsung.com>
References: <1364444747-16777-1-git-send-email-sachin.kamat@linaro.org>
 <1364444747-16777-2-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:34339 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359Ab3C1Ery (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Mar 2013 00:47:54 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MKC003YNTAND1M0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 28 Mar 2013 13:47:53 +0900 (KST)
In-reply-to: <1364444747-16777-2-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-mmc@vger.kernel.org, tgih.jun@samsung.com, jh80.chung@samsung.com, cjb@laptop.org, patches@linaro.org

Hi Sachin,

On 03/28/2013 01:25 PM, Sachin Kamat wrote:
> pr_info(... is preferred to printk(KERN_INFO ...
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/mmc/host/dw_mmc.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 1ba09d0..b8582d0 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2509,7 +2509,7 @@ EXPORT_SYMBOL(dw_mci_resume);
>  
>  static int __init dw_mci_init(void)
>  {
> -	printk(KERN_INFO "Synopsys Designware Multimedia Card Interface Driver");
> +	pr_info("Synopsys Designware Multimedia Card Interface Driver");
Using "...Card Interface Driver\n"? 
Then this patch looks good to me.

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung
>  	return 0;
>  }
>  
> 

