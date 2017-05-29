From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC 1/2] dt-bindings: mmc: Document the Amlogic Meson8 and
 Meson8b SDIO bindings
Date: Mon, 29 May 2017 12:04:48 +0200
Message-ID: <CAPDyKFp9Dhf+sebqvxwr=i1dskh_JfhWaG4FMPO-CHk_sj7pVg@mail.gmail.com>
References: <20170506171857.16492-1-martin.blumenstingl@googlemail.com> <20170506171857.16492-2-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170506171857.16492-2-martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Carlo Caione <carlo-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 6 May 2017 at 19:18, Martin Blumenstingl
<martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org> wrote:
> From: Carlo Caione <carlo-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
>
> This documents the devicetree bindings for the SDIO/MMC host found in
> Amlogic Meson8 and Meson8b SoCs. It supports the SD specification v2.0
> and the eMMC specification v4.41.
> It has an internal "mux" which allows connecting up to three MMC devices
> to it. The maximum supported bus-width is 4-bits.
>
> Amlogic's GPL kernel sources call it "SDIO" to differentiate it from the
> other MMC controller in (at least the Meson8 and Meson8b) the SoCs (they
> call the other one "SDHC", which supports a bus-width of up to 8-bits).
>
> Signed-off-by: Carlo Caione <carlo-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
> ---
>  .../bindings/mmc/amlogic,meson-mx-sdio.txt         | 50 ++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.txt
>
> diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.txt b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.txt
> new file mode 100644
> index 000000000000..991c43a602bd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.txt
> @@ -0,0 +1,50 @@
> +* Amlogic Meson6, Meson8 and Meson8b SDIO/MMC controller
> +
> +The highspeed MMC host controller on Amlogic SoCs provides an interface
> +for MMC, SD, SDIO and SDHC types of memory cards.
> +
> +Supported maximum speeds are the ones of the eMMC standard 4.41 as well
> +as the speed of SD standard 2.0.
> +
> +The hardware provides an internal "mux" which allows up to three slots
> +to be controlled. Only one device can be accessed at a time.
> +
> +Required properties:
> + - compatible : must be one of
> +       - "amlogic,meson8-sdio"
> +       - "amlogic,meson8b-sdio"
> +       along with the generic "amlogic,meson-mx-sdio"
> + - reg : mmc controller base registers
> + - interrupts : mmc controller interrupt
> + - #address-cells : must be 1
> + - size-cells : must be 0
> + - clocks : phandle to clock providers
> + - clock-names : must contain "core" and "clkin"
> +
> +Required child nodes:
> +A node for each slot provided by the MMC controller is required.
> +
> +Required properties on each child node (= slot):
> + - reg : the slot (or "port") ID

Please add also that we need a compatible = "mmc-slot", as we are
using req for childnodes to describe SDIO func nodes and embedded
cards.

While doing this, could you perhaps also update the generic mmc DT
doc, as currently the compatible is described only in
Documentation/devicetree/bindings/mmc/cavium-mmc.txt.

> +
> +Optional properties on each child node (= slot):
> + - bus-width : must be 1 or 4 (8-bit bus is not supported)
> + - for cd and all other additional generic mmc parameters
> +   please refer to mmc.txt within this directory
> +
> +Examples:
> +       mmc@c1108c20 {
> +               compatible = "amlogic,meson8-sdio", "amlogic,meson-mx-sdio";
> +               reg = <0xc1108c20 0x20>;
> +               interrupts = <0 28 1>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               clocks = <&clkc CLKID_SDIO>, <&clkc CLKID_CLK81>;
> +               clock-names = "core", "clkin";
> +
> +               slot@1 {
> +                       reg = <1>;
> +
> +                       bus-width = <4>;
> +               };
> +       };
> --
> 2.12.2
>

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
