From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/4] mmc: pwrseq: add op reset to struct mmc_pwrseq_ops
Date: Wed, 15 Mar 2017 11:50:42 +0100
Message-ID: <CAPDyKFr6_Y3cSv5Q1WRSQBo7_bsyeVVQTYBQ01gykdMpVWNtXw@mail.gmail.com>
References: <75ad5eac-412b-fe73-ff53-3d8b975937e4@gmail.com> <c75c3e5c-c4e1-3f2f-267b-1c781052c55e@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ua0-f175.google.com ([209.85.217.175]:34782 "EHLO
        mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753422AbdCOKuo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Mar 2017 06:50:44 -0400
Received: by mail-ua0-f175.google.com with SMTP id f54so6847466uaa.1
        for <linux-mmc@vger.kernel.org>; Wed, 15 Mar 2017 03:50:43 -0700 (PDT)
In-Reply-To: <c75c3e5c-c4e1-3f2f-267b-1c781052c55e@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Kevin Hilman <khilman@baylibre.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

On 8 February 2017 at 22:48, Heiner Kallweit <hkallweit1@gmail.com> wrote:
> Add an operation reset to struct mmc_pwrseq_ops and related wrappers.
>
> Don't expose the pwrseq-internal reset function directly to kernel
> users but just to the mmc core.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/mmc/core/core.c   | 6 ++++++
>  drivers/mmc/core/pwrseq.c | 8 ++++++++
>  drivers/mmc/core/pwrseq.h | 3 +++
>  include/linux/mmc/core.h  | 1 +
>  4 files changed, 18 insertions(+)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 926e0fde..5d5fe591 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1869,6 +1869,12 @@ void mmc_power_cycle(struct mmc_host *host, u32 ocr)
>         mmc_power_up(host, ocr);
>  }
>
> +void mmc_hw_reset_pwrseq(struct mmc_host *host)
> +{
> +       mmc_pwrseq_reset(host);
> +}
> +EXPORT_SYMBOL(mmc_hw_reset_pwrseq);
> +
>  /*
>   * Cleanup when the last reference to the bus operator is dropped.
>   */
> diff --git a/drivers/mmc/core/pwrseq.c b/drivers/mmc/core/pwrseq.c
> index 9386c477..e3ad30fa 100644
> --- a/drivers/mmc/core/pwrseq.c
> +++ b/drivers/mmc/core/pwrseq.c
> @@ -76,6 +76,14 @@ void mmc_pwrseq_power_off(struct mmc_host *host)
>                 pwrseq->ops->power_off(host);
>  }
>
> +void mmc_pwrseq_reset(struct mmc_host *host)
> +{
> +       struct mmc_pwrseq *pwrseq = host->pwrseq;
> +
> +       if (pwrseq && pwrseq->ops->reset)
> +               pwrseq->ops->reset(host);
> +}
> +
>  void mmc_pwrseq_free(struct mmc_host *host)
>  {
>         struct mmc_pwrseq *pwrseq = host->pwrseq;
> diff --git a/drivers/mmc/core/pwrseq.h b/drivers/mmc/core/pwrseq.h
> index 39c911aa..819386f4 100644
> --- a/drivers/mmc/core/pwrseq.h
> +++ b/drivers/mmc/core/pwrseq.h
> @@ -18,6 +18,7 @@ struct mmc_pwrseq_ops {
>         void (*pre_power_on)(struct mmc_host *host);
>         void (*post_power_on)(struct mmc_host *host);
>         void (*power_off)(struct mmc_host *host);
> +       void (*reset)(struct mmc_host *host);
>  };
>
>  struct mmc_pwrseq {
> @@ -36,6 +37,7 @@ int mmc_pwrseq_alloc(struct mmc_host *host);
>  void mmc_pwrseq_pre_power_on(struct mmc_host *host);
>  void mmc_pwrseq_post_power_on(struct mmc_host *host);
>  void mmc_pwrseq_power_off(struct mmc_host *host);
> +void mmc_pwrseq_reset(struct mmc_host *host);
>  void mmc_pwrseq_free(struct mmc_host *host);
>
>  #else
> @@ -49,6 +51,7 @@ static inline int mmc_pwrseq_alloc(struct mmc_host *host) { return 0; }
>  static inline void mmc_pwrseq_pre_power_on(struct mmc_host *host) {}
>  static inline void mmc_pwrseq_post_power_on(struct mmc_host *host) {}
>  static inline void mmc_pwrseq_power_off(struct mmc_host *host) {}
> +static inline void mmc_pwrseq_reset(struct mmc_host *host) {}
>  static inline void mmc_pwrseq_free(struct mmc_host *host) {}
>
>  #endif
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index a0c63ea2..8dbbd7a1 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -166,6 +166,7 @@ int mmc_wait_for_cmd(struct mmc_host *host, struct mmc_command *cmd,
>                 int retries);
>
>  int mmc_hw_reset(struct mmc_host *host);
> +void mmc_hw_reset_pwrseq(struct mmc_host *host);

Don't you think we can make this transparent to mmc host drivers,
instead of them having to assign their host_ops->hw_reset() callback
to this new API? Because I guess that's the though!?

In principle the mmc core already have all the information it needs,
as to understand when the eMMC pwrseq should be invoked. Or perhaps
the code may become a bit too messy for that?

>  void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card);
>
>  #endif /* LINUX_MMC_CORE_H */
> --
> 2.11.0
>
>

Kind regards
Uffe
