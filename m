From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3] mmc, sdhci, bcm-kona, LLVMLinux: Remove use of __initconst
Date: Fri, 3 Oct 2014 14:59:07 +0200
Message-ID: <CAPDyKFruar4iax_goZUmCbyoAM9BwNFLzyss1Fc+pZVkse+a7A@mail.gmail.com>
References: <5774775.2EcFmuR4sV@wuerfel>
	<1411685122-21867-1-git-send-email-behanw@converseincode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:46889 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314AbaJCM7I (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Oct 2014 08:59:08 -0400
Received: by mail-qc0-f180.google.com with SMTP id x3so879224qcv.39
        for <linux-mmc@vger.kernel.org>; Fri, 03 Oct 2014 05:59:07 -0700 (PDT)
In-Reply-To: <1411685122-21867-1-git-send-email-behanw@converseincode.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Behan Webster <behanw@converseincode.com>
Cc: Christian Daudt <bcm@fixthebug.org>, Chris Ball <chris@printf.net>, Matt Porter <mporter@linaro.org>, bcm-kernel-feedback-list@broadcom.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

On 26 September 2014 00:45, Behan Webster <behanw@converseincode.com> wrote:
> The __initconst is in the wrong place, and when moved to the correct place
> it uncovers an error where the variable is used by non-init data structures.
>
> Instead merely make them const and put the const in the right spot.
>
> Signed-off-by: Behan Webster <behanw@converseincode.com>
> Reviewed-by: Mark Charlebois <charlebm@gmail.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Matt Porter <mporter@linaro.org>

Thanks! Applied for next.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-bcm-kona.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
> index dd780c3..d085dfe 100644
> --- a/drivers/mmc/host/sdhci-bcm-kona.c
> +++ b/drivers/mmc/host/sdhci-bcm-kona.c
> @@ -225,7 +225,7 @@ static struct sdhci_pltfm_data sdhci_pltfm_data_kona = {
>                 SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
>  };
>
> -static struct __initconst of_device_id sdhci_bcm_kona_of_match[] = {
> +static const struct of_device_id sdhci_bcm_kona_of_match[] = {
>         { .compatible = "brcm,kona-sdhci"},
>         { .compatible = "bcm,kona-sdhci"}, /* deprecated name */
>         {}
> --
> 1.9.1
>
