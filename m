From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: Re: [PATCH 1/4] mmc: mtk-sd: don't hard-code interrupt trigger type
Date: Sun, 5 May 2019 15:43:53 +0800
Message-ID: <1557042233.18628.33.camel@mhfsdcap03>
References: <155696540998.8632.5242582397805128125.stgit@noble.brown>
         <155696549653.8632.3279283591868841381.stgit@noble.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <155696549653.8632.3279283591868841381.stgit@noble.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neil@brown.name>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, thirtythreeforty@gmail.com
List-Id: linux-mmc@vger.kernel.org

On Sat, 2019-05-04 at 20:24 +1000, NeilBrown wrote:
> When using devicetree for configuration, interrupt trigger type
> should be described in the dts file, not hard-coded in the C code.
> 
> The mtk-sd silicon in the mt7621 soc uses an active-high interrupt
> and so cannot be used with the current code.
> 
> So replace IRQF_TRIGGER_LOW with IRQF_TRIGGER_NONE.
> 
> Also IRQF_ONESHOT is not needed - it is used for threaded interrupt
> handlers, and this driver does not used a threaded interrupt handler.
> So remove that setting.
> 
> Signed-off-by: NeilBrown <neil@brown.name>
 Reviewed-by:Chaotian Jing <chaotian.jing@mediatek.com>
> ---
>  drivers/mmc/host/mtk-sd.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 0798f0ba6d34..469d4a717175 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -2240,7 +2240,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
>  	msdc_init_hw(host);
>  
>  	ret = devm_request_irq(&pdev->dev, host->irq, msdc_irq,
> -		IRQF_TRIGGER_LOW | IRQF_ONESHOT, pdev->name, host);
> +			       IRQF_TRIGGER_NONE, pdev->name, host);
>  	if (ret)
>  		goto release;
>  
> 
> 
