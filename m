From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 01/27] mmc: mmci: internalize dma map/unmap into mmci
 dma functions
Date: Thu, 27 Sep 2018 01:49:19 +0200
Message-ID: <CAPDyKFqGwihup0q=-mq_9-fj2YxJHWjWyP9jVSjUk6n=rdAvEg@mail.gmail.com>
References: <1537523181-14578-1-git-send-email-ludovic.Barre@st.com> <1537523181-14578-2-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537523181-14578-2-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Barre <ludovic.Barre@st.com>
Cc: Rob Herring <robh+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Gerald Baeza <gerald.baeza@st.com>, Loic Pallardy <loic.pallardy@st.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-mmc@vger.kernel.org

On 21 September 2018 at 11:45, Ludovic Barre <ludovic.Barre@st.com> wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
>
> This patch internalizes the management of dma map/unmap into
> mmci dma interfaces. This allows to simplify and prepare the next dma
> callbacks for mmci host ops.
> mmci_dma_unmap was called in mmci_data_irq & mmci_cmd_irq functions
> and can be integrated in mmci_dma_data_error.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/mmci.c | 40 +++++++++++++++++-----------------------
>  1 file changed, 17 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 1841d250..bf0bb07 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -482,16 +482,6 @@ static inline void mmci_dma_release(struct mmci_host *host)
>         host->dma_rx_channel = host->dma_tx_channel = NULL;
>  }
>
> -static void mmci_dma_data_error(struct mmci_host *host)
> -{
> -       dev_err(mmc_dev(host->mmc), "error during DMA transfer!\n");
> -       dmaengine_terminate_all(host->dma_current);
> -       host->dma_in_progress = false;
> -       host->dma_current = NULL;
> -       host->dma_desc_current = NULL;
> -       host->data->host_cookie = 0;
> -}
> -
>  static void mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
>  {
>         struct dma_chan *chan;
> @@ -505,6 +495,18 @@ static void mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
>                      mmc_get_dma_dir(data));
>  }
>
> +static void mmci_dma_data_error(struct mmci_host *host)
> +{
> +       dev_err(mmc_dev(host->mmc), "error during DMA transfer!\n");
> +       dmaengine_terminate_all(host->dma_current);
> +       host->dma_in_progress = false;
> +       host->dma_current = NULL;
> +       host->dma_desc_current = NULL;
> +       host->data->host_cookie = 0;
> +
> +       mmci_dma_unmap(host, host->data);
> +}
> +
>  static void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
>  {
>         u32 status;
> @@ -528,10 +530,9 @@ static void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
>                 mmci_dma_data_error(host);
>                 if (!data->error)
>                         data->error = -EIO;
> -       }
> -
> -       if (!data->host_cookie)
> +       } else if (!data->host_cookie) {
>                 mmci_dma_unmap(host, data);
> +       }
>
>         /*
>          * Use of DMA with scatter-gather is impossible.
> @@ -742,10 +743,6 @@ static inline void mmci_dma_release(struct mmci_host *host)
>  {
>  }
>
> -static inline void mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
> -{
> -}
> -
>  static inline void mmci_dma_finalize(struct mmci_host *host,
>                                      struct mmc_data *data)
>  {
> @@ -906,10 +903,8 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
>                 u32 remain, success;
>
>                 /* Terminate the DMA transfer */
> -               if (dma_inprogress(host)) {
> +               if (dma_inprogress(host))
>                         mmci_dma_data_error(host);
> -                       mmci_dma_unmap(host, data);
> -               }
>
>                 /*
>                  * Calculate how far we are into the transfer.  Note that
> @@ -1055,10 +1050,9 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>         if ((!sbc && !cmd->data) || cmd->error) {
>                 if (host->data) {
>                         /* Terminate the DMA transfer */
> -                       if (dma_inprogress(host)) {
> +                       if (dma_inprogress(host))
>                                 mmci_dma_data_error(host);
> -                               mmci_dma_unmap(host, host->data);
> -                       }
> +
>                         mmci_stop_data(host);
>                 }
>                 mmci_request_end(host, host->mrq);
> --
> 2.7.4
>
