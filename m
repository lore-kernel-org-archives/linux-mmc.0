From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH] mmc: mmci: Add qcom dml support to the driver.
Date: Fri, 11 Jul 2014 15:49:34 +0200
Message-ID: <CACRpkdZdU3PBt+tCqhtWutjwaqdM9yWQi-3bzELV1Xnd9w_EEw@mail.gmail.com>
References: <1405079306-1406-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1405079306-1406-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Russell King <linux@arm.linux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Jul 11, 2014 at 1:48 PM, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:

> On Qualcomm APQ8064 SOCs, SD card controller has an additional glue
> called DML (Data Mover Local/Lite) to assist dma transfers.
> This hardware needs to be setup before any dma transfer is requested.
> DML itself is not a DMA engine, its just a gule between the SD card
> controller and dma controller.
>
> Most of this code has been ported from qualcomm's 3.4 kernel.
>
> This patch adds the code necessary to intialize the hardware and setup
> before doing any dma transfers.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Pretty cool :-)

>  drivers/mmc/host/mmci.c     |  19 ++++-
>  drivers/mmc/host/qcom_dml.c | 171 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/qcom_dml.h |  17 +++++

Please call this file mmci-qcom-dml.c/h so we know that these files
have a strong
dependence.

> +config MMC_QCOM_DML
> +       tristate "Qualcomm Data Mover for SD Card Controller"
> +       depends on MMC_ARMMMCI && ARCH_QCOM

The way I get it is that this only makes sense when the qualcomm
DMA engine is used so should it not be

depends on MMC_ARMMMCI && QCOM_BAM_DMA

?

Or maybe we should be less specific?

depends on MMC_ARMMMCI && DMA_ENGINE

?

>  /*
> @@ -569,6 +579,7 @@ static int __mmci_dma_prep_data(struct mmci_host *host, struct mmc_data *data,
>         struct dma_async_tx_descriptor *desc;
>         enum dma_data_direction buffer_dirn;
>         int nr_sg;
> +       u32 flags = DMA_CTRL_ACK;
>
>         if (data->flags & MMC_DATA_READ) {
>                 conf.direction = DMA_DEV_TO_MEM;
> @@ -593,9 +604,12 @@ static int __mmci_dma_prep_data(struct mmci_host *host, struct mmc_data *data,
>         if (nr_sg == 0)
>                 return -EINVAL;
>
> +       if (host->variant->qcom_dml)
> +               flags |= DMA_PREP_INTERRUPT;

Is this correct? That augments every incoming DMA request to try to
do an interrupt callback. Why is that necessary? The interrupt
callback still isn't registered, so this isn't used for anything?

If it's still needed it would be a bug in the DMA engine I think.

Yours,
Linus Walleij
