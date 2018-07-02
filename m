From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-of-esdhc: set proper dma mask for ls104x chips
Date: Mon, 2 Jul 2018 16:37:06 +0200
Message-ID: <CAPDyKFoNmcg+7JbWq1eeb2Dx7GKSh=FWpZcEeB8RORaBbrr=qA@mail.gmail.com>
References: <20180628084509.19646-1-laurentiu.tudor@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180628084509.19646-1-laurentiu.tudor@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Yangbo Lu <yangbo.lu@nxp.com>
List-Id: linux-mmc@vger.kernel.org

On 28 June 2018 at 10:45, Laurentiu Tudor <laurentiu.tudor@nxp.com> wrote:
> SDHCI controller in ls1043a and ls1046a generate 40-bit wide addresses
> when doing DMA. Make sure that the corresponding dma mask is correctly
> configured.
>
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 4ffa6b173a21..8332f56e6c0d 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -22,6 +22,7 @@
>  #include <linux/sys_soc.h>
>  #include <linux/clk.h>
>  #include <linux/ktime.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/mmc/host.h>
>  #include "sdhci-pltfm.h"
>  #include "sdhci-esdhc.h"
> @@ -427,6 +428,11 @@ static void esdhc_of_adma_workaround(struct sdhci_host *host, u32 intmask)
>  static int esdhc_of_enable_dma(struct sdhci_host *host)
>  {
>         u32 value;
> +       struct device *dev = mmc_dev(host->mmc);
> +
> +       if (of_device_is_compatible(dev->of_node, "fsl,ls1043a-esdhc") ||
> +           of_device_is_compatible(dev->of_node, "fsl,ls1046a-esdhc"))
> +               dma_set_mask_and_coherent(dev, DMA_BIT_MASK(40));
>
>         value = sdhci_readl(host, ESDHC_DMA_SYSCTL);
>         value |= ESDHC_DMA_SNOOP;
> --
> 2.17.1
>
