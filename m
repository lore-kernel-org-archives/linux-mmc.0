From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] mmc: pwrseq: add support for Marvell SD8787 chip
Date: Mon, 28 Nov 2016 08:15:13 -0600
Message-ID: <20161128141513.agnkyz6ronigbukn@rob-hp-laptop>
References: <1479434109-8745-1-git-send-email-matt@ranostay.consulting>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1479434109-8745-1-git-send-email-matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
Cc: linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Nov 17, 2016 at 05:55:09PM -0800, Matt Ranostay wrote:
> Allow power sequencing for the Marvell SD8787 Wifi/BT chip.
> This can be abstracted to other chipsets if needed in the future.

I don't like the MMC pwrseq bindings, so I won't be acking any. Look at 
the USB pwrseq for why.

> Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
> Cc: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Signed-off-by: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
> ---
>  .../devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt  |  14 +++
>  .../bindings/net/wireless/marvell-sd8xxx.txt       |   4 +
>  drivers/mmc/core/Kconfig                           |  10 ++
>  drivers/mmc/core/Makefile                          |   1 +
>  drivers/mmc/core/pwrseq_sd8787.c                   | 117 +++++++++++++++++++++
>  5 files changed, 146 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt
>  create mode 100644 drivers/mmc/core/pwrseq_sd8787.c
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt
> new file mode 100644
> index 000000000000..1b658351629b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt
> @@ -0,0 +1,14 @@
> +* Marvell SD8787 power sequence provider
> +
> +Required properties:
> +- compatible: must be "mmc-pwrseq-sd8787".
> +- pwndn-gpio: contains a power down GPIO specifier.

powerdown-gpios

> +- reset-gpio: contains a reset GPIO specifier.

reset-gpios

> +
> +Example:
> +
> +	wifi_pwrseq: wifi_pwrseq {
> +		compatible = "mmc-pwrseq-sd8787";
> +		pwrdn-gpio = <&twl_gpio 0 GPIO_ACTIVE_LOW>;
> +		reset-gpio = <&twl_gpio 1 GPIO_ACTIVE_LOW>;
> +	}
> diff --git a/Documentation/devicetree/bindings/net/wireless/marvell-sd8xxx.txt b/Documentation/devicetree/bindings/net/wireless/marvell-sd8xxx.txt
> index c421aba0a5bc..08fd65d35725 100644
> --- a/Documentation/devicetree/bindings/net/wireless/marvell-sd8xxx.txt
> +++ b/Documentation/devicetree/bindings/net/wireless/marvell-sd8xxx.txt
> @@ -32,6 +32,9 @@ Optional properties:
>  		 so that the wifi chip can wakeup host platform under certain condition.
>  		 during system resume, the irq will be disabled to make sure
>  		 unnecessary interrupt is not received.
> +  - vmmc-supply: a phandle of a regulator, supplying VCC to the card

This is why pwrseq is wrong. You have some properties in the card node 
and some in pwrseq node. Everything should be in the card node.

> +  - mmc-pwrseq:  phandle to the MMC power sequence node. See "mmc-pwrseq-*"
> +		 for documentation of MMC power sequence bindings.
>  
>  Example:
>  
> @@ -44,6 +47,7 @@ so that firmware can wakeup host using this device side pin.
>  &mmc3 {
>  	status = "okay";
>  	vmmc-supply = <&wlan_en_reg>;
> +	mmc-pwrseq = <&wifi_pwrseq>;
>  	bus-width = <4>;
>  	cap-power-off-card;
>  	keep-power-in-suspend;
