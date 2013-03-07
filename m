From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v9 3/9] ARM: edma: add AM33XX support to the private EDMA API
Date: Thu, 7 Mar 2013 08:42:18 +0200
Message-ID: <CAHp75Ve40sM-d9Gr3k6mgOOTkM_G+cYSPcftqqsuAi-MzEb9dg@mail.gmail.com>
References: <1362586540-10393-1-git-send-email-mporter@ti.com>
	<1362586540-10393-4-git-send-email-mporter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1362586540-10393-4-git-send-email-mporter@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Matt Porter <mporter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Benoit Cousson <b-cousson@ti.com>, Russell King <linux@arm.linux.org.uk>, Rob Landley <rob@landley.net>, Andrew Morton <akpm@linux-foundation.org>, Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Documentation List <linux-doc@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux SPI Devel List <spi-devel-general@lists.sourceforge.net>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-mmc@vger.kernel.org

On Wed, Mar 6, 2013 at 6:15 PM, Matt Porter <mporter@ti.com> wrote:
> Adds support for parsing the TI EDMA DT data into the
> required EDMA private API platform data. Enables runtime
> PM support to initialize the EDMA hwmod. Adds AM33XX EDMA
> crossbar event mux support. Enables build on OMAP.

> --- a/arch/arm/common/edma.c
> +++ b/arch/arm/common/edma.c

> +static int edma_xbar_event_map(struct device *dev,
> +                              struct device_node *node,
> +                              struct edma_soc_info *pdata, int len)
> +{
> +       int ret = 0;
> +       int i;
> +       struct resource res;
> +       void *xbar;
> +       const s16 (*xbar_chans)[2];
> +       u32 shift, offset, mux;
> +
> +       xbar_chans = devm_kzalloc(dev,
> +                                 len/sizeof(s16) + 2*sizeof(s16),
> +                                 GFP_KERNEL);
> +       if (!xbar_chans)
> +               return -ENOMEM;
> +
> +       ret = of_address_to_resource(node, 1, &res);
> +       if (ret)
> +               return -EIO;
> +
> +       xbar = devm_ioremap(dev, res.start, resource_size(&res));
> +       if (!xbar)
> +               return -ENOMEM;
> +
> +       ret = edma_of_read_u32_to_s16_array(node,
> +                                           "ti,edma-xbar-event-map",
> +                                           (s16 *)xbar_chans,
> +                                           len/sizeof(u32));
> +       if (ret)
> +               return -EIO;
> +
> +       for (i = 0; xbar_chans[i][0] != -1; i++) {
> +               shift = (xbar_chans[i][1] % 4) * 8;

Looks like shift = (xbar_chans[i][1] & 0x03) << 3;

> +               offset = xbar_chans[i][1] >> 2;
> +               offset <<= 2;

Is it offset = xbar_chans[i][1] & 0xfffc; ?

> +               mux = readl((void *)((u32)xbar + offset));
> +               mux &= ~(0xff << shift);
> +               mux |= xbar_chans[i][0] << shift;
> +               writel(mux, (void *)((u32)xbar + offset));
> +       }


-- 
With Best Regards,
Andy Shevchenko
