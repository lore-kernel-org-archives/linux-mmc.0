From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/4] mmc: sdhci-omap: Add variable to indicate host is tuning
Date: Mon, 19 Nov 2018 14:18:46 +0100
Message-ID: <CAPDyKFqkscm9ZhJhk7SWFc_tmqqqXSx5_t2tzEL-DV6aE+Q=KA@mail.gmail.com>
References: <20181119111618.2745-1-faiz_abbas@ti.com> <20181119111618.2745-3-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181119111618.2745-3-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kishon <kishon@ti.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

On 19 November 2018 at 12:16, Faiz Abbas <faiz_abbas@ti.com> wrote:
> Add a variable in sdhc_omap_host to indicate whether a tuning
> operation is ongoing.
>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>

Please squash this into patch3 as it seems a bit silly to keep this a
separate change.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-omap.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index 87138067e334..cfffcf58be3f 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -115,6 +115,7 @@ struct sdhci_omap_host {
>
>         struct pinctrl          *pinctrl;
>         struct pinctrl_state    **pinctrl_state;
> +       bool                    is_tuning;
>  };
>
>  static void sdhci_omap_start_clock(struct sdhci_omap_host *omap_host);
> @@ -318,6 +319,8 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
>          */
>         host->ier &= ~SDHCI_INT_DATA_CRC;
>
> +       omap_host->is_tuning = true;
> +
>         while (phase_delay <= MAX_PHASE_DELAY) {
>                 sdhci_omap_set_dll(omap_host, phase_delay);
>
> @@ -355,9 +358,12 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
>         phase_delay = max_window + 4 * (max_len >> 1);
>         sdhci_omap_set_dll(omap_host, phase_delay);
>
> +       omap_host->is_tuning = false;
> +
>         goto ret;
>
>  tuning_error:
> +       omap_host->is_tuning = false;
>         dev_err(dev, "Tuning failed\n");
>         sdhci_omap_disable_tuning(omap_host);
>
> --
> 2.19.1
>
