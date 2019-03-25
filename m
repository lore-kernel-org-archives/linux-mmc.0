From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH -next] mmc: sdhci-omap: Make sdhci_omap_reset static
Date: Mon, 25 Mar 2019 14:27:07 +0100
Message-ID: <CAPDyKFpdQkOzXnBKjGhCZSgtBSSePkzeMUYwABkW61eCNzRu5w@mail.gmail.com>
References: <20190322141138.19244-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190322141138.19244-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yue Haibing <yuehaibing@huawei.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Kishon <kishon@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, 22 Mar 2019 at 15:15, Yue Haibing <yuehaibing@huawei.com> wrote:
>
> From: YueHaibing <yuehaibing@huawei.com>
>
> Fix sparse warning:
>
> drivers/mmc/host/sdhci-omap.c:788:6: warning:
>  symbol 'sdhci_omap_reset' was not declared. Should it be static?
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-omap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index 5bbed47..649c03f 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -785,7 +785,7 @@ static void sdhci_omap_set_uhs_signaling(struct sdhci_host *host,
>         sdhci_omap_start_clock(omap_host);
>  }
>
> -void sdhci_omap_reset(struct sdhci_host *host, u8 mask)
> +static void sdhci_omap_reset(struct sdhci_host *host, u8 mask)
>  {
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
> --
> 2.7.0
>
>
