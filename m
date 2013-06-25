From: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v12 00/11] DMA Engine support for AM33XX
Date: Tue, 25 Jun 2013 10:42:49 -0400
Message-ID: <51C9AC69.6060604@ti.com>
References: <1371762407-24544-1-git-send-email-joelagnel@ti.com>
	<20130624101903.GV5523@atomide.com> <51C85958.9030502@ti.com>
	<20130625065450.GY5523@atomide.com> <51C9A634.6030605@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <51C9A634.6030605-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Cc: Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Koen Kooi <koen-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Joel A Fernandes <joelagnel-l0cyMroinI0@public.gmane.org>, Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>Linux
List-Id: linux-mmc@vger.kernel.org

On Tuesday 25 June 2013 10:16 AM, Sekhar Nori wrote:
> On 6/25/2013 12:24 PM, Tony Lindgren wrote:
>> * Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org> [130624 07:42]:
>>> Hi Tony,
>>>
>>> On 06/24/2013 12:19 PM, Tony Lindgren wrote:
>>>> Hi,
>>>>
>>>> For merging this series, I suggest the following sets:
>>>>
>>>> * Joel A Fernandes <joelagnel-l0cyMroinI0@public.gmane.org> [130620 14:13]:
>>>>>
>>>>> Joel A Fernandes (3):
>>>>>   edma: config: Enable config options for EDMA
>>>>>   da8xx: config: Enable MMC and FS options
>>>>>   ARM: davinci: Fix compiler warnings in devices-da8xx
>>>>>
>>>>> Matt Porter (8):
>>>>>   dmaengine: edma: Add TI EDMA device tree binding
>>>>>   ARM: edma: Add DT and runtime PM support to the private EDMA API
>>>>>   ARM: edma: Add EDMA crossbar event mux support
>>>>>   dmaengine: edma: enable build for AM33XX
>>>>
>>>> Sekhar should queue the above patches, I've acked the
>>>> mach-omap2/Kconfig change.
>>>>
>>>>>   spi: omap2-mcspi: add generic DMA request support to the DT binding
>>>>>   spi: omap2-mcspi: convert to dma_request_slave_channel_compat()
>>>>
>>>>
>>>> The spi changes should get merged via the driver list.
>>>>
>>>>>   ARM: dts: add AM33XX EDMA support
>>>>>   ARM: dts: add AM33XX SPI DMA support
>>>>
>>>> Benoit should queue the .dts changes.
>>>
>>> I'll do that, but do you consider them for 3.11?
>>
>> Yes right after -rc1 if it makes the DMA work. We almost
>> certainly need to send few branches of fixes after -rc1 once
>> we find out what might have broken by the removal of the
>> hwmod data..
> 
> The DMA related changes went into arm-soc yesterday. So it should be
> safe to send the DT patches in before the merge window opens. If Tony is
> done with sending his pull requests may be Benoit can send to arm-soc
> directly?
> 
I was just typing the same thing. Even if Tony send them during rc's,
thats fine.

Regards,
Santosh
