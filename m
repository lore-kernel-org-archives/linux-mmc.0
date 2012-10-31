From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] exynos: mmc: use correct variable for MODULE_DEVICE_TABLE
Date: Wed, 31 Oct 2012 13:33:34 +0900
Message-ID: <5090AA1E.1040005@samsung.com>
References: <1351635712-17214-1-git-send-email-slyich@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:37006 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824Ab2JaEdw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Oct 2012 00:33:52 -0400
In-reply-to: <1351635712-17214-1-git-send-email-slyich@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sergei Trofimovich <slyich@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, Sergei Trofimovich <slyfox@gentoo.org>, Thomas Abraham <thomas.abraham@linaro.org>, Will Newton <will.newton@imgtec.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Looks good to me.

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

On 10/31/2012 07:21 AM, Sergei Trofimovich wrote:
> From: Sergei Trofimovich <slyfox@gentoo.org>
> 
> Found by gcc:
> 
>     linux-2.6/drivers/mmc/host/dw_mmc-exynos.c: At top level:
>     linux-2.6/drivers/mmc/host/dw_mmc-exynos.c:226:1: error: '__mod_of_device_table' aliased to undefined symbol 'dw_mci_pltfm_match'
> 
> CC: Chris Ball <cjb@laptop.org>
> CC: Thomas Abraham <thomas.abraham@linaro.org>
> CC: Will Newton <will.newton@imgtec.com>
> CC: linux-mmc@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
> ---
>  drivers/mmc/host/dw_mmc-exynos.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> index 660bbc5..0147ac3a 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -223,7 +223,7 @@ static const struct of_device_id dw_mci_exynos_match[] = {
>  			.data = (void *)&exynos5250_drv_data, },
>  	{},
>  };
> -MODULE_DEVICE_TABLE(of, dw_mci_pltfm_match);
> +MODULE_DEVICE_TABLE(of, dw_mci_exynos_match);
>  
>  int dw_mci_exynos_probe(struct platform_device *pdev)
>  {
> 

