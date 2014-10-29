From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH RESEND 10/12] ARM: dts: berlin: Add SDHCI controller nodes
 to BG2/BG2CD
Date: Wed, 29 Oct 2014 19:39:23 +0100
Message-ID: <5451345B.5000703@gmail.com>
References: <1413883364-681-1-git-send-email-sebastian.hesselbarth@gmail.com> <1413883364-681-11-git-send-email-sebastian.hesselbarth@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413883364-681-11-git-send-email-sebastian.hesselbarth@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, =?UTF-8?B?QW50b2luZSBUw6luYXJ0?= <antoine.tenart@free-electrons.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 21.10.2014 11:22, Sebastian Hesselbarth wrote:
> Marvell Berlin BG2 has three, BG2CD just one pxav3 compatible
> sdhci controllers, add them to the corresponding DT SoC
> includes.
>
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com=
>

Applied the three DT patches to berlin/dt.

Sebastian

> ---
> Cc: Chris Ball <chris@printf.net>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: "Antoine T=C3=A9nart" <antoine.tenart@free-electrons.com>
> Cc: linux-mmc@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>   arch/arm/boot/dts/berlin2.dtsi   | 34 +++++++++++++++++++++++++++++=
+++++
>   arch/arm/boot/dts/berlin2cd.dtsi |  9 +++++++++
>   2 files changed, 43 insertions(+)
>
> diff --git a/arch/arm/boot/dts/berlin2.dtsi b/arch/arm/boot/dts/berli=
n2.dtsi
> index 9d7c810ebd0b..504f1add1938 100644
> --- a/arch/arm/boot/dts/berlin2.dtsi
> +++ b/arch/arm/boot/dts/berlin2.dtsi
> @@ -53,6 +53,35 @@
>
>   		ranges =3D <0 0xf7000000 0x1000000>;
>
> +		sdhci0: sdhci@ab0000 {
> +			compatible =3D "mrvl,pxav3-mmc";
> +			reg =3D <0xab0000 0x200>;
> +			clocks =3D <&chip CLKID_SDIO0XIN>, <&chip CLKID_SDIO0>;
> +			clock-names =3D "io", "core";
> +			interrupts =3D <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> +			status =3D "disabled";
> +		};
> +
> +		sdhci1: sdhci@ab0800 {
> +			compatible =3D "mrvl,pxav3-mmc";
> +			reg =3D <0xab0800 0x200>;
> +			clocks =3D <&chip CLKID_SDIO1XIN>, <&chip CLKID_SDIO1>;
> +			clock-names =3D "io", "core";
> +			interrupts =3D <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
> +			status =3D "disabled";
> +		};
> +
> +		sdhci2: sdhci@ab1000 {
> +			compatible =3D "mrvl,pxav3-mmc";
> +			reg =3D <0xab1000 0x200>;
> +			interrupts =3D <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&chip CLKID_NFC_ECC>, <&chip CLKID_NFC>;
> +			clock-names =3D "io", "core";
> +			pinctrl-0 =3D <&emmc_pmux>;
> +			pinctrl-names =3D "default";
> +			status =3D "disabled";
> +		};
> +
>   		l2: l2-cache-controller@ac0000 {
>   			compatible =3D "marvell,tauros3-cache", "arm,pl310-cache";
>   			reg =3D <0xac0000 0x1000>;
> @@ -252,6 +281,11 @@
>   			reg =3D <0xea0000 0x400>;
>   			clocks =3D <&refclk>;
>   			clock-names =3D "refclk";
> +
> +			emmc_pmux: emmc-pmux {
> +				groups =3D "G26";
> +				function =3D "emmc";
> +			};
>   		};
>
>   		apb@fc0000 {
> diff --git a/arch/arm/boot/dts/berlin2cd.dtsi b/arch/arm/boot/dts/ber=
lin2cd.dtsi
> index cc1df65da504..5a19017b5d71 100644
> --- a/arch/arm/boot/dts/berlin2cd.dtsi
> +++ b/arch/arm/boot/dts/berlin2cd.dtsi
> @@ -45,6 +45,15 @@
>
>   		ranges =3D <0 0xf7000000 0x1000000>;
>
> +		sdhci0: sdhci@ab0000 {
> +			compatible =3D "mrvl,pxav3-mmc";
> +			reg =3D <0xab0000 0x200>;
> +			clocks =3D <&chip CLKID_SDIO0XIN>, <&chip CLKID_SDIO0>;
> +			clock-names =3D "io", "core";
> +			interrupts =3D <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> +			status =3D "disabled";
> +		};
> +
>   		l2: l2-cache-controller@ac0000 {
>   			compatible =3D "arm,pl310-cache";
>   			reg =3D <0xac0000 0x1000>;
>
