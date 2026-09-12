Received: from ixit.cz (ixit.cz [84.42.129.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEE7202F71;
	Sat, 12 Sep 2026 15:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.42.129.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789228039; cv=none; b=EBS2S2SRTF7kKGv4Byauzd13ZzF2NnRUoFotHb7tcOhQNVS1AjG6gMICnX9WNwLyZpRTPn+WgBxzdxoIP1sYI5YZSlbdWnvu7bdjiDDGuaRL+L++3rIqtQr1d97P5TL8prj2RLVhXYQP9fSc4rNS8e4PO5I/j8xYK5QPt5QC6Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789228039; c=relaxed/simple;
	bh=QxTlCoaF6PxewkJ90Z1sSkAchWr+sUp8WmwgtcwEe0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X+E5bT2XB8JeXpc9V5NffTuUl6PBBpdpjPOk6E5N8l1SQTnKUQKlk7xNClNAAoZxdueQgET6iFMMv9Ww8YKVR9G17HR/L6WN18b4gSLfeEcQ+t7Tw842IrPKvhp4DoCpnznnqKbupq9amqyjTM6GT8u3le2jqJCRoHhNYxYQS+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz; spf=pass smtp.mailfrom=ixit.cz; dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b=cuPiBpHp; arc=none smtp.client-ip=84.42.129.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="cuPiBpHp"
Received: from [IPV6:2a02:830a:f787:8f00:d622:eaa3:3dd6:8f5e] (unknown [IPv6:2a02:830a:f787:8f00:d622:eaa3:3dd6:8f5e])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id DA2C35340134;
	Sat, 12 Sep 2026 17:47:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1789228032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Em3f+na9kZ8GklQJBJybnG4k2BDFdfDVOkR3nGPC46c=;
	b=cuPiBpHpSHRW0AH0j0/osvF9MxUQImG7P8EVikR1et7G/WdsxunDQ19xZViwp/xlxyLtgv
	O7iz3pDC1+1beAZn1wi0sj7+LLGgBGWkQsXUsGWVbYjR6R/VwUZ/6FYj1wXIXxuJ8gGg6/
	aFASzP0BDkOKIbNbikeo7WaIJd21850=
Message-ID: <9d2c5d44-206f-4ae9-b340-ba1994e234bf@ixit.cz>
Date: Sat, 12 Sep 2026 17:47:11 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 20/20] arm64: dts: qcom: generalmobile-shamrock: new
 device
To: muzafferkadir@mainlining.org, Bjorn Andersson <andersson@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Srinivas Kandagatla <srini@kernel.org>,
 Ulf Hansson <ulfh@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Lee Jones <lee@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Robert Marko <robimarko@gmail.com>, Guru Das Srinagesh <linux@gurudas.dev>,
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Kees Cook <kees@kernel.org>,
 Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Dang Huynh <danct12@riseup.net>, phone-devel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, iommu@lists.linux.dev, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org,
 linux-input@vger.kernel.org
References: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
 <20260912-msm8952-initial-support-v1-20-0e742578b524@mainlining.org>
Content-Language: en-US, cs-CZ
From: David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 xsFNBF5v1x4BEADS3EddwsNsvVAI1XF8uQKbdYPY/GhjaSLziwVnbwv5BGwqB1tfXoHnccoA
 9kTgKAbiXG/CiZFhD6l4WCIskQDKzyQN3JhCUIxh16Xyw0lECI7iqoW9LmMoN1dNKcUmCO9g
 lZxQaOl+1bY/7ttd7DapLh9rmBXJ2lKiMEaIpUwb/Nw0d7Enp4Jy2TpkhPywIpUn8CoJCv3/
 61qbvI9y5utB/UhfMAUXsaAgwEJyGPAqHlC0YZjaTwOu+YQUE3AFzhCbksq95CwDz4U4gdls
 dmv9tkATfu2OmzERZQ6vJTehK0Pu4l5KmCAzYg42I9Dy4E6b17x6NncKbcByQFOXMtG0qVUk
 F1yeeOQUHwu+8t3ZDMBUhCkRL/juuoqLmyDWKMc0hKNNeZ9BNXgB8fXkRLWEUfgDXsFyEkKp
 NxUy5bDRlivf6XfExnikk5kj9l2gGlNQwqROti/46bfbmlmc/a2GM4k8ZyalHNEAdwtXYSpP
 8JJmlbQ7hNTLkc3HQLRsIocN5th/ur7pPMz1Beyp0gbE9GcOceqmdZQB80vJ01XDyCAihf6l
 AMnzwpXZsjqIqH9r7T7tM6tVEVbPSwPt4eZYXSoJijEBC/43TBbmxDX+5+3txRaSCRQrG9dY
 k3mMGM3xJLCps2KnaqMcgUnvb1KdTgEFUZQaItw7HyRd6RppewARAQABzSBEYXZpZCBIZWlk
 ZWxiZXJnIDxkYXZpZEBpeGl0LmN6PsLBlAQTAQgAPgIbAwULCQgHAgYVCgkICwIEFgIDAQIe
 AQIXgBYhBNd6Cc/u3Cu9U6cEdGACP8TTSSByBQJl+KksBQkPDaAOAAoJEGACP8TTSSBy6IAQ
 AMqFqVi9LLxCEcUWBn82ssQGiVSDniKpFE/tp7lMXflwhjD5xoftoWOmMYkiWE86t5x5Fsp7
 afALx7SEDz599F1K1bLnaga+budu55JEAYGudD2WwpLJ0kPzRhqBwGFIx8k6F+goZJzxPDsf
 loAtXQE62UvEKa4KRRcZmF0GGoRsgA7vE7OnV8LMeocdD3eb2CuXLzauHAfdvqF50IfPH/sE
 jbzROiAZU+WgrwU946aOzrN8jVU+Cy8XAccGAZxsmPBfhTY5f2VN1IqvfaRdkKKlmWVJWGw+
 ycFpAEJKFRdfcc5PSjUJcALn5C+hxzL2hBpIZJdfdfStn+DWHXNgBeRDiZj1x6vvyaC43RAb
 VXvRzOQfG4EaMVMIOvBjBA/FtIpb1gtXA42ewhvPnd5RVCqD9YYUxsVpJ9d+XsAy7uib3BsV
 W2idAEsPtoqhVhq8bCUs/G4sC2DdyGZK8MRFDJqciJSUbqA+5z1ZCuE8UOPDpZKiW6H/OuOM
 zDcjh0lOzr4p+/1TSg1PbUh7fQ+nbMuiT044sC1lLtJK0+Zyn0GwhR82oNM4fldNsaHRW42w
 QGD35+eNo5Pvb3We5XRMlBdhFnj7Siggp4J8/PJ6MJvRyC+RIJPGtbdMB2/RxWunFLn87e5w
 UgwR9jPMHAstuTR1yR23c4SIYoQ2fzkrRzuazsFNBF5v1x4BEADnlrbta2WL87BlEOotZUh0
 zXANMrNV15WxexsirLetfqbs0AGCaTRNj+uWlTUDJRXOVIwzmF76Us3I2796+Od2ocNpLheZ
 7EIkq8budtLVd1c06qJ+GMraz51zfgSIazVInNMPk9T6fz0lembji5yEcNPNNBA4sHiFmXfo
 IhepHFOBApjS0CiOPqowYxSTPe/DLcJ/LDwWpTi37doKPhBwlHev1BwVCbrLEIFjY0MLM0aT
 jiBBlyLJaTqvE48gblonu2SGaNmGtkC3VoQUQFcVYDXtlL9CVbNo7BAt5gwPcNqEqkUL60Jh
 FtvVSKyQh6gn7HHsyMtgltjZ3NKjv8S3yQd7zxvCn79tCKwoeNevsvoMq/bzlKxc9QiKaRPO
 aDj3FtW7R/3XoKJBY8Hckyug6uc2qYWRpnuXc0as6S0wfek6gauExUttBKrtSbPPHiuTeNHt
 NsT4+dyvaJtQKPBTbPHkXpTO8e1+YAg7kPj3aKFToE/dakIh8iqUHLNxywDAamRVn8Ha67WO
 AEAA3iklJ49QQk2ZyS1RJ2Ul28ePFDZ3QSr9LoJiOBZv9XkbhXS164iRB7rBZk6ZRVgCz3V6
 hhhjkipYvpJ/fpjXNsVL8jvel1mYNf0a46T4QQDQx4KQj0zXJbC2fFikAtu1AULktF4iEXEI
 rSjFoqhd4euZ+QARAQABwsF8BBgBCAAmAhsMFiEE13oJz+7cK71TpwR0YAI/xNNJIHIFAmX4
 qVAFCQ8NoDIACgkQYAI/xNNJIHKN4A/+Ine2Ii7JiuGITjJkcV6pgKlfwYdEs4eFD1pTRb/K
 5dprUz3QSLP41u9OJQ23HnESMvn31UENk9ffebNoW7WxZ/8cTQY0JY/cgTTrlNXtyAlGbR3/
 3Q/VBJptf04Er7I6TaKAmqWzdVeKTw33LljpkHp02vrbOdylb4JQG/SginLV9purGAFptYRO
 8JNa2J4FAQtQTrfOUjulOWMxy7XRkqK3QqLcPW79/CFn7q1yxamPkpoXUJq9/fVjlhk7P+da
 NYQpe4WQQnktBY29SkFnvfIAwqIVU8ix5Oz8rghuCcAdR7lEJ7hCX9bR0EE05FOXdZy5FWL9
 GHvFa/Opkq3DPmFl/0nt4HJqq1Nwrr+WR6d0414oo1n2hPEllge/6iD3ZYwptTvOFKEw/v0A
 yqOoYSiKX9F7Ko7QO+VnYeVDsDDevKic2T/4GDpcSVd9ipiKxCQvUAzKUH7RUpqDTa+rYurm
 zRKcgRumz2Tc1ouHj6qINlzEe3a5ldctIn/dvR1l2Ko7GBTG+VGp9U5NOAEkGpxHG9yg6eeY
 fFYnMme51H/HKiyUlFiE3yd5LSmv8Dhbf+vsI4x6BOOOq4Iyop/Exavj1owGxW0hpdUGcCl1
 ovlwVPO/6l/XLAmSGwdnGqok5eGZQzSst0tj9RC9O0dXO1TZocOsf0tJ8dR2egX4kxM=
In-Reply-To: <20260912-msm8952-initial-support-v1-20-0e742578b524@mainlining.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/09/2026 10:39, Muzaffer Kadir via B4 Relay wrote:
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
> 
> Add General Mobile Shamrock (GM 5 Plus).
> Shamrock is designed similar to L9300.
> Downstream reference is [1].
> 
> [1] https://github.com/Asderdd/android_kernel_generalmobile_shamrock/blob/cm-14.1/arch/arm/boot/dts/qcom/msm8952-l9300.dtsi
> 
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
> ---
>   arch/arm64/boot/dts/qcom/Makefile                  |   1 +
>   .../dts/qcom/msm8952-generalmobile-shamrock.dts    | 426 +++++++++++++++++++++
>   2 files changed, 427 insertions(+)
> 

Happy to see this series! Amazing work!

Few comments below:

> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index d6547fb18edf..3cc2dfb09116 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -125,6 +125,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-samsung-a7.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-sony-xperia-kanuti-tulip.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-wingtech-wt82918.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-wingtech-wt82918hd.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= msm8952-generalmobile-shamrock.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-flipkart-rimob.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-motorola-potter.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-daisy.dtb
> diff --git a/arch/arm64/boot/dts/qcom/msm8952-generalmobile-shamrock.dts b/arch/arm64/boot/dts/qcom/msm8952-generalmobile-shamrock.dts
> new file mode 100644
> index 000000000000..22723b62d3d6
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8952-generalmobile-shamrock.dts
> @@ -0,0 +1,426 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/dts-v1/;
> +
> +#include "msm8952.dtsi"
> +#include "pm8950.dtsi"
> +#include "pmi8950.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +
> +/ {
> +	model = "General Mobile GM 5 Plus (shamrock)";
> +	compatible = "generalmobile,shamrock", "qcom,msm8952";
> +	qcom,msm-id = <QCOM_ID_MSM8952 0x0>;
> +	qcom,board-id = <QCOM_BOARD_ID_QRD 1>;
> +	chassis-type = "handset";
> +
> +	aliases {
> +		mmc0 = &sdhc_1; /* SDC1 eMMC slot */
> +		mmc1 = &sdhc_2; /* SDC2 SD card slot */
> +		serial0 = &blsp1_uart2;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +
> +		framebuffer {
> +			compatible = "simple-framebuffer";
> +			memory-region = <&cont_splash_mem>;
> +
> +			width = <1080>;
> +			height = <1920>;
> +			stride = <(1080 * 3)>;
> +			format = "r8g8b8";
> +
> +			power-domains = <&gcc MDSS_GDSC>;
> +
> +			clocks = <&gcc GCC_MDSS_AHB_CLK>,
> +					 <&gcc GCC_MDSS_AXI_CLK>,
> +					 <&gcc GCC_MDSS_VSYNC_CLK>,
> +					 <&gcc GCC_MDSS_MDP_CLK>,
> +					 <&gcc GCC_MDSS_BYTE0_CLK>,
> +					 <&gcc GCC_MDSS_PCLK0_CLK>,
> +					 <&gcc GCC_MDSS_ESC0_CLK>;
> +		};
> +	};
> +
> +	reserved-memory {
> +		cont_splash_mem: cont-splash@83200000 {
> +			reg = <0x0 0x83200000 0x0 (1080 * 1920 * 3)>;
> +			no-map;
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		pinctrl-0 = <&gpio_hall_sensor_default>, <&gpio_keys_default>;
> +		pinctrl-names = "default";
> +
> +		event-hall-sensor {
> +			label = "Hall Effect Sensor";
> +			gpios = <&tlmm 46 GPIO_ACTIVE_LOW>;
> +			linux,input-type = <EV_SW>;
> +			linux,code = <SW_LID>;
> +			linux,can-disable;
> +			wakeup-source;
> +		};
> +
> +		button-volume-up {
> +			label = "Volume Up";
> +			gpios = <&tlmm 85 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_VOLUMEUP>;
> +			debounce-interval = <15>;
> +			wakeup-source;
> +		};
> +	};
> +
> +	/* Front Flash */
> +	flash-led-controller {
> +		compatible = "sgmicro,sgm3140";
> +
> +		enable-gpios = <&tlmm 33 GPIO_ACTIVE_HIGH>;
> +		flash-gpios = <&tlmm 128 GPIO_ACTIVE_HIGH>;
> +
> +		pinctrl-0 = <&front_flash_default>;
> +		pinctrl-names = "default";
> +
> +		front_flash_led: led {
> +			function = LED_FUNCTION_FLASH;
> +			color = <LED_COLOR_ID_WHITE>;
> +			flash-max-microamp = <1000000>;
> +			led-max-microamp = <625000>;
> +			flash-max-timeout-us = <1280000>;
> +		};
> +	};
> +
> +	battery: battery {
> +		compatible = "simple-battery";
> +
> +		charge-term-current-microamp = <100000>;
> +		charge-full-design-microamp-hours = <3100000>;
> +		constant-charge-current-max-microamp = <3000000>;
> +		constant-charge-voltage-max-microvolt = <4400000>;
> +		voltage-min-design-microvolt = <3400000>;
> +		voltage-max-design-microvolt = <4400000>;
> +	};
> +
> +	vph_pwr: regulator-vph-pwr {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vph-pwr";
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	multi-led {
> +		compatible = "leds-group-multicolor";
> +		color = <LED_COLOR_ID_RGB>;
> +		function = LED_FUNCTION_INDICATOR;
> +		leds = <&red_status>, <&green_status>, <&blue_status>;
> +	};
> +
> +};
> +
> +&blsp2_i2c1 {
> +	status = "okay";
> +
> +	/* FUSB301 @25 USB-C Controller */
> +
> +	tpa6130a2: tpa6130a2@60 {
> +		compatible = "ti,tpa6130a2";
> +		pinctrl-0 = <&tpa6130a2_default>;
> +		pinctrl-names = "default";
> +		reg = <0x60>;
> +		power-gpios = <&tlmm 61 GPIO_ACTIVE_HIGH>;
> +		Vdd-supply = <&pm8950_l22>;
> +	};
> +
> +	tusb320: tusb320@67 {
> +		compatible = "ti,tusb320";
> +		reg = <0x67>;
> +		interrupts-extended = <&tlmm 45 IRQ_TYPE_EDGE_RISING>;
> +	};
> +
> +	led-controller@68 {
> +		compatible = "si-en,sn3193";
> +		reg = <0x68>;
> +
> +		shutdown-gpios = <&tlmm 68 GPIO_ACTIVE_HIGH>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		red_status: led@1 {
> +			reg = <1>;
> +			label = "red:status";
> +			led-max-microamp = <17500>;
> +		};
> +
> +		green_status: led@2 {
> +			reg = <2>;
> +			label = "green:status";
> +			led-max-microamp = <17500>;
> +		};
> +
> +		blue_status: led@3 {
> +			reg = <3>;
> +			label = "blue:status";
> +			led-max-microamp = <17500>;
> +		};
> +	};
> +};
> +
> +&blsp1_i2c2 {
> +	status = "okay";
> +	/* SMB1351 @1d charger */
> +	/* wsa881x-i2c @e @44 @f @45 audio amplifier */
> +};
> +
> +&blsp1_i2c3 {
> +	status = "okay";
> +
> +	/* himax,852x@48 Touchscreen */
> +
> +	touchscreen@5d {
> +		compatible = "goodix,gt970", "goodix,gt911";
> +		reg = <0x5d>;
> +		interrupts-extended = <&tlmm 65 IRQ_TYPE_EDGE_FALLING>;
> +		irq-gpios = <&tlmm 65 GPIO_ACTIVE_HIGH>;
> +		reset-gpios = <&tlmm 64 GPIO_ACTIVE_HIGH>;
> +		AVDD28-supply = <&pm8950_l10>;
> +		VDDIO-supply = <&pm8950_l6>;
> +
> +		pinctrl-0 = <&touchscreen_default>;
> +		pinctrl-names = "default";
> +
> +		touchscreen-size-x = <1080>;
> +		touchscreen-size-y = <1920>;
> +	};
> +};
> +
> +&pm8950_resin {
> +	linux,code = <KEY_VOLUMEDOWN>;
> +
> +	status = "okay";
> +};
> +
> +&sdhc_1 {
> +	vmmc-supply = <&pm8950_l8>;
> +	vqmmc-supply = <&pm8950_l5>;
> +
> +	status = "okay";
> +};
> +
> +&sdhc_2 {
> +	cd-gpios = <&tlmm 67 GPIO_ACTIVE_HIGH>;
> +	vmmc-supply = <&pm8950_l11>;
> +	vqmmc-supply = <&pm8950_l12>;
> +
> +	status = "okay";
> +};
> +
> +&sdc2_cd_on {
> +	/delete-property/ bias-pull-up;
> +	bias-disable;
> +};
> +
> +&pmi8950_wled {
> +	qcom,enabled-strings = <0 1>;
> +	qcom,current-limit-microamp = <30000>;
> +	qcom,ovp-millivolt = <29500>;
> +	qcom,external-pfet;
> +
> +	status = "okay";
> +};
> +
> +&ramoops_mem {
> +	status = "okay";
> +};
> +
> +&adsp {
> +	status = "okay";
> +};
> +
> +&lpass_mem {
> +	status = "okay";
> +};
> +
> +&pm8950_spmi_regulators {
> +	// PM8950 S5 + S6 = VDD_APC supply
/* */ format> +	pm8950_s5: s5 {
> +		regulator-min-microvolt = <1050000>;
> +		regulator-max-microvolt = <1350000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +};
> +
> +&rpm_requests {
> +	pm8950_rpm_regulators: regulators {
> +		compatible = "qcom,rpm-pm8950-regulators";
> +		vdd_s1-supply = <&vph_pwr>;
> +		vdd_s2-supply = <&vph_pwr>;
> +		vdd_s3-supply = <&vph_pwr>;
> +		vdd_s4-supply = <&vph_pwr>;
> +		vdd_s6-supply = <&vph_pwr>;
> +		vdd_l1_l19-supply = <&pm8950_s3>;
> +		vdd_l2_l23-supply = <&pm8950_s3>;
> +		vdd_l3-supply = <&pm8950_s3>;
> +		vdd_l5_l6_l7_l16-supply = <&pm8950_s4>;
> +		vdd_l8_l11_l12_l17_l22-supply = <&vph_pwr>;
> +		vdd_l9_l10_l13_l14_l15_l18-supply = <&vph_pwr>;
> +
> +		pm8950_s1: s1 {
> +			regulator-min-microvolt = <1000000>;
> +			regulator-max-microvolt = <1225000>;
> +		};
> +
> +		pm8950_s3: s3 {
> +			regulator-min-microvolt = <1300000>;
> +			regulator-max-microvolt = <1300000>;
> +		};
> +		pm8950_s4: s4 {
> +			regulator-min-microvolt = <2050000>;
> +			regulator-max-microvolt = <2050000>;
> +		};
> +
> +		pm8950_l2: l2 {
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-always-on;
> +			regulator-boot-on;
> +		};
> +
> +		/* pm8950_l3 is managed by rpmpd (RPMPD_VDDMX) */
> +
> +		pm8950_l5: l5 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +		};
> +
> +		pm8950_l6: l6 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +		};
> +
> +		pm8950_l7: l7 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +		};
> +
> +		pm8950_l8: l8 {
> +			regulator-min-microvolt = <2850000>;
> +			regulator-max-microvolt = <2900000>;
> +		};
> +
> +		pm8950_l9: l9 {
> +			regulator-min-microvolt = <3000000>;
> +			regulator-max-microvolt = <3300000>;
> +		};
> +
> +		pm8950_l10: l10 {
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <2800000>;
> +		};
> +
> +		pm8950_l11: l11 {
> +			regulator-min-microvolt = <2950000>;
> +			regulator-max-microvolt = <2950000>;
> +			regulator-allow-set-load;
> +			regulator-system-load = <200000>;
> +		};
> +
> +		pm8950_l12: l12 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <2950000>;
> +		};
> +
> +		pm8950_l13: l13 {
> +			regulator-min-microvolt = <3075000>;
> +			regulator-max-microvolt = <3075000>;
> +		};
> +
> +		pm8950_l14: l14 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <3300000>;
> +		};
> +
> +		pm8950_l15: l15 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <3300000>;
> +		};
> +
> +		pm8950_l16: l16 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +		};
> +
> +		pm8950_l17: l17 {
> +			regulator-min-microvolt = <2850000>;
> +			regulator-max-microvolt = <2850000>;
> +		};
> +
> +		pm8950_l19: l19 {
> +			regulator-min-microvolt = <1225000>;
> +			regulator-max-microvolt = <1350000>;
> +		};
> +
> +		pm8950_l22: l22 {
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <2800000>;
> +		};
> +
> +		pm8950_l23: l23 {
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +		};
> +	};
> +};
> +
> +&tlmm {
> +	gpio-reserved-ranges = <20 4>; // Downstream doesn't use 21,22,23. 24 is mdss_te

No need to mention 24 here, but you should mention what's connected there. (and 
comments /* */ )
> +	gpio_hall_sensor_default: gpio-hall-sensor-default-state {
> +		pins = "gpio46";

Sort the entries by gpio numbers please

> +		function = "gpio";
> +		drive-strength = <6>;
> +		bias-pull-up;
> +	};
> +
> +	front_flash_default: front-flash-default-state {
> +		pins = "gpio33", "gpio128";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
> +
> +	gpio_keys_default: gpio-keys-default-state {
> +		pins = "gpio85";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-up;
> +	};
> +
> +	touchscreen_default: touchscreen-default-state {
> +		pins = "gpio65", "gpio64";

also pins should be sorted by number too, or each described by *-pins property 
inside the state (if you have more information about the usage, e.g. reset/irq 
function)

> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	tpa6130a2_default: tpa6130a2-default-state {
> +		pins = "gpio61";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		bias-pull-down;
> +		output-low;
> +	};
> +};
> +
> +&sleep_clk {
> +	clock-frequency = <32768>;
> +};
> +
> +&xo_board {
> +	clock-frequency = <19200000>;
> +};
> 

