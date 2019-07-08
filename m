From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: sdhci-msm: fix mutex while in spinlock
Date: Mon, 8 Jul 2019 13:55:55 +0200
Message-ID: <CAPDyKFrcB3Pqe+yiz4T5mL5wQ-2bATyO3aE+hy4T2Ueeu22g1Q@mail.gmail.com>
References: <20190701150125.2602-1-jorge.ramirez-ortiz@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190701150125.2602-1-jorge.ramirez-ortiz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc: agross@kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Khasim Syed Mohammed <khasim.mohammed@linaro.org>, vinod.koul@linaro.org
List-Id: linux-mmc@vger.kernel.org

On Mon, 1 Jul 2019 at 17:01, Jorge Ramirez-Ortiz
<jorge.ramirez-ortiz@linaro.org> wrote:
>
> mutexes can sleep and therefore should not be taken while holding a
> spinlock. move clk_get_rate (can sleep) outside the spinlock protected
> region.
>
> Fixes: 83736352e0ca ("mmc: sdhci-msm: Update DLL reset sequence")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-msm.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 5fc76a1993d0..9cf14b359c14 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -575,11 +575,14 @@ static int msm_init_cm_dll(struct sdhci_host *host)
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>         int wait_cnt = 50;
> -       unsigned long flags;
> +       unsigned long flags, xo_clk = 0;
>         u32 config;
>         const struct sdhci_msm_offset *msm_offset =
>                                         msm_host->offset;
>
> +       if (msm_host->use_14lpp_dll_reset && !IS_ERR_OR_NULL(msm_host->xo_clk))
> +               xo_clk = clk_get_rate(msm_host->xo_clk);
> +
>         spin_lock_irqsave(&host->lock, flags);
>
>         /*
> @@ -627,10 +630,10 @@ static int msm_init_cm_dll(struct sdhci_host *host)
>                 config &= CORE_FLL_CYCLE_CNT;
>                 if (config)
>                         mclk_freq = DIV_ROUND_CLOSEST_ULL((host->clock * 8),
> -                                       clk_get_rate(msm_host->xo_clk));
> +                                       xo_clk);
>                 else
>                         mclk_freq = DIV_ROUND_CLOSEST_ULL((host->clock * 4),
> -                                       clk_get_rate(msm_host->xo_clk));
> +                                       xo_clk);
>
>                 config = readl_relaxed(host->ioaddr +
>                                 msm_offset->core_dll_config_2);
> --
> 2.21.0
>
