From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V4 02/25] mmc: mmci: create generic mmci_dma_setup
Date: Wed, 3 Oct 2018 11:22:00 +0200
Message-ID: <CAPDyKFpZKdZ5Oh29_EpgDqpwppa63Uci-FeLHF2KZBxVcO4COQ@mail.gmail.com>
References: <1538482167-13819-1-git-send-email-ludovic.Barre@st.com> <1538482167-13819-3-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1538482167-13819-3-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Barre <ludovic.Barre@st.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Rob Herring <robh+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Gerald Baeza <gerald.baeza@st.com>, Loic Pallardy <loic.pallardy@st.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-mmc@vger.kernel.org

+ Srinivas

[...]

>  #ifdef CONFIG_DMA_ENGINE
> -static void mmci_dma_setup(struct mmci_host *host)
> +static inline void mmci_dma_release(struct mmci_host *host);
> +
> +int mmci_dmae_setup(struct mmci_host *host)
>  {
>         const char *rxname, *txname;
>
> @@ -464,8 +485,12 @@ static void mmci_dma_setup(struct mmci_host *host)
>                         host->mmc->max_seg_size = max_seg_size;
>         }
>
> -       if (host->ops && host->ops->dma_setup)
> -               host->ops->dma_setup(host);
> +       if (!host->dma_tx_channel || !host->dma_rx_channel) {
> +               mmci_dma_release(host);

This doesn't look right to me. The existing code allows a tx channel
to be used, even if an rx channel could not be setup. It seems
reasonable to still allow that.

> +               return -EINVAL;
> +       }
> +
> +       return 0;
>  }
>
>  /*
> @@ -496,7 +521,7 @@ static void mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
>
>  static void mmci_dma_data_error(struct mmci_host *host)
>  {
> -       if (!dma_inprogress(host))
> +       if (!host->use_dma || !dma_inprogress(host))

Adding the check for use_dma here seems like an unnecessary check,
unless there is a reason for it due to following changes on top. In
such case, please make it a part of the patch(es) where it's actually
needed.

>                 return;
>
>         dev_err(mmc_dev(host->mmc), "error during DMA transfer!\n");
> @@ -514,7 +539,7 @@ static void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
>         u32 status;
>         int i;
>
> -       if (!dma_inprogress(host))
> +       if (!host->use_dma || !dma_inprogress(host))

Ditto.

>                 return;
>
>         /* Wait up to 1ms for the DMA to complete */
> @@ -546,6 +571,7 @@ static void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
>         if (status & MCI_RXDATAAVLBLMASK) {
>                 dev_err(mmc_dev(host->mmc), "buggy DMA detected. Taking evasive action.\n");
>                 mmci_dma_release(host);
> +               host->use_dma = false;
>         }
>
>         host->dma_in_progress = false;
> @@ -640,6 +666,9 @@ static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
>         int ret;
>         struct mmc_data *data = host->data;
>
> +       if (!host->use_dma)
> +               return -EINVAL;
> +
>         ret = mmci_dma_prep_data(host, host->data);
>         if (ret)
>                 return ret;
> @@ -674,6 +703,9 @@ static void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
>  {
>         struct mmci_host_next *next = &host->next_data;
>
> +       if (!host->use_dma)
> +               return;
> +
>         WARN_ON(data->host_cookie && data->host_cookie != next->cookie);
>         WARN_ON(!data->host_cookie && (next->dma_desc || next->dma_chan));
>
> @@ -689,7 +721,7 @@ static void mmci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq)
>         struct mmc_data *data = mrq->data;
>         struct mmci_host_next *nd = &host->next_data;
>
> -       if (!data)
> +       if (!host->use_dma || !data)
>                 return;
>
>         BUG_ON(data->host_cookie);
> @@ -707,7 +739,7 @@ static void mmci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
>         struct mmci_host *host = mmc_priv(mmc);
>         struct mmc_data *data = mrq->data;
>
> -       if (!data || !data->host_cookie)
> +       if (!host->use_dma || !data || !data->host_cookie)

Ditto.

