From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Add quirk to avoid erroneous msg
Date: Tue, 6 Mar 2018 08:55:27 +0800
Message-ID: <755a8dc5-cbda-8a99-d106-8269b390de6d@rock-chips.com>
References: <1519739731-27920-1-git-send-email-phil.edworthy@renesas.com>
 <b35a8ac6-af47-5851-95ae-371288bb5f25@rock-chips.com>
 <HK2PR0601MB1393B39958A128DCB8CA0E44F5C00@HK2PR0601MB1393.apcprd06.prod.outlook.com>
 <b725dcf5-2f53-dab7-1e0c-85ea138f54a9@rock-chips.com>
 <HK2PR0601MB139380F295EF5CE849288F91F5C00@HK2PR0601MB1393.apcprd06.prod.outlook.com>
 <52191012-300a-e13d-fa54-8717eb97c2e1@rock-chips.com>
 <HK2PR0601MB139301F701386BB74CF369E2F5DA0@HK2PR0601MB1393.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <HK2PR0601MB139301F701386BB74CF369E2F5DA0@HK2PR0601MB1393.apcprd06.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: shawn.lin@rock-chips.com, Adrian Hunter <adrian.hunter@intel.com>, Michal Simek <michal.simek@xilinx.com>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org


On 2018/3/6 0:47, Phil Edworthy wrote:
> Hi Shawn,
> 
> On 28 February 2018 01:53, Shawn Lin wrote:
>> On 2018/2/27 23:05, Phil Edworthy wrote:
>>> On 27 February 2018 14:42, Shawn Lin wrote:
>>>> On 2018/2/27 22:31, Phil Edworthy wrote:
>>>>> On 27 February 2018 14:28, Shawn Lin wrote:
>>>>>> 在 2018/2/27 21:55, Phil Edworthy 写道:
>>>>>>> Since the controller does not support the end-of-busy IRQ, don't use
>> it.
>>>>>>> Otherwise, on older SD cards you will get lots of these messages:
>>>>>>> "mmc0: Got data interrupt 0x00000002 even though no data operation
>>>>>>> was
>>>>>> in progress"
>>>>>>>
>>>>>>
>>>>>> I'm afraid you have to explain which version of arasan's IP suffer
>>>>>> from this and what does the "older SD cards" mean?
>>>>> Ok, I'll try to find out the IP version...
>>>>> For "older SD cards", I can provide a list of a few cards that
>>>>> exhibit this problem and others that don't, is that enough info?
>>>>
>>>> What I meant is could you elaborate more about what kind of cards,
>>>> e.g, are them the  legacy SDSC cards or SDHC cards, or maybe they are
>>>> only running with defaut speed? or whatever, but not just with a
>>>> vague "older" cards. :)
>>> Unfortunately, I have one SDHC card that works, one that doesn't. Both
>>> cards are running with a 50MHz SD clock. All I know is this:
>>
>> Thanks for sharing these, though it looks wired as I never remember I saw
>> this problem when extensively tested SD cards on one of arasan controllers
>> in 2014.
> Not sure what you mean by 'wired'?
> 
> Note that this is on a relatively slow device, a dual core Cortex A7 @500MHz.
> Maybe that has some effect.

That's why I hope you could add the IP version in your commit msg, and
that would be a hint for why it behaved different over platforms.

> 
> It's also interesting that someone posted the same fix for Xilinx a while
> back, I linked to it in the commit msg.
> 
> Thanks
> Phil
> 
> 
>>> SD cards that report unexpected interrupts:
>>> 2GB Sandisk Extreme III                     (e624 SD02G 1.89 GiB)
>>> 8GB Sandisk (SDHC class 4)              (aaaa SU08G 7.40 GiB)
>>> 8GB Sandisk Extreme III (SDHC class 6)    (bb4e SD08G 7.61 GiB)
>>>
>>> SD cards that work ok:
>>> 16GB Samsung (microSDHC U1 class 10)          (0001 00000 14.6 GiB)
>>> 16GB Sandisk Ultra (microSDHC U1 class 10)    (aaaa SL16G 14.8 GiB)
>>> 32GB Sandisk Ultra (microSDHC U1 class 10)    (aaaa SL32G 29.7 GiB)
>>>
>>> Thanks
>>> Phil
>>>
>>>>>>> This has been reported on Xilinx devices that also use the Arasan IP.
>>>>>>> See https://patchwork.kernel.org/patch/8062871/
>>>>>>>
>>>>>>> This has been tested on the Renesas RZ/ND-DB board with the RZ/N1
>>>> SoC.
>>>>>>>
>>>>>>> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
>>>>>>> ---
>>>>>>>      drivers/mmc/host/sdhci-of-arasan.c | 3 ++-
>>>>>>>      1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/drivers/mmc/host/sdhci-of-arasan.c
>>>>>>> b/drivers/mmc/host/sdhci-of-arasan.c
>>>>>>> index c33a5f7..ab66e32 100644
>>>>>>> --- a/drivers/mmc/host/sdhci-of-arasan.c
>>>>>>> +++ b/drivers/mmc/host/sdhci-of-arasan.c
>>>>>>> @@ -290,7 +290,8 @@ static const struct sdhci_pltfm_data
>>>>>> sdhci_arasan_pdata = {
>>>>>>>      	.ops = &sdhci_arasan_ops,
>>>>>>>      	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
>>>>>>>      	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
>>>>>>> -			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
>>>>>>> +			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN
>> |
>>>>>>> +			SDHCI_QUIRK2_STOP_WITH_TC,
>>>>>>>      };
>>>>>>>
>>>>>>>      static u32 sdhci_arasan_cqhci_irq(struct sdhci_host *host, u32
>>>>>>> intmask)
>>>>>>>
>>>>>>
>>>>>>
>>>>>> --
>>>>>> Best Regards
>>>>>> Shawn Lin
>>>>>
>>>>>
>>>>>
>>>>>
>>>>
>>>>
>>>> --
>>>> Best Regards
>>>> Shawn Lin
>>>
>>>
>>>
>>>
> 
> 
> 
> 
