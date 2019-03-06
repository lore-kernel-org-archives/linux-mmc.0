From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 4/5] mmc: mmci: stm32: define get_dctrl_cfg
Date: Wed, 6 Mar 2019 14:31:52 +0100
Message-ID: <CAPDyKFr3PLOdozCmfE7Lin0FhzgLnN120RZmMwk=K8RzGvveow@mail.gmail.com>
References: <1551694625-6414-1-git-send-email-ludovic.Barre@st.com> <1551694625-6414-5-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551694625-6414-5-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Barre <ludovic.Barre@st.com>
Cc: Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-mmc@vger.kernel.org

On Mon, 4 Mar 2019 at 11:17, Ludovic Barre <ludovic.Barre@st.com> wrote:
>
> From: Ludovic Barre <ludovic.barre@st.com>
>
> This patch defines get_dctrl_cfg callback for sdmmc variant.
> sdmmc variant has specific stm32 transfer modes.
> sdmmc data transfer mode selection could be:
> -Block data transfer ending on block count.
> -SDIO multibyte data transfer.
> -MMC Stream data transfer (not used).
> -Block data transfer ending with STOP_TRANSMISSION command.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  drivers/mmc/host/mmci.h             |  5 +++++
>  drivers/mmc/host/mmci_stm32_sdmmc.c | 21 +++++++++++++++++++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index 6f28f71..eb5d99af 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -131,6 +131,11 @@
>  /* Control register extensions in the Qualcomm versions */
>  #define MCI_DPSM_QCOM_DATA_PEND        BIT(17)
>  #define MCI_DPSM_QCOM_RX_DATA_PEND BIT(20)
> +/* Control register extensions in STM32 versions */
> +#define MCI_DPSM_STM32_MODE_BLOCK      (0 << 2)
> +#define MCI_DPSM_STM32_MODE_SDIO       (1 << 2)
> +#define MCI_DPSM_STM32_MODE_STREAM     (2 << 2)
> +#define MCI_DPSM_STM32_MODE_BLOCK_STOP (3 << 2)
>
>  #define MMCIDATACNT            0x030
>  #define MMCISTATUS             0x034
> diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
> index cfbfc6f..e7bf744 100644
> --- a/drivers/mmc/host/mmci_stm32_sdmmc.c
> +++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
> @@ -265,10 +265,31 @@ static void mmci_sdmmc_set_pwrreg(struct mmci_host *host, unsigned int pwr)
>         }
>  }
>
> +u32 sdmmc_get_dctrl_cfg(struct mmci_host *host)
> +{
> +       struct variant_data *variant = host->variant;
> +       int blksz_bits;
> +       u32 datactrl;
> +
> +       blksz_bits = ffs(host->data->blksz) - 1;
> +       datactrl = variant->datactrl_dpsm_enable | blksz_bits << 4;
> +
> +       if (host->mmc->card && mmc_card_sdio(host->mmc->card) &&
> +           host->data->blocks == 1)

These settings are not limited to deal with the block size bits.

Don't get me wrong, it seems reasonable to include them, but the
generic code in mmci_start_data() also have code to cope with SDIO. I
think we should start by splitting that up into a couple of
helper/library functions, and make the legacy variant to use them.
This should probably be done as a preparation to your series, so you
can build on top of that.

Does it make sense? If not, please tell and I can try to provide some
patch to show you what I mean.


> +               datactrl |= MCI_DPSM_STM32_MODE_SDIO;
> +       else if (host->data->stop && !host->mrq->sbc)
> +               datactrl |= MCI_DPSM_STM32_MODE_BLOCK_STOP;
> +       else
> +               datactrl |= MCI_DPSM_STM32_MODE_BLOCK;
> +
> +       return datactrl;
> +}
> +
>  static struct mmci_host_ops sdmmc_variant_ops = {
>         .validate_data = sdmmc_idma_validate_data,
>         .prep_data = sdmmc_idma_prep_data,
>         .unprep_data = sdmmc_idma_unprep_data,
> +       .get_datactrl_cfg = sdmmc_get_dctrl_cfg,
>         .dma_setup = sdmmc_idma_setup,
>         .dma_start = sdmmc_idma_start,
>         .dma_finalize = sdmmc_idma_finalize,
> --
> 2.7.4
>

Kind regards
Uffe
