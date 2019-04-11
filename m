From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v6] mmc: sdhci-omap: Don't finish_mrq() on a command error
 during tuning
Date: Thu, 11 Apr 2019 12:44:19 +0200
Message-ID: <CAPDyKFpbNNX8=w1xKZNFhaxkRWTsY58tsQ+NEw_nZqVe0+fPig@mail.gmail.com>
References: <20190411085937.633-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190411085937.633-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Kishon <kishon@ti.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

On Thu, 11 Apr 2019 at 11:00, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> commit 5b0d62108b46 ("mmc: sdhci-omap: Add platform specific reset
> callback") skips data resets during tuning operation. Because of this,
> a data error or data finish interrupt might still arrive after a command
> error has been handled and the mrq ended. This ends up with a "mmc0: Got
> data interrupt 0x00000002 even though no data operation was in progress"
> error message.
>
> Fix this by adding a platform specific callback for sdhci_irq. Mark the
> mrq as a failure but wait for a data interrupt instead of calling
> finish_mrq().
>
> Fixes: 5b0d62108b46 ("mmc: sdhci-omap: Add platform specific reset
> callback")
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe

> ---
>
> Tested with 100 times boot tests on dra71x-evm, dra72x-evm and
> dra7xx-evm.
>
> v6:
> Changed return value to u32 to fix the build warning.
>
> v5:
> Drop patch 1 and replace call to sdhci_finish_command() with
> host->cmd = NULL
>
> v4:
> Fixed commit description for patch 1.
> Added SDHCI_INT_TIMEOUT to CMD_ERR_MASK in patch 2.
>
> v3:
> Removed the command error specific callback and using the already
> existing sdhci_irq callback instead. No measurable drop in performance.
>
> v2:
> Added EXPORT_SYMBOL_GPL for sdhci_cmd_err and sdhci_send_command to fix
> errors when built as module.
>
>  drivers/mmc/host/sdhci-omap.c | 38 +++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index 5bbed477c9b1..9f20fff9781b 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -797,6 +797,43 @@ void sdhci_omap_reset(struct sdhci_host *host, u8 mask)
>         sdhci_reset(host, mask);
>  }
>
> +#define CMD_ERR_MASK (SDHCI_INT_CRC | SDHCI_INT_END_BIT | SDHCI_INT_INDEX |\
> +                     SDHCI_INT_TIMEOUT)
> +#define CMD_MASK (CMD_ERR_MASK | SDHCI_INT_RESPONSE)
> +
> +static u32 sdhci_omap_irq(struct sdhci_host *host, u32 intmask)
> +{
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
> +
> +       if (omap_host->is_tuning && host->cmd && !host->data_early &&
> +           (intmask & CMD_ERR_MASK)) {
> +
> +               /*
> +                * Since we are not resetting data lines during tuning
> +                * operation, data error or data complete interrupts
> +                * might still arrive. Mark this request as a failure
> +                * but still wait for the data interrupt
> +                */
> +               if (intmask & SDHCI_INT_TIMEOUT)
> +                       host->cmd->error = -ETIMEDOUT;
> +               else
> +                       host->cmd->error = -EILSEQ;
> +
> +               host->cmd = NULL;
> +
> +               /*
> +                * Sometimes command error interrupts and command complete
> +                * interrupt will arrive together. Clear all command related
> +                * interrupts here.
> +                */
> +               sdhci_writel(host, intmask & CMD_MASK, SDHCI_INT_STATUS);
> +               intmask &= ~CMD_MASK;
> +       }
> +
> +       return intmask;
> +}
> +
>  static struct sdhci_ops sdhci_omap_ops = {
>         .set_clock = sdhci_omap_set_clock,
>         .set_power = sdhci_omap_set_power,
> @@ -807,6 +844,7 @@ static struct sdhci_ops sdhci_omap_ops = {
>         .platform_send_init_74_clocks = sdhci_omap_init_74_clocks,
>         .reset = sdhci_omap_reset,
>         .set_uhs_signaling = sdhci_omap_set_uhs_signaling,
> +       .irq = sdhci_omap_irq,
>  };
>
>  static int sdhci_omap_set_capabilities(struct sdhci_omap_host *omap_host)
> --
> 2.19.2
>
