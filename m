From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH v3 02/16] ARM: davinci: move private EDMA API to
 arm/common
Date: Tue, 22 Jan 2013 21:10:06 +0530
Message-ID: <50FEB2D6.50300@ti.com>
References: <1350566815-409-1-git-send-email-mporter@ti.com>
 <1350566815-409-3-git-send-email-mporter@ti.com> <508CEA05.8060200@ti.com>
 <20130110235157.GU14660@beef>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130110235157.GU14660@beef>
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
To: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Matt,

Sorry about the late reply. I noticed this mail only after I started to
look at v5 of your series :(

On 1/11/2013 5:21 AM, Matt Porter wrote:
> On Sun, Oct 28, 2012 at 01:47:09PM +0530, Sekhar Nori wrote:
>> On 10/18/2012 6:56 PM, Matt Porter wrote:
>>> Move mach-davinci/dma.c to common/edma.c so it can be used
>>> by OMAP (specifically AM33xx) as well. This just moves the
>>> private EDMA API but does not support OMAP.
>>>
>>> Signed-off-by: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
>>> ---
>>
>>> diff --git a/arch/arm/mach-davinci/devices.c b/arch/arm/mach-davinci/devices.c
>>> index 4c48a36..f45d591 100644
>>> --- a/arch/arm/mach-davinci/devices.c
>>> +++ b/arch/arm/mach-davinci/devices.c
>>> @@ -19,9 +19,10 @@
>>>  #include <mach/irqs.h>
>>>  #include <mach/cputype.h>
>>>  #include <mach/mux.h>
>>> -#include <mach/edma.h>
>>>  #include <linux/platform_data/mmc-davinci.h>
>>>  #include <mach/time.h>
>>> +#include <linux/platform_data/edma.h>
>>
>> Can you please introduce a patch to clean this mixture of linux/ and
>> mach/ includes?
> 
> Yeah, are you ok with a follow on series to clean all these files? I
> don't want to make this series longer with something not dma related
> that's purely cleanup from the great header reorg of 2012.

Okay. I agree doing this sort of change now will cause merge issues.

> 
>>> +
>>>  
>>>  #include "davinci.h"
>>>  #include "clock.h"
>>> @@ -141,10 +142,10 @@ static struct resource mmcsd0_resources[] = {
>>>  	},
>>>  	/* DMA channels: RX, then TX */
>>>  	{
>>> -		.start = EDMA_CTLR_CHAN(0, DAVINCI_DMA_MMCRXEVT),
>>> +		.start = EDMA_CTLR_CHAN(0, 26),
>>
>> Instead of just replacing the event #defines with plain numbers, can you
>> introduce a mach-davinci local edma.h which can then be included in the
>> davinci platform files which refer to edma channel numbers?
> 
> Ok, so when I removed the old edma.h it was full of unused defines and
> we are left with just this one. If I introduced something like that it
> would be used in just one place here. and only for these two values.
> How about we just add a comment?

I prefer adding a local #define in this file. This will keep it
consistent with what is done in arch/arm/mach-davinci/dm365.c for
example. Same for the change in sound/soc/davinci/davinci-sffsdr.c

> 
>>
>>> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
>>> index 7cd56ed..153fab8 100644
>>> --- a/arch/arm/plat-omap/Kconfig
>>> +++ b/arch/arm/plat-omap/Kconfig
>>> @@ -28,6 +28,7 @@ config ARCH_OMAP2PLUS
>>>  	select OMAP_DM_TIMER
>>>  	select PROC_DEVICETREE if PROC_FS
>>>  	select SPARSE_IRQ
>>> +	select TI_PRIV_EDMA
>>
>> This hunk does not seem to belong to subject of this patch.
> 
> Let me reword the subject/description. The idea of this logical
> chunk was to put everything in place to make it build on OMAP,
> with the expectation that the build fails without the next patch
> in the series.

But this will break bisect. With just this patch applied, omap build
breaks. Looks like it will be more logical to merge this hunk with 3/14
since that's when you really start using the private DMA support on OMAP
platforms.

This issue is a must fix IMO.

I am ok with the patch otherwise. With these changes done, you can add:

Acked-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>

Thanks,
Sekhar
