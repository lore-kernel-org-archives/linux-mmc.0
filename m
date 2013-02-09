From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v7 01/10] ARM: davinci: move private EDMA API to
	arm/common
Date: Sat, 9 Feb 2013 20:08:50 +0000
Message-ID: <20130209200850.GK17852@n2100.arm.linux.org.uk>
References: <1359742975-10421-1-git-send-email-mporter@ti.com> <1359742975-10421-2-git-send-email-mporter@ti.com> <511673E1.7000908@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <511673E1.7000908@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Matt Porter <mporter@ti.com>, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Benoit Cousson <b-cousson@ti.com>, Vinod Koul <vinod.koul@intel.com>, Rob Landley <rob@landley.net>, Chris Ball <cjb@laptop.org>, Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Documentation List <linux-doc@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux SPI Devel List <spi-devel-general@lists.sourceforge.net>, Arnd Bergmann <arnd@arndb.de>, Dan Williams <djbw@fb.com>, Rob Herring <rob.herring@calxeda.com>
List-Id: linux-mmc@vger.kernel.org

On Sat, Feb 09, 2013 at 09:35:53PM +0530, Sekhar Nori wrote:
> On 2/1/2013 11:52 PM, Matt Porter wrote:
> > +	ret = of_address_to_resource(node, 1, &res);
> 
> of_address_to_resource() needs <linux/of_address.h>
> 
> > +	if (IS_ERR_VALUE(ret))
> 
> This needs <linux/err.h>

More importantly, is this the correct way to check for errors from
of_address_to_resource() ?  Grepping the source shows that either less
than 0 or non-zero are the commonly used conditions here.
