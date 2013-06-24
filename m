From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v12 04/11] dmaengine: edma: enable build for AM33XX
Date: Mon, 24 Jun 2013 16:01:34 +0530
Message-ID: <51C82006.6060008@ti.com>
References: <1371762407-24544-1-git-send-email-joelagnel@ti.com>
	<1371762407-24544-5-git-send-email-joelagnel@ti.com>
	<51C427AA.6080601@ti.com> <20130624101756.GU5523@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <20130624101756.GU5523-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Joel A Fernandes <joelagnel-l0cyMroinI0@public.gmane.org>, Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Koen Kooi <koen-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Andrew Morton <akpm@linux-foundati>
List-Id: linux-mmc@vger.kernel.org


On 6/24/2013 3:47 PM, Tony Lindgren wrote:
> * Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org> [130621 03:21]:
>> On 6/21/2013 2:36 AM, Joel A Fernandes wrote:
>>> From: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
>>>
>>> Enable TI EDMA option on OMAP and TI_PRIV_EDMA
>>>
>>> Signed-off-by: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
>>> Signed-off-by: Joel A Fernandes <joelagnel-l0cyMroinI0@public.gmane.org>
>>
>> This will have to be taken by Tony.
> 
> Sekhar, please go ahead and take this one. I'll reply
> to the header email of this series how it should be
> queued.
> 
> For the mach-omap2/Kconfig change:
> 
> Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

Thanks Tony. Added to v3.11/soc-2 branch with your and Arnd's acks included.

Vinod, it will be nice to get your ack too for the drivers/dma/Kconfig
change.

Regards,
Sekhar

>  
>>> ---
>>>  arch/arm/mach-omap2/Kconfig |    1 +
>>>  drivers/dma/Kconfig         |    2 +-
>>>  2 files changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
>>> index f49cd51..f91b07f 100644
>>> --- a/arch/arm/mach-omap2/Kconfig
>>> +++ b/arch/arm/mach-omap2/Kconfig
>>> @@ -17,6 +17,7 @@ config ARCH_OMAP2PLUS
>>>  	select PROC_DEVICETREE if PROC_FS
>>>  	select SOC_BUS
>>>  	select SPARSE_IRQ
>>> +	select TI_PRIV_EDMA
>>>  	select USE_OF
>>>  	help
>>>  	  Systems based on OMAP2, OMAP3, OMAP4 or OMAP5
>>> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
>>> index e992489..3215a3c 100644
>>> --- a/drivers/dma/Kconfig
>>> +++ b/drivers/dma/Kconfig
>>> @@ -213,7 +213,7 @@ config SIRF_DMA
>>>  
>>>  config TI_EDMA
>>>  	tristate "TI EDMA support"
>>> -	depends on ARCH_DAVINCI
>>> +	depends on ARCH_DAVINCI || ARCH_OMAP
>>>  	select DMA_ENGINE
>>>  	select DMA_VIRTUAL_CHANNELS
>>>  	default n
>>>
> 
> 
