From: "Hebbar, Gururaja" <gururaja.hebbar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v4 05/14] dmaengine: edma: Add TI EDMA device tree binding
Date: Fri, 11 Jan 2013 07:54:05 +0000
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EB3EBBD@DBDE01.ent.ti.com>
References: <1357883330-5364-1-git-send-email-mporter@ti.com>
 <1357883330-5364-6-git-send-email-mporter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1357883330-5364-6-git-send-email-mporter-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
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
To: "Porter, Matt" <mporter-l0cyMroinI0@public.gmane.org>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Nori,
 Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Jan 11, 2013 at 11:18:41, Porter, Matt wrote:
> The binding definition is based on the generic DMA controller
> binding.
> 
> Signed-off-by: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/dma/ti-edma.txt |   51 +++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/ti-edma.txt
> 
> diff --git a/Documentation/devicetree/bindings/dma/ti-edma.txt b/Documentation/devicetree/bindings/dma/ti-edma.txt
> new file mode 100644
> index 0000000..3344345
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/ti-edma.txt
> @@ -0,0 +1,51 @@
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
> +	#address-cells = <1>;
> +	#size-cells = <0>;

address-cells & size-cells are only required when current node is a parent 
node & it has sibling/child nodes (that too if the child node uses "reg" 
property).

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
> -- 
> 1.7.9.5
> 
> _______________________________________________
> Davinci-linux-open-source mailing list
> Davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
> 


Regards, 
Gururaja
