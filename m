From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 1/1] mmc: omap_hsmmc: devm_pinctrl_get returns ERR_PTR upon error
Date: Wed, 20 Apr 2016 00:12:27 +0200
Message-ID: <5784587.0IP58U3KN7@wuerfel>
References: <1461099853-15011-1-git-send-email-afenkart@gmail.com> <1461099853-15011-2-git-send-email-afenkart@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:61170 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbcDSWMi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Apr 2016 18:12:38 -0400
In-Reply-To: <1461099853-15011-2-git-send-email-afenkart@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andreas Fenkart <afenkart@gmail.com>
Cc: linux-mmc@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>

On Tuesday 19 April 2016 23:04:13 Andreas Fenkart wrote:
> Only the dummy implementation of devm_pinctrl_get returns NULL.
> The real implementation returns ERR_PTR. By enforcing pinselect
> in Kconfig we can simplify the test to check only for ERR_PTR.
> detected/triggered by static code checker.

This is not how the interface is meant to work:

The dummy devm_pinctrl_get() intentionally returns NULL because IS_ERR()
treats that as valid. All other pinctrl functions subsequently ignore
that NULL pointer, so the second half of the patch is ok without the
first half.

	Arnd

> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
> ---
>  drivers/mmc/host/Kconfig      | 1 +
>  drivers/mmc/host/omap_hsmmc.c | 4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 1526b8a..b469755 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -366,6 +366,7 @@ config MMC_OMAP
>  config MMC_OMAP_HS
>  	tristate "TI OMAP High Speed Multimedia Card Interface support"
>  	depends on HAS_DMA
> +	select PINCTRL
>  	depends on ARCH_OMAP2PLUS || ARCH_KEYSTONE || COMPILE_TEST
>  	help
>  	  This selects the TI OMAP High Speed Multimedia card Interface.
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 62e421a..15ebc3b 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1842,8 +1842,8 @@ static int omap_hsmmc_configure_wake_irq(struct omap_hsmmc_host *host)
>  	 */
>  	if (host->pdata->controller_flags & OMAP_HSMMC_SWAKEUP_MISSING) {
>  		struct pinctrl *p = devm_pinctrl_get(host->dev);
> -		if (!p) {
> -			ret = -ENODEV;
> +		if (IS_ERR(p)) {
> +			ret = PTR_ERR(p);
>  			goto err_free_irq;
>  		}
>  		if (IS_ERR(pinctrl_lookup_state(p, PINCTRL_STATE_DEFAULT))) {
> 

