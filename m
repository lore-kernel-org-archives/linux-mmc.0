Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909E04317E;
	Fri, 10 May 2024 19:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715370229; cv=none; b=E4/F6Bspn1erR2nVnW/Kxal2AaRXF9ag6KBkFVvHIXRTO/bSnHyvjaMO6d05Ad2VsE2MQYwGZszse42Z93tAH5POwcECpFgsa36OQVO+zDa7ypq8JhJ6Z9GA+gttfj+tDTBfLkIS+4h3wm3WCFouJ4t9ItxtLhXWHYwzUTeZmOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715370229; c=relaxed/simple;
	bh=Z6JR/YXHNRqELCeV0I6QeT5umPODWZn3kxBybMmeL5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=b3NL5AbeNrqzWtQ09jBST2jttqqDyf8S91BxD72pevgp5yvAceL6+5BKtwXRaSuIh1Vzb8KpvXDxKU0i63LI4gPO7xLKWUYSc4IDwMlpWZHEAkhWe5APlMwJsYSAYmST3+I9f32cwYPdtMUAgI1MpKwkdVP1PjwuCJyhlbfoc9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=QEwmwCmL; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="QEwmwCmL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1715370207; x=1715975007; i=wahrenst@gmx.net;
	bh=XDCoIeuP6OBAz3vLkc/8yr7TOacQajXobnQ4DdJvzTo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QEwmwCmLGfh50ZIixhoOHuHlHm3xgHml+C1//s3YRUTc95Af1C/AflKkxfU3eyij
	 YtxA8yNCG3mtxiJDLTEIcDFGWV7Ch7Z4Z34eo5Eqb8mrAjAndNgpQ0yjnarw3seIN
	 1Lvu8XaAIa1DWp7Fsm7Lv4SRfGgSrztJnACtF15XTztUeppX6nkBGpgbImLrRfO3X
	 pWeA6Nr2IGuC/x6sC/m5JHRTAB0jtt9POpV+gfIjMSH4vBDrNxiqLqdRrnH4zu1S/
	 OlaiFCvJaFUvTbl7OiysMB+yAFBnpk2puroIMjZ/ZgxJkiDo5bC8w0sxbD1YvMGC5
	 PROQC5/tqHC9mUxQ+w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.126] ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N33Il-1skWKB3gI1-0103nS; Fri, 10
 May 2024 21:43:26 +0200
Message-ID: <6199ca74-772a-41ed-a1b7-a86c1ed6cba5@gmx.net>
Date: Fri, 10 May 2024 21:43:23 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] arm64: dts: broadcom: Add support for BCM2712
To: Andrea della Porta <andrea.porta@suse.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ulf Hansson
 <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kamal Dasu <kamal.dasu@broadcom.com>, Al Cooper <alcooperx@gmail.com>,
 Eric Anholt <eric@anholt.net>, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
References: <cover.1715332922.git.andrea.porta@suse.com>
 <59a3015c3a6f2f0b70a38c030274a163773e7757.1715332922.git.andrea.porta@suse.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <59a3015c3a6f2f0b70a38c030274a163773e7757.1715332922.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XjPWSbwk96CQpLbORvk9j0w7gFWu3/wPSq4fUVVQt4sTSkzko3l
 MbDNzJ55XX/EKq0zhr7D6Ie0I7C9bnFuyMw6pAdCukghuBvRNj0SmHua/37eEN6sZdQcoeu
 ThV6yFWhNefLdlXhzmdKD6F0JcAbLRm23M9Z1yOaxj40YQgnQ17JEowljImVVGjylArtMvL
 kKbTdPkd4PlaMbQ7/lbrg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xiWQUMp0tVw=;koqFzweo7xISxav+8dY1eYyxtbT
 gWhF1v4fFU+lS5ur0PhTsYAtizUSJvSZM4ZIm3hjSDtTywNWgiDk7rlwHwS7hvUUxqP16dCO2
 UKLraL5aFKA3ClnuSkNrwI8YOEu3DFvwvhaAZk5SmX/ZKWS+d4+f2ppUvLy7smaNvjcWoSqln
 w6D6vIzc6wdPVKxDenyfDdI2TNNe+YTpXcXQfnFbVXFAfl8xW9NjmIwAdhifD3jcvbRK8ta1U
 pcGX2kWC7X7N/PJFhg2vWDW/A4XUdTWXHLiFo0qpOc/Ql3GWXbfEThJKhM5TDdEUP+vFjmXRS
 p64Gqunk0ibr8+MJ6IvsslflT9nD74p+sITjM+ZRGOQJ1sQv/e28W0nhfUF+anke/E/Di3JL4
 f8cntYukErQ2zchD4LBp4gAtRW1KpJ4Llx9sN62q1jBs7ny+VC+J85OOU2IvKeokPGN7twjHM
 QzAZmoG/d0gAnmLOtmuPz1rzwqDDrYCpQIo8ciILJwIiovtFVcuG71mTP0Aj+v5A8hDURGauZ
 ChVCEvnlXkmdgZaaNbffGT6Ka8iQ4cISAtzS2e9NL8Nk2ce4B89+ldCIEgiFhbdDgxdl7e41t
 THnKiX1UYdvgJENFV1fFrEUowk3Hkrxu262fX9ugMnbD/zp0pGd/KL8ROYZQ7TQmnOZtKECvh
 Rn/H0hDvzZA39BF/kpoaTcJbeh+Z89PPHQRar+pZpBaJZCGUhOzUXz1Pkqi0DzsvSx90KSOgk
 u7n2asfUbOmoo97mZTosRucwfkotHjJLWJFEnEZD8qZ49Dkqhi8QHHfBtbATyX3U1iifZzoiS
 GGEu6NTEaBim28xEd9vE43cmw8wHOLmbPTwX1T0QegBrc=

