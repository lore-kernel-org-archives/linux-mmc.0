From: "Hiremath, Vaibhav" <hvaibhav-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 2/2] ARM: dts: add AM33XX MMC support
Date: Thu, 7 Mar 2013 14:59:42 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EC20CCA@DBDE01.ent.ti.com>
References: <1362629799-22485-1-git-send-email-mporter@ti.com>
 <1362629799-22485-3-git-send-email-mporter@ti.com>
 <41fde401c8e646689123d7c6d3a2dffc@DLEE71.ent.ti.com>
 <20130307141235.GQ6209@beef>
 <79CD15C6BA57404B839C016229A409A83EC20C57@DBDE01.ent.ti.com>
 <20130307144656.GR6209@beef>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
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
To: "Hiremath, Vaibhav" <hvaibhav-l0cyMroinI0@public.gmane.org>, "Porter, Matt" <mporter-l0cyMroinI0@public.gmane.org>
Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "Krishnamoorthy, Balaji T" <balajitk-l0cyMroinI0@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org


> -----Original Message-----
> From: Hiremath, Vaibhav
> Sent: Thursday, March 07, 2013 8:24 PM
> To: Porter, Matt
> Cc: Linux OMAP List; Russell King; Krishnamoorthy, Balaji T; Devicetree
> Discuss; Linux MMC List; Linux Kernel Mailing List; Chris Ball; Linux
> ARM Kernel List
> Subject: RE: [PATCH 2/2] ARM: dts: add AM33XX MMC support
> 
> > -----Original Message-----
> > From: Matt Porter [mailto:ohiomdp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org] On Behalf Of Porter,
> Matt
> > Sent: Thursday, March 07, 2013 8:17 PM
> > To: Hiremath, Vaibhav
> > Cc: Linux OMAP List; Russell King; Krishnamoorthy, Balaji T;
> Devicetree
> > Discuss; Linux MMC List; Linux Kernel Mailing List; Chris Ball; Linux
> > ARM Kernel List
> > Subject: Re: [PATCH 2/2] ARM: dts: add AM33XX MMC support
> >
> > On Thu, Mar 07, 2013 at 02:39:55PM +0000, Vaibhav Hiremath wrote:
> > >
> > > > -----Original Message-----
> > > > From: Matt Porter [mailto:ohiomdp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org] On Behalf Of Porter,
> > Matt
> > > > Sent: Thursday, March 07, 2013 7:43 PM
> > > > To: Hiremath, Vaibhav
> > > > Cc: Krishnamoorthy, Balaji T; Chris Ball; Cousson, Benoit; Tony
> > > > Lindgren; Russell King; Devicetree Discuss; Linux ARM Kernel
> List;
> > > > Linux OMAP List; Linux Kernel Mailing List; Linux MMC List
> > > > Subject: Re: [PATCH 2/2] ARM: dts: add AM33XX MMC support
> > > >
> > > > On Thu, Mar 07, 2013 at 05:29:24AM +0000, Vaibhav Hiremath wrote:
> > > > > > -----Original Message-----
> > > > > > From: linux-omap-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-omap-
> > > > > > owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Porter, Matt
> > > > > > Sent: Thursday, March 07, 2013 9:47 AM
> > > > > > To: Krishnamoorthy, Balaji T; Chris Ball; Cousson, Benoit;
> Tony
> > > > > > Lindgren; Russell King
> > > > > > Cc: Devicetree Discuss; Linux ARM Kernel List; Linux OMAP
> List;
> > > > Linux
> > > > > > Kernel Mailing List; Linux MMC List
> > > > > > Subject: [PATCH 2/2] ARM: dts: add AM33XX MMC support
> > > > > >
<snip>
> 
> I believe you meant "CONFIG_TI_EDMA" right?
> 
> Yes, I just enabled it and the result is still same.
> 
> 
> 
> [root@arago /]# dmesg | grep -ir mmc
> [    0.506844] vmmc: 1800 <--> 3300 mV at 3300 mV
> [    0.506970] vmmc: supplied by vbat
> [root@arago /]#
> [root@arago /]#
> [root@arago /]# dmesg | grep -ir dma
> [    0.217063] DMA: preallocated 256 KiB pool for atomic coherent
> allocations
> [    0.236321] platform 49000000.edma: alias fck already exists
> [    0.236360] platform 49000000.edma: alias fck already exists
> [    0.236381] platform 49000000.edma: alias fck already exists
> [    0.370705] edma-dma-engine edma-dma-engine.0: TI EDMA DMA engine
> driver
> [    0.445156] omap-dma-engine omap-dma-engine: OMAP DMA engine driver
> [root@arago /]#
> [root@arago /]#
> 
> 
I have applied below patches from your recent post


[2/2] ARM: dts: add AM33XX MMC support 	
[1/2] mmc: omap_hsmmc: set max_segs based on dma engine limits 	
[v4,3/3] mmc: davinci: get SG segment limits with dma_get_slave_sg_limits()
[v4,2/3] dma: edma: add device_slave_sg_limits() support 
[v4,1/3] dmaengine: add dma_get_slave_sg_limits()
[v9,9/9] ARM: dts: add AM33XX SPI DMA support
[v9,8/9] spi: omap2-mcspi: add generic DMA request support to the DT binding
[v9,7/9] spi: omap2-mcspi: convert to dma_request_slave_channel_compat() 
[v9,6/9] ARM: dts: add AM33XX EDMA support 
[v9,5/9] dmaengine: edma: Add TI EDMA device tree binding
[v9,4/9] dmaengine: edma: enable build for AM33XX
[v9,3/9] ARM: edma: add AM33XX support to the private EDMA API
[v9,2/9] ARM: edma: remove unused transfer controller handlers
[v9,1/9] ARM: davinci: move private EDMA API to arm/common
[v3,2/2] mmc: omap_hsmmc: add generic DMA request support to the DT binding
[v3,1/2] mmc: omap_hsmmc: convert to dma_request_slave_channel_compat()



Am I missing anything here?

Thanks,
Vaibhav
