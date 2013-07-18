From: Joel Fernandes <joelf@ti.com>
Subject: Re: ARM: AM335x: Kernel oops when using EDMA and MMC
Date: Thu, 18 Jul 2013 12:02:12 -0500
Message-ID: <51E81F94.7090804@ti.com>
References: <51E6BE84.6080905@newflow.co.uk> <51E6C88B.8090608@ti.com> <51E81A7E.9030805@ti.com> <51E81C0E.6070709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <51E81C0E.6070709@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: Balaji T K <balajitk@ti.com>, Mark Jackson <mpfj-list@newflow.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

On 07/18/2013 11:47 AM, Daniel Mack wrote:
> Hi Balaji,
> 
> On 18.07.2013 18:40, Balaji T K wrote:
>> With DMA channel info retrieved from dt binding on 3.11rc1,
>> unused_chan_list is broken after hwmod cleanup removing mmc sdma
>> resource info, hence pdev resource wont have DMA resource populated.
>>
>> arch/arm/common/edma.c
>> static int prepare_unused_channel_list(struct device *dev, void *data)
>> {
>> 	struct platform_device *pdev = to_platform_device(dev);
>> 	int i, ctlr;
>>
>> 	for (i = 0; i < pdev->num_resources; i++) {
>> 		if ((pdev->resource[i].flags & IORESOURCE_DMA) &&
>> 				(int)pdev->resource[i].start >= 0) {
>> 			ctlr = EDMA_CTLR(pdev->resource[i].start);
>> 			clear_bit(EDMA_CHAN_SLOT(pdev->resource[i].start),
>> 					edma_cc[ctlr]->edma_unused);
>> 		}
>> 	}
>>
>> 	return 0;
>> }
>>
>> int edma_alloc_channel(int channel,
>> 	if (!unused_chan_list_done) {
>> 		/*
>> 		 * Scan all the platform devices to find out the EDMA channels
>> 		 * used and clear them in the unused list, making the rest
>> 		 * available for ARM usage.
>> 		 */
>> 		ret = bus_for_each_dev(&platform_bus_type, NULL, NULL,
>> 				prepare_unused_channel_list);
>> 		if (ret < 0)
>> 			return ret;
>>
>> 		unused_chan_list_done = true;
>> 	}
>>
>> ===========
>>
>> with the below hack patch, edma is working fine with mmc on your 3.11rc1+ branch
>>
>> diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
>> index a432e6c..5a19164 100644
>> --- a/arch/arm/common/edma.c
>> +++ b/arch/arm/common/edma.c
>> @@ -1262,8 +1262,8 @@ int edma_start(unsigned channel)
>>   		if (test_bit(channel, edma_cc[ctlr]->edma_unused)) {
>>   			pr_debug("EDMA: ESR%d %08x\n", j,
>>   				edma_shadow0_read_array(ctlr, SH_ESR, j));
>> -			edma_shadow0_write_array(ctlr, SH_ESR, j, mask);
>> -			return 0;
>> +//			edma_shadow0_write_array(ctlr, SH_ESR, j, mask);
>> +//			return 0;
>>   		}
>>
>>   		/* EDMA channel with event association */
>>
> 
> Yes, this in fact works for me as well. Thanks for the quick reply! What
> would be the proper fix for this?

Correct fix would be in the common EDMA driver to populate the unused
channel list correctly as found by Balaji.

Thanks,

-Joel
