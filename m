From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: [PATCH v3 6/9] omap: hsmmc: remove unused variable
Date: Wed, 11 Aug 2010 12:55:04 +0300
Message-ID: <4C627378.2090304@nokia.com>
References: <1281478348-24833-1-git-send-email-ohad@wizery.com> <1281478348-24833-7-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1281478348-24833-7-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Chikkature Rajashekar Madhusudhan <madhu.cr@ti.com>, "Coelho Luciano (Nokia-MS/Helsinki)" <Luciano.Coelho@nokia.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, San Mehat <san@google.com>, "Quadros Roger (Nokia-MS/Helsinki)" <roger.quadros@nokia.com>, Tony Lindgren <tony@atomide.com>, Nicolas Pitre <nico@fluxnic.net>, Pandita Vikram <vikram.pandita@ti.com>, Kalle Valo <kalle.valo@iki.fi>
List-Id: linux-mmc@vger.kernel.org

Ohad Ben-Cohen wrote:
> Make this go away:
> 
> drivers/mmc/host/omap_hsmmc.c: In function 'omap_hsmmc_suspend':
> drivers/mmc/host/omap_hsmmc.c:2328: warning: unused variable 'state'

Was done a while ago.

See 1a13f8fa76c880be41d6b1e6a2b44404bcbfdf9e in linus' tree.

> 
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index b032828..d50e917 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -2272,7 +2272,6 @@ static int omap_hsmmc_suspend(struct device *dev)
>  	int ret = 0;
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct omap_hsmmc_host *host = platform_get_drvdata(pdev);
> -	pm_message_t state = PMSG_SUSPEND; /* unused by MMC core */
>  
>  	if (host && host->suspended)
>  		return 0;

