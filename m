From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH 1/1] mmc: Fixed bug in IDMAC_SET_BUFFER1_SIZE Macro in
 dw_mmc.c
Date: Thu, 28 Jul 2011 12:17:54 +0100
Message-ID: <4E314562.2000001@imgtec.com>
References: <1311851023-3563-1-git-send-email-shashidharh@vayavyalabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:19620 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754481Ab1G1LR6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 28 Jul 2011 07:17:58 -0400
In-Reply-To: <1311851023-3563-1-git-send-email-shashidharh@vayavyalabs.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Cc: Will Newton <will.newton@imgtec.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On 07/28/2011 12:03 PM, Shashidhar Hiremath wrote:
> The mask used inside this macro was assuming Buffer_Size1's[BS1's] width to be 14 bits,
> it is actually of 13 bits, Modified masks used in IDMAC_SET_BUFFER1_SIZE such that
> they use only 13 bits instead of current 14.
> 
> Signed-off-by: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
> ---
>  drivers/mmc/host/dw_mmc.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 77f0b6b..f13bb49 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -62,7 +62,7 @@ struct idmac_desc {
>  
>  	u32		des1;	/* Buffer sizes */
>  #define IDMAC_SET_BUFFER1_SIZE(d, s) \
> -	((d)->des1 = ((d)->des1 & 0x03ffc000) | ((s) & 0x3fff))
> +	((d)->des1 = ((d)->des1 & 0x03ffe000) | ((s) & 0x1fff))
>  
>  	u32		des2;	/* buffer 1 physical address */
>  

Yes, according to the TRM you appear to be correct

Reviewed-by: James Hogan <james.hogan@imgtec.com>

Thanks
James

