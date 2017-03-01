From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH 4/4] arm: dts: rockchip: Enable post_ios_power_on and pre-power-on-delay-ms
Date: Wed, 01 Mar 2017 23:43:30 +0100
Message-ID: <2352931.6xxz4r33MQ@phil>
References: <20170301145310.22813-1-romain.perier@collabora.com> <20170301145310.22813-5-romain.perier@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:51466 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753579AbdCAXAF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 1 Mar 2017 18:00:05 -0500
In-Reply-To: <20170301145310.22813-5-romain.perier@collabora.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Romain Perier <romain.perier@collabora.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org

Hi Romain,

Am Mittwoch, 1. März 2017, 15:53:10 CET schrieb Romain Perier:
> This enables the property post_ios_power_on. With this property, the
> driver pwrseq_simple will do its entire power sequence at the end of the
> mmc_power_up() function. The property pre-power-on-delay-ms adds a delay
> of 1ms between the enablement of the clk and the assertion of the reset
> line.
> 
> It fixes the power-up sequence for the Wifi chipset AP6335.
> 
> Signed-off-by: Romain Perier <romain.perier@collabora.com>

I didn't get the other 3 patches touching the mmc subsystem, so if and when 
they get accepted, please ping this devicetree patch.


> ---
>  arch/arm/boot/dts/rk3288-rock2-square.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk3288-rock2-square.dts
> b/arch/arm/boot/dts/rk3288-rock2-square.dts index 818c4bf..9bf2991 100644
> --- a/arch/arm/boot/dts/rk3288-rock2-square.dts
> +++ b/arch/arm/boot/dts/rk3288-rock2-square.dts
> @@ -106,6 +106,8 @@
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&wifi_enable>;
>  		reset-gpios = <&gpio4 28 GPIO_ACTIVE_LOW>;
> +		pre-power-on-delay-ms = <1>;
> +		post-ios-power-on;

If you need to resend your series, please make sure you have alphabetically 
sorted properties -> pinctrl, post-ios-..., pre-power-... and finally reset-
gpios. No need to resend just for this though, as I can reorder them myself if 
needed.


Thanks
Heiko
