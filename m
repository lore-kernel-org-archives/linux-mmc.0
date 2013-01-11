From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 07/14] dmaengine: add
 dma_request_slave_channel_compat()
Date: Fri, 11 Jan 2013 09:52:23 -0800
Message-ID: <20130111175223.GF14149@atomide.com>
References: <1357883330-5364-1-git-send-email-mporter@ti.com>
 <1357883330-5364-8-git-send-email-mporter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1357883330-5364-8-git-send-email-mporter@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Matt Porter <mporter@ti.com>
Cc: Sekhar Nori <nsekhar@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Benoit Cousson <b-cousson@ti.com>, Russell King <linux@arm.linux.org.uk>, Vinod Koul <vinod.koul@intel.com>, Rob Landley <rob@landley.net>, Chris Ball <cjb@laptop.org>, Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Documentation List <linux-doc@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux SPI Devel List <spi-devel-general@lists.sourceforge.net>, Arnd Bergmann <arnd@arndb.de>, Dan Williams <djbw@fb.com>, Rob Herring <rob.herring@calxeda.com>
List-Id: linux-mmc@vger.kernel.org

* Matt Porter <mporter@ti.com> [130110 21:47]:
> Adds a dma_request_slave_channel_compat() wrapper which accepts
> both the arguments from dma_request_channel() and
> dma_request_slave_channel(). Based on whether the driver is
> instantiated via DT, the appropriate channel request call will be
> made.
> 
> This allows for a much cleaner migration of drivers to the
> dmaengine DT API as platforms continue to be mixed between those
> that boot using DT and those that do not.

Cool, looks like the driver changes are quite minimal after this:

Acked-by: Tony Lindgren <tony@atomide.com>

> 
> Suggested-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Matt Porter <mporter@ti.com>
> ---
>  include/linux/dmaengine.h |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 9fd0c5b..64f9f69 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -1047,6 +1047,16 @@ void dma_run_dependencies(struct dma_async_tx_descriptor *tx);
>  struct dma_chan *dma_find_channel(enum dma_transaction_type tx_type);
>  struct dma_chan *net_dma_find_channel(void);
>  #define dma_request_channel(mask, x, y) __dma_request_channel(&(mask), x, y)
> +static inline struct dma_chan
> +*dma_request_slave_channel_compat(dma_cap_mask_t mask, dma_filter_fn fn,
> +				  void *fn_param, struct device *dev,
> +				  char *name)
> +{
> +	if (dev->of_node)
> +		return dma_request_slave_channel(dev, name);
> +	else
> +		return dma_request_channel(mask, fn, fn_param);
> +}
>  
>  /* --- Helper iov-locking functions --- */
>  
> -- 
> 1.7.9.5
> 
