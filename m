From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH] mmc/dw_mmc: Add support for ARC
Date: Thu, 29 Aug 2013 21:05:49 +0900
Message-ID: <001701cea4b0$19b00b10$4d102130$%jun@samsung.com>
References: <1377715229-2414-1-git-send-email-mjonker@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:48334 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754761Ab3H2MF5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Aug 2013 08:05:57 -0400
In-reply-to: <1377715229-2414-1-git-send-email-mjonker@synopsys.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Mischa Jonker' <Mischa.Jonker@synopsys.com>, 'Chris Ball' <cjb@laptop.org>, 'Arnd Bergmann' <arnd@arndb.de>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Vineet.Gupta1@synopsys.com

On Thu, August 29, 2013, Mischa Jonker wrote:
> Adapt Kconfig to include ARC in supported architectures
> 
> Signed-off-by: Mischa Jonker <mjonker@synopsys.com>
Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

Thanks,
Seungwon Jeon

> ---
>  drivers/mmc/host/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 8a4c066..6496d50 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -530,7 +530,7 @@ config SDH_BFIN_MISSING_CMD_PULLUP_WORKAROUND
> 
>  config MMC_DW
>  	tristate "Synopsys DesignWare Memory Card Interface"
> -	depends on ARM
> +	depends on ARC || ARM
>  	help
>  	  This selects support for the Synopsys DesignWare Mobile Storage IP
>  	  block, this provides host support for SD and MMC interfaces, in both
> --
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

