From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: Add MSHC compatible for Exynos4412
Date: Thu, 24 Jan 2013 11:41:49 +0900
Message-ID: <51009F6D.5040001@samsung.com>
References: <1358954692-5625-1-git-send-email-tobetter@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:26948 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752850Ab3AXCmE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Jan 2013 21:42:04 -0500
In-reply-to: <1358954692-5625-1-git-send-email-tobetter@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dongjin Kim <tobetter@gmail.com>
Cc: "unlisted-recipients: ;Chris Ball" <cjb@laptop.org>, Arnd Bergmann <arnd@arndb.de>, Thomas Abraham <thomas.abraham@linaro.org>, Will Newton <will.newton@imgtec.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On 01/24/2013 12:24 AM, Dongjin Kim wrote:
> This patch adds the compatible string for MSHC controller of Exynos4412, and
> reuse the controller specific properties with Exynos5250 since those have same
> features.
> 
> Signed-off-by: Dongjin Kim <tobetter@gmail.com>
> ---
>  drivers/mmc/host/dw_mmc-exynos.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> index 0cb9bcb..4f7685f 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -204,6 +204,8 @@ static const struct dw_mci_drv_data exynos5250_drv_data = {
>  };
>  
>  static const struct of_device_id dw_mci_exynos_match[] = {
> +	{ .compatible = "samsung,exynos4412-dw-mshc",
> +			.data = &exynos5250_drv_data, },
If we can use the same drv_data, should be changed to more generic name, not "exynos5250_".

Best Regards,
Jaehoon Chung
>  	{ .compatible = "samsung,exynos5250-dw-mshc",
>  			.data = &exynos5250_drv_data, },
>  	{},
> 

