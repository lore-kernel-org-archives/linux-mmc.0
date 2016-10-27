From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v6 2/2] Documentation: DT: MMC: meson-gx: new bindings doc
Date: Thu, 27 Oct 2016 09:47:12 +0200
Message-ID: <CAPDyKFqTeTQb0V6zTaP2VN7Wx1_kHZjEndXb8LCRHOZ6fd951A@mail.gmail.com>
References: <20161019181825.2186-1-khilman@baylibre.com>
 <20161019181825.2186-2-khilman@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161019181825.2186-2-khilman@baylibre.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-amlogic@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 19 October 2016 at 20:18, Kevin Hilman <khilman@baylibre.com> wrote:
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  .../devicetree/bindings/mmc/amlogic,meson-gx.txt   | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
>
> diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
> new file mode 100644
> index 000000000000..a2fa9a1c26ae
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
> @@ -0,0 +1,33 @@
> +Amlogic SD / eMMC controller for S905/GXBB family SoCs
> +
> +The MMC 5.1 compliant host controller on Amlogic provides the
> +interface for SD, eMMC and SDIO devices.
> +
> +This file documents the properties in addition to those available in
> +the MMC core bindings, documented by mmc.txt.
> +
> +Required properties:
> +- compatible : contains one of:
> +  - "amlogic,meson-gx-mmc"
> +  - "amlogic,meson-gxbb-mmc"
> +  - "amlogic,meson-gxl-mmc"
> +  - "amlogic,meson-gxm-mmc"
> +- clocks     : A list of phandle + clock-specifier pairs for the clocks listed in clock-names.
> +- clock-names: Should contain the following:
> +       "core" - Main peripheral bus clock
> +       "clkin0" - Parent clock of internal mux
> +       "clkin1" - Other parent clock of internal mux
> +  The driver has an interal mux clock which switches between clkin0 and clkin1 depending on the
> +  clock rate requested by the MMC core.
> +
> +Example:
> +
> +       sd_emmc_a: mmc@70000 {
> +               compatible = "amlogic,meson-gxbb-mmc";
> +               reg = <0x0 0x70000 0x0 0x2000>;
> +                interrupts = < GIC_SPI 216 IRQ_TYPE_EDGE_RISING>;
> +               clocks = <&clkc CLKID_SD_EMMC_A>, <&xtal>, <&clkc CLKID_FCLK_DIV2>;
> +               clock-names = "core", "clkin0", "clkin1";
> +               pinctrl-0 = <&emmc_pins>;
> +       };
> +
> --
> 2.9.3
>
