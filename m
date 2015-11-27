From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC 3/6] dmaengine: core: Introduce new,
 universal API to request a channel
Date: Fri, 27 Nov 2015 12:00:10 +0100
Message-ID: <24788322.ynD35Kf0xi@wuerfel>
References: <1448612982-28141-1-git-send-email-peter.ujfalusi@ti.com>
 <1448612982-28141-4-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1448612982-28141-4-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: vinod.koul@intel.com, nsekhar@ti.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Friday 27 November 2015 10:29:39 Peter Ujfalusi wrote:
> struct dma_chan *dma_request_chan(struct device *dev, const char *name,
> 				  const dma_cap_mask_t *mask);
> To request a slave channel. The mask parameter is optional and it is used
> to check if the received channel's capabilities can satisfy the requested
> mask. The dma_request_chan() will try to find the channel via DT, ACPI or
> in case if the kernel booted in non DT/ACPI mode it will use a filter
> lookup table and retrieves the RESOURCE_DMA from the requester's device.
> This legacy mode needs changes in platform code, in dmaengine drivers and
> finally the dmaengine user drivers can be converted:

I think we should not introduce the mask parameter at all. In the rare
case that we actually need to pass a mask other than DMA_SLAVE today,
we should be able to encode that in the data we pass to the filter
function.

> RESOURCE_DMA needs to be added to the platform devices with names
> 
> For each dmaengine driver a string array listing the devices handled by the
> given DMA driver:
> 
> static char *da8xx_edma0_devices[] = {
> 	"davinci-mcasp.0",
> 	"da830-mmc.0",
> };
> 
> This information is going to be needed by the dmaengine driver, so
> modification to the platform_data is needed, and the driver map should be
> added to the pdata of the DMA driver:

However, a lot of drivers definitely need to pass a data pointer for
each device. I see that you currently rely on the IORESOURCE_DMA
method that a couple of platforms use today, but I think it would
be backwards to do it that way for the platforms that require passing
more than an integer number today.

Having a pointer as the filter function argument is intentional and I'd
prefer to change the platforms that currently use IORESOURCE_DMA (davinci,
pxa, omap1, blackfin, alchemy) to stop doing it instead, and return
IORESOURCE_DMA to its original meaning that was limited to ISAPNP style
devices not using the dmaengine API.

	Arnd
