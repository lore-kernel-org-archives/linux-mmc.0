From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 04/24] soc: mediatek: pwrap: add missing check on rstc
Date: Fri, 12 Apr 2019 19:44:15 +0200
Message-ID: <bfb3a38b-994c-ef4f-799c-8f8a4f012fa0@gmail.com>
References: <20190323211612.860-1-fparent@baylibre.com>
 <20190323211612.860-5-fparent@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190323211612.860-5-fparent@baylibre.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Fabien Parent <fparent@baylibre.com>, robh+dt@kernel.org, mark.rutland@arm.com
Cc: sean.wang@kernel.org, ryder.lee@mediatek.com, hsin-hsiung.wang@mediatek.com, wenzhen.yu@mediatek.com, chaotian.jing@mediatek.com, yong.mao@mediatek.com, jjian.zhou@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org, stephane.leprovost@mediatek.com
List-Id: linux-mmc@vger.kernel.org



On 23/03/2019 22:15, Fabien Parent wrote:
> The variable rstc is set only when the SoC PWRAP have the
> PWRAP_CAP_RESET capability. Check whether rstc is set before
> using it to avoid errors.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  drivers/soc/mediatek/mtk-pmic-wrap.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

applied to v5.1-next/soc

Thanks!

> 
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index 8236a6c87e19..b3ba2301f569 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -1478,7 +1478,8 @@ static int pwrap_init(struct pmic_wrapper *wrp)
>  {
>  	int ret;
>  
> -	reset_control_reset(wrp->rstc);
> +	if (wrp->rstc)
> +		reset_control_reset(wrp->rstc);
>  	if (wrp->rstc_bridge)
>  		reset_control_reset(wrp->rstc_bridge);
>  
> 
