From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: add missing MFD_SYSCON dependency for SOCFPGA
Date: Thu, 01 Aug 2013 23:52:16 +0900
Message-ID: <51FA7620.9090504@samsung.com>
References: <002601ce8e4e$027246c0$0756d440$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:39014 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755866Ab3HAOwR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Aug 2013 10:52:17 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MQU001UHXB4XY20@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 01 Aug 2013 23:52:16 +0900 (KST)
In-reply-to: <002601ce8e4e$027246c0$0756d440$@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, 'Dinh Nguyen' <dinguyen@altera.com>

When I used socfpga_defconfig, MFD_SYSCON is enabled.
Which config do you use?

Best Regards,
Jaehoon Chung

On 08/01/2013 09:28 AM, Jingoo Han wrote:
> Added missing MFD_SYSCON dependency for SOCFPGA in order to fix
> the following link error.
> 
> drivers/mmc/host/dw_mmc-socfpga.c:49: undefined reference to `syscon_regmap_lookup_by_compatible'
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/mmc/host/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 8a4c066..84102bc 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -569,7 +569,7 @@ config MMC_DW_EXYNOS
>  
>  config MMC_DW_SOCFPGA
>  	tristate "SOCFPGA specific extensions for Synopsys DW Memory Card Interface"
> -	depends on MMC_DW
> +	depends on MMC_DW && MFD_SYSCON
>  	select MMC_DW_PLTFM
>  	help
>  	  This selects support for Altera SoCFPGA specific extensions to the
> 

