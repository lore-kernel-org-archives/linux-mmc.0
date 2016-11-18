From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci: remove unneeded (void *) casts in sdhci_(pltfm_)priv()
Date: Fri, 18 Nov 2016 15:28:57 +0100
Message-ID: <CAPDyKFps5kZYbuQVJJjZ9AyCiW+GGS5rf9-BvDuBaQ1UpU4u8g@mail.gmail.com>
References: <1478784138-18594-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478784138-18594-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

On 10 November 2016 at 14:22, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> The type of host->private is (unsigned long *).  No cast is needed
> to return an opaque pointer.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>
>  drivers/mmc/host/sdhci-pltfm.h | 2 +-
>  drivers/mmc/host/sdhci.h       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
> index 3280f20..957839d 100644
> --- a/drivers/mmc/host/sdhci-pltfm.h
> +++ b/drivers/mmc/host/sdhci-pltfm.h
> @@ -106,7 +106,7 @@ extern int sdhci_pltfm_register(struct platform_device *pdev,
>
>  static inline void *sdhci_pltfm_priv(struct sdhci_pltfm_host *host)
>  {
> -       return (void *)host->private;
> +       return host->private;
>  }
>
>  extern const struct dev_pm_ops sdhci_pltfm_pmops;
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 766df17..9886115 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -655,7 +655,7 @@ extern struct sdhci_host *sdhci_alloc_host(struct device *dev,
>
>  static inline void *sdhci_priv(struct sdhci_host *host)
>  {
> -       return (void *)host->private;
> +       return host->private;
>  }
>
>  extern void sdhci_card_detect(struct sdhci_host *host);
> --
> 1.9.1
>
