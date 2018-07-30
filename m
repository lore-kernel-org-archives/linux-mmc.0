From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 2/6] dt-bindings: mmc: rockchip-dw-mshc: add
 description for px30
Date: Mon, 30 Jul 2018 17:06:32 +0200
Message-ID: <CAPDyKFo2GmxKwXDTOxnNY_wb4ydmVjGAZD3=bZYLhfEvjmGyXQ@mail.gmail.com>
References: <1532337924-4185-1-git-send-email-cl@rock-chips.com> <1532337924-4185-3-git-send-email-cl@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532337924-4185-3-git-send-email-cl@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: cl@rock-chips.com
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, klaus.goger@theobroma-systems.com, hjc@rock-chips.com, jagan@amarulasolutions.com, djw@t-chip.com.cn, jacob-chen@iotwrt.com, devicetree@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Frank Wang <frank.wang@rock-chips.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
List-Id: linux-mmc@vger.kernel.org

On 23 July 2018 at 11:25,  <cl@rock-chips.com> wrote:
> From: Liang Chen <cl@rock-chips.com>
>
> Add "rockchip,px30-dw-mshc", "rockchip,rk3288-dw-mshc" for
> dwmmc on px30 platform.
>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Liang Chen <cl@rock-chips.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
> index 8ce49b2..6f629b1 100644
> --- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
> +++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
> @@ -14,6 +14,7 @@ Required Properties:
>                                                         before RK3288
>         - "rockchip,rk3288-dw-mshc": for Rockchip RK3288
>         - "rockchip,rv1108-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RV1108
> +       - "rockchip,px30-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip PX30
>         - "rockchip,rk3036-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK3036
>         - "rockchip,rk3228-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK322x
>         - "rockchip,rk3328-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK3328
> --
> 1.9.1
>
>
