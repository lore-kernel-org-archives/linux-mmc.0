From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [v2] mmc: sdhci-pltfm: enable interrupt mode to detect card for ls1021a
Date: Wed, 23 Sep 2015 23:42:15 +0200
Message-ID: <CAPDyKFoVj0z_vHK_s0_7s1d_VKz8FqWUpHx1YATd5-Tw8-SyiA@mail.gmail.com>
References: <1442385370-26961-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:35291 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755595AbbIWVmQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Sep 2015 17:42:16 -0400
Received: by wicge5 with SMTP id ge5so226655509wic.0
        for <linux-mmc@vger.kernel.org>; Wed, 23 Sep 2015 14:42:15 -0700 (PDT)
In-Reply-To: <1442385370-26961-1-git-send-email-yangbo.lu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@freescale.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 16 September 2015 at 08:36, Yangbo Lu <yangbo.lu@freescale.com> wrote:
> Enable interrupt mode to detect card instead of polling mode for
> ls1021a by removing the quirk SDHCI_QUIRK_BROKEN_CARD_DETECTION.
> This could improve data transferring performance and avoid the call
> trace caused by polling card status sometime.
>
> Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
> Changes for v2:
>         - Modified commit message
> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 653f335..2a54dbe 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -371,7 +371,8 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
>             of_device_is_compatible(np, "fsl,p5020-esdhc") ||
>             of_device_is_compatible(np, "fsl,p4080-esdhc") ||
>             of_device_is_compatible(np, "fsl,p1020-esdhc") ||
> -           of_device_is_compatible(np, "fsl,t1040-esdhc"))
> +           of_device_is_compatible(np, "fsl,t1040-esdhc") ||
> +           of_device_is_compatible(np, "fsl,ls1021a-esdhc"))
>                 host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
>
>         if (of_device_is_compatible(np, "fsl,p2020-esdhc")) {
> --
> 2.1.0.27.g96db324
>
