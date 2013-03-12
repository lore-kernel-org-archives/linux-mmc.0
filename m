From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v9 5/9] dmaengine: edma: Add TI EDMA device tree binding
Date: Tue, 12 Mar 2013 12:23:03 +0530
Message-ID: <513ED0CF.6070302@ti.com>
References: <1362586540-10393-1-git-send-email-mporter@ti.com>
 <1362586540-10393-6-git-send-email-mporter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1362586540-10393-6-git-send-email-mporter-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 3/6/2013 9:45 PM, Matt Porter wrote:
> The binding definition is based on the generic DMA controller
> binding.
> 
> Signed-off-by: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>

Okay the bindings the documented after they are used leading to some
confusion. This patch should be moved up the series. As I noted in my
other e-mail, some of these bindings are not really hardware description
and need to be re-looked.

Thanks,
Sekhar

> ---
>  Documentation/devicetree/bindings/dma/ti-edma.txt |   49 +++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/ti-edma.txt
> 
> diff --git a/Documentation/devicetree/bindings/dma/ti-edma.txt b/Documentation/devicetree/bindings/dma/ti-edma.txt
> new file mode 100644
> index 0000000..075a60e3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/ti-edma.txt
> @@ -0,0 +1,49 @@
> +TI EDMA
> +
> +Required properties:
> +- compatible : "ti,edma3"
> +- ti,hwmods: Name of the hwmods associated to the EDMA
> +- ti,edma-regions: Number of regions
> +- ti,edma-slots: Number of slots
> +- ti,edma-queue-tc-map: List of transfer control to queue mappings
> +- ti,edma-queue-priority-map: List of queue priority mappings
> +- ti,edma-default-queue: Default queue value
> +
> +Optional properties:
> +- ti,edma-reserved-channels: List of reserved channel regions
> +- ti,edma-reserved-slots: List of reserved slot regions
> +- ti,edma-xbar-event-map: Crossbar event to channel map
> +
> +Example:
> +
> +edma: edma@49000000 {
> +	reg = <0x49000000 0x10000>;
> +	interrupt-parent = <&intc>;
> +	interrupts = <12 13 14>;
> +	compatible = "ti,edma3";
> +	ti,hwmods = "tpcc", "tptc0", "tptc1", "tptc2";
> +	#dma-cells = <1>;
> +	dma-channels = <64>;
> +	ti,edma-regions = <4>;
> +	ti,edma-slots = <256>;
> +	ti,edma-reserved-channels = <0  2
> +				     14 2
> +				     26 6
> +				     48 4
> +				     56 8>;
> +	ti,edma-reserved-slots = <0  2
> +				  14 2
> +				  26 6
> +				  48 4
> +				  56 8
> +				  64 127>;
> +	ti,edma-queue-tc-map = <0 0
> +				1 1
> +				2 2>;
> +	ti,edma-queue-priority-map = <0 0
> +				      1 1
> +				      2 2>;
> +	ti,edma-default-queue = <0>;
> +	ti,edma-xbar-event-map = <1 12
> +				  2 13>;
> +};
> 
