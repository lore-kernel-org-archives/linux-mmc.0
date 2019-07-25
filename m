From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-pltfm: Use devm_platform_ioremap_resource() to
 simplify code
Date: Thu, 25 Jul 2019 15:14:50 +0200
Message-ID: <CAPDyKFpwOaa-8GxkWnXoyoC8nLyGMGE8moyEJr4a7TVBSiw6mw@mail.gmail.com>
References: <20190725151748.1a59b1ba@xhacker.debian>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190725151748.1a59b1ba@xhacker.debian>
Sender: linux-kernel-owner@vger.kernel.org
To: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, 25 Jul 2019 at 09:28, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
>
> devm_platform_ioremap_resource() wraps platform_get_resource() and
> devm_ioremap_resource() in a single helper, let's use that helper to
> simplify the code.
>
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pltfm.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
> index d268b3b8850a..11ecff9e998d 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -118,12 +118,10 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
>                                     size_t priv_size)
>  {
>         struct sdhci_host *host;
> -       struct resource *iomem;
>         void __iomem *ioaddr;
>         int irq, ret;
>
> -       iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       ioaddr = devm_ioremap_resource(&pdev->dev, iomem);
> +       ioaddr = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(ioaddr)) {
>                 ret = PTR_ERR(ioaddr);
>                 goto err;
> --
> 2.22.0
>
