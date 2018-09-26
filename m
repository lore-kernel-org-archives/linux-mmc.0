From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 02/27] mmc: mmci: internalize dma_inprogress into mmci
 dma functions
Date: Thu, 27 Sep 2018 01:49:25 +0200
Message-ID: <CAPDyKFrkTNyvEtLeaDRhJjMk90gfKJseX=Ukn-244awCGMp3EQ@mail.gmail.com>
References: <1537523181-14578-1-git-send-email-ludovic.Barre@st.com> <1537523181-14578-3-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537523181-14578-3-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Barre <ludovic.Barre@st.com>
Cc: Rob Herring <robh+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Gerald Baeza <gerald.baeza@st.com>, Loic Pallardy <loic.pallardy@st.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-mmc@vger.kernel.org

On 21 September 2018 at 11:45, Ludovic Barre <ludovic.Barre@st.com> wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
>
> This patch internalizes the dma_inprogress into mmci dma interfaces.
> This allows to simplify and prepare the next dma callbacks
> for mmci host ops. dma_inprogress is called in mmci_dma_data_error
> and mmci_dma_finalize.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
> change v3:
> -remove __dma_inprogress rename
>
>  drivers/mmc/host/mmci.c | 16 ++++++++++------
>  drivers/mmc/host/mmci.h |  2 --
>  2 files changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index bf0bb07..cbd67bc 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -497,6 +497,9 @@ static void mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
>
>  static void mmci_dma_data_error(struct mmci_host *host)
>  {
> +       if (!dma_inprogress(host))
> +               return;
> +
>         dev_err(mmc_dev(host->mmc), "error during DMA transfer!\n");
>         dmaengine_terminate_all(host->dma_current);
>         host->dma_in_progress = false;
> @@ -512,6 +515,9 @@ static void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
>         u32 status;
>         int i;
>
> +       if (!dma_inprogress(host))
> +               return;
> +
>         /* Wait up to 1ms for the DMA to complete */
>         for (i = 0; ; i++) {
>                 status = readl(host->base + MMCISTATUS);
> @@ -903,8 +909,7 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
>                 u32 remain, success;
>
>                 /* Terminate the DMA transfer */
> -               if (dma_inprogress(host))
> -                       mmci_dma_data_error(host);
> +               mmci_dma_data_error(host);
>
>                 /*
>                  * Calculate how far we are into the transfer.  Note that
> @@ -942,8 +947,8 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
>                 dev_err(mmc_dev(host->mmc), "stray MCI_DATABLOCKEND interrupt\n");
>
>         if (status & MCI_DATAEND || data->error) {
> -               if (dma_inprogress(host))
> -                       mmci_dma_finalize(host, data);
> +               mmci_dma_finalize(host, data);
> +
>                 mmci_stop_data(host);
>
>                 if (!data->error)
> @@ -1050,8 +1055,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>         if ((!sbc && !cmd->data) || cmd->error) {
>                 if (host->data) {
>                         /* Terminate the DMA transfer */
> -                       if (dma_inprogress(host))
> -                               mmci_dma_data_error(host);
> +                       mmci_dma_data_error(host);
>
>                         mmci_stop_data(host);
>                 }
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index 517591d..21aaf9a 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -333,8 +333,6 @@ struct mmci_host {
>         bool                    dma_in_progress;
>
>  #define dma_inprogress(host)   ((host)->dma_in_progress)
> -#else
> -#define dma_inprogress(host)   (0)
>  #endif
>  };
>
> --
> 2.7.4
>
