From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] mmc: sdio: Fix PM_SLEEP related build warnings
Date: Thu, 9 Aug 2012 12:00:10 +0200
Message-ID: <201208091200.11161.rjw@sisk.pl>
References: <1344504741-12081-1-git-send-email-thierry.reding@avionic-design.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:50325 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751477Ab2HIJyQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 9 Aug 2012 05:54:16 -0400
In-Reply-To: <1344504741-12081-1-git-send-email-thierry.reding@avionic-design.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Chris Ball <cjb@laptop.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday, August 09, 2012, Thierry Reding wrote:
> Power management callbacks defined by SIMPLE_DEV_PM_OPS are only used if
> the PM_SLEEP Kconfig symbol has been defined. If not, the compiler will
> complain about them being unused. However, since the callback for this
> driver doesn't do anything it can just as well be dropped.
> 
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>

Acked-by: Rafael J. Wysocki <rjw@sisk.pl>

> ---
>  drivers/mmc/core/sdio_bus.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
> index 236842e..6bf6879 100644
> --- a/drivers/mmc/core/sdio_bus.c
> +++ b/drivers/mmc/core/sdio_bus.c
> @@ -193,14 +193,7 @@ static int sdio_bus_remove(struct device *dev)
>  }
>  
>  #ifdef CONFIG_PM
> -
> -static int pm_no_operation(struct device *dev)
> -{
> -	return 0;
> -}
> -
>  static const struct dev_pm_ops sdio_bus_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(pm_no_operation, pm_no_operation)
>  	SET_RUNTIME_PM_OPS(
>  		pm_generic_runtime_suspend,
>  		pm_generic_runtime_resume,
> 

