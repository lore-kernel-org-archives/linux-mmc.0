From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 5/7] ARM: dts: add pbias dt node
Date: Tue, 10 Dec 2013 14:42:53 -0800
Message-ID: <20131210224252.GX13171@atomide.com>
References: <1385043627-30439-1-git-send-email-balajitk@ti.com>
 <1386670577-3530-1-git-send-email-balajitk@ti.com>
 <1386670577-3530-6-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:34607 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776Ab3LJWm4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Dec 2013 17:42:56 -0500
Content-Disposition: inline
In-Reply-To: <1386670577-3530-6-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-omap@vger.kernel.org, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, broonie@kernel.org

* Balaji T K <balajitk@ti.com> [131210 02:17]:
> Add pbias regulator node as a child of system control
> module - syscon.
> 
> Signed-off-by: Balaji T K <balajitk@ti.com>
> ---
>  arch/arm/boot/dts/dra7.dtsi     |   14 ++++++++++++++
>  arch/arm/boot/dts/omap2430.dtsi |   14 ++++++++++++++
>  arch/arm/boot/dts/omap3.dtsi    |   14 ++++++++++++++
>  arch/arm/boot/dts/omap4.dtsi    |   14 ++++++++++++++
>  arch/arm/boot/dts/omap5.dtsi    |   14 ++++++++++++++
>  5 files changed, 70 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index d0df4c4..1a52676 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -119,6 +119,19 @@
>  			pinctrl-single,function-mask = <0x3fffffff>;
>  		};
>  
> +		tisyscon: tisyscon@4A100600 {
> +			compatible = "ti,control-syscon", "syscon", "simple-bus";
> +			reg = <0x4A002E00 0x4>;

This should map the whole GENERAL area of the SCM register space instead
in one or multiple sections or driver instances. This way the same driver
can be used for the misc SCM registers from other drivers.

If you don't define it that way now, you'll end up with broken child driver
offsets in the .dts files later on.

> +				pbias_regulator: pbias_regulator {
> +					compatible = "regulator-pbias-omap5";
> +					pbias-reg-offset = <0>;
> +					regulator-name = "pbias_regulator";
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <3000000>;
> +					regulator-enable-ramp-delay = <10>;

Then the pbias_regulator needs to have the standard reg property as an
offset from the SCM GENERAL base address.

Regards,

Tony
