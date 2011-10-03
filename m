From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] mmc: sdhci-tegra: Add #ifdef CONFIG_OF guard for of_find_property
Date: Mon, 03 Oct 2011 10:32:24 +0200
Message-ID: <4E897318.3090004@compulab.co.il>
References: <1317614852.30838.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:57412
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751957Ab1JCIck (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Oct 2011 04:32:40 -0400
In-Reply-To: <1317614852.30838.1.camel@phoenix>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Chris Ball <cjb@laptop.org>, Olof Johansson <olof@lixom.net>, Stephen Warren <swarren@nvidia.com>, linux-mmc@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>

Hi Axel,

On 10/03/11 06:07, Axel Lin wrote:
> I got below build error with "make tegra_defconfig;make"
> Add #ifdef CONFIG_OF guard for of_find_property to fix below build error:
> 
>   CC      drivers/mmc/host/sdhci-tegra.o
> drivers/mmc/host/sdhci-tegra.c: In function 'sdhci_tegra_dt_parse_pdata':
> drivers/mmc/host/sdhci-tegra.c:157: error: implicit declaration of function 'of_find_property'
> make[3]: *** [drivers/mmc/host/sdhci-tegra.o] Error 1
> make[2]: *** [drivers/mmc/host] Error 2
> make[1]: *** [drivers/mmc] Error 2
> make: *** [drivers] Error 2
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
> I got the build error on linux-next (20110930).
> Axel
> 
>  drivers/mmc/host/sdhci-tegra.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 67176afc..3883602 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -154,8 +154,11 @@ static struct tegra_sdhci_platform_data * __devinit sdhci_tegra_dt_parse_pdata(
>  	plat->cd_gpio = of_get_named_gpio(np, "cd-gpios", 0);
>  	plat->wp_gpio = of_get_named_gpio(np, "wp-gpios", 0);
>  	plat->power_gpio = of_get_named_gpio(np, "power-gpios", 0);
> +
> +#ifdef CONFIG_OF
>  	if (of_find_property(np, "support-8bit", NULL))
>  		plat->is_8bit = 1;
> +#endif

Shouldn't we add a stub for the of_find_property() method to include/linux/of.h
instead of adding more ifdefs?
Or may be use of_get_property() method instead?

>  
>  	return plat;
>  }

-- 
Regards,
Igor.
