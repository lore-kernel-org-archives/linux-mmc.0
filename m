From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3] ARM: EDMA: Fix clearing of unused list for DT DMA
	resources
Date: Tue, 17 Sep 2013 10:38:19 +0530
Message-ID: <5237E3C3.8050602@ti.com>
References: <1378839171-14455-1-git-send-email-joelf@ti.com>
	<5231903F.7080301@ti.com> <5233B471.40603@ti.com>
	<5236F00B.5040605@ti.com> <5237314D.7080102@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <5237314D.7080102-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pantel Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Koen Kooi <koen-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Jyri Sarah <jsarha-l0cyMroinI0@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Monday 16 September 2013 09:56 PM, Joel Fernandes wrote:
> On 09/16/2013 06:48 AM, Sekhar Nori wrote:
>> Hi Joel,
>>
>> On Saturday 14 September 2013 06:27 AM, Joel Fernandes wrote:
>>> From: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
>>> Subject: [PATCH v4] ARM: EDMA: Fix clearing of unused list for DT DMA resources
>>>
>>> HWMOD removal for MMC is breaking edma_start as the events are being manually
>>> triggered due to unused channel list not being clear.
>>>
>>> This patch fixes the issue, by reading the "dmas" property from the DT node if
>>> it exists and clearing the bits in the unused channel list. For this purpose
>>> we use the of_* helpers to parse the arguments in the dmas phandle list.
>>>
>>> Reviewed-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
>>> Reported-by: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
>>> Cc: Pantel Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
>>> Signed-off-by: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
>>> ---
>>> Changes since v1, in v2 and v3:
>>> - Reduced indentation of non-of case by returning from of-case
>>> - Using of_* helpers for parsing
>>>
>>> Note:
>>> This patch should go into the merge window as it is a critical bug fix.
>>
>> I still cannot find any users of edma in the device tree sources either
>> in linux-next or linus/master. Why cannot this wait until v3.13?
> 
> I understand this affects only DT users of EDMA. But I get so many private
> reports of breakage due to this patch not being there that I think it will save
> everyone a lot of pain, specially folks creating integration trees to have this
> patch available by default.

Well, I do agree that the current DT support for EDMA is incomplete
without this patch even if there are no in-kernel users of it. I will
try sending this for the next -rc if we get to the final version in time
and after that its upto the upstreams to take it.

>>>  arch/arm/common/edma.c | 23 +++++++++++++++++++++--
>>>  1 file changed, 21 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
>>> index 39ad030..43c7b22 100644
>>> --- a/arch/arm/common/edma.c
>>> +++ b/arch/arm/common/edma.c
>>> @@ -560,14 +560,33 @@ static int reserve_contiguous_slots(int ctlr, unsigned int
>>> id,
>>>  static int prepare_unused_channel_list(struct device *dev, void *data)
>>>  {
>>>  	struct platform_device *pdev = to_platform_device(dev);
>>> -	int i, ctlr;
>>> +	int i, count, ctlr;
>>> +	struct of_phandle_args  dma_spec;
>>>
>>> +	if (dev->of_node) {
>>> +		count = of_property_count_strings(dev->of_node, "dma-names");
>>> +		if (count < 0)
>>> +			return 0;
>>> +		for (i = 0; i < count; i++) {
>>> +			if (of_parse_phandle_with_args(dev->of_node, "dmas",
>>> +						       "#dma-cells", i,
>>> +						       &dma_spec))
>>> +				continue;
>>
>> This will break for the case where devices on platform bus use non-EDMA
>> dma controllers like SDMA or CPPI (DRA7x has both EDMA and SDMA on the
>> same chip). You need to do an additional check to make sure the dma
>> controller is indeed EDMA. Something like.
> 
> Ok, edma is probed earlier so I could never see any problem.

This has got nothing to do with edma probe order.

> Thanks for pointing this out,
> 
> Using the below method is more future-proof than using compatible literal
> strings directly. The only problem is the matches table has to be defined
> earlier in the sources. What do you think?
> 
>                         if (!of_match_node(edma_of_ids, dma_spec.np) {
>                                 of_node_put(dma_spec.np);
>                                 continue;
>                         }

Looks fine to me.

>> 	if(!of_device_is_compatible(dma_spec.np, "ti,edma3"))
>> 		continue;
>>
>> Don forget to call of_node_put() on dma_spec.np (something that needs to
>> be done even with your current code).
> 
> Ok, will do.
> 
> 
>>> +
>>> +			ctlr = EDMA_CTLR(dma_spec.args[0]);
>>> +			clear_bit(EDMA_CHAN_SLOT(dma_spec.args[0]),
>>> +				  edma_cc[ctlr]->edma_unused);
>>
>> We don't support the second controller when using DT and the controller
>> number is not really encoded in the argument to edma phandle. So just
>> simplify this to:
>>
>> 	clear_bit(EDMA_CHAN_SLOT(dma_spec.args[0]), 	
>> 		  edma_cc[0]->edma_unused);
> 
> I think let's not make that assumption just incase in the future we support more
> than one EDMA controller for DT-based boot. Is that ok?

We don't write future proof code in that _hope_ that it will get used
someday.  In fact this will confuse the reader into wondering if support
for second channel controller is present or not as the code will send
mixed messages. In short, we aim for consistency with situation today,
not tomorrow.

Besides, I can bet that when second CC support does get added, it is
very unlikely that the CC number is get encoded into channel number when
using DT.

Thanks,
Sekhar
