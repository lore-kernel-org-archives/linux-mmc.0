From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: mtk-sd: check for valid optional memory resource
Date: Thu, 11 Apr 2019 12:43:13 +0200
Message-ID: <CAPDyKFrKxGxp5K38P-AHrRpjOGjKhBv333HXAHPNKYWqLJmz+g@mail.gmail.com>
References: <20190403193050.22180-1-fparent@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403193050.22180-1-fparent@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabien Parent <fparent@baylibre.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Yingjoe Chen <yingjoe.chen@mediatek.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, Jjian Zhou <jjian.zhou@mediatek.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, 3 Apr 2019 at 21:31, Fabien Parent <fparent@baylibre.com> wrote:
>
> 'top_base' memory region is optional. Check that the resource is valid
> before using it. This avoid getting a "invalid resource" error message
> printed by the kernel.
>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> V2:
>         Fix invalid condition: check against 'res' variable instead of 'ret'.
>
> ---
>  drivers/mmc/host/mtk-sd.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 833ef0590af8..61bf8704491c 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -2123,9 +2123,11 @@ static int msdc_drv_probe(struct platform_device *pdev)
>         }
>
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -       host->top_base = devm_ioremap_resource(&pdev->dev, res);
> -       if (IS_ERR(host->top_base))
> -               host->top_base = NULL;
> +       if (res) {
> +               host->top_base = devm_ioremap_resource(&pdev->dev, res);
> +               if (IS_ERR(host->top_base))
> +                       host->top_base = NULL;
> +       }
>
>         ret = mmc_regulator_get_supply(mmc);
>         if (ret)
> --
> 2.20.1
>
