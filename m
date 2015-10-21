From: Alim Akhtar <alim.akhtar@samsung.com>
Subject: Re: [1/2] mmc: dw_mmc: fix the CardThreshold boundary at CardThrCtl
 register
Date: Wed, 21 Oct 2015 16:55:46 +0530
Message-ID: <5627763A.7030800@samsung.com>
References: <1445424582-7940-1-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:56761 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752517AbbJULfM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Oct 2015 07:35:12 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NWK030M0IUM9V00@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 21 Oct 2015 20:35:10 +0900 (KST)
In-reply-to: <1445424582-7940-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, k.kozlowski@samsung.com, linux.amoon@gmail.com, jh80.chung@gmail.com

Hi Jaehoon

On 10/21/2015 04:19 PM, Jaehoon Chung wrote:
> According to DesignWare DoC file, CardThreshold bit should be
> bit[27:16].
> So it's correct to use (0xFFF << 16), not (0x1FFF << 16).
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> 
Looks good.
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

> ---
> drivers/mmc/host/dw_mmc.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index f2a88d4..01cdc86 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -172,7 +172,7 @@
>   /* Version ID register define */
>   #define SDMMC_GET_VERID(x)		((x) & 0xFFFF)
>   /* Card read threshold */
> -#define SDMMC_SET_RD_THLD(v, x)		(((v) & 0x1FFF) << 16 | (x))
> +#define SDMMC_SET_RD_THLD(v, x)		(((v) & 0xFFF) << 16 | (x))
>   #define SDMMC_UHS_18V			BIT(0)
>   /* All ctrl reset bits */
>   #define SDMMC_CTRL_ALL_RESET_FLAGS \
> 
