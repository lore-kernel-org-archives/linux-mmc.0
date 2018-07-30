From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: tegra: Force correct divider calculation on DDR50/52
Date: Mon, 30 Jul 2018 17:05:59 +0200
Message-ID: <CAPDyKFoRtSH6Run5WE-iyPgFOjxanNtHq6QtR007_KcW5Ld3=A@mail.gmail.com>
References: <1531751669-26584-1-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531751669-26584-1-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <avienamo@nvidia.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Stefan Agner <stefan@agner.ch>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-tegra@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 16 July 2018 at 16:34, Aapo Vienamo <avienamo@nvidia.com> wrote:
> Tegra SDHCI controllers require the SDHCI clock divider to be configured
> to divide the clock by two in DDR50/52 modes. Incorrectly configured
> clock divider results in corrupted data.
>
> Prevent the possibility of incorrectly calculating the divider value due
> to clock rate rounding or low parent clock frequency by not assigning
> host->max_clk to clk_get_rate() on tegra_sdhci_set_clock().
>
> See the comments for further details.
>
> Fixes: a8e326a ("mmc: tegra: implement module external clock change")
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-tegra.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index ddf00166..908b23e 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -210,9 +210,24 @@ static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>         if (!clock)
>                 return sdhci_set_clock(host, clock);
>
> +       /*
> +        * In DDR50/52 modes the Tegra SDHCI controllers require the SDHCI
> +        * divider to be configured to divided the host clock by two. The SDHCI
> +        * clock divider is calculated as part of sdhci_set_clock() by
> +        * sdhci_calc_clk(). The divider is calculated from host->max_clk and
> +        * the requested clock rate.
> +        *
> +        * By setting the host->max_clk to clock * 2 the divider calculation
> +        * will always result in the correct value for DDR50/52 modes,
> +        * regardless of clock rate rounding, which may happen if the value
> +        * from clk_get_rate() is used.
> +        */
>         host_clk = tegra_host->ddr_signaling ? clock * 2 : clock;
>         clk_set_rate(pltfm_host->clk, host_clk);
> -       host->max_clk = clk_get_rate(pltfm_host->clk);
> +       if (tegra_host->ddr_signaling)
> +               host->max_clk = host_clk;
> +       else
> +               host->max_clk = clk_get_rate(pltfm_host->clk);
>
>         sdhci_set_clock(host, clock);
>
> --
> 2.7.4
>
