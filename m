From: Markus Mayer <markus.mayer@linaro.org>
Subject: Re: [PATCH 1/6] mmc: sdhci-bcm-kona: fix build errors when built-in
Date: Fri, 28 Feb 2014 13:54:50 -0800
Message-ID: <CAPdLdqmm8NpeovzA7aMYmkPA=34ty4niUgcNX=3tVUUny-dckw@mail.gmail.com>
References: <20140228212936.GA21483@n2100.arm.linux.org.uk>
	<E1WJV2e-000429-1D@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:62395 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752162AbaB1Vyv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Feb 2014 16:54:51 -0500
Received: by mail-ig0-f169.google.com with SMTP id y6so3046951igj.0
        for <linux-mmc@vger.kernel.org>; Fri, 28 Feb 2014 13:54:50 -0800 (PST)
In-Reply-To: <E1WJV2e-000429-1D@rmk-PC.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Chris Ball <chris@printf.net>, linux-mmc@vger.kernel.org, Christian Daudt <csd@broadcom.com>, Matt Porter <matt.porter@linaro.org>

On 28 February 2014 13:32, Russell King <rmk+kernel@arm.linux.org.uk> wrote:
> `sdhci_bcm_kona_remove' referenced in section `.data' of drivers/built-in.o: defined in discarded section `.exit.text' of drivers/built-in.o
>
> Fixes: 058feb53666f ("mmc: sdhci-bcm-kona: make linker-section warning go away")
> Cc: Markus Mayer <markus.mayer@linaro.org>
> Cc: Christian Daudt <csd@broadcom.com>
> Cc: Matt Porter <matt.porter@linaro.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/mmc/host/sdhci-bcm-kona.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
> index 7a190fe4dff1..e5565aa5ed36 100644
> --- a/drivers/mmc/host/sdhci-bcm-kona.c
> +++ b/drivers/mmc/host/sdhci-bcm-kona.c
> @@ -314,7 +314,7 @@ static int sdhci_bcm_kona_probe(struct platform_device *pdev)
>         return ret;
>  }
>
> -static int __exit sdhci_bcm_kona_remove(struct platform_device *pdev)
> +static int sdhci_bcm_kona_remove(struct platform_device *pdev)
>  {
>         return sdhci_pltfm_unregister(pdev);
>  }
> --
> 1.8.3.1
>

Tested-by: Markus Mayer <markus.mayer@linaro.org>

-- 
Markus Mayer
Broadcom Landing Team
