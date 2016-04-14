From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: tegra: Disable UHS-I modes for tegra124
Date: Thu, 14 Apr 2016 11:48:09 +0200
Message-ID: <CAPDyKFrt8Jt96rSF_2mqMYgb=2cfYnfsTZkj406pUy4LD62dKg@mail.gmail.com>
References: <1460558156-10407-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:33186 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614AbcDNJsM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Apr 2016 05:48:12 -0400
Received: by mail-wm0-f49.google.com with SMTP id f198so2549032wme.0
        for <linux-mmc@vger.kernel.org>; Thu, 14 Apr 2016 02:48:11 -0700 (PDT)
In-Reply-To: <1460558156-10407-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Lucas Stach <dev@lynxeye.de>

On 13 April 2016 at 16:35, Jon Hunter <jonathanh@nvidia.com> wrote:
> Tegra124 has been randomly hanging during system suspend when entering
> the Tegra LP1 low power state. The hang is caused by the tegra SDHCI
> driver and linked to the UHS-I tuning sequence. Disabling the UHS-I
> modes for Tegra124 prevents any hangs from occurring when entering
> system suspend.
>
> Unfortunately, the tuning sequence described in the public Tegra
> documentation is incomplete and on inspection of the current tuning
> sequence that has been implemented is also incomplete and may cause
> problems. In the short-term it is safer to disable UHS-I modes for now
> and fix later because it would be too large of a change to simply patch
> now. Therefore, disable UHS-I modes for Tegra124.
>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>

Thanks, applied for fixes (with minor updates to the change log
according to suggestions from Stephen)!

Kind regards
Uffe

> ---
>
> I previously brought up this issue in this thread [0], but there has
> been no resolution and so I think that for v4.6 we need to disable this
> for now. I also pointered out that there is a complete implementation
> available in the v3.18 kernel used by chromeos products [1]. We do plan
> to get better support for UHS-I modes for Tegra it is just a matter of
> bandwidth at the moment :-(
>
> [0] http://marc.info/?l=linux-tegra&m=145926947408663&w=2
> [1] https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-3.10/drivers/mmc/host/sdhci-tegra.c
>
>  drivers/mmc/host/sdhci-tegra.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index f8c4762bb48d..bcc0de47fe7e 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -382,14 +382,6 @@ static const struct sdhci_tegra_soc_data soc_data_tegra114 = {
>         .pdata = &sdhci_tegra114_pdata,
>  };
>
> -static const struct sdhci_tegra_soc_data soc_data_tegra124 = {
> -       .pdata = &sdhci_tegra114_pdata,
> -       .nvquirks = NVQUIRK_ENABLE_SDR50 |
> -                   NVQUIRK_ENABLE_DDR50 |
> -                   NVQUIRK_ENABLE_SDR104 |
> -                   NVQUIRK_HAS_PADCALIB,
> -};
> -
>  static const struct sdhci_pltfm_data sdhci_tegra210_pdata = {
>         .quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
>                   SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
> @@ -407,7 +399,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra210 = {
>
>  static const struct of_device_id sdhci_tegra_dt_match[] = {
>         { .compatible = "nvidia,tegra210-sdhci", .data = &soc_data_tegra210 },
> -       { .compatible = "nvidia,tegra124-sdhci", .data = &soc_data_tegra124 },
> +       { .compatible = "nvidia,tegra124-sdhci", .data = &soc_data_tegra114 },
>         { .compatible = "nvidia,tegra114-sdhci", .data = &soc_data_tegra114 },
>         { .compatible = "nvidia,tegra30-sdhci", .data = &soc_data_tegra30 },
>         { .compatible = "nvidia,tegra20-sdhci", .data = &soc_data_tegra20 },
> --
> 2.1.4
>
