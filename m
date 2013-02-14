From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/2] mmc: dw_mmc: exynos: Add compatibility for exynos4412 SoC
Date: Thu, 14 Feb 2013 20:55:11 +0530
Message-ID: <CAK9yfHynG-avvyNaiXpDcKmDoDYY+6jg4knL6n6aM87bfq0K_w@mail.gmail.com>
References: <1360238236-17694-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:53621 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758140Ab3BNPZM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Feb 2013 10:25:12 -0500
Received: by mail-oa0-f44.google.com with SMTP id h1so2663929oag.31
        for <linux-mmc@vger.kernel.org>; Thu, 14 Feb 2013 07:25:12 -0800 (PST)
In-Reply-To: <1360238236-17694-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, tgih.jun@samsung.com, jh80.chung@samsung.com, sachin.kamat@linaro.org, patches@linaro.org, Thomas Abraham <thomas.abraham@linaro.org>

On 07/02/2013, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> Added compatibility string for Exynos4412 SoC.
>
> Cc: Thomas Abraham <thomas.abraham@linaro.org>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

Any comments on this patch?

> ---
>  drivers/mmc/host/dw_mmc-exynos.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c
> b/drivers/mmc/host/dw_mmc-exynos.c
> index 72fd0f2..f15b4d3 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -209,6 +209,8 @@ static const struct dw_mci_drv_data exynos5250_drv_data
> = {
>  };
>
>  static const struct of_device_id dw_mci_exynos_match[] = {
> +	{ .compatible = "samsung,exynos4412-dw-mshc",
> +			.data = &exynos5250_drv_data, },
>  	{ .compatible = "samsung,exynos5250-dw-mshc",
>  			.data = &exynos5250_drv_data, },
>  	{},
> --
> 1.7.4.1
>
>


-- 
With warm regards,
Sachin
