From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 01/19] mmc: mmci: regroup and define dma operations
Date: Thu, 5 Jul 2018 17:17:46 +0200
Message-ID: <CAPDyKFpt5HUeUqaoS9icDodM+r64jB9vQ=zTecO0tuBv=TtOXg@mail.gmail.com>
References: <1528809280-31116-1-git-send-email-ludovic.Barre@st.com> <1528809280-31116-2-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528809280-31116-2-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Barre <ludovic.Barre@st.com>
Cc: Rob Herring <robh+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Gerald Baeza <gerald.baeza@st.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 12 June 2018 at 15:14, Ludovic Barre <ludovic.Barre@st.com> wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
>
> Prepare mmci driver to manage dma interface by new property.
> This patch defines and regroups dma operations for mmci drivers.
> mmci_dma_XX prototypes are added to call member of mmci_dma_ops
> if not null. Based on legacy need, a mmci dma interface has been
> defined with:
> -mmci_dma_setup
> -mmci_dma_release
> -mmci_dma_pre_req
> -mmci_dma_start
> -mmci_dma_finalize
> -mmci_dma_post_req
> -mmci_dma_error
> -mmci_dma_get_next_data

As I suggested for one of the other patches, I would rather turn core
mmci functions into library functions, which can be either invoked
from variant callbacks or assigned directly to them.

In other words, I would leave the functions that you move in this
patch to stay in mmci.c. Although some needs to be re-factored and we
also needs to make some of them available to be called from another
file, hence the functions needs to be shared via mmci.h rather than
being declared static.

Let me take a concrete example on how I would move forward, hopefully
that explains it a bit better. Please see below.

[...]

> -/*
> - * All the DMA operation mode stuff goes inside this ifdef.
> - * This assumes that you have a generic DMA device interface,
> - * no custom DMA interfaces are supported.
> - */
> -#ifdef CONFIG_DMA_ENGINE
> -static void mmci_dma_setup(struct mmci_host *host)
> -{
> -       const char *rxname, *txname;
> -       struct variant_data *variant = host->variant;
> -
> -       host->dma_rx_channel = dma_request_slave_channel(mmc_dev(host->mmc), "rx");
> -       host->dma_tx_channel = dma_request_slave_channel(mmc_dev(host->mmc), "tx");
> -
> -       /* initialize pre request cookie */
> -       host->next_data.cookie = 1;
> -
> -       /*
> -        * If only an RX channel is specified, the driver will
> -        * attempt to use it bidirectionally, however if it is
> -        * is specified but cannot be located, DMA will be disabled.
> -        */
> -       if (host->dma_rx_channel && !host->dma_tx_channel)
> -               host->dma_tx_channel = host->dma_rx_channel;
> -
> -       if (host->dma_rx_channel)
> -               rxname = dma_chan_name(host->dma_rx_channel);
> -       else
> -               rxname = "none";
> -
> -       if (host->dma_tx_channel)
> -               txname = dma_chan_name(host->dma_tx_channel);
> -       else
> -               txname = "none";
> -
> -       dev_info(mmc_dev(host->mmc), "DMA channels RX %s, TX %s\n",
> -                rxname, txname);
> -
> -       /*
> -        * Limit the maximum segment size in any SG entry according to
> -        * the parameters of the DMA engine device.
> -        */
> -       if (host->dma_tx_channel) {
> -               struct device *dev = host->dma_tx_channel->device->dev;
> -               unsigned int max_seg_size = dma_get_max_seg_size(dev);
> -
> -               if (max_seg_size < host->mmc->max_seg_size)
> -                       host->mmc->max_seg_size = max_seg_size;
> -       }
> -       if (host->dma_rx_channel) {
> -               struct device *dev = host->dma_rx_channel->device->dev;
> -               unsigned int max_seg_size = dma_get_max_seg_size(dev);
> -
> -               if (max_seg_size < host->mmc->max_seg_size)
> -                       host->mmc->max_seg_size = max_seg_size;
> -       }

Everything above shall be left as generic library function,
mmci_dma_setup() and I would share it via mmci.h and thus change it
from being static.

> -
> -       if (variant->qcom_dml && host->dma_rx_channel && host->dma_tx_channel)
> -               if (dml_hw_init(host, host->mmc->parent->of_node))
> -                       variant->qcom_dml = false;

This piece of code, should be made specific to the qcom variant and
managed though a "mmci_host_ops" callback. The corresponding code in
that callback would then start by invoking mmci_dma_setup(), before it
continues with the qcom specific operations.

For legacy variants, the corresponding callback would be set directly
to mmci_dma_setup() and called through the callback from mmci.c when
needed. There is no need to have a separate file for DMA for the
legacy variants, I think.

[...]

Kind regards
Uffe
