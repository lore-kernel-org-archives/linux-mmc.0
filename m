From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v10 5/8] dmaengine: edma: Add TI EDMA device tree binding
Date: Tue, 18 Jun 2013 10:10:51 +0530
Message-ID: <51BFE4D3.50509@ti.com>
References: <1371263570-9323-1-git-send-email-joelagnel@ti.com>
	<1371263570-9323-5-git-send-email-joelagnel@ti.com>
	<3940138.jZFEtfGGLz@wuerfel>
	<083BC63EECB6FD41B8E81CF7FD87CC0F2E4E9395@DLEE08.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <083BC63EECB6FD41B8E81CF7FD87CC0F2E4E9395-YmePFLaaepqIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: "Fernandes, Joel A" <joelagnel-l0cyMroinI0@public.gmane.org>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "Cousson,  Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Koen Kooi <koen-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uv+2+P5yyue3@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org


On 6/17/2013 9:10 PM, Fernandes, Joel A wrote:
> Hi Arnd,
> 
>> -----Original Message-----
>> From: Arnd Bergmann [mailto:arnd-r2nGTMty4D4@public.gmane.org]
>> Sent: Monday, June 17, 2013 6:13 AM
>> To: Fernandes, Joel A
>> Cc: Tony Lindgren; Nori, Sekhar; Matt Porter; Grant Likely; Rob Herring; Vinod
>> Koul; Mark Brown; Cousson, Benoit; Russell King; Rob Landley; Andrew
>> Morton; Jason Kridner; Koen Kooi; Devicetree Discuss; Linux OMAP List; Linux
>> ARM Kernel List; Linux DaVinci Kernel List; Linux Kernel Mailing List; Linux
>> Documentation List; Linux MMC List; Linux SPI Devel List
>> Subject: Re: [PATCH v10 5/8] dmaengine: edma: Add TI EDMA device tree
>> binding
>>
>> On Friday 14 June 2013 21:32:47 Joel A Fernandes wrote:
>>>
>>> diff --git a/Documentation/devicetree/bindings/dma/ti-edma.txt
>>> b/Documentation/devicetree/bindings/dma/ti-edma.txt
>>> new file mode 100644
>>> index 0000000..ada0018
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/dma/ti-edma.txt
>>> @@ -0,0 +1,26 @@
>>> +TI EDMA
>>> +
>>> +Required properties:
>>> +- compatible : "ti,edma3"
>>> +- ti,hwmods: Name of the hwmods associated to the EDMA
>>> +- ti,edma-regions: Number of regions
>>> +- ti,edma-slots: Number of slots
>>> +
>>> +Optional properties:
>>> +- ti,edma-xbar-event-map: Crossbar event to channel map
>>
>> You need to list #dma-cells as required here, and which values are accepted
>> by the driver (I suppose only <1>). You should also explain the format of the
>> dma-specifier for a slave here for each possible value of #dma-cells.
>>
>> For each of the standard properties (reg, interrupts, dma-channels), list
>> whether they are optional or required. Since the example has three
>> interrupts, you should probably list how many interrupts need to be specified
>> (minimum and maximum if the number is variable) and in what order to
>> expect them.
>  
> [Joel] Thanks for the suggestion, I updated it and it looks like this now:
>                                                                                                              
> Required properties:                                                                                                                   
> - compatible : "ti,edma3"                                                                                                              
> - ti,hwmods: Name of the hwmods associated to the EDMA  

I have already asked for ti,hwmods to be made optional. Please see my
comment from yesterday.

Thanks,
Sekhar
