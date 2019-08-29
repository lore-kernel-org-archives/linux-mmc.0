From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/3] mmc: sdhci: constify references of parameters to __sdhci_read_caps()
Date: Thu, 29 Aug 2019 15:34:00 +0200
Message-ID: <CAPDyKFo9B6pDTcyoK-APicu+WcroCrjA7niHzd3DZH-7qkoZ_w@mail.gmail.com>
References: <20190829104928.27404-1-yamada.masahiro@socionext.com> <20190829104928.27404-2-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190829104928.27404-2-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Piotr Sroka <piotrs@cadence.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, 29 Aug 2019 at 12:49, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> __sdhci_read_caps() does not modify *ver, *caps, or *caps1.
>
> Probably, the caller of this function will want to constifythe
> parameters passed in.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
>  drivers/mmc/host/sdhci.c | 3 ++-
>  drivers/mmc/host/sdhci.h | 4 ++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index a5dc5aae973e..08cc0792c174 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3565,7 +3565,8 @@ static int sdhci_set_dma_mask(struct sdhci_host *host)
>         return ret;
>  }
>
> -void __sdhci_read_caps(struct sdhci_host *host, u16 *ver, u32 *caps, u32 *caps1)
> +void __sdhci_read_caps(struct sdhci_host *host, const u16 *ver,
> +                      const u32 *caps, const u32 *caps1)
>  {
>         u16 v;
>         u64 dt_caps_mask = 0;
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 902f855efe8f..81e23784475a 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -738,8 +738,8 @@ static inline void *sdhci_priv(struct sdhci_host *host)
>  }
>
>  void sdhci_card_detect(struct sdhci_host *host);
> -void __sdhci_read_caps(struct sdhci_host *host, u16 *ver, u32 *caps,
> -                      u32 *caps1);
> +void __sdhci_read_caps(struct sdhci_host *host, const u16 *ver,
> +                      const u32 *caps, const u32 *caps1);
>  int sdhci_setup_host(struct sdhci_host *host);
>  void sdhci_cleanup_host(struct sdhci_host *host);
>  int __sdhci_add_host(struct sdhci_host *host);
> --
> 2.17.1
>
