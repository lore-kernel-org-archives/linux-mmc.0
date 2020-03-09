Return-Path: <SRS0=Ofta=42=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5EDC10F27
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Mar 2020 20:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6074924671
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Mar 2020 20:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgCIUAQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 9 Mar 2020 16:00:16 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:36757 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgCIUAP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Mar 2020 16:00:15 -0400
Received: from [192.168.1.183] ([37.4.249.171]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MKbXu-1iuygH0Nf2-00Kyiu; Mon, 09 Mar 2020 21:00:01 +0100
Subject: Re: [PATCH v2 11/11] ARM: dts: bcm2711: Add vmmc regulator in emmc2
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Cc:     phil@raspberrypi.com, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org
References: <20200306174413.20634-1-nsaenzjulienne@suse.de>
 <20200306174413.20634-12-nsaenzjulienne@suse.de>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Openpgp: preference=signencrypt
Autocrypt: addr=stefan.wahren@i2se.com; keydata=
 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 AQ==
Message-ID: <3bd022a6-922f-c20a-8d07-383817549960@i2se.com>
Date:   Mon, 9 Mar 2020 21:00:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200306174413.20634-12-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:HLq74eK/5uYp9FuDYB8nlYhQ+L1Iy16XuKUVj0/NO++R6Vyw8bS
 /mWXFYiUpH8XsOLxW+0Q1LUtIHfUZD10r1Tp2MjSKhLZBDDPCjHLSxAXnrYUr9LainLLHNE
 5zo32AxrZ87ogn3ujsQ9CcpsYr8c8gvPlpdXaBlkZ66zElrN0brGSZ8hZJNntE8qtzqDDtT
 mGPm9nMSXh7b7TR4xQR8Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J0AK1UndQlM=:omVXShDsl6kG//to/aRKy4
 zUEFAtmKVgE/H4EhRCHw9crOIH34eYeqXeOVqgSjUHo/xWwGt/mRrNGXdPzmdbzkAlPYHd8J0
 xqSS25nm2ikaI54jHmWpJ3BQBTB0tq1fI0jMGiy6IVSWOSpSggAbYLMCtGFF9u1rDh5HtGWYP
 RXTEuMbLKv0EDovM/usgo3RP5Ovab09P/NA0rPMZV9IX96b2q4lfy3HdyI4qHlx2VM/2irqUJ
 g9MVTJV8155GnQQQTRSNEpTwOfIHbLYqO3H+8EqRLyB59ECuJH6EUZTvdOU6yxn7BDLqnX8hl
 SAqWqIfaEQ76v3+PTnqYRPLQZPoWlbyBwSRE2iizh+sv6W75x8p+LRCHH2GudXBBFy/xpD+Uo
 I7iw1PTMJCJ5SipvsJ2tBNKRpO9A3HUqaguqSNJQ6gfVg5EQYsZ+T2EGHogKjwcFqIEkWwl2j
 xSIapX6eKh9JnSDmKrVwodAg4YM1q7WOgqtz5gVho5r4YpP5EGnNCUWWYcAp25ZS6v/s2WwPE
 59kptDoQvZeNxXLlWyDYLAHBs3yK23c76tpbJqGonsoT0qqamtdyT3gYF/tTsOPHRz9yZLCG2
 SqMjbeA+HbEcCBZt5DuLtEqlzdlWnRgL7P93g29qHlQH8LPPqG4lq90BjQO2u68iNrT3dLQhq
 q8bfLgyRv33NokTONt4u5ZUZ63JA+2qJodbONQxUmHnGKoYyzaoOIXhbz+f+2y+cAGM30LhRv
 vMEY/wPM5yOt+rEoma4iLm8IE/+KCsi4W7nfFCEsXCedTnfS9rNuxkkDhK1UfWwIRCtXRTSoV
 q0SWOsQGnkVx5VE4cyAXc7Zcp+vDBDQNGI2gdc6luPaxkG9KZCN9vnyuWRbE9vhZ+xSXnxg
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Nicolas,

Am 06.03.20 um 18:44 schrieb Nicolas Saenz Julienne:
> The SD card power can be controlled trough a pin routed into the board's
> external GPIO expander. Turn that into a regulator and provide it to
> emmc2.
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  arch/arm/boot/dts/bcm2711-rpi-4-b.dts | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> index b0ea8233b636..a2da058396fe 100644
> --- a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> +++ b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> @@ -55,6 +55,16 @@ sd_io_1v8_reg: sd_io_1v8_reg {
>  			  3300000 0x0>;
>  		status = "okay";
>  	};
> +
> +	sd_vcc_reg: sd_vcc_reg {
> +		compatible = "regulator-fixed";

i think we need to enable CONFIG_REGULATOR_FIXED_VOLTAGE in
bcm2835_defconfig

Best regards
Stefan

> +		regulator-name = "vcc-sd";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		enable-active-high;
> +		gpio = <&expgpio 6 GPIO_ACTIVE_HIGH>;
> +	};
>  };
>  
>  &firmware {
> @@ -173,6 +183,7 @@ brcmf: wifi@1 {
>  /* EMMC2 is used to drive the SD card */
>  &emmc2 {
>  	vqmmc-supply = <&sd_io_1v8_reg>;
> +	vmmc-supply = <&sd_vcc_reg>;
>  	broken-cd;
>  	status = "okay";
>  };
