From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/7] dt-bindings: rockchip-dw-mshc: rename RK1108 to RV1108
Date: Tue, 14 Mar 2017 17:20:36 +0100
Message-ID: <CAPDyKFoz_OuW+rWMji7G2D=MbANN+=YGrmtPgZFtYkDz6u5sug@mail.gmail.com>
References: <1486983566-32265-1-git-send-email-andy.yan@rock-chips.com> <1486983759-32337-1-git-send-email-andy.yan@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1486983759-32337-1-git-send-email-andy.yan@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Yan <andy.yan@rock-chips.com>
Cc: Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 13 February 2017 at 12:02, Andy Yan <andy.yan@rock-chips.com> wrote:
> Rockchip finally named the SOC as RV1108, so change it.
>
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

Thanks, applied for fixes!

Kind regards
Uffe

>
> ---
>
>  Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
> index ea9c1c9..520d61d 100644
> --- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
> +++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
> @@ -13,7 +13,7 @@ Required Properties:
>         - "rockchip,rk2928-dw-mshc": for Rockchip RK2928 and following,
>                                                         before RK3288
>         - "rockchip,rk3288-dw-mshc": for Rockchip RK3288
> -       - "rockchip,rk1108-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK1108
> +       - "rockchip,rv1108-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RV1108
>         - "rockchip,rk3036-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK3036
>         - "rockchip,rk3368-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK3368
>         - "rockchip,rk3399-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK3399
> --
> 2.7.4
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
