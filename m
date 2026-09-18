Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E554B7A4F;
	Fri, 18 Sep 2026 10:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789726005; cv=none; b=T8jsSUp94deM3plRhOCVJg2DUA832XIJLzC8XU8O3CjQGk9pDxT9yfeI5uD4V+8jm7RK6lYNT6nsWbrp3h/h7Zk0a6jpPu1iq6bOwBANdtpWGrFFbzr4JL8aQeqVZqUv6cF8ESVkVCfcDvJe8sa6rdit950MWCA8qSilIOsypbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789726005; c=relaxed/simple;
	bh=hUbgB4sodNc1jQems6aJgXkb9FKq3ifZSsj8WpxvWk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUyLceIrZ0WM6JpS0C42FRcOCit4JP9NUFHascwZl+79BOzWTHh4BFzoOGTwb2gDWV0sFNzw9y/1GqwOy7hjRePLXivAdEZBlrGVCRYxBhjp30chk3ORmn6BFdBf2jQDtlc7i2gzsi8n6kMBmA5zaolsrkgk+Ij4aUL6NfXNWNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dUr5FLwC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUr5FLwC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F381F000FF;
	Fri, 18 Sep 2026 10:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789725989;
	bh=XeTScAV1898A4WeOOlldUoZmdDv0vu84oTioY4jjM/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dUr5FLwCO8pBLQtqTM8nFskrZqsevnG4lmAXiMPOdlyoVP9SH2MSJwetfUfAkcVpq
	 hacOyqBptnEwiXe7Ij5v3cgDvuj/JRUJ86pCYPi9FdYxg5FuSawLuwFRxGKg+ftufN
	 D41TN9Alg1lg72NQq01bIxwgAE65wtryKyM8ds8Ga915EqQhBkZhLmETr3o5OHal1e
	 uQrZxUs4WVxmENkpd9dGRyfumObmHA8x1YAiJBJILiYD6BgSfztzwKgc64zFr5Vocy
	 lvYv+bKq4KvsR+0okoDBDwW7dNYMWe2f2x2o03uLNXgHF0As+YY1La25RwayFDp0qK
	 Z1WiyPyIje4sw==
Date: Fri, 18 Sep 2026 12:06:26 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Muzaffer Kadir <muzafferkadir@mainlining.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Srinivas Kandagatla <srini@kernel.org>, 
	Ulf Hansson <ulfh@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Lee Jones <lee@kernel.org>, 
	Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
	Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Robert Marko <robimarko@gmail.com>, 
	Guru Das Srinagesh <linux@gurudas.dev>, Amit Kucheria <amitk@kernel.org>, 
	Thara Gopinath <thara.gopinath@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	David Heidelberg <david@ixit.cz>, Dang Huynh <danct12@riseup.net>, phone-devel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, iommu@lists.linux.dev, 
	mfd@lists.linux.dev, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-pm@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v2 19/19] arm64: dts: qcom: generalmobile-shamrock: new
 device
Message-ID: <20260918-therapeutic-hypnotic-orangutan-f7b9ad@quoll>
References: <20260916-msm8952-initial-support-v2-0-798c2602dde1@mainlining.org>
 <20260916-msm8952-initial-support-v2-19-798c2602dde1@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260916-msm8952-initial-support-v2-19-798c2602dde1@mainlining.org>

On Wed, Sep 16, 2026 at 05:22:24PM +0300, Muzaffer Kadir wrote:
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

button node before event, to keep things sorted by name


> +			label = "Volume Up";
> +			gpios = <&tlmm 85 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_VOLUMEUP>;
> +			debounce-interval = <15>;
> +			wakeup-source;
> +		};
> +	};
> +
> +	multi-led {
> +		compatible = "leds-group-multicolor";
> +		color = <LED_COLOR_ID_RGB>;
> +		function = LED_FUNCTION_INDICATOR;
> +		leds = <&red_status>, <&green_status>, <&blue_status>;
> +	};
> +
> +	reserved-memory {

Please run dt-check-style and fix some of the less disputable reported issues.

> +		cont_splash_mem: cont-splash@83200000 {
> +			reg = <0x0 0x83200000 0x0 (1080 * 1920 * 3)>;
> +			no-map;
> +		};
> +	};
> +
> +	vph_pwr: regulator-vph-pwr {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vph-pwr";
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +};
> +
> +&adsp {
> +	status = "okay";
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
> +&blsp2_i2c1 {
> +	status = "okay";
> +
> +	/* FUSB301 @25 USB-C Controller */
> +
> +	tpa6130a2: tpa6130a2@60 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
If you cannot find a name matching your device, please check in kernel
sources for similar cases or you can grow the spec (via pull request to
DT spec repo).

> +		compatible = "ti,tpa6130a2";
> +		pinctrl-0 = <&tpa6130a2_default>;
> +		pinctrl-names = "default";
> +		reg = <0x60>;
> +		power-gpio = <&tlmm 61 GPIO_ACTIVE_HIGH>;
> +		Vdd-supply = <&pm8950_l22>;
> +	};
> +
> +	tusb320: tusb320@67 {

Same here

Best regards,
Krzysztof

