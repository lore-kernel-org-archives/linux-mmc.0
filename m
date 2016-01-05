From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: tegra: don't enable UHS modes on Tegra210
Date: Tue, 5 Jan 2016 18:06:32 +0100
Message-ID: <CAPDyKFrgp20TRH-+W874tRxiiXmdLKm6ERW1Zvf=vwPfsZXxJw@mail.gmail.com>
References: <1451490549-21430-1-git-send-email-dev@lynxeye.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f179.google.com ([209.85.160.179]:36117 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809AbcAERGd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Jan 2016 12:06:33 -0500
Received: by mail-yk0-f179.google.com with SMTP id v14so194772893ykd.3
        for <linux-mmc@vger.kernel.org>; Tue, 05 Jan 2016 09:06:33 -0800 (PST)
In-Reply-To: <1451490549-21430-1-git-send-email-dev@lynxeye.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lucas Stach <dev@lynxeye.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>

On 30 December 2015 at 16:49, Lucas Stach <dev@lynxeye.de> wrote:
> Tegra210 needs a different tuning sequence than Tegra30+. Disable
> UHS modes until support for this is properly added.
>
> Signed-off-by: Lucas Stach <dev@lynxeye.de>
> ---
> Ulf,
> this is a follow on patch to my Tegra UHS-I series. After reading the
> Tegra210 TRM I realized that the currently implemented tuning sequence will
> only work on Tegra30..Tegra124.  If you don't keep your tree stable you
> might want to squash this into [PATCH v2 4/5] mmc: tegra: enable UHS-I modes,
> otherwise please pick this up as a fix on top.

Thanks, I have squashed the change into patch4.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-tegra.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index b5abbe2..83c4bf7 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -353,9 +353,6 @@ static const struct sdhci_pltfm_data sdhci_tegra210_pdata = {
>
>  static const struct sdhci_tegra_soc_data soc_data_tegra210 = {
>         .pdata = &sdhci_tegra210_pdata,
> -       .nvquirks = NVQUIRK_ENABLE_SDR50 |
> -                   NVQUIRK_ENABLE_DDR50 |
> -                   NVQUIRK_ENABLE_SDR104,
>  };
>
>  static const struct of_device_id sdhci_tegra_dt_match[] = {
> --
> 2.5.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
