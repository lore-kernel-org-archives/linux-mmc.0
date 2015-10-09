From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 3/5] ARM: mvebu: set SW polling as SDHCI card
 detection on A388-GP
Date: Fri, 9 Oct 2015 15:46:41 +0200
Message-ID: <20151009134641.GD14688@lunn.ch>
References: <1444352635-21965-1-git-send-email-mw@semihalf.com>
 <1444352635-21965-4-git-send-email-mw@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1444352635-21965-4-git-send-email-mw@semihalf.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcin Wojtas <mw@semihalf.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, sebastian.hesselbarth@gmail.com, jason@lakedaemon.net, thomas.petazzoni@free-electrons.com, gregory.clement@free-electrons.com, nadavh@marvell.com, alior@marvell.com, tawfik@marvell.com, jaz@semihalf.com
List-Id: linux-mmc@vger.kernel.org

On Fri, Oct 09, 2015 at 03:03:53AM +0200, Marcin Wojtas wrote:
> The newest revisions of A388-GP (v1.5 and higher) support only
> DAT3-based card detection. Revisions < v1.5 based on GPIO detection
> via I2C expander, but this solution is supposed to be deprecated on
> new boards. In order to satisfy all type of hardware this commit
> changes card detection to use software polling mechanism.

Hi Marcin

Thanks for going with broken-cd and not introducing a regression for
older boards. As others have said, a comment would be good, but
otherwise:

Acked-by: Andrew Lunn <andrew@lunn.ch>

Thanks
	Andrew

> 
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> ---
>  arch/arm/boot/dts/armada-388-gp.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/armada-388-gp.dts b/arch/arm/boot/dts/armada-388-gp.dts
> index 391dea9..403a86b 100644
> --- a/arch/arm/boot/dts/armada-388-gp.dts
> +++ b/arch/arm/boot/dts/armada-388-gp.dts
> @@ -213,8 +213,8 @@
>  			sdhci@d8000 {
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&sdhci_pins>;
> -				cd-gpios = <&expander0 5 GPIO_ACTIVE_LOW>;
>  				no-1-8-v;
> +				broken-cd;
>  				wp-inverted;
>  				bus-width = <8>;
>  				status = "okay";
> -- 
> 1.8.3.1
> 
