From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] mmc: renesas-sdhi: export renesas_sdhi_probe
Date: Tue, 23 May 2017 07:31:55 +0200
Message-ID: <20170523053155.GD25840@verge.net.au>
References: <20170522133339.798278-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:58154 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932860AbdEWFb7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 23 May 2017 01:31:59 -0400
Content-Disposition: inline
In-Reply-To: <20170522133339.798278-1-arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Chris Brandt <chris.brandt@renesas.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, May 22, 2017 at 03:33:08PM +0200, Arnd Bergmann wrote:
> We now build the sdhi driver in separate modules, which means we
> have to export the symbols that are called from another module:
> 
> ERROR: "renesas_sdhi_remove" [drivers/mmc/host/renesas_sdhi_sys_dmac.ko] undefined!
> ERROR: "renesas_sdhi_probe" [drivers/mmc/host/renesas_sdhi_sys_dmac.ko] undefined!
> 
> Fixes: 94418768f765 ("mmc: renesas-sdhi: make renesas_sdhi_sys_dmac main module file")

Sorry for messing this up and thanks for the fix.

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/mmc/host/renesas_sdhi_core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index 846ee1a8e5a6..fa6c188e0327 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -638,6 +638,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
>  eprobe:
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(renesas_sdhi_probe);
>  
>  int renesas_sdhi_remove(struct platform_device *pdev)
>  {
> @@ -648,3 +649,4 @@ int renesas_sdhi_remove(struct platform_device *pdev)
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(renesas_sdhi_remove);
> -- 
> 2.9.0
> 
