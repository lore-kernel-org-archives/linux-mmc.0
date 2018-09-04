From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 07/14] mmc: mmci: add prepare/unprepare_data callbacks
Date: Tue, 4 Sep 2018 11:43:06 +0200
Message-ID: <CAPDyKFrKNMBzqy-Fbf-_2BznBS5R3g_O3hPsfjqWef5FB7ZTmQ@mail.gmail.com>
References: <1533116221-380-1-git-send-email-ludovic.Barre@st.com> <1533116221-380-8-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533116221-380-8-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Barre <ludovic.Barre@st.com>
Cc: Rob Herring <robh+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Gerald Baeza <gerald.baeza@st.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

[...]

>
>  static struct variant_data variant_qcom = {
> @@ -357,6 +365,31 @@ static void mmci_set_clkreg(struct mmci_host *host, unsigned int desired)
>         mmci_write_clkreg(host, clk);
>  }
>
> +int mmci_prepare_data(struct mmci_host *host, struct mmc_data *data, bool next)

I think we need to agree on naming rules for functions, as I think
this becomes a bit hard to follow when you decide to rename and pick
new names.

First, let's strive towards keeping existing names and in cases when a
subset of a function is re-used and called from the original function,
then name it with the same name, but add "__" or "_" as prefixes.

So for this one it should be:

mmci_dma_prep_data()
_mmci_dma_prep_data()
__mmci_dma_prep_data().

That should also decrease the number lines of code you need to change
and thus also make the review easier. Can you please try this?

> +{
> +       int err;
> +
> +       if (!host->ops || !host->ops->prepare_data)
> +               return 0;

Is the host->ops optional and so also the ->prepare_data() callback in it?

> +
> +       err = host->ops->prepare_data(host, data, next);

The job of the callback is to map the dma data. Perhaps a better name
would be ->dma_map_data()?

> +
> +       if (next && !err)
> +               data->host_cookie = ++host->next_cookie < 0 ?
> +                       1 : host->next_cookie;
> +
> +       return err;
> +}
> +
> +void mmci_unprepare_data(struct mmci_host *host, struct mmc_data *data,
> +                        int err)
> +{
> +       if (host->ops && host->ops->unprepare_data)
> +               host->ops->unprepare_data(host, data, err);

As stated, please follow existing naming convention. Perhaps
->dma_unmap_data() is a better name?

> +
> +       data->host_cookie = 0;
> +}
> +
>  static void
>  mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
>  {
> @@ -588,9 +621,9 @@ static void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
>  }
>
>  /* prepares DMA channel and DMA descriptor, returns non-zero on failure */
> -static int __mmci_dma_prep_data(struct mmci_host *host, struct mmc_data *data,
> -                               struct dma_chan **dma_chan,
> -                               struct dma_async_tx_descriptor **dma_desc)
> +static int __mmci_dmae_prep_data(struct mmci_host *host, struct mmc_data *data,
> +                                struct dma_chan **dma_chan,
> +                                struct dma_async_tx_descriptor **dma_desc)
>  {
>         struct dmaengine_priv *dmae = host->dma_priv;
>         struct variant_data *variant = host->variant;
> @@ -651,22 +684,21 @@ static int __mmci_dma_prep_data(struct mmci_host *host, struct mmc_data *data,
>         return -ENOMEM;
>  }
>
> -static inline int mmci_dma_prepare_data(struct mmci_host *host,
> -                                       struct mmc_data *data,
> -                                       bool next)
> +int mmci_dmae_prepare_data(struct mmci_host *host,
> +                          struct mmc_data *data, bool next)

Here's is yet another rename of a function. As stated, try to stick to
the existing names and use the scheme I described above.

>  {
>         struct dmaengine_priv *dmae = host->dma_priv;
>         struct dmaengine_next *nd = &dmae->next_data;
>
>         if (next)
> -               return __mmci_dma_prep_data(host, data, &nd->dma_chan,
> +               return __mmci_dmae_prep_data(host, data, &nd->dma_chan,
>                                             &nd->dma_desc);
>         /* Check if next job is already prepared. */
>         if (dmae->dma_current && dmae->dma_desc_current)
>                 return 0;
>
>         /* No job were prepared thus do it now. */
> -       return __mmci_dma_prep_data(host, data, &dmae->dma_current,
> +       return __mmci_dmae_prep_data(host, data, &dmae->dma_current,
>                                     &dmae->dma_desc_current);
>  }
>
> @@ -676,7 +708,7 @@ static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
>         struct mmc_data *data = host->data;
>         int ret;
>
> -       ret = mmci_dma_prepare_data(host, host->data, false);
> +       ret = mmci_prepare_data(host, host->data, false);
>         if (ret)
>                 return ret;
>
> @@ -720,33 +752,11 @@ static void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
>         next->dma_chan = NULL;
>  }
>
> -static void mmci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq)
> -{
> -       struct mmci_host *host = mmc_priv(mmc);
> -       struct mmc_data *data = mrq->data;
> -
> -       if (!data)
> -               return;
> -
> -       BUG_ON(data->host_cookie);
> -
> -       if (mmci_validate_data(host, data))
> -               return;
> +void mmci_dmae_unprepare_data(struct mmci_host *host,
> +                             struct mmc_data *data, int err)
>
> -       if (!mmci_dma_prepare_data(host, data, true))
> -               data->host_cookie = ++host->next_cookie < 0 ?
> -                       1 : host->next_cookie;
> -}
> -
> -static void mmci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
> -                             int err)
>  {
> -       struct mmci_host *host = mmc_priv(mmc);
>         struct dmaengine_priv *dmae = host->dma_priv;
> -       struct mmc_data *data = mrq->data;
> -
> -       if (!data || !data->host_cookie)
> -               return;
>
>         __mmci_dmae_unmap(host, data);
>
> @@ -769,10 +779,13 @@ static void mmci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
>
>                 next->dma_desc = NULL;
>                 next->dma_chan = NULL;
> -               data->host_cookie = 0;
>         }
>  }
>
> +static struct mmci_host_ops mmci_variant_ops = {
> +       .prepare_data = mmci_dmae_prepare_data,
> +       .unprepare_data = mmci_dmae_unprepare_data,
> +};
>  #else
>  /* Blank functions if the DMA engine is not available */
>  static void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
> @@ -802,11 +815,42 @@ static inline int mmci_dma_start_data(struct mmci_host *host, unsigned int datac
>         return -ENOSYS;
>  }
>
> -#define mmci_pre_request NULL
> -#define mmci_post_request NULL
> -
> +static struct mmci_host_ops mmci_variant_ops = {};
>  #endif

