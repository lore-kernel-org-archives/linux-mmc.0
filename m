From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH] mmc: dw_mmc: exynos: Turn SDIO interrupts on
Date: Mon, 15 Apr 2013 21:14:17 +0900
Message-ID: <001701ce39d2$c0dbf8c0$4293ea40$%jun@samsung.com>
References: <1365698338-27503-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:21093 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753442Ab3DOMOU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Apr 2013 08:14:20 -0400
In-reply-to: <1365698338-27503-1-git-send-email-dianders@chromium.org>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Doug Anderson' <dianders@chromium.org>, 'Chris Ball' <cjb@laptop.org>
Cc: 'Thomas Abraham' <thomas.abraham@linaro.org>, 'Bing Zhao' <bzhao@marvell.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Sachin Kamat' <sachin.kamat@linaro.org>, 'Olof Johansson' <olof@lixom.net>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Friday, April 12, 2013, Doug Anderson wrote:
> The mmc part in exynos supports SDIO interrupts and they work fine, so
> turn the capability on.  With this I see download speeds increase
> about 10x.  This is a port of a change present in the Chrome OS tree
> that can be found at <https://gerrit.chromium.org/gerrit/#/c/26729/>.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
>  drivers/mmc/host/dw_mmc-exynos.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> index c7f0976..3a227be 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -192,10 +192,10 @@ static int dw_mci_exynos_setup_bus(struct dw_mci *host,
>  /* Common capabilities of Exynos4/Exynos5 SoC */
>  static unsigned long exynos_dwmmc_caps[4] = {
>  	MMC_CAP_UHS_DDR50 | MMC_CAP_1_8V_DDR |
> -		MMC_CAP_8_BIT_DATA | MMC_CAP_CMD23,
> -	MMC_CAP_CMD23,
> -	MMC_CAP_CMD23,
> -	MMC_CAP_CMD23,
> +		MMC_CAP_8_BIT_DATA | MMC_CAP_CMD23 | MMC_CAP_SDIO_IRQ,
> +	MMC_CAP_CMD23 | MMC_CAP_SDIO_IRQ,
This line for [1]
> +	MMC_CAP_CMD23 | MMC_CAP_SDIO_IRQ,
> +	MMC_CAP_CMD23 | MMC_CAP_SDIO_IRQ,
[1] is for mshc1. mshc1 is only used for SDIO.
As I know, The others are improper for SDIO.

Thanks,
Seungwon Jeon
>  };
> 
>  static const struct dw_mci_drv_data exynos_drv_data = {
> --
> 1.8.1.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

