From: Kevin Liu <keyuan.liu@gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pltfm: Fix timeout on t4240's sdhci controller
Date: Fri, 8 Mar 2013 23:17:02 +0800
Message-ID: <CADz5_gKDP2S9RnH0n6A3M4o3vuxNeRObVgMnAPGdSFFjJa9gHg@mail.gmail.com>
References: <25B60CDC2F704E4E9D88FFD52780CB4C0BDEB04DCF@SC-VEXCH1.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:57605 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932256Ab3CHPRF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Mar 2013 10:17:05 -0500
Received: by mail-we0-f182.google.com with SMTP id t57so1198355wey.13
        for <linux-mmc@vger.kernel.org>; Fri, 08 Mar 2013 07:17:03 -0800 (PST)
In-Reply-To: <25B60CDC2F704E4E9D88FFD52780CB4C0BDEB04DCF@SC-VEXCH1.marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chunhe Lan <Chunhe.Lan@freescale.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Jerry Huang <Chang-Ming.Huang@freescale.com>

Hi,

> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of Chunhe Lan
> Sent: Friday, March 08, 2013 4:14 PM
> To: linux-mmc@vger.kernel.org
> Cc: cjb@laptop.org; Chunhe Lan
> Subject: [PATCH] mmc: sdhci-pltfm: Fix timeout on t4240's sdhci controller
>
> This patch fixes timeout problems on t4240's sdhci controller:
>
>         mmc0: Too large timeout requested for CMD25!
>         mmc0: Too large timeout requested for CMD25!
>         mmc0: Too large timeout requested for CMD25!
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
>                 if (of_device_is_compatible(np, "fsl,p2020-esdhc") ||
>                     of_device_is_compatible(np, "fsl,p1010-esdhc") ||
> +                   of_device_is_compatible(np, "fsl,t4240-esdhc") ||
>                     of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
>                         host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
>

I think it's better to parse host specific property in host's driver
rather than the shared sdhci-pltfm.c.
Otherwise, sdhci_get_of_property will become bigger and bigger.
How do you think?
I have submitted below patch aim to do this:
[PATCH 2/2] mmc: sdhci-pltfm: add function in sdhci_ops to parse dt property

Thanks
Kevin
