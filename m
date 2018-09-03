From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 04/14] mmc: mmci: introduce dma_priv pointer to mmci_host
Date: Mon, 3 Sep 2018 14:15:26 +0200
Message-ID: <CAPDyKFrBtB8Z-9gxcYmmoVPwLQ8dedJLmDiLqbyEoL5oax5owg@mail.gmail.com>
References: <1533116221-380-1-git-send-email-ludovic.Barre@st.com> <1533116221-380-5-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533116221-380-5-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Barre <ludovic.Barre@st.com>
Cc: Rob Herring <robh+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Gerald Baeza <gerald.baeza@st.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 1 August 2018 at 11:36, Ludovic Barre <ludovic.Barre@st.com> wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
>
> This patch introduces dma_priv pointer to define specific
> needs for each dma engine. This patch is needed to prepare
> sdmmc variant with internal dma which not use dmaengine API.

Overall this looks good, however a couple a few things below, mostly nitpicks.

>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  drivers/mmc/host/mmci.c          | 165 +++++++++++++++++++++++++--------------
>  drivers/mmc/host/mmci.h          |  20 +----
>  drivers/mmc/host/mmci_qcom_dml.c |   6 +-
>  3 files changed, 112 insertions(+), 79 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 8144a87..bdc48c3 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -415,31 +415,57 @@ static void mmci_init_sg(struct mmci_host *host, struct mmc_data *data)
>   * no custom DMA interfaces are supported.
>   */
>  #ifdef CONFIG_DMA_ENGINE
> -static void mmci_dma_setup(struct mmci_host *host)
> +struct dmaengine_next {

I would rather rename this struct to something along the lines of
"mmci_dma_next", that should follow how most of the data structures
are named in mmci.

> +       struct dma_async_tx_descriptor *dma_desc;
> +       struct dma_chan *dma_chan;

For these two, I think you should remove the "dma_" prefix from their
names. At least to me, it's of obvious they are about dma if they are
part of a struct used (and named) used solely for that purpose.

> +       s32 cookie;
> +};
> +
> +struct dmaengine_priv {
> +       struct dma_chan *dma_current;
> +       struct dma_chan *dma_rx_channel;
> +       struct dma_chan *dma_tx_channel;
> +       struct dma_async_tx_descriptor  *dma_desc_current;
> +       struct dmaengine_next next_data;
> +       bool dma_in_progress;

For similar reasons as above, I suggest to rename the struct to
"mmci_dma_priv" and to drop the "dma_" prefix from the variable names.

> +};
> +
> +#define __dmae_inprogress(dmae) ((dmae)->dma_in_progress)

How about naming this to mmci_dma_inprogress() instead?

BTW, in general it looks like you are a bit fond of using "__" as
function name prefix for internally called functions. Please try to
avoid that, but rather try to pick names that explains what the
functions do.

> +
> +static int mmci_dma_setup(struct mmci_host *host)
>  {
>         const char *rxname, *txname;
> +       struct dmaengine_priv *dmae;
>
> -       host->dma_rx_channel = dma_request_slave_channel(mmc_dev(host->mmc), "rx");
> -       host->dma_tx_channel = dma_request_slave_channel(mmc_dev(host->mmc), "tx");
> +       dmae = devm_kzalloc(mmc_dev(host->mmc), sizeof(*dmae), GFP_KERNEL);
> +       if (!dmae)
> +               return -ENOMEM;
> +
> +       host->dma_priv = dmae;
> +
> +       dmae->dma_rx_channel = dma_request_slave_channel(mmc_dev(host->mmc),
> +                                                        "rx");
> +       dmae->dma_tx_channel = dma_request_slave_channel(mmc_dev(host->mmc),
> +                                                        "tx");
>
>         /* initialize pre request cookie */
> -       host->next_data.cookie = 1;
> +       dmae->next_data.cookie = 1;
>
>         /*
>          * If only an RX channel is specified, the driver will
>          * attempt to use it bidirectionally, however if it is
>          * is specified but cannot be located, DMA will be disabled.
>          */
> -       if (host->dma_rx_channel && !host->dma_tx_channel)
> -               host->dma_tx_channel = host->dma_rx_channel;
> +       if (dmae->dma_rx_channel && !dmae->dma_tx_channel)
> +               dmae->dma_tx_channel = dmae->dma_rx_channel;
>
> -       if (host->dma_rx_channel)
> -               rxname = dma_chan_name(host->dma_rx_channel);
> +       if (dmae->dma_rx_channel)
> +               rxname = dma_chan_name(dmae->dma_rx_channel);
>         else
>                 rxname = "none";
>
> -       if (host->dma_tx_channel)
> -               txname = dma_chan_name(host->dma_tx_channel);
> +       if (dmae->dma_tx_channel)
> +               txname = dma_chan_name(dmae->dma_tx_channel);
>         else
>                 txname = "none";
>
> @@ -450,15 +476,15 @@ static void mmci_dma_setup(struct mmci_host *host)
>          * Limit the maximum segment size in any SG entry according to
>          * the parameters of the DMA engine device.
>          */
> -       if (host->dma_tx_channel) {
> -               struct device *dev = host->dma_tx_channel->device->dev;
> +       if (dmae->dma_tx_channel) {
> +               struct device *dev = dmae->dma_tx_channel->device->dev;
>                 unsigned int max_seg_size = dma_get_max_seg_size(dev);
>
>                 if (max_seg_size < host->mmc->max_seg_size)
>                         host->mmc->max_seg_size = max_seg_size;
>         }
> -       if (host->dma_rx_channel) {
> -               struct device *dev = host->dma_rx_channel->device->dev;
> +       if (dmae->dma_rx_channel) {
> +               struct device *dev = dmae->dma_rx_channel->device->dev;
>                 unsigned int max_seg_size = dma_get_max_seg_size(dev);
>
>                 if (max_seg_size < host->mmc->max_seg_size)
> @@ -466,7 +492,9 @@ static void mmci_dma_setup(struct mmci_host *host)
>         }
>
>         if (host->ops && host->ops->dma_setup)
> -               host->ops->dma_setup(host);
> +               return host->ops->dma_setup(host);

I agree that converting the ->dma_setup() callback to return an int makes sense.

However, please make that a separate change and while doing that,
don't forget to implement the error path, as that is missing here.

> +
> +       return 0;
>  }

[...]

Kind regards
Uffe
