From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: Re: [PATCH 2/5] mmc: mtk-sd: don't hard-code interrupt trigger type
Date: Tue, 16 Apr 2019 16:11:42 +0800
Message-ID: <1555402302.18628.17.camel@mhfsdcap03>
References: <155538933003.25108.3338569916935462285.stgit@noble.brown>
         <155539004923.25108.12499096383277776864.stgit@noble.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <155539004923.25108.12499096383277776864.stgit@noble.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neil@brown.name>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, thirtythreeforty@gmail.com
List-Id: linux-mmc@vger.kernel.org

On Tue, 2019-04-16 at 14:47 +1000, NeilBrown wrote:
> When using devicetree for configuration, interrupt trigger type
> should be described in the dts file, not hard-coded in the C code.
> 
> The mtk-sd silicon in the mt7621 soc uses an active-high interrupt
> and so cannot be used with the current code.
> 
> So remove the trigger and leave it to be set from devicetree.
> 
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  drivers/mmc/host/mtk-sd.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 4492a4465c0e..14e048239143 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -2243,7 +2243,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
>  	msdc_init_hw(host);
>  
>  	ret = devm_request_irq(&pdev->dev, host->irq, msdc_irq,
> -		IRQF_TRIGGER_LOW | IRQF_ONESHOT, pdev->name, host);
> +
change it to IRQF_TRIGGER_NONE | IRQF_ONESHOT
> 			       0, pdev->name, host);
>  	if (ret)
>  		goto release;
>  
> 
> 
