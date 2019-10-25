From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 01/11] Documentation: dt: wireless: update wl1251 for
 sdio
Date: Fri, 25 Oct 2019 16:13:38 -0500
Message-ID: <20191025211338.GA20249@bogus>
References: <cover.1571510481.git.hns@goldelico.com>
 <741828f69eca2a9c9a0a7e80973c91f50cc71f9b.1571510481.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <741828f69eca2a9c9a0a7e80973c91f50cc71f9b.1571510481.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Kalle Valo <kvalo@codeaurora.org>, Mike Rapoport <rppt@linux.ibm.com>, David Sterba <dsterba@suse.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Petr Mladek <pmladek@suse.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Yangtao Li <tiny.windzz@gmail.com>, Alexios Zavras <alexios.zavras@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, John Stultz <john.stultz@linaro.org>, Bjorn Helgaas <bhelgaas@google.>
List-Id: linux-mmc@vger.kernel.org

On Sat, Oct 19, 2019 at 08:41:16PM +0200, H. Nikolaus Schaller wrote:
> The standard method for sdio devices connected to
> an sdio interface is to define them as a child node
> like we can see with wlcore.
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> Acked-by: Kalle Valo <kvalo@codeaurora.org>
> ---
>  .../bindings/net/wireless/ti,wl1251.txt       | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/ti,wl1251.txt b/Documentation/devicetree/bindings/net/wireless/ti,wl1251.txt
> index bb2fcde6f7ff..88612ff29f2d 100644
> --- a/Documentation/devicetree/bindings/net/wireless/ti,wl1251.txt
> +++ b/Documentation/devicetree/bindings/net/wireless/ti,wl1251.txt
> @@ -35,3 +35,29 @@ Examples:
>  		ti,power-gpio = <&gpio3 23 GPIO_ACTIVE_HIGH>; /* 87 */
>  	};
>  };
> +
> +&mmc3 {
> +	vmmc-supply = <&wlan_en>;
> +
> +	bus-width = <4>;
> +	non-removable;
> +	ti,non-removable;
> +	cap-power-off-card;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc3_pins>;

None of the above are really relevant to this binding.

> +
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	wlan: wl1251@1 {

wifi@1

> +		compatible = "ti,wl1251";
> +
> +		reg = <1>;
> +
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <21 IRQ_TYPE_LEVEL_HIGH>;	/* GPIO_21 */
> +
> +		ti,wl1251-has-eeprom;
> +	};
> +};
> -- 
> 2.19.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
