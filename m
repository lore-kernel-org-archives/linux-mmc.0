Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7A2DDA0;
	Thu, 30 May 2024 06:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717049510; cv=none; b=S42myYXjLSy1p6hWAs5wgzMG8CMX1kmw1M3Co1jpqM61aIto7oe1fvYs0qWoP8M4esxvF3WcLpdQQlANL/uDK793lL/q844huN2dDgjuU3cy03fM3GUV1iELyFX/hZsXiyeATxZqyRrdHERB/lBJk8G7lQVGqlBgFsey3PuM3OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717049510; c=relaxed/simple;
	bh=NNuRGnCC/PwvYry4sTt4WxbSvgwyXHJP0+uo5/GHg94=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Z0GtF/fLa6ALqtM1aUTablUWHrkv4ycenx3I5OhAs78Z1oYuo+I3FFO3MPDZpFV/bsAWzpdrrUrihfBiiBe9G39x+p2+DEivUJiiRtYTyxA/KHxVZpqz1hVn6HJSOU3lHgwVL+PYF50sOmGwnpjqIdN8AVhHq8oYDOVAiCLJkfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=iqnipGLU; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="iqnipGLU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1717049479; x=1717654279; i=wahrenst@gmx.net;
	bh=EsObzuDggZcPsAJCrYelSxDfb2ObF3xVT9aYpHF/x8o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=iqnipGLUmAHOOWqDMe9hRcfpFCCpxhFLUkCe/fYExpavDdLid1imlEzKBqHZpsvW
	 xl+SkXhnxzRcHcqbUdH4f9i9KgQywuvm1M7Wx3+9QLJrs0vNNwWTtgBoavp8j+QW4
	 gUueQNl1mOrSPgzR+e3z7sGeJY3hKmSBpvAf28XtjUXb8lDzWiSMP6JTXZci9v/e7
	 8aftExv2s2VmQtJFJKT2AQtSgnNa3pLgFO64cYBfPIqqwuDFBRa8iRa0RKvX0uO1R
	 EGzmUBb8+q6Q2/ulh0zVNTCLaHBxb12s5MA71IowjWDzzZenGmi6KjYaULVLCywcA
	 CvXJTgQT/yH5hrLIXg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MORAa-1rq4531Lw6-00MYLI; Thu, 30
 May 2024 08:11:19 +0200
Message-ID: <f94cf0fb-a9a2-4447-9b32-7f09c2a37cf6@gmx.net>
Date: Thu, 30 May 2024 08:11:18 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] arm64: dts: broadcom: Add support for BCM2712
To: Andrea della Porta <andrea.porta@suse.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ulf Hansson
 <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kamal Dasu <kamal.dasu@broadcom.com>, Al Cooper <alcooperx@gmail.com>,
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org
References: <cover.1716899600.git.andrea.porta@suse.com>
 <8dd6997394a01317747ca11b4779f586752b4947.1716899600.git.andrea.porta@suse.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <8dd6997394a01317747ca11b4779f586752b4947.1716899600.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wTYiOw3KxXiOy40hYJRqts+FSsstKKT4WxhXtd/QEojTR2X2ojL
 TySUwrIHVWRK3PLZ3br7lh9HWcvgqFq2Wsw6ETiv3sJukezwScTkBHYdP/3PM8UfTPdtmKG
 4PnTCpPe//sivTIVv2K/20Lv58L+bv4arelOS6JPGh2oZW5HDWxTFz+P5yfPc9Faf5xmkRv
 AtJ9RlWQo0KXN4mclqdFw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:c7pe3KccDI8=;iYBiNMPDOng309BceoMXopUPaVf
 wnJd1FHtrLbgnE+aKZuojCZx19zPY+xm5Sr1HrY+8QY2JE4otngDh4f8+WEUgX0h/5kAUIYr0
 5xeQK+lu93ucjWyBnUM+W9Clm4/bAP6k+znyoSe/yllkHhEB7rIf6lNB+FLrgRk4r0WGgQCik
 70Wm8/xDZPJ1fevl80ItZ5AaOULyUUrKCnXN9ums/pzQcWkx0PHQlgJllXlUITDsAhtQrETRm
 S9gepccEx2efsRDN3ziRxdTuQ/kXe+Bi2P2cVlASD/e94++dKDpOEzAVLUcfSMnLGHx3WaNVW
 AOqbouezSuWZEF9RSP6VygGPoux36PMni+hPcGS6CjL9axWBCQ5zwGrws/CzyKW9QRisEV30l
 s09DMY9oosd6PEtfd9TQms3xAEqhu9EMHMAj5FiT5cno8+eRIPpgDZyUwmfs56sBOIjpASvOx
 4LkRwTwBORL8OOaQO8HJSiFLKYct3/ZvpocLr3lWwOpC+imcDk2EZKW5svuBOSmqsAMWXrco9
 0MBMIvO0xEORFqbG62E04VWvt4b8kv8ziJNy88Dc/d7ys0dZeqS0n0HV43nPhJa5x6XGLxEbw
 OJZFnankn0wnJTy+ORGZi9TmkOjCIbvk8LBrj/WN2XcjjsrLlfI69xjHatQsjt8plx5anT5py
 rwGl2ezvMFlRKTzDA20toUCIM8flQ99OJp/boL9gnvpx7eDNv8OwMSQp1OrepdQJkRFgNOVLv
 Xx51oZF7v5LEjaUY95FEDNX/kUiKBmsl0UjkOUqOH641g+/9lCPOmZOi9vVVGp1pvPRjva/TC
 S+R7WtrnsdDkIRs3CuiaT0gLswLgiB8iwIAkz7+7/70Xs=

