From: Karsten Merker <merker-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/2] ARM64: dts: meson-gxbb: add MMC support
Date: Fri, 5 Aug 2016 05:46:23 +0200
Message-ID: <20160805034623.GA1883@excalibur.cnev.de>
References: <20160803231843.23012-1-khilman@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160803231843.23012-1-khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Xing Wu <xing.xu-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>, Victor Wan <victor.wan-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jerry Cao <jerry.cao-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Aug 03, 2016 at 04:18:42PM -0700, Kevin Hilman wrote:

> Add binding and basic support for the SD/eMMC controller on Amlogic
> S905/GXBB devices.
> 
> Signed-off-by: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> ---
>  .../devicetree/bindings/mmc/amlogic,meson-gxbb.txt | 29 +++++++++
>  .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 74 ++++++++++++++++++++++
>  arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi   | 71 +++++++++++++++++++++
>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        | 36 ++++++++++-
>  4 files changed, 209 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/amlogic,meson-gxbb.txt
> 
> diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-gxbb.txt b/Documentation/devicetree/bindings/mmc/amlogic,meson-gxbb.txt
> new file mode 100644
> index 000000000000..2bfdf47018c5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-gxbb.txt
> @@ -0,0 +1,29 @@
> +Amlogic SD / eMMC controller for S905/GXBB family SoCs
> +
> +The MMC 5.1 compliant host controller on Amlogic provides the
> +interface for SD, eMMC and SDIO devices.
> +
> +This file documents the properties in addition to those available in
> +the MMC core bindings, documented by mmc.txt.
> +
> +Required properties:
> +- compatible : contains "amlogic,meson-gxbb"

I assume that should be "amlogic,meson-gxbb-mmc" instead of
"amlogic,meson-gxbb", shouldn't it?

> +- clocks     : A list of phandle + clock-specifier pairs for the clocks listed in clock-names.
> +- clock-names: Should contain the following:
> +	"core" - Main peripheral bus clock
> +	"clkin0" - Parent clock of internal mux
> +	"clkin1" - Other parent clock of internal mux
> +  The driver has an interal mux clock which switches between clkin0 and clkin1 depending on the
> +  clock rate requested by the MMC core.
> +
> +Example:
> +
> +	sd_emmc_a: mmc@70000 {
> +        	compatible = "amlogic,meson-gxbb-mmc";
> +		reg = <0x0 0x70000 0x0 0x2000>;
> +                interrupts = < GIC_SPI 216 IRQ_TYPE_EDGE_RISING>;
> +		clocks = <&clkc CLKID_SD_EMMC_A>, <&xtal>, <&clkc CLKID_FCLK_DIV2>;
> +		clock-names = "core", "clkin0", "clkin1";
> +		pinctrl-0 = <&emmc_pins>;
> +	};
> +
   
Regards,
Karsten
-- 
Gem. Par. 28 Abs. 4 Bundesdatenschutzgesetz widerspreche ich der Nutzung
sowie der Weitergabe meiner personenbezogenen Daten für Zwecke der
Werbung sowie der Markt- oder Meinungsforschung.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
