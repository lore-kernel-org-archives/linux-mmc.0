From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v12 08/11] spi: omap2-mcspi: add generic DMA request
	support to the DT binding
Date: Fri, 21 Jun 2013 16:05:35 +0530
Message-ID: <51C42C77.90909@ti.com>
References: <1371762407-24544-1-git-send-email-joelagnel@ti.com>
	<1371762407-24544-9-git-send-email-joelagnel@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1371762407-24544-9-git-send-email-joelagnel-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Koen Kooi <koen-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Joel A Fernandes <joelagnel-l0cyMroinI0@public.gmane.org>, Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>Rob
List-Id: linux-mmc@vger.kernel.org

Hi Benoit,
On Friday 21 June 2013 02:36 AM, Joel A Fernandes wrote:
> From: Matt Porter<mporter-l0cyMroinI0@public.gmane.org>
>
> The binding definition is based on the generic DMA request binding
>
> Signed-off-by: Matt Porter<mporter-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Joel A Fernandes<joelagnel-l0cyMroinI0@public.gmane.org>
> ---
>   Documentation/devicetree/bindings/spi/omap-spi.txt |   27 +++++++++++++++++++-
>   1 file changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/spi/omap-spi.txt b/Documentation/devicetree/bindings/spi/omap-spi.txt
> index 938809c..4c85c4c 100644
> --- a/Documentation/devicetree/bindings/spi/omap-spi.txt
> +++ b/Documentation/devicetree/bindings/spi/omap-spi.txt
> @@ -10,7 +10,18 @@ Required properties:
>   			  input. The default is D0 as input and
>   			  D1 as output.
>
> -Example:
> +Optional properties:
> +- dmas: List of DMA specifiers with the controller specific format
> +	as described in the generic DMA client binding. A tx and rx
> +	specifier is required for each chip select.
> +- dma-names: List of DMA request names. These strings correspond
> +	1:1 with the DMA specifiers listed in dmas. The string naming
> +	is to be "rxN" and "txN" for RX and TX requests,
> +	respectively, where N equals the chip select number.
> +
> +Examples:
> +
> +[hwmod populated DMA resources]
>
>   mcspi1: mcspi@1 {
>       #address-cells =<1>;
> @@ -20,3 +31,17 @@ mcspi1: mcspi@1 {
>       ti,spi-num-cs =<4>;
>   };
>
> +[generic DMA request binding]
> +
> +mcspi1: mcspi@1 {
> +    #address-cells =<1>;
> +    #size-cells =<0>;
> +    compatible = "ti,omap4-mcspi";
> +    ti,hwmods = "mcspi1";
> +    ti,spi-num-cs =<2>;
> +    dmas =<&edma 42
> +	&edma 43
> +	&edma 44
> +	&edma 45>;
> +    dma-names = "tx0", "rx0", "tx1", "rx1";
> +};
If the patch looks good to you, these can go independently in your
tree.

Reviewed-by: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>

~Sourav
