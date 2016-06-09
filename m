From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: fix 32bit little-endian access of des1 field
Date: Thu, 09 Jun 2016 21:28:30 +0900
Message-ID: <575960EE.8040702@samsung.com>
References: <CGME20160607133726epcas1p1c3274577f12dbf456a7a6bf3efb6e1fe@epcas1p1.samsung.com>
 <1465306639-9537-1-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:55416 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbcFIM2d (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jun 2016 08:28:33 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O8I01UQZ7ZIAF50@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 09 Jun 2016 21:28:30 +0900 (KST)
In-reply-to: <1465306639-9537-1-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ben Dooks <ben.dooks@codethink.co.uk>, linux-kernel@lists.codethink.co.uk
Cc: Matthew Leach <matt.leach@codethink.co.uk>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Ben,

On 06/07/2016 10:37 PM, Ben Dooks wrote:
> The IDMAC_SET_BUFFER1_SIZE() macro modifies des1, but does
> not check if the value being passed is big or little endian
> desptire the des1 field being marked as __le32.
> 
> Fix the issue by ensuring the values are changed from the
> cpu endian to the descriptor endian by using cpu_to_le32.
> 
> Spotted whilst doing big endian conversion work on Exynos,
> and stops the mmc worker thread from stalling.

Applied this patch. Thanks!

Best Regards,
Jaehoon Chung

> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> Cc: Matthew Leach <matt.leach@codethink.co.uk>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>  drivers/mmc/host/dw_mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 2cc6123..544397e 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -92,7 +92,7 @@ struct idmac_desc {
>  
>  	__le32		des1;	/* Buffer sizes */
>  #define IDMAC_SET_BUFFER1_SIZE(d, s) \
> -	((d)->des1 = ((d)->des1 & 0x03ffe000) | ((s) & 0x1fff))
> +	((d)->des1 = ((d)->des1 & cpu_to_le32(0x03ffe000)) | (cpu_to_le32((s) & 0x1fff)))
>  
>  	__le32		des2;	/* buffer 1 physical address */
>  
> 

