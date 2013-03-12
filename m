From: Matt Porter <mporter@ti.com>
Subject: Re: [PATCH v9 5/9] dmaengine: edma: Add TI EDMA device tree binding
Date: Tue, 12 Mar 2013 12:09:45 -0400
Message-ID: <20130312160945.GX6209@beef>
References: <1362586540-10393-1-git-send-email-mporter@ti.com>
 <1362586540-10393-6-git-send-email-mporter@ti.com>
 <90c29a73df9e495f907517c49dd45b88@DFLE72.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <90c29a73df9e495f907517c49dd45b88@DFLE72.ent.ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: Tony Lindgren <tony@atomide.com>, "Nori, Sekhar" <nsekhar@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Cousson, Benoit" <b-cousson@ti.com>, Russell King <linux@arm.linux.org.uk>, Rob Landley <rob@landley.net>, Andrew Morton <akpm@linux-foundation.org>, Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, Arnd Bergmann <arnd@arndb.de>, Linux Documentation List <linux-doc@vger.kernel.org>, Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux SPI Devel List <spi-devel-general@lists.sourceforge.net>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Mar 06, 2013 at 08:24:06PM +0000, Peter Korsgaard wrote:
> >>>>> "Matt" == Matt Porter <mporter@ti.com> writes:
> 
>  Matt> The binding definition is based on the generic DMA controller
>  Matt> binding.
> 
>  Matt> Signed-off-by: Matt Porter <mporter@ti.com>
>  Matt> ---
>  Matt>  Documentation/devicetree/bindings/dma/ti-edma.txt |   49 +++++++++++++++++++++
>  Matt>  1 file changed, 49 insertions(+)
>  Matt>  create mode 100644 Documentation/devicetree/bindings/dma/ti-edma.txt
> 
>  Matt> diff --git a/Documentation/devicetree/bindings/dma/ti-edma.txt b/Documentation/devicetree/bindings/dma/ti-edma.txt
>  Matt> new file mode 100644
>  Matt> index 0000000..075a60e3
>  Matt> --- /dev/null
>  Matt> +++ b/Documentation/devicetree/bindings/dma/ti-edma.txt
>  Matt> @@ -0,0 +1,49 @@
>  Matt> +TI EDMA
>  Matt> +
>  Matt> +Required properties:
>  Matt> +- compatible : "ti,edma3"
>  Matt> +- ti,hwmods: Name of the hwmods associated to the EDMA
>  Matt> +- ti,edma-regions: Number of regions
>  Matt> +- ti,edma-slots: Number of slots
>  Matt> +- ti,edma-queue-tc-map: List of transfer control to queue mappings
>  Matt> +- ti,edma-queue-priority-map: List of queue priority mappings
>  Matt> +- ti,edma-default-queue: Default queue value
>  Matt> +
>  Matt> +Optional properties:
>  Matt> +- ti,edma-reserved-channels: List of reserved channel regions
>  Matt> +- ti,edma-reserved-slots: List of reserved slot regions
>  Matt> +- ti,edma-xbar-event-map: Crossbar event to channel map
>  Matt> +
>  Matt> +Example:
>  Matt> +
>  Matt> +edma: edma@49000000 {
>  Matt> +	reg = <0x49000000 0x10000>;
>  Matt> +	interrupt-parent = <&intc>;
>  Matt> +	interrupts = <12 13 14>;
> 
> Probably interrupt-parent should be removed from the example as well to
> match am33xx.dtsi

On second thought, I'm not sure we're going to get any direction on this
one so let's just do what feels right and make it reflect common usage
like you suggested.

Thanks,
Matt