>                 return;
>
>         mmci_dma_unmap(host, data);
> @@ -735,14 +767,14 @@ static void mmci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
>         }
>  }
>
> +static struct mmci_host_ops mmci_variant_ops = {
> +       .dma_setup = mmci_dmae_setup,
> +};
>  #else
>  /* Blank functions if the DMA engine is not available */
>  static void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
>  {
>  }
> -static inline void mmci_dma_setup(struct mmci_host *host)
> -{
> -}
>
>  static inline void mmci_dma_release(struct mmci_host *host)
>  {
> @@ -765,8 +797,14 @@ static inline int mmci_dma_start_data(struct mmci_host *host, unsigned int datac
>  #define mmci_pre_request NULL
>  #define mmci_post_request NULL
>
> +static struct mmci_host_ops mmci_variant_ops = {};

This seems a bit unnecessary. See more about why, below.

>  #endif
>
> +void mmci_variant_init(struct mmci_host *host)

Looks like you should make mmci_variant_init() internal to mmci.c,
thus covert it to static.

Moreover, I suggest you define a "static inline void
mmci_variant_init()", when CONFIG_DMA_ENGINE is unset. In that way you
don't need to assign host->ops at all for this case.

> +{
> +       host->ops = &mmci_variant_ops;
> +}
> +
>  static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
>  {
>         struct variant_data *variant = host->variant;
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index 01e6c6b..f7fe80f 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -273,7 +273,7 @@ struct variant_data {
>
>  /* mmci variant callbacks */
>  struct mmci_host_ops {
> -       void (*dma_setup)(struct mmci_host *host);
> +       int (*dma_setup)(struct mmci_host *host);
>  };
>
>  struct mmci_host_next {
> @@ -323,6 +323,7 @@ struct mmci_host {
>         unsigned int            size;
>         int (*get_rx_fifocnt)(struct mmci_host *h, u32 status, int remain);
>
> +       u8                      use_dma:1;
>  #ifdef CONFIG_DMA_ENGINE
>         /* DMA stuff */
>         struct dma_chan         *dma_current;
> @@ -336,3 +337,7 @@ struct mmci_host {
>  #endif
>  };
>
> +void mmci_variant_init(struct mmci_host *host);
> +
> +int mmci_dmae_setup(struct mmci_host *host);
> +
> diff --git a/drivers/mmc/host/mmci_qcom_dml.c b/drivers/mmc/host/mmci_qcom_dml.c
> index be3fab5..c8d7592 100644
> --- a/drivers/mmc/host/mmci_qcom_dml.c
> +++ b/drivers/mmc/host/mmci_qcom_dml.c
> @@ -119,19 +119,22 @@ static int of_get_dml_pipe_index(struct device_node *np, const char *name)
>  }
>
>  /* Initialize the dml hardware connected to SD Card controller */
> -static void qcom_dma_setup(struct mmci_host *host)
> +static int qcom_dma_setup(struct mmci_host *host)
>  {
>         u32 config;
>         void __iomem *base;
>         int consumer_id, producer_id;
>         struct device_node *np = host->mmc->parent->of_node;
>
> +       if (mmci_dmae_setup(host))
> +               return -EINVAL;
> +
>         consumer_id = of_get_dml_pipe_index(np, "tx");
>         producer_id = of_get_dml_pipe_index(np, "rx");
>
>         if (producer_id < 0 || consumer_id < 0) {
>                 host->variant->qcom_dml = false;
> -               return;
> +               return -EINVAL;

Seems like you need to call a corresponding dma release function here,
before returning the error code.

Probably an "mmci_dmae_release()" needs to be implemented as a part of
this change - and then also called from here. This is according to
Srinivas recommendations, which means falling back to pio. As a matter
of fact this also needs to be clearly stated in the changelog, as you
are really also improving the behavior for the Qcom variant.

Unfortunate, I am not able to test this as I don't have the HW (which
I thought I had). Perhaps Srinivas can help, once we have something
ready for him to test.

>         }
>
>         base = host->base + DML_OFFSET;
> @@ -175,6 +178,8 @@ static void qcom_dma_setup(struct mmci_host *host)
>
>         /* Make sure dml initialization is finished */
>         mb();
> +
> +       return 0;
>  }
>
>  static struct mmci_host_ops qcom_variant_ops = {
> --
> 2.7.4
>

Kind regards
Uffe
