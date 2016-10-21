From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: mediatek: Fix module autoload
Date: Fri, 21 Oct 2016 10:22:28 +0200
Message-ID: <CAPDyKFpNPdcQnWs59MiVGnv5FMYjfgR9F4OCiCWhnmkh7EcyCA@mail.gmail.com>
References: <1476720825-30442-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1476720825-30442-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Douglas Anderson <dianders@chromium.org>, linux-mediatek@lists.infradead.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On 17 October 2016 at 18:13, Javier Martinez Canillas
<javier@osg.samsung.com> wrote:
> If the driver is built as a module, autoload won't work because the module
> alias information is not filled. So user-space can't match the registered
> device with the corresponding module.
>
> Export the module alias information using the MODULE_DEVICE_TABLE() macro.
>
> Before this patch:
>
> $ modinfo drivers/mmc/host/mtk-sd.ko | grep alias
> $
>
> After this patch:
>
> $ modinfo drivers/mmc/host/mtk-sd.ko | grep alias
> alias:          of:N*T*Cmediatek,mt8135-mmcC*
> alias:          of:N*T*Cmediatek,mt8135-mmc
>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>
>  drivers/mmc/host/mtk-sd.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 84e9afcb5c09..86af0b199a54 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -1713,6 +1713,7 @@ static const struct of_device_id msdc_of_ids[] = {
>         {   .compatible = "mediatek,mt8135-mmc", },
>         {}
>  };
> +MODULE_DEVICE_TABLE(of, msdc_of_ids);
>
>  static struct platform_driver mt_msdc_driver = {
>         .probe = msdc_drv_probe,
> --
> 2.7.4
>
