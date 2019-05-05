From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: Re: [PATCH 2/4] mmc: mtk-sd: add support for config found in mt7620
 family SOCs.
Date: Sun, 5 May 2019 15:49:19 +0800
Message-ID: <1557042559.18628.34.camel@mhfsdcap03>
References: <155696540998.8632.5242582397805128125.stgit@noble.brown>
         <155696549676.8632.14384982012480111613.stgit@noble.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <155696549676.8632.14384982012480111613.stgit@noble.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neil@brown.name>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, thirtythreeforty@gmail.com
List-Id: linux-mmc@vger.kernel.org

On Sat, 2019-05-04 at 20:24 +1000, NeilBrown wrote:
> mt7620 family MIPS SOCs contain the mtk-sd silicon.
> Add support for this.
> 
> Signed-off-by: NeilBrown <neil@brown.name>
 Reviewed-by:Chaotian Jing <chaotian.jing@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.txt |    1 +
>  drivers/mmc/host/mtk-sd.c                        |   12 ++++++++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> index 91a2ec59e497..8a532f4453f2 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> @@ -16,6 +16,7 @@ Required properties:
>  	"mediatek,mt2712-mmc": for mmc host ip compatible with mt2712
>  	"mediatek,mt7622-mmc": for MT7622 SoC
>  	"mediatek,mt7623-mmc", "mediatek,mt2701-mmc": for MT7623 SoC
> +	"mediatek,mt7620-mmc", for MT7621 SoC (and others)
>  
>  - reg: physical base address of the controller and length
>  - interrupts: Should contain MSDC interrupt number
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 469d4a717175..0c2be4f54b1f 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -517,6 +517,17 @@ static const struct mtk_mmc_compatible mt8516_compat = {
>  	.stop_clk_fix = true,
>  };
>  
> +static const struct mtk_mmc_compatible mt7620_compat = {
> +	.clk_div_bits = 8,
> +	.hs400_tune = false,
> +	.pad_tune_reg = MSDC_PAD_TUNE,
> +	.async_fifo = false,
> +	.data_tune = false,
> +	.busy_check = false,
> +	.stop_clk_fix = false,
> +	.enhance_rx = false,
> +};
> +
>  static const struct of_device_id msdc_of_ids[] = {
>  	{ .compatible = "mediatek,mt8135-mmc", .data = &mt8135_compat},
>  	{ .compatible = "mediatek,mt8173-mmc", .data = &mt8173_compat},
> @@ -525,6 +536,7 @@ static const struct of_device_id msdc_of_ids[] = {
>  	{ .compatible = "mediatek,mt2712-mmc", .data = &mt2712_compat},
>  	{ .compatible = "mediatek,mt7622-mmc", .data = &mt7622_compat},
>  	{ .compatible = "mediatek,mt8516-mmc", .data = &mt8516_compat},
> +	{ .compatible = "mediatek,mt7620-mmc", .data = &mt7620_compat},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, msdc_of_ids);
> 
> 
