From: Dinh Nguyen <dinh.linux@gmail.com>
Subject: Re: [PATCHv10 4/5] ARM: dts: socfpga: unuse the slot-node and
 deprecate the supports-highspeed for dw-mmc
Date: Mon, 11 Aug 2014 16:03:52 -0500
Message-ID: <CADhT+wcKrL8f-OyLnKKzsBgyU3PSYFLfsZgvCcdAgVV5BAT76Q@mail.gmail.com>
References: <1407397082-32495-1-git-send-email-jh80.chung@samsung.com>
	<1407397082-32495-5-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1407397082-32495-5-git-send-email-jh80.chung@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Seungwon Jeon <tgih.jun@samsung.com>, Chris Ball <chris@printf.net>, linux-samsung-soc@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Dinh Nguyen <dinguyen@altera.com>
List-Id: linux-mmc@vger.kernel.org

On Thu, Aug 7, 2014 at 2:38 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> dw-mmc controller can support multiple slots.
> But, there are no use-cases anywhere. So we don't need to support the
> slot-node for dw-mmc controller.
> And "supports-highspeed" property in dw-mmc is deprecated.
> "supports-highspeed" property can be replaced with "cap-sd/mmc-highspeed".
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Reviewed-by: Tushar Behera <trblinux@gmail.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
> Acked-by: Dinh Nguyen <dinguyen@altera.com>
> ---

I've queued this patch in my tree for v3.18.

Thanks,
Dinh

>  arch/arm/boot/dts/socfpga_arria5.dtsi   |    9 +++------
>  arch/arm/boot/dts/socfpga_cyclone5.dtsi |    9 +++------
>  arch/arm/boot/dts/socfpga_vt.dts        |    9 +++------
>  3 files changed, 9 insertions(+), 18 deletions(-)
>
> diff --git a/arch/arm/boot/dts/socfpga_arria5.dtsi b/arch/arm/boot/dts/socfpga_arria5.dtsi
> index 12d1c2c..468fc4c 100644
> --- a/arch/arm/boot/dts/socfpga_arria5.dtsi
> +++ b/arch/arm/boot/dts/socfpga_arria5.dtsi
> @@ -29,13 +29,10 @@
>
>                 dwmmc0@ff704000 {
>                         num-slots = <1>;
> -                       supports-highspeed;
>                         broken-cd;
> -
> -                       slot@0 {
> -                               reg = <0>;
> -                               bus-width = <4>;
> -                       };
> +                       bus-width = <4>;
> +                       cap-mmc-highspeed;
> +                       cap-sd-highspeed;
>                 };
>
>                 sysmgr@ffd08000 {
> diff --git a/arch/arm/boot/dts/socfpga_cyclone5.dtsi b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
> index bf51182..1ee03c4 100644
> --- a/arch/arm/boot/dts/socfpga_cyclone5.dtsi
> +++ b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
> @@ -30,13 +30,10 @@
>
>                 dwmmc0@ff704000 {
>                         num-slots = <1>;
> -                       supports-highspeed;
>                         broken-cd;
> -
> -                       slot@0 {
> -                               reg = <0>;
> -                               bus-width = <4>;
> -                       };
> +                       bus-width = <4>;
> +                       cap-mmc-highspeed;
> +                       cap-sd-highspeed;
>                 };
>
>                 ethernet@ff702000 {
> diff --git a/arch/arm/boot/dts/socfpga_vt.dts b/arch/arm/boot/dts/socfpga_vt.dts
> index 09792b4..f9345e0 100644
> --- a/arch/arm/boot/dts/socfpga_vt.dts
> +++ b/arch/arm/boot/dts/socfpga_vt.dts
> @@ -43,13 +43,10 @@
>
>                 dwmmc0@ff704000 {
>                         num-slots = <1>;
> -                       supports-highspeed;
>                         broken-cd;
> -
> -                       slot@0 {
> -                               reg = <0>;
> -                               bus-width = <4>;
> -                       };
> +                       bus-width = <4>;
> +                       cap-mmc-highspeed;
> +                       cap-sd-highspeed;
>                 };
>
>                 ethernet@ff700000 {
> --
> 1.7.9.5
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