Ahh, now I see why you need the mmci_host_ops to be optional, earlier above.

However, I have been thinking on what granularity we should pick for
the mmci host ops callbacks. Honestly I am not sure, but let me
through out an idea and see what you think about it.

So, having callbacks for dealing with dma_map|unmap() kind of
operations, becomes rather fine-grained and not very flexible.
Instead, what do you think of allowing the variant init function to
dynamically assign the ->pre_req() and the ->post_req() callbacks in
the struct mmc_host_ops. Common mmci functions to manage these
operations can instead be shared via mmci.h and called by the
variants.

The point is, following that scheme may improve flexibility, but
possibly also decrease the number of needed mmci specific host ops
callbacks, don't you think?

>
> +void mmci_variant_init(struct mmci_host *host)
> +{
> +       host->ops = &mmci_variant_ops;
> +}
> +
> +static void mmci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq)
> +{
> +       struct mmci_host *host = mmc_priv(mmc);
> +       struct mmc_data *data = mrq->data;
> +
> +       if (!data)
> +               return;
> +
> +       WARN_ON(data->host_cookie);
> +
> +       if (mmci_validate_data(host, data))
> +               return;
> +
> +       mmci_prepare_data(host, data, true);
> +}
> +
> +static void mmci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
> +                             int err)
> +{
> +       struct mmci_host *host = mmc_priv(mmc);
> +       struct mmc_data *data = mrq->data;
> +
> +       if (!data || !data->host_cookie)
> +               return;
> +
> +       mmci_unprepare_data(host, data, err);
> +}
> +
>  static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
>  {
>         struct variant_data *variant = host->variant;
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index d2ec4fd..fa2702b 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -273,6 +273,10 @@ struct variant_data {
>
>  /* mmci variant callbacks */
>  struct mmci_host_ops {
> +       int (*prepare_data)(struct mmci_host *host, struct mmc_data *data,
> +                           bool next);
> +       void (*unprepare_data)(struct mmci_host *host, struct mmc_data *data,
> +                              int err);
>         int (*dma_setup)(struct mmci_host *host);
>  };
>
> @@ -323,3 +327,9 @@ struct mmci_host {
>  };
>
>  void qcom_variant_init(struct mmci_host *host);
> +void mmci_variant_init(struct mmci_host *host);
> +
> +int mmci_dmae_prepare_data(struct mmci_host *host, struct mmc_data *data,
> +                          bool next);
> +void mmci_dmae_unprepare_data(struct mmci_host *host,
> +                             struct mmc_data *data, int err);
> diff --git a/drivers/mmc/host/mmci_qcom_dml.c b/drivers/mmc/host/mmci_qcom_dml.c
> index 1bb59cf..d534fa1 100644
> --- a/drivers/mmc/host/mmci_qcom_dml.c
> +++ b/drivers/mmc/host/mmci_qcom_dml.c
> @@ -180,6 +180,8 @@ static int qcom_dma_setup(struct mmci_host *host)
>  }
>
>  static struct mmci_host_ops qcom_variant_ops = {
> +       .prepare_data = mmci_dmae_prepare_data,
> +       .unprepare_data = mmci_dmae_unprepare_data,
>         .dma_setup = qcom_dma_setup,
>  };
>
> --
> 2.7.4
>

Kind regards
Uffe
