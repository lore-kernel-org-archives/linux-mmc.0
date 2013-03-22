From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/2] mmc: davinci_mmc: use module_platform_driver_probe()
Date: Fri, 22 Mar 2013 12:30:56 -0400
Message-ID: <877gkzpfb3.fsf@octavius.laptop.org>
References: <005801ce1954$fc029ce0$f407d6a0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:43757 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1160995Ab3CVQbA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Mar 2013 12:31:00 -0400
In-Reply-To: <005801ce1954$fc029ce0$f407d6a0$%han@samsung.com> (Jingoo Han's
	message of "Tue, 05 Mar 2013 12:53:23 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-mmc@vger.kernel.org

Hi,

On Mon, Mar 04 2013, Jingoo Han wrote:
> This patch uses module_platform_driver_probe() macro which makes
> the code smaller and simpler.
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/mmc/host/davinci_mmc.c |   13 +------------
>  1 files changed, 1 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
> index 2063677..7635e48 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -1410,18 +1410,7 @@ static struct platform_driver davinci_mmcsd_driver = {
>  	.remove		= __exit_p(davinci_mmcsd_remove),
>  };
>  
> -static int __init davinci_mmcsd_init(void)
> -{
> -	return platform_driver_probe(&davinci_mmcsd_driver,
> -				     davinci_mmcsd_probe);
> -}
> -module_init(davinci_mmcsd_init);
> -
> -static void __exit davinci_mmcsd_exit(void)
> -{
> -	platform_driver_unregister(&davinci_mmcsd_driver);
> -}
> -module_exit(davinci_mmcsd_exit);
> +module_platform_driver_probe(davinci_mmcsd_driver, davinci_mmcsd_probe);
>  
>  MODULE_AUTHOR("Texas Instruments India");
>  MODULE_LICENSE("GPL");

Thanks, pushed to mmc-next for 3.10.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