Hi Andrea,

i think the following subject would be better:

arm64: dts: broadcom: Add minimal support for Raspberry Pi 5

because you also add the board file here.

Am 28.05.24 um 15:32 schrieb Andrea della Porta:
> The BCM2712 SoC family can be found on Raspberry Pi 5.
> Add minimal SoC and board (Rpi5 specific) dts file to be able to
> boot from SD card and use console on debug UART.
>
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>   arch/arm64/boot/dts/broadcom/Makefile         |   1 +
>   .../boot/dts/broadcom/bcm2712-rpi-5-b.dts     |  64 ++++
>   arch/arm64/boot/dts/broadcom/bcm2712.dtsi     | 292 ++++++++++++++++++
>   3 files changed, 357 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
>   create mode 100644 arch/arm64/boot/dts/broadcom/bcm2712.dtsi
>
> diff --git a/arch/arm64/boot/dts/broadcom/Makefile b/arch/arm64/boot/dts=
/broadcom/Makefile
> index 8b4591ddd27c..92565e9781ad 100644
> --- a/arch/arm64/boot/dts/broadcom/Makefile
> +++ b/arch/arm64/boot/dts/broadcom/Makefile
> @@ -6,6 +6,7 @@ DTC_FLAGS :=3D -@
>   dtb-$(CONFIG_ARCH_BCM2835) +=3D bcm2711-rpi-400.dtb \
>   			      bcm2711-rpi-4-b.dtb \
>   			      bcm2711-rpi-cm4-io.dtb \
> +			      bcm2712-rpi-5-b.dtb \
>   			      bcm2837-rpi-3-a-plus.dtb \
>   			      bcm2837-rpi-3-b.dtb \
>   			      bcm2837-rpi-3-b-plus.dtb \
> diff --git a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts b/arch/arm=
64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
> new file mode 100644
> index 000000000000..2bdbb6780242
> --- /dev/null
> +++ b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
> @@ -0,0 +1,64 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include "bcm2712.dtsi"
> +
> +/ {
> +	compatible =3D "raspberrypi,5-model-b", "brcm,bcm2712";
> +	model =3D "Raspberry Pi 5";
> +
> +	aliases {
> +		serial10 =3D &uart10;
> +	};
> +
> +	chosen: chosen {
> +		stdout-path =3D "serial10:115200n8";
> +	};
> +
> +	/* Will be filled by the bootloader */
> +	memory@0 {
> +		device_type =3D "memory";
> +		reg =3D <0 0 0 0x28000000>;
> +	};
> +
> +	sd_io_1v8_reg: sd-io-1v8-reg {
> +		compatible =3D "regulator-gpio";
> +		regulator-name =3D "vdd-sd-io";
> +		regulator-min-microvolt =3D <1800000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +		regulator-settling-time-us =3D <5000>;
> +		gpios =3D <&gio_aon 3 GPIO_ACTIVE_HIGH>;
> +		states =3D <1800000 1>,
> +			 <3300000 0>;
> +	};
> +
> +	sd_vcc_reg: sd-vcc-reg {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "vcc-sd";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		regulator-boot-on;
> +		enable-active-high;
> +		gpios =3D <&gio_aon 4 GPIO_ACTIVE_HIGH>;
> +	};
> +};
> +
> +/* The Debug UART, on Rpi5 it's on JST-SH 1.0mm 3-pin connector
> + * labeled "UART", i.e. the interface with the system console.
> + */
> +&uart10 {
> +	status =3D "okay";
> +};
> +
> +/* SDIO1 is used to drive the SD card */
> +&sdio1 {
> +	vqmmc-supply =3D <&sd_io_1v8_reg>;
> +	vmmc-supply =3D <&sd_vcc_reg>;
> +	bus-width =3D <4>;
> +	sd-uhs-sdr50;
> +	sd-uhs-ddr50;
> +	sd-uhs-sdr104;
> +};
> diff --git a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi b/arch/arm64/boot=
/dts/broadcom/bcm2712.dtsi
> new file mode 100644
> index 000000000000..71b0fa6c9594
> --- /dev/null
> +++ b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
> @@ -0,0 +1,292 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	compatible =3D "brcm,bcm2712";
> +
> +	#address-cells =3D <2>;
> +	#size-cells =3D <2>;
> +
> +	interrupt-parent =3D <&gicv2>;
> +
> +	axi: axi@1000000000 {
> +		compatible =3D "simple-bus";
> +		#address-cells =3D <2>;
> +		#size-cells =3D <2>;
> +		ranges =3D <0x10 0x00000000  0x10 0x00000000  0x01 0x00000000>;
> +
> +		sdio1: mmc@1000fff000 {
> +			compatible =3D "brcm,bcm2712-sdhci",
> +				     "brcm,sdhci-brcmstb";
> +			reg =3D <0x10 0x00fff000  0x0 0x260>,
> +			      <0x10 0x00fff400  0x0 0x200>;
> +			reg-names =3D "host", "cfg";
> +			interrupts =3D <GIC_SPI 273 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&clk_emmc2>;
> +			clock-names =3D "sw_sdio";
> +			mmc-ddr-3_3v;
> +		};
> +
> +		gicv2: interrupt-controller@107fff9000 {
> +			interrupt-controller;
> +			#interrupt-cells =3D <3>;
> +			compatible =3D "arm,gic-400";
> +			reg =3D <0x10 0x7fff9000  0x0 0x1000>,
> +			      <0x10 0x7fffa000  0x0 0x2000>,
> +			      <0x10 0x7fffc000  0x0 0x2000>,
> +			      <0x10 0x7fffe000  0x0 0x2000>;
Please move compatible and reg before the other properties (DTS coding
style)
> +		};
> +	};
> +
> +	clocks {
> +		/* The oscillator is the root of the clock tree. */
> +		clk_osc: clk-osc {
> +			compatible =3D "fixed-clock";
> +			#clock-cells =3D <0>;
> +			clock-output-names =3D "osc";
> +			clock-frequency =3D <54000000>;
> +		};
> +
> +		clk_vpu: clk-vpu {
> +			#clock-cells =3D <0>;
> +			compatible =3D "fixed-clock";
> +			clock-frequency =3D <750000000>;
> +			clock-output-names =3D "vpu-clock";
> +		};
Is the VPU clock really fixed or is it just a workaround for minimal
boot support?

Except of this, LGTM
