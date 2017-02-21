From: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Subject: Re: [PATCH v3 3/7] mmc: bcm2835: add sdhost controller to devicetree
Date: Tue, 21 Feb 2017 16:57:15 +0100
Message-ID: <48fcc95e-3a21-f6d0-8073-cae34871656a@i2se.com>
References: <1487668026-7100-1-git-send-email-kraxel@redhat.com>
 <1487668026-7100-4-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1487668026-7100-4-git-send-email-kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


Am 21.02.2017 um 10:07 schrieb Gerd Hoffmann:
> Signed-off-by: Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Acked-by: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
> ---
>   arch/arm/boot/dts/bcm2835-rpi.dtsi |  6 ++++++
>   arch/arm/boot/dts/bcm283x.dtsi     | 10 ++++++++++
>   2 files changed, 16 insertions(+)
>
> diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
> index 0b73f9c..7d89af2 100644
> --- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
> +++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
> @@ -69,6 +69,12 @@
>   	bus-width = <4>;
>   };
>   
> +&sdhost {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdhost_gpio48>;
> +	bus-width = <4>;
> +};
> +
>   &pwm {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&pwm0_gpio40 &pwm1_gpio45>;
> diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
> index a3106aa..3f4fbff 100644
> --- a/arch/arm/boot/dts/bcm283x.dtsi
> +++ b/arch/arm/boot/dts/bcm283x.dtsi
> @@ -450,6 +450,16 @@
>   			status = "disabled";
>   		};
>   
> +		sdhost: mmc@7e202000 {
> +			compatible = "brcm,bcm2835-sdhost";
> +			reg = <0x7e202000 0x100>;
> +			interrupts = <2 24>;
> +			clocks = <&clocks BCM2835_CLOCK_VPU>;
> +			dmas = <&dma 13>;
> +			dma-names = "rx-tx";
> +			status = "disabled";
> +		};
> +
>   		hvs@7e400000 {
>   			compatible = "brcm,bcm2835-hvs";
>   			reg = <0x7e400000 0x6000>;

Unfortunately this is still the wrong place regarding to the register 
order. So please be placed it between uart0: serial@7e201000 and i2s: 
i2s@7e203000.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
