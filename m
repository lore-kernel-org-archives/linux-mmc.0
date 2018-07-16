From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: tegra: Add and use tegra_sdhci_get_max_clock()
Date: Mon, 16 Jul 2018 12:11:43 +0200
Message-ID: <CAPDyKFqY31RSebKxUtiPsXFZD35aJFxerakHgjyq7gqrRCHmBA@mail.gmail.com>
References: <1531487865-17427-1-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531487865-17427-1-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <avienamo@nvidia.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-tegra@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Stefan Agner <stefan@agner.ch>
List-Id: linux-mmc@vger.kernel.org

+Stefan

On 13 July 2018 at 15:17, Aapo Vienamo <avienamo@nvidia.com> wrote:
> Implement and use tegra_sdhci_get_max_clock() which returns the true
> maximum host clock rate. The issue with tegra_sdhci_get_max_clock() is
> that it returns the current clock rate of the host instead of the
> maximum one, which can lead to unnecessarily small clock rates.
>
> This differs from the previous implementation of
> tegra_sdhci_get_max_clock() in that it doesn't divide the result by two.
>
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>

Thanks, applied for next!

I realize there are some discussions and tests going on in regards to
the changes for tegra driver. However, I decided to apply all pending
patches from Stefan and you, to get them tested in next for a while to
see how it plays.

Please tell if you want me to drop some changes - or if you prefer to
send patches on top to fix further related issues.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-tegra.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 28b98e2..ddf00166 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -235,6 +235,13 @@ static void tegra_sdhci_set_uhs_signaling(struct sdhci_host *host,
>         sdhci_set_uhs_signaling(host, timing);
>  }
>
> +static unsigned int tegra_sdhci_get_max_clock(struct sdhci_host *host)
> +{
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +
> +       return clk_round_rate(pltfm_host->clk, UINT_MAX);
> +}
> +
>  static void tegra_sdhci_set_tap(struct sdhci_host *host, unsigned int tap)
>  {
>         u32 reg;
> @@ -299,7 +306,7 @@ static const struct sdhci_ops tegra_sdhci_ops = {
>         .platform_execute_tuning = tegra_sdhci_execute_tuning,
>         .set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
>         .voltage_switch = tegra_sdhci_voltage_switch,
> -       .get_max_clock = sdhci_pltfm_clk_get_max_clock,
> +       .get_max_clock = tegra_sdhci_get_max_clock,
>  };
>
>  static const struct sdhci_pltfm_data sdhci_tegra20_pdata = {
> @@ -356,7 +363,7 @@ static const struct sdhci_ops tegra114_sdhci_ops = {
>         .platform_execute_tuning = tegra_sdhci_execute_tuning,
>         .set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
>         .voltage_switch = tegra_sdhci_voltage_switch,
> -       .get_max_clock = sdhci_pltfm_clk_get_max_clock,
> +       .get_max_clock = tegra_sdhci_get_max_clock,
>  };
>
>  static const struct sdhci_pltfm_data sdhci_tegra114_pdata = {
> --
> 2.7.4
>
