From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2, 2/2] mmc: sdhci-pltfm: enable interrupt mode to detect card
Date: Mon, 18 May 2015 11:03:57 +0200
Message-ID: <CAPDyKFrgr5-xL3xG83AdFd8sAf20TUetCN=7etCg9rsKoZ317g@mail.gmail.com>
References: <1431657984-42484-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:32768 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752937AbbERJD6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 May 2015 05:03:58 -0400
Received: by qkgv12 with SMTP id v12so30522661qkg.0
        for <linux-mmc@vger.kernel.org>; Mon, 18 May 2015 02:03:57 -0700 (PDT)
In-Reply-To: <1431657984-42484-1-git-send-email-yangbo.lu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@freescale.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chrisball@gmail.com>, Scott Wood <scottwood@freescale.com>

On 15 May 2015 at 04:46, Yangbo Lu <yangbo.lu@freescale.com> wrote:
> Enable interrupt mode to detect card instead of polling mode
> for P1020/P4080/P5020/P5040/T1040 by removing the quirk
> SDHCI_QUIRK_BROKEN_CARD_DETECTION. This could improve data
> transferring performance and avoid the call trace caused by
> polling card status sometime.
>
> Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
> ----
> Changes for v2:
>         - Aligned all "of_device_is_compatibles" in same column
> ---
>  drivers/mmc/host/sdhci-pltfm.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
> index c5b01d6..97128f3 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -102,6 +102,13 @@ void sdhci_get_of_property(struct platform_device *pdev)
>                     of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
>                         host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
>
> +               if (of_device_is_compatible(np, "fsl,p5040-esdhc") ||
> +                   of_device_is_compatible(np, "fsl,p5020-esdhc") ||
> +                   of_device_is_compatible(np, "fsl,p4080-esdhc") ||
> +                   of_device_is_compatible(np, "fsl,p1020-esdhc") ||
> +                   of_device_is_compatible(np, "fsl,t1040-esdhc"))
> +                       host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;

This looks strange to me.

Why not just change the DT files for the relevant platforms to not
enable "broken-cd"?

Kind regards
Uffe
