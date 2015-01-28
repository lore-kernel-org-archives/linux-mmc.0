From: Arend van Spriel <arend@broadcom.com>
Subject: Re: [PATCH 5/5] ARM: dts: exynos5250-snow: Enable wifi power-on
Date: Wed, 28 Jan 2015 15:03:36 +0100
Message-ID: <54C8EC38.6010702@broadcom.com>
References: <1422439819-29854-1-git-send-email-javier.martinez@collabora.co.uk>
 <1422439819-29854-6-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1422439819-29854-6-git-send-email-javier.martinez@collabora.co.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, Doug Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, Kukjin Kim <kgene@kernel.org>, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 01/28/15 11:10, Javier Martinez Canillas wrote:
> The Snow board has a MMC/SDIO wifi chip that is always powered but it
> needs a power sequence involving a reset (active low) and an enable
> (active high) pins. Both pins are marked as active low since the MMC
> simple power sequence driver asserts the pins prior to the card power
> up procedure and de-asserts the pins after the card has been powered.
>
> So the reset line will be left de-asserted and the enable pin will be
> left asserted.
>
> The chip also needs an external 32kHz reference clock to be operational
> that is by the MAX77686 PMIC clock.
>
> Add a simple MMC power sequence provider for the wifi MMC/SDIO slot.
>
> Signed-off-by: Javier Martinez Canillas<javier.martinez@collabora.co.uk>
> ---
>   arch/arm/boot/dts/exynos5250-snow.dts | 25 ++++++++++++++++++++++++-
>   1 file changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
> index b9aeec430527..0f7971ba8238 100644
> --- a/arch/arm/boot/dts/exynos5250-snow.dts
> +++ b/arch/arm/boot/dts/exynos5250-snow.dts
> @@ -229,6 +229,13 @@
>   		power-supply =<&fet6>;
>   		backlight =<&backlight>;
>   	};
> +
> +	mmc3_pwrseq: mmc3_pwrseq {
> +		reset-gpios =<&gpx0 2 GPIO_ACTIVE_LOW>, /* WIFI_RSTn */
> +			<&gpx0 1 GPIO_ACTIVE_LOW>; /* WIFI_EN */
> +		clocks =<&max77686 MAX77686_CLK_PMIC>;
> +		clock-names = "ext_clock";
> +	};
>   };
>
>   &dp {
> @@ -531,17 +538,33 @@
>   	status = "okay";
>   	num-slots =<1>;
>   	broken-cd;
> +	cap-sdio-irq;

This seems like an unrelated change, right?

Regards,
Arend

>   	card-detect-delay =<200>;
>   	samsung,dw-mshc-ciu-div =<3>;
>   	samsung,dw-mshc-sdr-timing =<2 3>;
>   	samsung,dw-mshc-ddr-timing =<1 2>;
>   	pinctrl-names = "default";
> -	pinctrl-0 =<&sd3_clk&sd3_cmd&sd3_bus4>;
> +	pinctrl-0 =<&sd3_clk&sd3_cmd&sd3_bus4&wifi_en&wifi_rst>;
>   	bus-width =<4>;
>   	cap-sd-highspeed;
> +	mmc-pwrseq =<&mmc3_pwrseq>;
>   };
>
>   &pinctrl_0 {
> +	wifi_en: wifi-en {
> +		samsung,pins = "gpx0-1";
> +		samsung,pin-function =<1>;
> +		samsung,pin-pud =<0>;
> +		samsung,pin-drv =<0>;
> +	};
> +
> +	wifi_rst: wifi-rst {
> +		samsung,pins = "gpx0-2";
> +		samsung,pin-function =<1>;
> +		samsung,pin-pud =<0>;
> +		samsung,pin-drv =<0>;
> +	};
> +
>   	power_key_irq: power-key-irq {
>   		samsung,pins = "gpx1-3";
>   		samsung,pin-function =<0xf>;
