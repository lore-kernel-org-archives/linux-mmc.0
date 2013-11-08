From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RESEND PATCH v2 1/6] ARM: dts: Declare clocks as fixed on bcm11351
Date: Fri, 08 Nov 2013 11:53:25 +0100
Message-ID: <527CC2A5.7080000@linaro.org>
References: <1381960030-1640-1-git-send-email-tim.kryger@linaro.org> <1381960030-1640-2-git-send-email-tim.kryger@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f42.google.com ([209.85.214.42]:57660 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756942Ab3KHKx2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Nov 2013 05:53:28 -0500
Received: by mail-bk0-f42.google.com with SMTP id w16so686826bkz.15
        for <linux-mmc@vger.kernel.org>; Fri, 08 Nov 2013 02:53:27 -0800 (PST)
In-Reply-To: <1381960030-1640-2-git-send-email-tim.kryger@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tim Kryger <tim.kryger@linaro.org>, Christian Daudt <bcm@fixthebug.org>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Chris Ball <cjb@laptop.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, patches@linaro.org

On 10/16/2013 11:47 PM, Tim Kryger wrote:
> Declare clocks that are enabled and configured by bootloaders as fixe=
d
> rate clocks in the DTS such that device drivers may use standard cloc=
k
> function calls.
>
> Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
> Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
> Reviewed-by: Matt Porter <matt.porter@linaro.org>
> ---

Hi Tim,

I was wondering what is the status of this patchset ?

The patchset touches different areas maintained by different people.=20
Through what tree do you expect this patchset to be merged ??

Thanks
   -- Daniel

>   arch/arm/boot/dts/bcm11351.dtsi | 97 ++++++++++++++++++++++++++++++=
+++++++++++
>   1 file changed, 97 insertions(+)
>
> diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm1=
1351.dtsi
> index 98e6bc0..c6464fb 100644
> --- a/arch/arm/boot/dts/bcm11351.dtsi
> +++ b/arch/arm/boot/dts/bcm11351.dtsi
> @@ -126,4 +126,101 @@
>   		status =3D "disabled";
>   	};
>
> +	clocks {
> +		bsc1_clk: bsc1 {
> +			compatible =3D "fixed-clock";
> +			clock-frequency =3D <13000000>;
> +			#clock-cells =3D <0>;
> +		};
> +
> +		bsc2_clk: bsc2 {
> +			compatible =3D "fixed-clock";
> +			clock-frequency =3D <13000000>;
> +			#clock-cells =3D <0>;
> +		};
> +
> +		bsc3_clk: bsc3 {
> +			compatible =3D "fixed-clock";
> +			clock-frequency =3D <13000000>;
> +			#clock-cells =3D <0>;
> +		};
> +
> +		pmu_bsc_clk: pmu_bsc {
> +			compatible =3D "fixed-clock";
> +			clock-frequency =3D <13000000>;
> +			#clock-cells =3D <0>;
> +		};
> +
> +		hub_timer_clk: hub_timer {
> +			compatible =3D "fixed-clock";
> +			clock-frequency =3D <32768>;
> +			#clock-cells =3D <0>;
> +		};
> +
> +		pwm_clk: pwm {
> +			compatible =3D "fixed-clock";
> +			clock-frequency =3D <26000000>;
> +			#clock-cells =3D <0>;
> +		};
> +
> +		sdio1_clk: sdio1 {
> +			compatible =3D "fixed-clock";
> +			clock-frequency =3D <48000000>;
> +			#clock-cells =3D <0>;
> +		};
> +
> +		sdio2_clk: sdio2 {
> +			compatible =3D "fixed-clock";
> +			clock-frequency =3D <48000000>;
> +			#clock-cells =3D <0>;
> +		};
> +
> +		sdio3_clk: sdio3 {
> +			compatible =3D "fixed-clock";
> +			clock-frequency =3D <48000000>;
> +			#clock-cells =3D <0>;
> +		};
> +
> +		sdio4_clk: sdio4 {
> +			compatible =3D "fixed-clock";
> +			clock-frequency =3D <48000000>;
> +			#clock-cells =3D <0>;
> +		};
> +
> +		tmon_1m_clk: tmon_1m {
> +			compatible =3D "fixed-clock";
> +			clock-frequency =3D <1000000>;
> +			#clock-cells =3D <0>;
> +		};
> +
> +		uartb_clk: uartb {
> +			compatible =3D "fixed-clock";
> +			clock-frequency =3D <13000000>;
> +			#clock-cells =3D <0>;
> +		};
> +
> +		uartb2_clk: uartb2 {
> +			compatible =3D "fixed-clock";
> +			clock-frequency =3D <13000000>;
> +			#clock-cells =3D <0>;
> +		};
> +
> +		uartb3_clk: uartb3 {
> +			compatible =3D "fixed-clock";
> +			clock-frequency =3D <13000000>;
> +			#clock-cells =3D <0>;
> +		};
> +
> +		uartb4_clk: uartb4 {
> +			compatible =3D "fixed-clock";
> +			clock-frequency =3D <13000000>;
> +			#clock-cells =3D <0>;
> +		};
> +
> +		usb_otg_ahb_clk: usb_otg_ahb {
> +			compatible =3D "fixed-clock";
> +			clock-frequency =3D <52000000>;
> +			#clock-cells =3D <0>;
> +		};
> +	};
>   };
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

