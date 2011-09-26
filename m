From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH] mmc: dw_mmc: fix wrong SDMMC_GET_FCNT macro
Date: Mon, 26 Sep 2011 09:05:40 +0100
Message-ID: <4E803254.9050908@imgtec.com>
References: <4E8010A0.7060106@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:42640 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750928Ab1IZIGQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 26 Sep 2011 04:06:16 -0400
In-Reply-To: <4E8010A0.7060106@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Will Newton <will.newton@imgtec.com>, Kyungmin Park <kyungmin.park@samsung.com>

On 09/26/2011 06:41 AM, Jaehoon Chung wrote:
> I understood that SDMMC_GET_FCNT is used to get fifo_count.
> In status register, fifo_count is bit[17:29].
> But this macro is control with bit[17:25].
> 
> i think right that change 0x1FFF instead of 0x1FF.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.Park@samsung.com>

nice catch.

Reviewed-by: James Hogan <james.hogan@imgtec.com>

> ---
>  drivers/mmc/host/dw_mmc.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index bfa3c1c..193ec94 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -117,7 +117,7 @@
>  #define SDMMC_CMD_RESP_EXP		BIT(6)
>  #define SDMMC_CMD_INDX(n)		((n) & 0x1F)
>  /* Status register defines */
> -#define SDMMC_GET_FCNT(x)		(((x)>>17) & 0x1FF)
> +#define SDMMC_GET_FCNT(x)		(((x)>>17) & 0x1FFF)
>  /* Internal DMAC interrupt defines */
>  #define SDMMC_IDMAC_INT_AI		BIT(9)
>  #define SDMMC_IDMAC_INT_NI		BIT(8)

