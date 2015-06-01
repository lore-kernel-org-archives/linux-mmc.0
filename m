From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3] mmc: sdhci-pltfm: enable interrupt mode to detect card
Date: Mon, 1 Jun 2015 10:06:03 +0200
Message-ID: <CAPDyKFpQV_pOe7FpPTVz2-KjZe_QQTTmfTQqpSgLy_2RpQ8Jwg@mail.gmail.com>
References: <1433137632-48130-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:33045 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752374AbbFAIGE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Jun 2015 04:06:04 -0400
Received: by qkhg32 with SMTP id g32so80078801qkh.0
        for <linux-mmc@vger.kernel.org>; Mon, 01 Jun 2015 01:06:03 -0700 (PDT)
In-Reply-To: <1433137632-48130-1-git-send-email-yangbo.lu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@freescale.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chrisball@gmail.com>, Scott Wood <scottwood@freescale.com>

On 1 June 2015 at 07:47, Yangbo Lu <yangbo.lu@freescale.com> wrote:
> Enable interrupt mode to detect card instead of polling mode
> for P1020/P4080/P5020/P5040/T1040 by removing the quirk
> SDHCI_QUIRK_BROKEN_CARD_DETECTION. This could improve data
> transferring performance and avoid the call trace caused by
> polling card status sometime.
>
> Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>

Thanks, applied!

I updated the prefix of the commit message header and removed the
version history from the change-log.

Kind regards
Uffe


> ----
> Changes for v3:
>         - Moved code from sdhci-pltfm to sdhci-of-esdhc
> Changes for v2:
>         - Aligned all "of_device_is_compatibles" in same column
> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 22e9111..af9dad8 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -361,6 +361,13 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
>         sdhci_get_of_property(pdev);
>
>         np = pdev->dev.of_node;
> +       if (of_device_is_compatible(np, "fsl,p5040-esdhc") ||
> +           of_device_is_compatible(np, "fsl,p5020-esdhc") ||
> +           of_device_is_compatible(np, "fsl,p4080-esdhc") ||
> +           of_device_is_compatible(np, "fsl,p1020-esdhc") ||
> +           of_device_is_compatible(np, "fsl,t1040-esdhc"))
> +               host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
> +
>         if (of_device_is_compatible(np, "fsl,p2020-esdhc")) {
>                 /*
>                  * Freescale messed up with P2020 as it has a non-standard
> --
> 2.1.0.27.g96db324
>
