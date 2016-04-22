From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci: Remove SDHCI_SDR104_NEEDS_TUNING
Date: Fri, 22 Apr 2016 14:54:48 +0200
Message-ID: <CAPDyKFqq3MZ+GRaoty1vrgE94eMc=TQBs8917ocE8rrVFhXr0A@mail.gmail.com>
References: <1461133443-22146-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36061 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752004AbcDVMyu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Apr 2016 08:54:50 -0400
Received: by mail-wm0-f48.google.com with SMTP id v188so19955132wme.1
        for <linux-mmc@vger.kernel.org>; Fri, 22 Apr 2016 05:54:49 -0700 (PDT)
In-Reply-To: <1461133443-22146-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 20 April 2016 at 08:24, Adrian Hunter <adrian.hunter@intel.com> wrote:
> SDHCI_SDR104_NEEDS_TUNING was originally named SDHCI_HS200_NEEDS_TUNING
> and was added in commit 069c9f142822 ("mmc: host: Adds support for eMMC
> 4.5 HS200 mode").
>
> That commit conflated SDHCI_SDR50_NEEDS_TUNING and SDHCI_HS200_NEEDS_TUNING
> due to what appears to be misplaced parentheses.
>
> Commit 156e14b126ff ("mmc: sdhci: fix caps2 for HS200") made HS200
> configuration equivalent to SDR104 configuration, renaming
> SDHCI_HS200_NEEDS_TUNING to SDHCI_SDR104_NEEDS_TUNING despite tuning for
> HS200 now being non-optional.
>
> The mix-up with SDHCI_SDR50_NEEDS_TUNING remained and became more obvious
> after commit 4b6f37d3a379 ("mmc: sdhci: clean up sdhci_execute_tuning()
> decision") where the author noted the patch was "reflecting what the
> original code was doing, it shows that it may not be what the author
> actually intended."
>
> The way the code is currently written, SDHCI_SDR104_NEEDS_TUNING
> causes tuning to be done always for SDR50 mode if SDR104 mode is
> also supported by the host controller.  That makes no sense because
> we already have capabilities bit SDHCI_USE_SDR50_TUNING and
> corresponding flag SDHCI_SDR50_NEEDS_TUNING for that purpose.
>
> Given the dubious origins of SDHCI_SDR104_NEEDS_TUNING, it seems
> reasonable to remove it.  The benefit being SDR50 mode will now not
> un-nessessarily do tuning.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied for next! Appreciate the detailed changed log!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci.c | 7 +------
>  drivers/mmc/host/sdhci.h | 1 -
>  2 files changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index b284924aed13..a26c3996d78d 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1906,8 +1906,7 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>                 break;
>
>         case MMC_TIMING_UHS_SDR50:
> -               if (host->flags & SDHCI_SDR50_NEEDS_TUNING ||
> -                   host->flags & SDHCI_SDR104_NEEDS_TUNING)
> +               if (host->flags & SDHCI_SDR50_NEEDS_TUNING)
>                         break;
>                 /* FALLTHROUGH */
>
> @@ -3171,10 +3170,6 @@ int sdhci_add_host(struct sdhci_host *host)
>         if (caps[1] & SDHCI_USE_SDR50_TUNING)
>                 host->flags |= SDHCI_SDR50_NEEDS_TUNING;
>
> -       /* Does the host need tuning for SDR104 / HS200? */
> -       if (mmc->caps2 & MMC_CAP2_HS200)
> -               host->flags |= SDHCI_SDR104_NEEDS_TUNING;
> -
>         /* Driver Type(s) (A, C, D) supported by the host */
>         if (caps[1] & SDHCI_DRIVER_TYPE_A)
>                 mmc->caps |= MMC_CAP_DRIVER_TYPE_A;
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 0decc859523d..502627d71deb 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -445,7 +445,6 @@ struct sdhci_host {
>  #define SDHCI_AUTO_CMD23       (1<<7)  /* Auto CMD23 support */
>  #define SDHCI_PV_ENABLED       (1<<8)  /* Preset value enabled */
>  #define SDHCI_SDIO_IRQ_ENABLED (1<<9)  /* SDIO irq enabled */
> -#define SDHCI_SDR104_NEEDS_TUNING (1<<10)      /* SDR104/HS200 needs tuning */
>  #define SDHCI_USE_64_BIT_DMA   (1<<12) /* Use 64-bit DMA */
>  #define SDHCI_HS400_TUNING     (1<<13) /* Tuning for HS400 */
>
> --
> 1.9.1
>
