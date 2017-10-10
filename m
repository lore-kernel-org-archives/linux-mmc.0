From: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v4 05/12] mmc: mediatek: add pad_tune0 support
Date: Tue, 10 Oct 2017 17:57:26 +0100
Message-ID: <afac6efe-d721-acae-6c07-adf4cfff962d@arm.com>
References: <1507627831-29323-1-git-send-email-chaotian.jing@mediatek.com>
 <1507627831-29323-6-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507627831-29323-6-git-send-email-chaotian.jing@mediatek.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, srv_heupstream@mediatek.com, Catalin Marinas <catalin.marinas@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, yong mao <yong.mao@mediatek.com>, Phong LE <ple@baylibre.com>, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, linux-mmc@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Hi,

On 10/10/17 10:30, Chaotian Jing wrote:
> from mt2701, the register of PAD_TUNE has been phased out,
> while there is a new register of PAD_TUNE0
> 
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> ---
>   drivers/mmc/host/mtk-sd.c | 69 ++++++++++++++++++++++++++++++++++-------------
>   1 file changed, 51 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index ab2fbbb..0dc45b3 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -75,6 +75,7 @@
>   #define MSDC_PATCH_BIT   0xb0
>   #define MSDC_PATCH_BIT1  0xb4
>   #define MSDC_PAD_TUNE    0xec
> +#define MSDC_PAD_TUNE0   0xf0
>   #define PAD_DS_TUNE      0x188
>   #define PAD_CMD_TUNE     0x18c
>   #define EMMC50_CFG0      0x208
> @@ -301,6 +302,7 @@ struct msdc_save_para {
>   struct mtk_mmc_compatible {
>   	u8 clk_div_bits;
>   	bool hs400_tune; /* only used for MT8173 */
> +	bool pad_tune0;

You only use this to decide whether to use MDSC_PAD_TUNE or 
MSDC_PAD_TUNE0 as tune regs.

Couldn't this field directly be a 'u32' that is either MDSC_PAD_TUNE or 
MDSC_PAD_TUNE0 rather than a bool?

>   };
>   
>   struct msdc_tune_para {
> @@ -362,21 +364,25 @@ struct msdc_host {
>   static const struct mtk_mmc_compatible mt8135_compat = {
>   	.clk_div_bits = 8,
>   	.hs400_tune = false,
> +	.pad_tune0 = false,

and here we could have (field could be renamed accordingly of course):

	.pad_tune0 = MDSC_PAD_TUNE,

>   };
>   
>   static const struct mtk_mmc_compatible mt8173_compat = {
>   	.clk_div_bits = 8,
>   	.hs400_tune = true,
> +	.pad_tune0 = false,
>   };
>   
>   static const struct mtk_mmc_compatible mt2701_compat = {
>   	.clk_div_bits = 12,
>   	.hs400_tune = false,
> +	.pad_tune0 = true,

here:
	.pad_tune0 = MDSC_PAD_TUNE0,

>   };
>   
>   static const struct mtk_mmc_compatible mt2712_compat = {
>   	.clk_div_bits = 12,
>   	.hs400_tune = false,
> +	.pad_tune0 = true,
>   };
>   
>   static const struct of_device_id msdc_of_ids[] = {
> @@ -581,6 +587,10 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
>   	u32 flags;
>   	u32 div;
>   	u32 sclk;
> +	u32 tune_reg = MSDC_PAD_TUNE;
> +
> +	if (host->dev_comp->pad_tune0)
> +		tune_reg = MSDC_PAD_TUNE0;

And this would not be needed here nor in the other functions, it could 
just be replaced by host->dev_comp->pad_tune0.

Thanks,

-- 
Julien Thierry
