From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 3/6] mmc: mmci: define get_dctrl_cfg for legacy variant
Date: Thu, 21 Mar 2019 17:55:48 +0100
Message-ID: <CAPDyKFrkdQf1yq2YKaNMr8vgpd5fH4BAXgO7Qkj-aaw0AB9wRw@mail.gmail.com>
References: <1551976742-4358-1-git-send-email-ludovic.Barre@st.com> <1551976742-4358-4-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551976742-4358-4-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Barre <ludovic.Barre@st.com>
Cc: Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-mmc@vger.kernel.org

On Thu, 7 Mar 2019 at 17:39, Ludovic Barre <ludovic.Barre@st.com> wrote:
>
> From: Ludovic Barre <ludovic.barre@st.com>
>
> This patch defines get_dctrl_cfg callback for legacy variants
> whatever DMA_ENGINE configuration.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  drivers/mmc/host/mmci.c | 44 ++++++++++++++++++++++++++++++++++++--------
>  drivers/mmc/host/mmci.h |  3 +++
>  2 files changed, 39 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 28b76c5..52f9dbf 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -46,12 +46,6 @@
>
>  #define DRIVER_NAME "mmci-pl18x"
>
> -#ifdef CONFIG_DMA_ENGINE
> -static void mmci_variant_init(struct mmci_host *host);
> -#else
> -static inline void mmci_variant_init(struct mmci_host *host) {}
> -#endif
> -
>  static unsigned int fmax = 515633;
>
>  static struct variant_data variant_arm = {
> @@ -231,7 +225,7 @@ static struct variant_data variant_ux500v2 = {
>         .irq_pio_mask           = MCI_IRQ_PIO_MASK,
>         .start_err              = MCI_STARTBITERR,
>         .opendrain              = MCI_OD,
> -       .init                   = mmci_variant_init,
> +       .init                   = mmci_ux500v2_variant_init,
>  };
>
>  static struct variant_data variant_stm32 = {
> @@ -617,6 +611,29 @@ static void mmci_init_sg(struct mmci_host *host, struct mmc_data *data)
>         sg_miter_start(&host->sg_miter, data->sg, data->sg_len, flags);
>  }
>
> +u32 mmci_get_dctrl_cfg(struct mmci_host *host)
> +{
> +       u32 datactrl;
> +
> +       datactrl = MCI_DPSM_ENABLE;
> +       datactrl |= mmci_dctrl_blksz(host) | mmci_dctrl_dir(host);
> +       datactrl |= mmci_dctrl_sdio(host) | mmci_dctrl_ddr(host);
> +
> +       return datactrl;
> +}
> +
> +u32 mmci_ux500v2_get_dctrl_cfg(struct mmci_host *host)

To be consistent with other variant function names, let's drop the
"mmci_"* prefix.

> +{
> +       u32 datactrl;
> +
> +       datactrl = MCI_DPSM_ENABLE;
> +       datactrl |= (host->data->blksz << 16);
> +       datactrl |= mmci_dctrl_dir(host);
> +       datactrl |= mmci_dctrl_sdio(host) | mmci_dctrl_ddr(host);
> +
> +       return datactrl;
> +}
> +
>  /*
>   * All the DMA operation mode stuff goes inside this ifdef.
>   * This assumes that you have a generic DMA device interface,
> @@ -941,6 +958,7 @@ void mmci_dmae_unprep_data(struct mmci_host *host,
>  static struct mmci_host_ops mmci_variant_ops = {
>         .prep_data = mmci_dmae_prep_data,
>         .unprep_data = mmci_dmae_unprep_data,
> +       .get_datactrl_cfg = mmci_get_dctrl_cfg,
>         .get_next_data = mmci_dmae_get_next_data,
>         .dma_setup = mmci_dmae_setup,
>         .dma_release = mmci_dmae_release,
> @@ -948,12 +966,22 @@ static struct mmci_host_ops mmci_variant_ops = {
>         .dma_finalize = mmci_dmae_finalize,
>         .dma_error = mmci_dmae_error,
>  };
> +#else
> +static struct mmci_host_ops mmci_variant_ops = {
> +       .get_datactrl_cfg = mmci_get_dctrl_cfg,
> +}
> +#endif
>
>  void mmci_variant_init(struct mmci_host *host)
>  {
>         host->ops = &mmci_variant_ops;
>  }
> -#endif
> +
> +void mmci_ux500v2_variant_init(struct mmci_host *host)
> +{
> +       host->ops = &mmci_variant_ops;
> +       host->ops->get_datactrl_cfg = mmci_ux500v2_get_dctrl_cfg;
> +}
>
>  static void mmci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  {
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index 32ae41d..bfc6e54 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -448,6 +448,9 @@ void mmci_dmae_finalize(struct mmci_host *host, struct mmc_data *data);
>  void mmci_dmae_error(struct mmci_host *host);
>  #endif
>
> +void mmci_variant_init(struct mmci_host *host);
> +void mmci_ux500v2_variant_init(struct mmci_host *host);

Drop the "mmci_" prefix.

> +
>  #ifdef CONFIG_MMC_QCOM_DML
>  void qcom_variant_init(struct mmci_host *host);
>  #else
> --
> 2.7.4
>

Kind regards
Uffe
