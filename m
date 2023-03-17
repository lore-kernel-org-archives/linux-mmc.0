Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A408C6FD1D
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Mar 2023 11:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjCQLeo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Mar 2023 07:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjCQLeo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Mar 2023 07:34:44 -0400
X-Greylist: delayed 345 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 17 Mar 2023 04:34:07 PDT
Received: from m239-7.eu.mailgun.net (m239-7.eu.mailgun.net [185.250.239.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B900443923
        for <linux-mmc@vger.kernel.org>; Fri, 17 Mar 2023 04:34:06 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=hewittfamily.org.uk;
 q=dns/txt; s=s1; t=1679052803; x=1679060003; h=To: To: References:
 Message-Id: Content-Transfer-Encoding: Cc: Date: In-Reply-To: From: From:
 Subject: Subject: Mime-Version: Content-Type: Sender: Sender;
 bh=vzYD/MvgijTyNc01xjYglYr90mQ+xY3EBkTsGJwz2cE=;
 b=hx+v5oIcanYOjfvHOst5NAYS5WYe35dYv/Tcbwwi1Y7CMX2slI5sZ+WmIIktKb16sGWgxFfQktmlZM9nqxrFiLCf1jNW6SiHVRR0vMLaaTPlys51It+PFuCQnzxwDC1sdp/prDACsduNuzpM+yOP07KWLMssxo+kX6FrUIehX6LZZY5UjHuT5D0RYY4XtdJaJKPiw6SCdALVxO0WOlnNKMKdiHcQGFqUlYXkQKZsFMOgHxsO/trFieXR+bqdRbxJeFUHQt+yWVimgw59AKHMX75CtxmPP8NtdiwBcrIN3LKF1i+SNLVN1ySYWVj/fjYIqcv7FhJKEN9QLvTYDWYY4A==
X-Mailgun-Sending-Ip: 185.250.239.7
X-Mailgun-Sid: WyJiZmI5NCIsImxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmciLCJlMzcyMCJd
Received: from mail.hewittfamily.org.uk (<unknown> [87.200.95.144]) by 65d6cd48f507 with
 SMTP id 64144ed37874da449016e2a3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 17 Mar 2023 11:28:19 GMT
Sender: christian@hewittfamily.org.uk
Received: from smtpclient.apple (unknown [167.99.200.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.hewittfamily.org.uk (Postfix) with ESMTPSA id 1875C7F670C;
        Fri, 17 Mar 2023 15:28:13 +0400 (+04)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.2\))
Subject: Re: [PATCH] mmc: meson-gx: increase power-up delay
From:   Christian Hewitt <christian@hewittfamily.org.uk>
In-Reply-To: <7ac7d5c5-912b-7598-0050-3b8c76ef6cab@free.fr>
Date:   Fri, 17 Mar 2023 15:28:03 +0400
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Pierre-Hugues Husson <phh@phh.me>,
        Rong Chen <rong.chen@amlogic.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        MMC <linux-mmc@vger.kernel.org>,
        AML <linux-amlogic@lists.infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B7A94112-2215-4E0E-81B4-8E367920EFB0@hewittfamily.org.uk>
References: <11a8a0c8-a5b1-8f38-a139-97172ab7be68@free.fr>
 <0696106f-8d70-6410-999a-fcda6c5b39c2@gmail.com>
 <b6971cd6-80f2-522a-64fb-82b126500010@free.fr>
 <1jcz5axc8j.fsf@starbuckisacylon.baylibre.com>
 <CAPDyKFqYK2bEbkZ7A=t-VYwmgSYJUGxm2Ew5-7CFeO741fB-_w@mail.gmail.com>
 <7ac7d5c5-912b-7598-0050-3b8c76ef6cab@free.fr>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
X-Mailer: Apple Mail (2.3696.120.41.1.2)
X-Synology-Spam-Status: score=2.909, required 5, MV_CASE 0.5, __THREADED 0, TO_DN_ALL 0, FREEMAIL_TO 0, RCVD_COUNT_ZERO 0, FROM_EQ_ENVFROM 0, MIME_TRACE 0, __NOT_SPOOFED 0, __BODY_URI_ONLY 0, MID_RHS_MATCH_FROM 0, NO_RECEIVED -0.001, FROM_HAS_DN 0, FREEMAIL_ENVRCPT 0, TO_MATCH_ENVRCPT_ALL 0, TAGGED_RCPT 0, MIME_GOOD -0.1, RCPT_COUNT_TWELVE 0, __HDRS_LCASE_KNOWN 0, SUSPICIOUS_RECIPS 2.51
X-Synology-Spam-Flag: no
X-Synology-Virus-Status: no
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



> On 16 Mar 2023, at 8:32 pm, Marc Gonzalez <marc.w.gonzalez@free.fr> =
wrote:
>=20
> On 16/03/2023 12:59, Ulf Hansson wrote:
>=20
>> If the problem is regulator specific, this would be the correct thing =
to do.
>>=20
>> Although, if the problem is pwrseq specific, like that we need a =
delay
>> after enabling the clock and asserting the GPIO enable pin for the
>> WiFi chip, then we have the "post-power-on-delay-ms" of the pwrseq
>> node to play with instead.
>=20
> Heiner, Jerome, Uffe, Amlogic DT maintainers,
>=20
> Perhaps tweaking the driver for every user is too intrusive.
>=20
> Another solution would be to factorize all boards that implement
> the reference design SDIO-based RF (WiFi + BT using brcm).
>=20
> Then we can add post-power-on-delay-ms =3D 20 in sdio_pwrseq.
>=20
> NB: there's vddio_ao1v8 vs vddao_1v8 in sei510.
> Is my addition OK?

In LibreELEC we use a fairly minimal kernel defconfig; things are =
booting fast
compared to most desktop distro configs. I see occasional wireless =
issues with
cheap STB boards where SDIO speeds need to be reduced or UHS modes need =
to be
removed to keep things stable, but I don=E2=80=99t see SDIO probe issues =
with any of
the 30+ boards I do random testing with. The only SDIO drama in recent =
times
have been Heiner's IRQ changes (which are now resolved).

Are you using a real SEI510 board? ..I ask because we get lots of users =
with
random no-name Android boxes who try lots of dtb files until they come =
across
something that works; and there is a recurring trend where users have =
been
using SEI510 or SEI620 with poor results, and odd issues magically go =
away
once they are persuaded to use something else. So I have the impression =
those
specific device-trees aren=E2=80=99t well suited to typical reference =
design clones.

FWIW, I=E2=80=99ve also had thoughts about factoring aspects of WiFi =
support into a
few common dtsi files as there are increasing numbers of boxes/boards =
that
use Realtek or Qualcomm chips in circulation (due to post-covid chip =
supply
and pricing troubles). I would leave the sd_mmc_a node in the board =
files
since this is common (and in my experience works the same everywhere) =
while
moving the BT bits that need =E2=80=98compatible=E2=80=99 and GPIO =
details and the SDIO ID
poke and compatible (which isn=E2=80=99t really needed) to dtsi files. =
My goal would
be to make the copy/paste assembly of a new Android box dts even easier =
than
it already is.

If you don=E2=80=99t have an SEI510 board I have a hunch you=E2=80=99d =
be better off with
another device-tree as the source/base for your board. If you=E2=80=99re =
able to
share the schematics (privately if preferred) I=E2=80=99d be interested =
in seeing
what other dtb's could be used; and perhaps getting you to boot a =
LibreELEC
test image on your board to see whether my codebase gives same or =
different
results?

Christian

> RFC prototype:
>=20
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-radxa-zero.dts =
b/arch/arm64/boot/dts/amlogic/meson-g12a-radxa-zero.dts
> index e3bb6df42ff3e..42b5dcf358912 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12a-radxa-zero.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a-radxa-zero.dts
> @@ -6,6 +6,7 @@
> /dts-v1/;
>=20
> #include "meson-g12a.dtsi"
> +#include "meson-g12a-ref-design-brcm-rf.dtsi"
> #include <dt-bindings/gpio/meson-g12a-gpio.h>
> #include <dt-bindings/sound/meson-g12a-tohdmitx.h>
>=20
> @@ -53,13 +54,6 @@ emmc_pwrseq: emmc-pwrseq {
> 		reset-gpios =3D <&gpio BOOT_12 GPIO_ACTIVE_LOW>;
> 	};
>=20
> -	sdio_pwrseq: sdio-pwrseq {
> -		compatible =3D "mmc-pwrseq-simple";
> -		reset-gpios =3D <&gpio GPIOX_6 GPIO_ACTIVE_LOW>;
> -		clocks =3D <&wifi32k>;
> -		clock-names =3D "ext_clock";
> -	};
> -
> 	ao_5v: regulator-ao_5v {
> 		compatible =3D "regulator-fixed";
> 		regulator-name =3D "AO_5V";
> @@ -182,13 +176,6 @@ codec {
> 			};
> 		};
> 	};
> -
> -	wifi32k: wifi32k {
> -		compatible =3D "pwm-clock";
> -		#clock-cells =3D <0>;
> -		clock-frequency =3D <32768>;
> -		pwms =3D <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
> -	};
> };
>=20
> &arb {
> @@ -299,37 +286,6 @@ &saradc {
> 	vref-supply =3D <&vddao_1v8>;
> };
>=20
> -/* SDIO */
> -&sd_emmc_a {
> -	status =3D "okay";
> -	pinctrl-0 =3D <&sdio_pins>;
> -	pinctrl-1 =3D <&sdio_clk_gate_pins>;
> -	pinctrl-names =3D "default", "clk-gate";
> -	#address-cells =3D <1>;
> -	#size-cells =3D <0>;
> -
> -	bus-width =3D <4>;
> -	cap-sd-highspeed;
> -	sd-uhs-sdr50;
> -	max-frequency =3D <100000000>;
> -
> -	non-removable;
> -	disable-wp;
> -
> -	/* WiFi firmware requires power to be kept while in suspend */
> -	keep-power-in-suspend;
> -
> -	mmc-pwrseq =3D <&sdio_pwrseq>;
> -
> -	vmmc-supply =3D <&vddao_3v3>;
> -	vqmmc-supply =3D <&vddao_1v8>;
> -
> -	brcmf: wifi@1 {
> -		reg =3D <1>;
> -		compatible =3D "brcm,bcm4329-fmac";
> -	};
> -};
> -
> /* SD card */
> &sd_emmc_b {
> 	status =3D "okay";
> diff --git =
a/arch/arm64/boot/dts/amlogic/meson-g12a-ref-design-brcm-rf.dtsi =
b/arch/arm64/boot/dts/amlogic/meson-g12a-ref-design-brcm-rf.dtsi
> new file mode 100644
> index 0000000000000..e462324596964
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a-ref-design-brcm-rf.dtsi
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2018 Amlogic, Inc. All rights reserved.
> + */
> +
> +#include <dt-bindings/gpio/meson-g12a-gpio.h>
> +
> +/ {
> +	sdio_pwrseq: sdio-pwrseq {
> +		compatible =3D "mmc-pwrseq-simple";
> +		reset-gpios =3D <&gpio GPIOX_6 GPIO_ACTIVE_LOW>;
> +		clocks =3D <&wifi32k>;
> +		clock-names =3D "ext_clock";
> +	};
> +
> +	wifi32k: wifi32k {
> +		compatible =3D "pwm-clock";
> +		#clock-cells =3D <0>;
> +		clock-frequency =3D <32768>;
> +		pwms =3D <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
> +	};
> +};
> +
> +/* SDIO */
> +&sd_emmc_a {
> +	status =3D "okay";
> +	pinctrl-0 =3D <&sdio_pins>;
> +	pinctrl-1 =3D <&sdio_clk_gate_pins>;
> +	pinctrl-names =3D "default", "clk-gate";
> +	#address-cells =3D <1>;
> +	#size-cells =3D <0>;
> +
> +	bus-width =3D <4>;
> +	cap-sd-highspeed;
> +	sd-uhs-sdr50;
> +	max-frequency =3D <100000000>;
> +
> +	non-removable;
> +	disable-wp;
> +
> +	/* WiFi firmware requires power to be kept while in suspend */
> +	keep-power-in-suspend;
> +
> +	mmc-pwrseq =3D <&sdio_pwrseq>;
> +
> +	vmmc-supply =3D <&vddao_3v3>;
> +	vqmmc-supply =3D <&vddao_1v8>;
> +
> +	brcmf: wifi@1 {
> +		reg =3D <1>;
> +		compatible =3D "brcm,bcm4329-fmac";
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts =
b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
> index 23b790c6469d3..e12aeb956b7d7 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
> @@ -6,6 +6,7 @@
> /dts-v1/;
>=20
> #include "meson-g12a.dtsi"
> +#include "meson-g12a-ref-design-brcm-rf.dtsi"
> #include <dt-bindings/gpio/gpio.h>
> #include <dt-bindings/input/input.h>
> #include <dt-bindings/gpio/meson-g12a-gpio.h>
> @@ -96,6 +97,15 @@ emmc_1v8: regulator-emmc_1v8 {
> 		regulator-always-on;
> 	};
>=20
> +	vddao_1v8: regulator-vddao_1v8 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "VDDAO_1V8";
> +		regulator-min-microvolt =3D <1800000>;
> +		regulator-max-microvolt =3D <1800000>;
> +		vin-supply =3D <&vddao_3v3>;
> +		regulator-always-on;
> +	};
> +
> 	vddao_3v3: regulator-vddao_3v3 {
> 		compatible =3D "regulator-fixed";
> 		regulator-name =3D "VDDAO_3V3";
> @@ -143,20 +153,6 @@ vddio_ao1v8: regulator-vddio_ao1v8 {
> 		regulator-always-on;
> 	};
>=20
> -	sdio_pwrseq: sdio-pwrseq {
> -		compatible =3D "mmc-pwrseq-simple";
> -		reset-gpios =3D <&gpio GPIOX_6 GPIO_ACTIVE_LOW>;
> -		clocks =3D <&wifi32k>;
> -		clock-names =3D "ext_clock";
> -	};
> -
> -	wifi32k: wifi32k {
> -		compatible =3D "pwm-clock";
> -		#clock-cells =3D <0>;
> -		clock-frequency =3D <32768>;
> -		pwms =3D <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
> -	};
> -
> 	sound {
> 		compatible =3D "amlogic,axg-sound-card";
> 		model =3D "SEI510";
> @@ -375,37 +371,6 @@ &saradc {
> 	vref-supply =3D <&vddio_ao1v8>;
> };
>=20
> -/* SDIO */
> -&sd_emmc_a {
> -	status =3D "okay";
> -	pinctrl-0 =3D <&sdio_pins>;
> -	pinctrl-1 =3D <&sdio_clk_gate_pins>;
> -	pinctrl-names =3D "default", "clk-gate";
> -	#address-cells =3D <1>;
> -	#size-cells =3D <0>;
> -
> -	bus-width =3D <4>;
> -	cap-sd-highspeed;
> -	sd-uhs-sdr50;
> -	max-frequency =3D <100000000>;
> -
> -	non-removable;
> -	disable-wp;
> -
> -	/* WiFi firmware requires power to be kept while in suspend */
> -	keep-power-in-suspend;
> -
> -	mmc-pwrseq =3D <&sdio_pwrseq>;
> -
> -	vmmc-supply =3D <&vddao_3v3>;
> -	vqmmc-supply =3D <&vddio_ao1v8>;
> -
> -	brcmf: wifi@1 {
> -		reg =3D <1>;
> -		compatible =3D "brcm,bcm4329-fmac";
> -	};
> -};
> -
> /* SD card */
> &sd_emmc_b {
> 	status =3D "okay";
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts =
b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
> index b2bb94981838f..68a8876386115 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
> @@ -6,6 +6,7 @@
> /dts-v1/;
>=20
> #include "meson-g12a.dtsi"
> +#include "meson-g12a-ref-design-brcm-rf.dtsi"
> #include <dt-bindings/gpio/gpio.h>
> #include <dt-bindings/gpio/meson-g12a-gpio.h>
> #include <dt-bindings/sound/meson-g12a-tohdmitx.h>
> @@ -60,13 +61,6 @@ emmc_pwrseq: emmc-pwrseq {
> 		reset-gpios =3D <&gpio BOOT_12 GPIO_ACTIVE_LOW>;
> 	};
>=20
> -	sdio_pwrseq: sdio-pwrseq {
> -		compatible =3D "mmc-pwrseq-simple";
> -		reset-gpios =3D <&gpio GPIOX_6 GPIO_ACTIVE_LOW>;
> -		clocks =3D <&wifi32k>;
> -		clock-names =3D "ext_clock";
> -	};
> -
> 	flash_1v8: regulator-flash_1v8 {
> 		compatible =3D "regulator-fixed";
> 		regulator-name =3D "FLASH_1V8";
> @@ -226,13 +220,6 @@ codec {
> 			};
> 		};
> 	};
> -
> -	wifi32k: wifi32k {
> -		compatible =3D "pwm-clock";
> -		#clock-cells =3D <0>;
> -		clock-frequency =3D <32768>;
> -		pwms =3D <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
> -	};
> };
>=20
> &arb {
> @@ -391,37 +378,6 @@ &usb {
> 	dr_mode =3D "host";
> };
>=20
> -/* SDIO */
> -&sd_emmc_a {
> -	status =3D "okay";
> -	pinctrl-0 =3D <&sdio_pins>;
> -	pinctrl-1 =3D <&sdio_clk_gate_pins>;
> -	pinctrl-names =3D "default", "clk-gate";
> -	#address-cells =3D <1>;
> -	#size-cells =3D <0>;
> -
> -	bus-width =3D <4>;
> -	cap-sd-highspeed;
> -	sd-uhs-sdr50;
> -	max-frequency =3D <100000000>;
> -
> -	non-removable;
> -	disable-wp;
> -
> -	/* WiFi firmware requires power to be kept while in suspend */
> -	keep-power-in-suspend;
> -
> -	mmc-pwrseq =3D <&sdio_pwrseq>;
> -
> -	vmmc-supply =3D <&vddao_3v3>;
> -	vqmmc-supply =3D <&vddao_1v8>;
> -
> -	brcmf: wifi@1 {
> -		reg =3D <1>;
> -		compatible =3D "brcm,bcm4329-fmac";
> -	};
> -};
> -
> /* SD card */
> &sd_emmc_b {
> 	status =3D "okay";
>=20
>=20
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

