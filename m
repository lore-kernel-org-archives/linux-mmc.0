From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v3 3/5] ARM: mvebu: set SW polling as SDHCI card detection on A388-GP
Date: Fri, 16 Oct 2015 19:19:30 +0200
Message-ID: <878u72hgt9.fsf@free-electrons.com>
References: <1444926346-29763-1-git-send-email-mw@semihalf.com>
	<1444926346-29763-4-git-send-email-mw@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:41144 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751510AbbJPRTe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Oct 2015 13:19:34 -0400
In-Reply-To: <1444926346-29763-4-git-send-email-mw@semihalf.com> (Marcin
	Wojtas's message of "Thu, 15 Oct 2015 18:25:44 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marcin Wojtas <mw@semihalf.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, sebastian.hesselbarth@gmail.com, andrew@lunn.ch, jason@lakedaemon.net, thomas.petazzoni@free-electrons.com, nadavh@marvell.com, alior@marvell.com, tawfik@marvell.com, jaz@semihalf.com, jszhang@marvell.com

Hi Marcin,
 
 On jeu., oct. 15 2015, Marcin Wojtas <mw@semihalf.com> wrote:

> The newest revisions of A388-GP (v1.5 and higher) support only
> DAT3-based card detection. Revisions < v1.5 based on GPIO detection
> via I2C expander, but this solution is supposed to be deprecated on
> new boards. In order to satisfy all type of hardware this commit
> changes card detection to use software polling mechanism. Also a
> comment is added on possible card detection options in A388-GP
> DT board file.
>
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> Acked-by: Andrew Lunn <andrew@lunn.ch>

Applied on mvebu/dt

Thanks,

Gregory

> ---
>  arch/arm/boot/dts/armada-388-gp.dts | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/armada-388-gp.dts b/arch/arm/boot/dts/armada-388-gp.dts
> index 391dea9..3deba13 100644
> --- a/arch/arm/boot/dts/armada-388-gp.dts
> +++ b/arch/arm/boot/dts/armada-388-gp.dts
> @@ -213,8 +213,21 @@
>  			sdhci@d8000 {
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&sdhci_pins>;
> -				cd-gpios = <&expander0 5 GPIO_ACTIVE_LOW>;
>  				no-1-8-v;
> +				/*
> +				 * A388-GP board v1.5 and higher replace
> +				 * hitherto card detection method based on GPIO
> +				 * with the one using DAT3 pin. As they are
> +				 * incompatible, software-based polling is
> +				 * enabled with 'broken-cd' property. For boards
> +				 * older than v1.5 it can be replaced with:
> +				 * 'cd-gpios = <&expander0 5 GPIO_ACTIVE_LOW>;',
> +				 * whereas for the newer ones following can be
> +				 * used instead:
> +				 * 'dat3-cd;'
> +				 * 'cd-inverted;'
> +				 */
> +				broken-cd;
>  				wp-inverted;
>  				bus-width = <8>;
>  				status = "okay";
> -- 
> 1.8.3.1
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
