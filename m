From: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 06/14] mmc: sdhci-msm: Add get_min_clock() and
 get_max_clock() callback
Date: Tue, 8 Nov 2016 14:15:39 +0200
Message-ID: <a6c48c47-9788-094c-a214-d50627c7a17e@intel.com>
References: <1478517877-23733-1-git-send-email-riteshh@codeaurora.org>
 <1478517877-23733-7-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1478517877-23733-7-git-send-email-riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ritesh Harjani <riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, georgi.djakov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, alex.lemberg-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org, mateusz.nowak-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Yuliy.Izrailov-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org, asutoshd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, kdorfman-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, david.griego-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, stummala-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, venkatg-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, pramod.gurav-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 07/11/16 13:24, Ritesh Harjani wrote:
> This add get_min_clock() and get_max_clock() callback
> for sdhci-msm. sdhci-msm min/max clocks may be different
> hence implement these callbacks.
> 
> Signed-off-by: Sahitya Tummala <stummala-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> Signed-off-by: Ritesh Harjani <riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

Acked-by: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

> ---
>  drivers/mmc/host/sdhci-msm.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 32b0b79..66ca444 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -68,6 +68,7 @@
>  #define CORE_VENDOR_SPEC_CAPABILITIES0	0x11c
>  
>  #define TCXO_FREQ		19200000
> +#define SDHCI_MSM_MIN_CLOCK	400000
>  
>  #define CDR_SELEXT_SHIFT	20
>  #define CDR_SELEXT_MASK		(0xf << CDR_SELEXT_SHIFT)
> @@ -559,6 +560,19 @@ static irqreturn_t sdhci_msm_pwr_irq(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> +static unsigned int sdhci_msm_get_max_clock(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +
> +	return clk_round_rate(msm_host->clk, ULONG_MAX);
> +}
> +
> +static unsigned int sdhci_msm_get_min_clock(struct sdhci_host *host)
> +{
> +	return SDHCI_MSM_MIN_CLOCK;
> +}
> +
>  static const struct of_device_id sdhci_msm_dt_match[] = {
>  	{ .compatible = "qcom,sdhci-msm-v4" },
>  	{},
> @@ -570,6 +584,8 @@ static irqreturn_t sdhci_msm_pwr_irq(int irq, void *data)
>  	.platform_execute_tuning = sdhci_msm_execute_tuning,
>  	.reset = sdhci_reset,
>  	.set_clock = sdhci_set_clock,
> +	.get_min_clock = sdhci_msm_get_min_clock,
> +	.get_max_clock = sdhci_msm_get_max_clock,
>  	.set_bus_width = sdhci_set_bus_width,
>  	.set_uhs_signaling = sdhci_msm_set_uhs_signaling,
>  	.voltage_switch = sdhci_msm_voltage_switch,
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
