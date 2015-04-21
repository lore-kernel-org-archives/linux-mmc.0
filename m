From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 RESEND 2/2] mmc: host: Add some quirks to be read from fdt in sdhci-pltm.c
Date: Tue, 21 Apr 2015 17:46:38 +0200
Message-ID: <8525627.D1S9aInyMV@wuerfel>
References: <1429630959-32649-1-git-send-email-stripathi@apm.com> <1429630959-32649-3-git-send-email-stripathi@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:63694 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932875AbbDUPqp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Apr 2015 11:46:45 -0400
In-Reply-To: <1429630959-32649-3-git-send-email-stripathi@apm.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Suman Tripathi <stripathi@apm.com>
Cc: chris@printf.net, ulf.hansson@linaro.org, anton@enomsg.org, linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ddutile@redhat.com, jcm@redhat.com, mlangsdo@redhat.com, patches@apm.com

On Tuesday 21 April 2015 21:12:39 Suman Tripathi wrote:
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
>  
>                 if (of_get_property(np, "no-1-8-v", NULL))
>                         host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
> 

Any property you add needs to be documented in the DT binding.

If possible, add generic properties for each bug you have mmc.txt
rather than the driver specific sdhci.txt, and implement the
parsing in a common function that is used for all mmc hosts.

An alternative would be to set all these bits based on the compatible
string of your host, if that is the only one that has all these bugs.

	Arnd
