From: santosh shilimkar <santosh.shilimkar@oracle.com>
Subject: Re: [PATCH 2/5] mmc: omap_hsmmc: Enable omap_hsmmc for Keystone 2
Date: Tue, 20 Oct 2015 18:25:00 -0700
Message-ID: <5626E96C.2090002@oracle.com>
References: <1445377809-12516-1-git-send-email-fcooper@ti.com>
 <1445377809-12516-2-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:36209 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621AbbJUBZv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Oct 2015 21:25:51 -0400
In-Reply-To: <1445377809-12516-2-git-send-email-fcooper@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Franklin S Cooper Jr <fcooper@ti.com>, linux@arm.linux.org.uk, ssantosh@kernel.org, ulf.hansson@linaro.org, m-karicheri2@ti.com, grygorii.strashko@ti.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Lokesh Vutla <lokeshvutla@ti.com>

On 10/20/2015 2:50 PM, Franklin S Cooper Jr wrote:
> From: Lokesh Vutla <lokeshvutla@ti.com>
>
> Enable omap_hsmmc for Keystone 2 architecture which reuses the HSMMC
> IP found on OMAP platforms.
>
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> ---
>   drivers/mmc/host/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 8a1e349..2ccec71 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -366,7 +366,7 @@ config MMC_OMAP
>   config MMC_OMAP_HS
>   	tristate "TI OMAP High Speed Multimedia Card Interface support"
>   	depends on HAS_DMA
> -	depends on ARCH_OMAP2PLUS || COMPILE_TEST
> +	depends on ARCH_OMAP2PLUS || ARCH_KEYSTONE || COMPILE_TEST
>   	help
>   	  This selects the TI OMAP High Speed Multimedia card Interface.
>   	  If you have an omap2plus board with a Multimedia Card slot,
>
Please send this to MMC tree.

Regards,
Santosh
