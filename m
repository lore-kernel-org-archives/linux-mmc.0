From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: Fix null dma_ops access when use_dma is false
Date: Fri, 15 Jun 2012 16:25:00 +0900
Message-ID: <4FDAE34C.1030102@samsung.com>
References: <1339695115-606-1-git-send-email-kliegs@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:55765 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363Ab2FOHZg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Jun 2012 03:25:36 -0400
Received: from epcpsbgm2.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M5N00DG5DYE2ID0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 15 Jun 2012 16:25:35 +0900 (KST)
Received: from [165.213.219.108] by mmp2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0M5N00JF0DYMI970@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 15 Jun 2012 16:25:34 +0900 (KST)
In-reply-to: <1339695115-606-1-git-send-email-kliegs@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jonathan Kliegman <kliegs@chromium.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>

It looks good to me.

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

On 06/15/2012 02:31 AM, Jonathan Kliegman wrote:

> host->dma_ops is not valid if host->usa dma is 0 so protect
> host->dma_ops reference in dw_mci_resume
> 
> Signed-off-by: Jonathan Kliegman <kliegs@chromium.org>
> ---
>  drivers/mmc/host/dw_mmc.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 1ca5e72..e2758d5 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2175,7 +2175,7 @@ int dw_mci_resume(struct dw_mci *host)
>  		return ret;
>  	}
>  
> -	if (host->dma_ops->init)
> +	if (host->use_dma && host->dma_ops->init)
>  		host->dma_ops->init(host);
>  
>  	/* Restore the old value at FIFOTH register */


