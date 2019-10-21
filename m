From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: mxs: fix flags passed to dmaengine_prep_slave_sg
Date: Mon, 21 Oct 2019 16:59:12 +0200
Message-ID: <CAPDyKFo7-rb3285L9XpCi_eAE=RqfuKaz-njEWQjGYzfCoSLwQ@mail.gmail.com>
References: <20191018093934.29695-1-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20191018093934.29695-1-s.hauer@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Fabio Estevam <festevam@gmail.com>, Bruno Thomsen <bruno.thomsen@gmail.com>, "# 4.0+" <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, 18 Oct 2019 at 11:39, Sascha Hauer <s.hauer@pengutronix.de> wrote:
>
> Since ceeeb99cd821 we no longer abuse the DMA_CTRL_ACK flag for custom
> driver use and introduced the MXS_DMA_CTRL_WAIT4END instead. We have not
> changed all users to this flag though. This patch fixes it for the
> mxs-mmc driver.
>
> Fixes: ceeeb99cd821 ("dmaengine: mxs: rename custom flag")
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Tested-by: Fabio Estevam <festevam@gmail.com>
> Reported-by: Bruno Thomsen <bruno.thomsen@gmail.com>
> Tested-by: Bruno Thomsen <bruno.thomsen@gmail.com>
> Cc: stable@vger.kernel.org

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mxs-mmc.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index 78e7e350655c..4031217d21c3 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -17,6 +17,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/dmaengine.h>
> +#include <linux/dma/mxs-dma.h>
>  #include <linux/highmem.h>
>  #include <linux/clk.h>
>  #include <linux/err.h>
> @@ -266,7 +267,7 @@ static void mxs_mmc_bc(struct mxs_mmc_host *host)
>         ssp->ssp_pio_words[2] = cmd1;
>         ssp->dma_dir = DMA_NONE;
>         ssp->slave_dirn = DMA_TRANS_NONE;
> -       desc = mxs_mmc_prep_dma(host, DMA_CTRL_ACK);
> +       desc = mxs_mmc_prep_dma(host, MXS_DMA_CTRL_WAIT4END);
>         if (!desc)
>                 goto out;
>
> @@ -311,7 +312,7 @@ static void mxs_mmc_ac(struct mxs_mmc_host *host)
>         ssp->ssp_pio_words[2] = cmd1;
>         ssp->dma_dir = DMA_NONE;
>         ssp->slave_dirn = DMA_TRANS_NONE;
> -       desc = mxs_mmc_prep_dma(host, DMA_CTRL_ACK);
> +       desc = mxs_mmc_prep_dma(host, MXS_DMA_CTRL_WAIT4END);
>         if (!desc)
>                 goto out;
>
> @@ -441,7 +442,7 @@ static void mxs_mmc_adtc(struct mxs_mmc_host *host)
>         host->data = data;
>         ssp->dma_dir = dma_data_dir;
>         ssp->slave_dirn = slave_dirn;
> -       desc = mxs_mmc_prep_dma(host, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> +       desc = mxs_mmc_prep_dma(host, DMA_PREP_INTERRUPT | MXS_DMA_CTRL_WAIT4END);
>         if (!desc)
>                 goto out;
>
> --
> 2.23.0
>
