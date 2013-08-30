From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2 2/4] mmc: sdhci-s3c: initialize host->quirks2 for using quirk2
Date: Thu, 29 Aug 2013 21:19:32 -0400
Message-ID: <8761uox9ej.fsf@octavius.laptop.org>
References: <51FBBD7C.10800@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:33304 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752103Ab3H3BTf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 29 Aug 2013 21:19:35 -0400
In-Reply-To: <51FBBD7C.10800@samsung.com> (Jaehoon Chung's message of "Fri, 02
	Aug 2013 23:09:00 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>

Hi Jaehoon,

On Fri, Aug 02 2013, Jaehoon Chung wrote:
> In order to use the quirks2, initialized the host->quirks2.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <Kyungmin.park@samsung.com>
> ---
> Changelog v2:
> 	- Nothing
>
>  drivers/mmc/host/sdhci-s3c.c |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 1572b6a..6debda9 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -611,6 +611,7 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
>  	host->hw_name = "samsung-hsmmc";
>  	host->ops = &sdhci_s3c_ops;
>  	host->quirks = 0;
> +	host->quirks2 = 0;
>  	host->irq = irq;
>  
>  	/* Setup quirks for the controller */

Thanks, pushed too mmc-next for 3.12.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
