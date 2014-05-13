From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 3/5] mmc: dw_mmc-exynos: add the MMC_CAP_ERASE by default.
Date: Tue, 13 May 2014 20:15:02 +0900
Message-ID: <002b01cf6e9c$962e8b60$c28ba220$%jun@samsung.com>
References: <1399893256-7071-1-git-send-email-jh80.chung@samsung.com>
 <1399893256-7071-4-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:57467 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752875AbaEMLPE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 May 2014 07:15:04 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N5I00ENTF939W20@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 13 May 2014 20:15:03 +0900 (KST)
In-reply-to: <1399893256-7071-4-git-send-email-jh80.chung@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Jaehoon Chung' <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org
Cc: chris@printf.net, ulf.hansson@linaro.org, zhangfei.gao@linaro.org, dinguyen@altera.com

Hi Jaehoon,

I think we can remove MMC_CAP_ERASE from host's cap.

Can you check below patch?
[PATCH v4] mmc: remove MMC_CAP_ERASE to enable trim in eMMC/SD Device

Thanks,
Seungwon Jeon

On Mon, May 12, 2014, Jaehoon Chung wrote:
> To use the erase command, add the MMC_CAP_ERASE capability by default.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc-exynos.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> index 0fbc53a..46fafd8 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -386,10 +386,11 @@ static int dw_mci_exynos_execute_tuning(struct dw_mci_slot *slot, u32 opcode,
> 
>  /* Common capabilities of Exynos4/Exynos5 SoC */
>  static unsigned long exynos_dwmmc_caps[4] = {
> -	MMC_CAP_1_8V_DDR | MMC_CAP_8_BIT_DATA | MMC_CAP_CMD23,
> -	MMC_CAP_CMD23,
> -	MMC_CAP_CMD23,
> -	MMC_CAP_CMD23,
> +	MMC_CAP_1_8V_DDR | MMC_CAP_8_BIT_DATA | MMC_CAP_CMD23 |
> +		MMC_CAP_ERASE,
> +	MMC_CAP_CMD23 | MMC_CAP_ERASE,
> +	MMC_CAP_CMD23 | MMC_CAP_ERASE,
> +	MMC_CAP_CMD23 | MMC_CAP_ERASE,
>  };
> 
>  static const struct dw_mci_drv_data exynos_drv_data = {
> --
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

