From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci-pltfm: Fix timeout on t4240's sdhci controller
Date: Fri, 22 Mar 2013 12:37:12 -0400
Message-ID: <87ppyro0g7.fsf@octavius.laptop.org>
References: <1362730450-24254-1-git-send-email-Chunhe.Lan@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:39086 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422631Ab3CVQhP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Mar 2013 12:37:15 -0400
In-Reply-To: <1362730450-24254-1-git-send-email-Chunhe.Lan@freescale.com>
	(Chunhe Lan's message of "Fri, 8 Mar 2013 16:14:10 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chunhe Lan <Chunhe.Lan@freescale.com>
Cc: linux-mmc@vger.kernel.org

Hi,

On Fri, Mar 08 2013, Chunhe Lan wrote:
> This patch fixes timeout problems on t4240's sdhci controller:
>
> 	mmc0: Too large timeout requested for CMD25!
> 	mmc0: Too large timeout requested for CMD25!
> 	mmc0: Too large timeout requested for CMD25!
>
> Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
> Cc: Chris Ball <cjb@laptop.org>
> ---
>  drivers/mmc/host/sdhci-pltfm.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
> index 3145a78..9db7b12 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -94,6 +94,7 @@ void sdhci_get_of_property(struct platform_device *pdev)
>  
>  		if (of_device_is_compatible(np, "fsl,p2020-esdhc") ||
>  		    of_device_is_compatible(np, "fsl,p1010-esdhc") ||
> +		    of_device_is_compatible(np, "fsl,t4240-esdhc") ||
>  		    of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
>  			host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;

Thanks, pushed to mmc-next for 3.10.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
