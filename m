From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci: remove unneeded (void *) casts in
 sdhci_(pltfm_)priv()
Date: Fri, 11 Nov 2016 14:43:59 +0200
Message-ID: <664579d5-a5be-bcc8-a24e-d725c8552b4a@intel.com>
References: <1478784138-18594-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478784138-18594-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On 10/11/16 15:22, Masahiro Yamada wrote:
> The type of host->private is (unsigned long *).  No cast is needed
> to return an opaque pointer.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

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
> -	return (void *)host->private;
> +	return host->private;
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
> -	return (void *)host->private;
> +	return host->private;
>  }
>  
>  extern void sdhci_card_detect(struct sdhci_host *host);
> 
