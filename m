From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 2/2] mmc: host: Add some quirks to be read from fdt in sdhci-pltm.c
Date: Wed, 8 Apr 2015 11:40:16 +0200
Message-ID: <CAPDyKFoc0V5BdKCO8v92Y1qHzEPgwxRdYR3cCj8nCyU-s25NuQ@mail.gmail.com>
References: <1427726768-17233-1-git-send-email-stripathi@apm.com>
	<1427726768-17233-3-git-send-email-stripathi@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:35380 "EHLO
	mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287AbbDHJkS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Apr 2015 05:40:18 -0400
Received: by qkhg7 with SMTP id g7so78640350qkh.2
        for <linux-mmc@vger.kernel.org>; Wed, 08 Apr 2015 02:40:17 -0700 (PDT)
In-Reply-To: <1427726768-17233-3-git-send-email-stripathi@apm.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Suman Tripathi <stripathi@apm.com>
Cc: Chris Ball <chris@printf.net>, Anton Vorontsov <anton@enomsg.org>, Arnd Bergmann <arnd@arndb.de>, linux-mmc <linux-mmc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, ddutile@redhat.com, jcm@redhat.com, mlangsdo@redhat.com, patches@apm.com

On 30 March 2015 at 16:46, Suman Tripathi <stripathi@apm.com> wrote:
> This patch adds some quirks support to be read from fdt.
>
> Signed-off-by: Suman Tripathi <stripathi@apm.com>
> ---
>  drivers/mmc/host/sdhci-pltfm.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
> index bef250e..9f6a4b9 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -85,6 +85,21 @@ void sdhci_get_of_property(struct platform_device *pdev)
>
>                 if (of_get_property(np, "broken-cd", NULL))
>                         host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
> +
> +               if (of_get_property(np, "delay-after-power", NULL))
> +                       host->quirks |= SDHCI_QUIRK_DELAY_AFTER_POWER;
> +
> +               if (of_get_property(np, "no-hispd", NULL))
> +                       host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
> +
> +               if (of_get_property(np, "broken-adma", NULL))
> +                       host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
> +
> +               if (of_get_property(np, "broken-dma", NULL))
> +                       host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
> +
> +               if (of_get_property(np, "no-cmd23", NULL))
> +                       host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;

Can't at least some of these be distinguished from what sdhci variant
that is being used? Instead of having them in DT...

Kind regards
Uffe

>
>                 if (of_get_property(np, "no-1-8-v", NULL))
>                         host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
> --
> 1.8.2.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
