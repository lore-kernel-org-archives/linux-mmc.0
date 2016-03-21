From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: devm_pinctrl_get returns ERR_PTR upon
 error
Date: Mon, 21 Mar 2016 11:41:48 +0300
Message-ID: <20160321084148.GV5273@mwanda>
References: <1458514504-21380-1-git-send-email-afenkart@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:42867 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973AbcCUIl4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Mar 2016 04:41:56 -0400
Content-Disposition: inline
In-Reply-To: <1458514504-21380-1-git-send-email-afenkart@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andreas Fenkart <afenkart@gmail.com>
Cc: linux-mmc@vger.kernel.org

On Sun, Mar 20, 2016 at 11:55:04PM +0100, Andreas Fenkart wrote:
> devm_pinctrl_get returns NULL if CONFIG_PINCTRL is not set,
> returns ERR_PTR on error otherwise
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 62e421a..898878d 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1842,7 +1842,7 @@ static int omap_hsmmc_configure_wake_irq(struct omap_hsmmc_host *host)
>  	 */
>  	if (host->pdata->controller_flags & OMAP_HSMMC_SWAKEUP_MISSING) {
>  		struct pinctrl *p = devm_pinctrl_get(host->dev);
> -		if (!p) {
> +		if (!p || IS_ERR(p)) {
>  			ret = -ENODEV;

I think I know why it returns NULL with pinctrl disabled, it's not
because of COMPILE_TEST as I said before.  The reason is that it's not
supposed to be treated as an error if we turn off that config.  In
other words, the person configuring the kernel wanted it to just boot
here.  If it's not possible to boot then instead of checking for NULL we
should make it impossible to compile without PINCTRL by setting that in
the Kconfig.

It may be that the Kconfig already force you to have PINCTRL.
ARCH_OMAP2PLUS does, but I'm not sure about ARCH_KEYSTONE.

So the check for NULL should be removed and also we should preserve the
error code.

	if (IS_ERR(p)) {
		ret = PTR_ERR(p);

regards,
dan carpenter

