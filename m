From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: dw_mmc: fix 32bit little-endian access of des1 field
Date: Wed, 8 Jun 2016 17:55:59 +0800
Message-ID: <0f6eee92-1bf3-7bea-86d7-6da1c7a0051c@rock-chips.com>
References: <1465306639-9537-1-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:59635 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161696AbcFHJ5W (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Jun 2016 05:57:22 -0400
In-Reply-To: <1465306639-9537-1-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ben Dooks <ben.dooks@codethink.co.uk>, linux-kernel@lists.codethink.co.uk
Cc: Matthew Leach <matt.leach@codethink.co.uk>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, shawn.lin@rock-chips.com

Hi Ben,

On 2016-6-7 21:37, Ben Dooks wrote:
> The IDMAC_SET_BUFFER1_SIZE() macro modifies des1, but does
> not check if the value being passed is big or little endian
> desptire the des1 field being marked as __le32.

Looks good.

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

Test on Rockchip platform, so

Tested-by: Shawn Lin <shawn.lin@rock-chips.com>

> Fix the issue by ensuring the values are changed from the
> cpu endian to the descriptor endian by using cpu_to_le32.
>
> Spotted whilst doing big endian conversion work on Exynos,
> and stops the mmc worker thread from stalling.
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> Cc: Matthew Leach <matt.leach@codethink.co.uk>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>   drivers/mmc/host/dw_mmc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 2cc6123..544397e 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -92,7 +92,7 @@ struct idmac_desc {
>   
>   	__le32		des1;	/* Buffer sizes */
>   #define IDMAC_SET_BUFFER1_SIZE(d, s) \
> -	((d)->des1 = ((d)->des1 & 0x03ffe000) | ((s) & 0x1fff))
> +	((d)->des1 = ((d)->des1 & cpu_to_le32(0x03ffe000)) | (cpu_to_le32((s) & 0x1fff)))
>   
>   	__le32		des2;	/* buffer 1 physical address */
>   


