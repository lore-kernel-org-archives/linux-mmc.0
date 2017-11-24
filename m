From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] mmc: renesas_sdhi: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE
Date: Sat, 25 Nov 2017 00:42:09 +0900
Message-ID: <CAK7LNASHxODKVztu8VsWfqPdYC5gaDBHuWp4M_VjTEMJcVRH4w@mail.gmail.com>
References: <20171120213236.53266-1-jc@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conssluserg-05.nifty.com ([210.131.2.90]:38198 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753139AbdKXPnD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Nov 2017 10:43:03 -0500
In-Reply-To: <20171120213236.53266-1-jc@linux.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jesse Chan <jc@linux.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

2017-11-21 6:32 GMT+09:00 Jesse Chan <jc@linux.com>:
> This change resolves a new compile-time warning
> when built as a loadable module:
>
> WARNING: modpost: missing MODULE_LICENSE() in drivers/mmc/host/renesas_sdhi_core.o
> see include/linux/module.h for more information
>
> This adds the license as "GPL v2", which matches the header of the file.
>
> MODULE_DESCRIPTION and MODULE_AUTHOR are also added.
>
> Signed-off-by: Jesse Chan <jc@linux.com>
> ---
>  drivers/mmc/host/renesas_sdhi.h               | 1 +
>  drivers/mmc/host/renesas_sdhi_core.c          | 5 +++++
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 1 -
>  drivers/mmc/host/renesas_sdhi_sys_dmac.c      | 1 -
>  4 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
> index b9dfea5d8193..090cf86d7cd3 100644
> --- a/drivers/mmc/host/renesas_sdhi.h
> +++ b/drivers/mmc/host/renesas_sdhi.h
> @@ -13,6 +13,7 @@
>  #define RENESAS_SDHI_H
>
>  #include <linux/platform_device.h>
> +#include <linux/module.h>
>  #include "tmio_mmc.h"
>
>  struct renesas_sdhi_scc {



Why did you move <linux/module.h> to this header?

I do not see anything that requires <linux/module.h>
in this header.



> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index fcf7235d5742..0a0daa7a342f 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -667,3 +667,8 @@ int renesas_sdhi_remove(struct platform_device *pdev)
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(renesas_sdhi_remove);
> +
> +MODULE_DESCRIPTION("Renesas SDHI driver");
> +MODULE_AUTHOR("Phil Blundell <pb@handhelds.org>");
> +MODULE_AUTHOR("Samuel Ortiz <sameo@openedhand.com>");
> +MODULE_LICENSE("GPL v2");


Including <linux/module.h> from this file is fine.






> diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> index 41cbe84c1d18..a9b452b42fac 100644
> --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> @@ -15,7 +15,6 @@
>  #include <linux/mfd/tmio.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mod_devicetable.h>
> -#include <linux/module.h>
>  #include <linux/pagemap.h>
>  #include <linux/scatterlist.h>
>  #include <linux/sys_soc.h>
> diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> index 9ab10436e4b8..fe6a09f14682 100644
> --- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> @@ -17,7 +17,6 @@
>  #include <linux/mfd/tmio.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mod_devicetable.h>
> -#include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/pagemap.h>
>  #include <linux/scatterlist.h>
> --
> 2.14.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
