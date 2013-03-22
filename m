From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/2] mmc: mvsdio: use module_platform_driver_probe()
Date: Fri, 22 Mar 2013 12:31:11 -0400
Message-ID: <8738vnpfao.fsf@octavius.laptop.org>
References: <005801ce1954$fc029ce0$f407d6a0$%han@samsung.com>
	<005901ce1955$15a43280$40ec9780$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:43764 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1160995Ab3CVQbO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Mar 2013 12:31:14 -0400
In-Reply-To: <005901ce1955$15a43280$40ec9780$%han@samsung.com> (Jingoo Han's
	message of "Tue, 05 Mar 2013 12:54:06 +0900")
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
>  drivers/mmc/host/mvsdio.c |   13 +------------
>  1 files changed, 1 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
> index 145cdaf..2b7d5b7 100644
> --- a/drivers/mmc/host/mvsdio.c
> +++ b/drivers/mmc/host/mvsdio.c
> @@ -881,18 +881,7 @@ static struct platform_driver mvsd_driver = {
>  	},
>  };
>  
> -static int __init mvsd_init(void)
> -{
> -	return platform_driver_probe(&mvsd_driver, mvsd_probe);
> -}
> -
> -static void __exit mvsd_exit(void)
> -{
> -	platform_driver_unregister(&mvsd_driver);
> -}
> -
> -module_init(mvsd_init);
> -module_exit(mvsd_exit);
> +module_platform_driver_probe(mvsd_driver, mvsd_probe);
>  
>  /* maximum card clock frequency (default 50MHz) */
>  module_param(maxfreq, int, 0);

Thanks, pushed to mmc-next for 3.10.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
