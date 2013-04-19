From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH v3 2/6] ARM: at91: dts: set #dma-cells to the correct value
Date: Fri, 19 Apr 2013 11:39:45 +0200
Message-ID: <517110E1.70804@atmel.com>
References: <1366362683-14496-1-git-send-email-ludovic.desroches@atmel.com>
 <1366362683-14496-3-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1366362683-14496-3-git-send-email-ludovic.desroches@atmel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: ludovic.desroches@atmel.com
Cc: plagnioj@jcrosoft.com, linux-mmc@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 04/19/2013 11:11 AM, ludovic.desroches@atmel.com :
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> Moving to generic DMA DT binding involves to set #dma-cells to 2.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

And stacked in at91-3.10-soc.

thanks,

> ---
>  arch/arm/boot/dts/at91sam9g45.dtsi | 1 +
>  arch/arm/boot/dts/at91sam9n12.dtsi | 1 +
>  arch/arm/boot/dts/at91sam9x5.dtsi  | 2 ++
>  arch/arm/boot/dts/sama5d3.dtsi     | 4 ++--
>  4 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
> index 6b1d4ca..275e768 100644
> --- a/arch/arm/boot/dts/at91sam9g45.dtsi
> +++ b/arch/arm/boot/dts/at91sam9g45.dtsi
> @@ -108,6 +108,7 @@
>  				compatible = "atmel,at91sam9g45-dma";
>  				reg = <0xffffec00 0x200>;
>  				interrupts = <21 4 0>;
> +				#dma-cells = <2>;
>  			};
>  
>  			pinctrl@fffff200 {
> diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
> index 7750f98..acc4526 100644
> --- a/arch/arm/boot/dts/at91sam9n12.dtsi
> +++ b/arch/arm/boot/dts/at91sam9n12.dtsi
> @@ -110,6 +110,7 @@
>  				compatible = "atmel,at91sam9g45-dma";
>  				reg = <0xffffec00 0x200>;
>  				interrupts = <20 4 0>;
> +				#dma-cells = <2>;
>  			};
>  
>  			pinctrl@fffff400 {
> diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
> index 3870322..8e83d87 100644
> --- a/arch/arm/boot/dts/at91sam9x5.dtsi
> +++ b/arch/arm/boot/dts/at91sam9x5.dtsi
> @@ -104,12 +104,14 @@
>  				compatible = "atmel,at91sam9g45-dma";
>  				reg = <0xffffec00 0x200>;
>  				interrupts = <20 4 0>;
> +				#dma-cells = <2>;
>  			};
>  
>  			dma1: dma-controller@ffffee00 {
>  				compatible = "atmel,at91sam9g45-dma";
>  				reg = <0xffffee00 0x200>;
>  				interrupts = <21 4 0>;
> +				#dma-cells = <2>;
>  			};
>  
>  			pinctrl@fffff400 {
> diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
> index 39b0458..95c00a3 100644
> --- a/arch/arm/boot/dts/sama5d3.dtsi
> +++ b/arch/arm/boot/dts/sama5d3.dtsi
> @@ -348,14 +348,14 @@
>  				compatible = "atmel,at91sam9g45-dma";
>  				reg = <0xffffe600 0x200>;
>  				interrupts = <30 4 0>;
> -				#dma-cells = <1>;
> +				#dma-cells = <2>;
>  			};
>  
>  			dma1: dma-controller@ffffe800 {
>  				compatible = "atmel,at91sam9g45-dma";
>  				reg = <0xffffe800 0x200>;
>  				interrupts = <31 4 0>;
> -				#dma-cells = <1>;
> +				#dma-cells = <2>;
>  			};
>  
>  			ramc0: ramc@ffffea00 {
> 


-- 
Nicolas Ferre
