From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 2/4] mmc: omap: adapt the hsmmc driver to device tree
Date: Fri, 4 Nov 2011 13:04:15 -0700
Message-ID: <20111104200415.GC3045@quad.lixom.net>
References: <1320407441-29697-1-git-send-email-rnayak@ti.com>
 <1320407441-29697-3-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1320407441-29697-3-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, thomas.abraham@linaro.org, balajitk@ti.com, cjb@laptop.org, tony@atomide.com
List-Id: linux-mmc@vger.kernel.org

On Fri, Nov 04, 2011 at 05:20:39PM +0530, Rajendra Nayak wrote:
> Define dt bindings for the ti-omap-hsmmc, and adapt
> the driver to extract data (which was earlier passed as
> platform_data) from device tree node.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |   50 +++++++++
>  drivers/mmc/host/omap_hsmmc.c                      |  117 ++++++++++++++++++++
>  2 files changed, 167 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> 
> diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> new file mode 100644
> index 0000000..370af1b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> @@ -0,0 +1,50 @@
> +* TI Highspeed MMC host controller for OMAP
> +
> +The Highspeed MMC Host Controller on TI OMAP family
> +provides an interface for MMC, SD, and SDIO types of memory cards.
> +
> +Required properties:
> +- compatible: Should be "ti,omap-hsmmc<n>", "ti,omap2-hsmmc";
> +n is controller instance starting 0, for OMAP2/3 controllers

No, no, no. You should not have to specify the unit-address in the compatible
field. They are all programmed the same way, right?

Also, they should go from the specific to the generic, but the first property
is the same for 2/3 and 4. That's wrong.

> +- compatible: Should be "ti,omap-hsmmc<n>", "ti,omap4-hsmmc";
> +n is controller instance starting 0, for OMAP4 controllers
> +- ti,hwmods: Must be "mmc<n>", n is controller instance starting 1

I didn't think hwmod bindings were settled on yet?

> +- reg : should contain hsmmc registers location and length
> +
> +Optional properties:
> +ti,hsmmc-supports-dual-volt: boolean, supports dual voltage cards

ti,dual-voltage is a better name here (by definition, if it has the property it
supports it, the word "supports" is redundant).

> +ti,hsmmc-nr-slots: Number of mmc slots

You shouldn't have to specify this, it can be derived from the number of child
nodes.

> +<supply-name>-supply: phandle to the regulator device tree node
> +"supply-name" examples are "vmmc", "vmmc_aux" etc
> +ti,hsmmc-has-pbias: Has PBIAS cell support
> +ti,hsmmc-has-special-reset: Requires a special softreset sequence

you can drop hsmmc- from the properties here

> +
> +For every supported slot a slot node can be defined
> +with the following optional properties
> +
> +ti,hsmmc-slot-name: Name assocaited to the mmc slot
> +ti,hsmmc-gpio-cd: gpio for card detect
> +ti,hsmmc-gpio-wp: gpio for write protect

Please use the same standard as the other mmc controllers for CD/WP.

> +ti,hsmmc-ocr-mask: mmc/sd/sdio ocr mask

What is OCR mask?

> +ti,hsmmc-non-removable: non-removable slot (like eMMC)

Same here, non-removable should be standardized.


-Olof
