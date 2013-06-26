From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH 3/5] ARM: dts: am33xx: Add interrupts and memory resources
 for MMC
Date: Wed, 26 Jun 2013 22:03:54 +0530
Message-ID: <51CB17F2.5060504@ti.com>
References: <1372209888-6649-1-git-send-email-joelagnel@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1372209888-6649-1-git-send-email-joelagnel@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Joel A Fernandes <agnel.joel@gmail.com>
Cc: Mark Brown <broonie@linaro.org>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Koen Kooi <koen@beagleboard.org>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, Vinod Koul <vinod.koul@intel.com>, Linux Documentation List <linux-doc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Arnd Bergmann <arnd@arndb.de>, Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, Rob Herring <rob.herring@calxeda.com>, Jason Kridner <jkridner@beagleboard.org>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, Benoit Cousson <b-cousson@ti.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Landley <rob@landley.net>, Linux SPI Devel List <spi-dev>
List-Id: linux-mmc@vger.kernel.org

Hi Joel,

On Wednesday 26 June 2013 06:54 AM, Joel A Fernandes wrote:
> From: Joel A Fernandes <agnel.joel@gmail.com>
>
> HWMOD irq entries for MMC were removed. We provide the same from DT for MMC.
>
> This fixes issue where memory resource could not be found during probe.
> Also, added the reg-offset property to account for the offset from start.
>
> Signed-off-by: Joel A Fernandes <agnel.joel@gmail.com>
> ---
>   arch/arm/boot/dts/am33xx.dtsi |   12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 119f8a9..e0a5741 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -237,6 +237,10 @@
>   			dmas = <&edma 24
>   				&edma 25>;
>   			dma-names = "tx", "rx";
> +			interrupts = <64>;
> +			interrupt-parent = <&intc>;
> +			reg = <0x48060000 0x1000>;
> +			reg-offset = <0x100>;
>   			status = "disabled";
>   		};
>
> @@ -247,6 +251,10 @@
>   			dmas = <&edma 2
>   				&edma 3>;
>   			dma-names = "tx", "rx";
> +			interrupts = <24>;

s/24/28

> +			interrupt-parent = <&intc>;
> +			reg = <0x481d8000 0x1000>;
> +			reg-offset = <0x100>;
>   			status = "disabled";
>   		};
>
> @@ -254,6 +262,10 @@
>   			compatible = "ti,omap3-hsmmc";

compatible should be ti,omap4-hsmmc since omap4 hsmmc IP is re-used in am33xx
and reg-offset property is not needed.
combine this patch with 2/5 ARM: dts: add AM33XX MMC support and please add
your signed-off to that patch.

>   			ti,hwmods = "mmc3";
>   			ti,needs-special-reset;
> +			interrupts = <25>;

s/25/29

> +			interrupt-parent = <&intc>;
> +			reg = <0x47810000 0x1000>;
> +			reg-offset = <0x100>;
>   			status = "disabled";
>   		};
>
>
