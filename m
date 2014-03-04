From: Matt Porter <mporter@linaro.org>
Subject: Re: [PATCH 1/6] mmc: sdhci-bcm-kona: fix build errors when built-in
Date: Tue, 4 Mar 2014 02:17:20 -0500
Message-ID: <20140304071720.GA25092@beef>
References: <20140228212936.GA21483@n2100.arm.linux.org.uk>
 <E1WJV2e-000429-1D@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:59018 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752622AbaCDHRY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Mar 2014 02:17:24 -0500
Received: by mail-ie0-f180.google.com with SMTP id as1so2708643iec.39
        for <linux-mmc@vger.kernel.org>; Mon, 03 Mar 2014 23:17:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <E1WJV2e-000429-1D@rmk-PC.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Chris Ball <chris@printf.net>, linux-mmc@vger.kernel.org, Markus Mayer <markus.mayer@linaro.org>, Christian Daudt <csd@broadcom.com>

On Fri, Feb 28, 2014 at 09:32:24PM +0000, Russell King wrote:
> `sdhci_bcm_kona_remove' referenced in section `.data' of drivers/built-in.o: defined in discarded section `.exit.text' of drivers/built-in.o
> 
> Fixes: 058feb53666f ("mmc: sdhci-bcm-kona: make linker-section warning go away")
> Cc: Markus Mayer <markus.mayer@linaro.org>
> Cc: Christian Daudt <csd@broadcom.com>
> Cc: Matt Porter <matt.porter@linaro.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Matt Porter <mporter@linaro.org>

> ---
>  drivers/mmc/host/sdhci-bcm-kona.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
> index 7a190fe4dff1..e5565aa5ed36 100644
> --- a/drivers/mmc/host/sdhci-bcm-kona.c
> +++ b/drivers/mmc/host/sdhci-bcm-kona.c
> @@ -314,7 +314,7 @@ static int sdhci_bcm_kona_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static int __exit sdhci_bcm_kona_remove(struct platform_device *pdev)
> +static int sdhci_bcm_kona_remove(struct platform_device *pdev)
>  {
>  	return sdhci_pltfm_unregister(pdev);
>  }
> -- 
> 1.8.3.1
> 
