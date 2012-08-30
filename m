From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: mmc_spi: Use module_spi_driver
Date: Thu, 30 Aug 2012 11:11:22 -0400
Message-ID: <87ipc0qusl.fsf@octavius.laptop.org>
References: <1346048622-2024-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:43678 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751041Ab2H3PLc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 30 Aug 2012 11:11:32 -0400
In-Reply-To: <1346048622-2024-1-git-send-email-sachin.kamat@linaro.org>
	(Sachin Kamat's message of "Mon, 27 Aug 2012 11:53:42 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-mmc@vger.kernel.org, patches@linaro.org

Hi,

On Mon, Aug 27 2012, Sachin Kamat wrote:
> module_spi_driver makes the code simpler by eliminating
> module_init and module_exit calls.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/mmc/host/mmc_spi.c |   15 +--------------
>  1 files changed, 1 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index 273306c..a600eab 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -1532,20 +1532,7 @@ static struct spi_driver mmc_spi_driver = {
>  	.remove =	__devexit_p(mmc_spi_remove),
>  };
>  
> -
> -static int __init mmc_spi_init(void)
> -{
> -	return spi_register_driver(&mmc_spi_driver);
> -}
> -module_init(mmc_spi_init);
> -
> -
> -static void __exit mmc_spi_exit(void)
> -{
> -	spi_unregister_driver(&mmc_spi_driver);
> -}
> -module_exit(mmc_spi_exit);
> -
> +module_spi_driver(mmc_spi_driver);
>  
>  MODULE_AUTHOR("Mike Lavender, David Brownell, "
>  		"Hans-Peter Nilsson, Jan Nikitenko");

Thanks, pushed to mmc-next for 3.7.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
