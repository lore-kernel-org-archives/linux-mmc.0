From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH 2/2] ARM: dts: at91: sama5d27_som1_ek: add mmc
 capabilities for SDMMC0
Date: Thu, 8 Aug 2019 14:42:18 +0200
Message-ID: <20190808124217.wrmcxohw5i6ju2qe@M43218.corp.atmel.com>
References: <1565252928-28994-1-git-send-email-eugen.hristev@microchip.com>
 <1565252928-28994-2-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1565252928-28994-2-git-send-email-eugen.hristev@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eugen Hristev - M18282 <Eugen.Hristev@microchip.com>
Cc: Nicolas Ferre - M43238 <Nicolas.Ferre@microchip.com>, "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Aug 08, 2019 at 10:35:43AM +0200, Eugen Hristev - M18282 wrote:
> From: Eugen Hristev <eugen.hristev@microchip.com>
> 
> Add mmc capabilities for SDMMC0 for this board.
> With this enabled, eMMC connected card is detected as:
> 
> mmc0: new DDR MMC card at address 0001
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

I am interested to have the some insights about the use of sd-uhs-*
properties.

Our IP can't deal with 1V8 by itself. It has a 1V8SEL signal which can
be used as the logic control input of a mux. So even if the IP claims
to support UHS modes, it depends on the board.

Are the sd-uhs-* properties a way to deal with this? I tend to think no
as sdhci_setup_host() will set the caps depending on the content of the
capabilities register. Do we have to use the SDHCI_QUIRK_MISSING_CAPS
quirk or sdhci-caps/sdhci-caps-mask?

Regards

Ludovic

> ---
>  arch/arm/boot/dts/at91-sama5d27_som1_ek.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
> index 149e539..194b3a3 100644
> --- a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
> +++ b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
> @@ -54,6 +54,7 @@
>  
>  		sdmmc0: sdio-host@a0000000 {
>  			bus-width = <8>;
> +			mmc-ddr-3_3v;
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&pinctrl_sdmmc0_default>;
>  			status = "okay";
> -- 
> 2.7.4
> 