Hi Andrea,

Am 10.05.24 um 16:35 schrieb Andrea della Porta:
> The BCM2712 SoC family can be found on Raspberry Pi 5.
> Add minimal SoC and board (Rpi5 specific) dts file to be able to
> boot from SD card and use console on debug UART.
>
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>   arch/arm64/boot/dts/broadcom/Makefile         |   1 +
>   .../boot/dts/broadcom/bcm2712-rpi-5-b.dts     |  62 ++++
>   arch/arm64/boot/dts/broadcom/bcm2712.dtsi     | 302 ++++++++++++++++++
>   3 files changed, 365 insertions(+)
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
> index 000000000000..b5921437e09f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
> @@ -0,0 +1,62 @@
> +// SPDX-License-Identifier: GPL-2.0
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
> +		serial10 =3D &uart0;
> +	};
> +
> +	chosen: chosen {
> +		stdout-path =3D "serial10:115200n8";
> +	};
> +
> +	/* Will be filled by the bootloader */
> +	memory@0 {
> +		device_type =3D "memory";
> +		reg =3D <0 0 0x28000000>;
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
> +		states =3D <1800000 0x1>,
> +			 <3300000 0x0>;
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
> +/* The system UART */
Not sure this comment is helpful. Debug UART?
> +&uart0 {
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
> index 000000000000..398df13148bd
> --- /dev/null
> +++ b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
> @@ -0,0 +1,302 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	compatible =3D "brcm,bcm2712";
> +
> +	#address-cells =3D <2>;
> +	#size-cells =3D <1>;
> +
> +	interrupt-parent =3D <&gicv2>;
> +
> +	axi: axi {
> +		compatible =3D "simple-bus";
> +		#address-cells =3D <2>;
> +		#size-cells =3D <1>;
> +		ranges;
> +
> +		sdio1: mmc@1000fff000 {
> +			compatible =3D "brcm,bcm2712-sdhci",
> +				     "brcm,sdhci-brcmstb";
> +			reg =3D <0x10 0x00fff000  0x260>,
> +			      <0x10 0x00fff400  0x200>;
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
> +			reg =3D <0x10 0x7fff9000  0x1000>,
> +			      <0x10 0x7fffa000  0x2000>,
> +			      <0x10 0x7fffc000  0x2000>,
> +			      <0x10 0x7fffe000  0x2000>;
> +			interrupts =3D <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) |
> +				      IRQ_TYPE_LEVEL_HIGH)>;
Please take care of the DTS coding style [1].
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
> +
> +		clk_uart: clk-uart {
> +			#clock-cells =3D <0>;
> +			compatible =3D "fixed-clock";
> +			clock-frequency =3D <9216000>;
> +			clock-output-names =3D "uart-clock";
> +		};
> +
> +		clk_emmc2: clk-emmc2 {
> +			#clock-cells =3D <0>;
> +			compatible =3D "fixed-clock";
> +			clock-frequency =3D <200000000>;
> +			clock-output-names =3D "emmc2-clock";
> +		};
> +	};
> +
> +	cpus: cpus {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		/* Source for d/i cache-line-size, cache-sets, cache-size
> +		 * https://developer.arm.com/documentation/100798/0401
> +		 * /L1-memory-system/About-the-L1-memory-system?lang=3Den
I think we should try to keep URLs in one line, even checkpatch
complains about it.

[1] - https://docs.kernel.org/devicetree/bindings/dts-coding-style.html
