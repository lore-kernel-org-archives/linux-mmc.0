From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH] mmc: dw_mmc: remove the MMC_CAP_8_BIT_DATA in dw_mmc_caps[]
Date: Wed, 26 Jun 2013 10:56:29 +0900
Message-ID: <001101ce7210$5fd99020$1f8cb060$%jun@samsung.com>
References: <51BEC639.3070105@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:14441 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326Ab3FZB4b (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Jun 2013 21:56:31 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MOZ00DUZ9D1TX50@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 26 Jun 2013 10:56:30 +0900 (KST)
In-reply-to: <51BEC639.3070105@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Jaehoon Chung' <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'James Hogan' <james.hogan@imgtec.com>, 'Thomas Abraham' <thomas.abraham@linaro.org>

On Monday, June 17, 2013, Jaehoon Chung wrote:
> This capability didn't need to set in dw_mmc_caps[].
> In dw-mmc.c, this capability could be set with bus_width value.
You're right. It can be set from dw_mci_of_get_bus_wd.
But I have another idea. exynos_dwmmc_caps is host own capability.
As we know, host#0 support 8-bit widths.
This capability is meaningful by default at this view.
On the other hand, we don't need to refer to bus_width value.

If we exclude bus-width capability from exynos_dwmmc_caps,
it should assume that bus-width is decided from outside.
Then, I think the related comment should be included.

Thanks,
Seungwon Jeon
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc-exynos.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> index f013e7e..31d518b 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -154,8 +154,7 @@ static int dw_mci_exynos_parse_dt(struct dw_mci *host)
> 
>  /* Common capabilities of Exynos4/Exynos5 SoC */
>  static unsigned long exynos_dwmmc_caps[4] = {
> -	MMC_CAP_UHS_DDR50 | MMC_CAP_1_8V_DDR |
> -		MMC_CAP_8_BIT_DATA | MMC_CAP_CMD23,
> +	MMC_CAP_UHS_DDR50 | MMC_CAP_1_8V_DDR | MMC_CAP_CMD23,
>  	MMC_CAP_CMD23,
>  	MMC_CAP_CMD23,
>  	MMC_CAP_CMD23,
> --
> 1.7.9.5
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

