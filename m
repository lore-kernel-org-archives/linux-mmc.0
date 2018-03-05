From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] mmc: mediatek: add support for MT7622 SoC
Date: Mon, 5 Mar 2018 09:45:59 +0100
Message-ID: <CAPDyKFq6kPXsxHMCkCfvmm1t1ccs-ZgFY=z6YhuKdza5+WuLLw@mail.gmail.com>
References: <6cb1d6d4ee40a61f7b33aed1711753342590d0dd.1520232933.git.sean.wang@mediatek.com>
 <83a3ee9471cc7312b9cc43bcf692939e90af34ba.1520232933.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <83a3ee9471cc7312b9cc43bcf692939e90af34ba.1520232933.git.sean.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sean.wang@mediatek.com
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chaotian Jing <chaotian.jing@mediatek.com>
List-Id: linux-mmc@vger.kernel.org

On 5 March 2018 at 08:03,  <sean.wang@mediatek.com> wrote:
> From: Sean Wang <sean.wang@mediatek.com>
>
> Just applying the existing logic and adding its own characteristics into
> the space pointed by an extra entry of struct of_device_id to have support
> of MT7622 SoC.
>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Tested-by: Jumin Li <jumin.li@mediatek.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/mtk-sd.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 6457a7d..cb274e8 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -438,11 +438,23 @@ static const struct mtk_mmc_compatible mt2712_compat = {
>         .enhance_rx = true,
>  };
>
> +static const struct mtk_mmc_compatible mt7622_compat = {
> +       .clk_div_bits = 12,
> +       .hs400_tune = false,
> +       .pad_tune_reg = MSDC_PAD_TUNE0,
> +       .async_fifo = true,
> +       .data_tune = true,
> +       .busy_check = true,
> +       .stop_clk_fix = true,
> +       .enhance_rx = true,
> +};
> +
>  static const struct of_device_id msdc_of_ids[] = {
>         { .compatible = "mediatek,mt8135-mmc", .data = &mt8135_compat},
>         { .compatible = "mediatek,mt8173-mmc", .data = &mt8173_compat},
>         { .compatible = "mediatek,mt2701-mmc", .data = &mt2701_compat},
>         { .compatible = "mediatek,mt2712-mmc", .data = &mt2712_compat},
> +       { .compatible = "mediatek,mt7622-mmc", .data = &mt7622_compat},
>         {}
>  };
>  MODULE_DEVICE_TABLE(of, msdc_of_ids);
> --
> 2.7.4
>
