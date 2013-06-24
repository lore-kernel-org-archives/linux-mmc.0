From: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v12 00/11] DMA Engine support for AM33XX
Date: Mon, 24 Jun 2013 16:36:08 +0200
Message-ID: <51C85958.9030502@ti.com>
References: <1371762407-24544-1-git-send-email-joelagnel@ti.com>
	<20130624101903.GV5523@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <20130624101903.GV5523-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Joel A Fernandes <joelagnel-l0cyMroinI0@public.gmane.org>, Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Koen Kooi <koen-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Andrew Morton <akpm@linux-foundat>
List-Id: linux-mmc@vger.kernel.org

Hi Tony,

On 06/24/2013 12:19 PM, Tony Lindgren wrote:
> Hi,
> 
> For merging this series, I suggest the following sets:
> 
> * Joel A Fernandes <joelagnel-l0cyMroinI0@public.gmane.org> [130620 14:13]:
>>
>> Joel A Fernandes (3):
>>   edma: config: Enable config options for EDMA
>>   da8xx: config: Enable MMC and FS options
>>   ARM: davinci: Fix compiler warnings in devices-da8xx
>>
>> Matt Porter (8):
>>   dmaengine: edma: Add TI EDMA device tree binding
>>   ARM: edma: Add DT and runtime PM support to the private EDMA API
>>   ARM: edma: Add EDMA crossbar event mux support
>>   dmaengine: edma: enable build for AM33XX
> 
> Sekhar should queue the above patches, I've acked the
> mach-omap2/Kconfig change.
> 
>>   spi: omap2-mcspi: add generic DMA request support to the DT binding
>>   spi: omap2-mcspi: convert to dma_request_slave_channel_compat()
> 
> 
> The spi changes should get merged via the driver list.
> 
>>   ARM: dts: add AM33XX EDMA support
>>   ARM: dts: add AM33XX SPI DMA support
> 
> Benoit should queue the .dts changes.

I'll do that, but do you consider them for 3.11?

Thanks,
Benoit
