From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 1/2] mmc: core: Improve marking broken HPI through
 devicetree
Date: Tue, 19 Apr 2016 21:44:57 +0900
Message-ID: <57162849.3070108@samsung.com>
References: <1461049934-12848-1-git-send-email-oliver@schinagl.nl>
 <1461049934-12848-2-git-send-email-oliver@schinagl.nl>
 <CAPDyKFqftYtrHvcQB7te1fuWxjWtrhOGY=5DnRTnrRxHm2cQ-A@mail.gmail.com>
 <5715FD6B.5000809@schinagl.nl> <5715FF1B.80402@samsung.com>
 <57162270.6040701@schinagl.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:44105 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486AbcDSMpA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Apr 2016 08:45:00 -0400
In-reply-to: <57162270.6040701@schinagl.nl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olliver Schinagl <oliver@schinagl.nl>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Michal Hocko <mhocko@suse.com>, Lars-Peter Clausen <lars@metafoo.de>, Sudeep Holla <Sudeep.Holla@arm.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Wenkai Du <wenkai.du@intel.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Hans de Goede <hdegoede@redhat.com>, Michal Suchanek <hramrach@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Olliver,

On 04/19/2016 09:20 PM, Olliver Schinagl wrote:
> Hey Jaehoon,
> 
> On 19-04-16 11:49, Jaehoon Chung wrote:
>> Hi
>>
>> On 04/19/2016 06:42 PM, Olliver Schinagl wrote:
>>> Hi Ulf,
>>>
>>> On 19-04-16 11:29, Ulf Hansson wrote:
>>>> On 19 April 2016 at 09:12, Olliver Schinagl <oliver@schinagl.nl> wrote:
>>>>> In patch 81f8a7be66 Hans de Goede added a patch to allow marking an mmc
>>>>> device as to having an broken HPI implementation. After talking some
>>>>> with Hans, we now think it is actually the mmc controller that can be
>>>>> broken and not support broken HPI's.
>>>> I don't want us to invent a DT binding for something you *think* is a
>>>> HW controller issue.
>>>>
>>>> Have you really excluded that this isn't a software issue? Me
>>>> personally haven't been using HPI that much so I can't really tell
>>>> about the code robustness from the mmc core (mmc protocol point of
>>>> view).
>>> Well this patch goes hand in hand so to speak with the broken-hpi patch introduced by him, he did most of the investigation. We just discussed how to handle it and asked me to cook up the patch.
>> I didn't understand why add this property. Is this same patch?
>>
>> commit 81f8a7be6642b4c26ab681b2e0f4c4120a6de1b0
>> Author: Hans de Goede <hdegoede@redhat.com>
>> Date:   Wed Apr 1 17:26:23 2015 +0200
>>
>>      mmc: Add support for marking hpi as broken through devicetree
>>
>>      The eMMC on a tablet I've will stop working / communicating as soon as
>>      the kernel executes:
>>
>>                  mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>>                                  EXT_CSD_HPI_MGMT, 1,
>>                                  card->ext_csd.generic_cmd6_time);
>>
>>      There seems to be no way to reliable identify eMMC-s which have a broken
>>      hpi implementation, but at least for eMMC's which are soldered onto a board
>>      we can work around this by specifying that hpi is broken in devicetree.
> Similar, this does it on the card level, e.g. you mark a card as having a broken HPI implementation.
> 
> The truth is, the card may not be broken at all, but the mmc controller so we add a property on the controller level.
> 
> What Ulf is pondering, if this is not a software stack problem, rather then a hardware implementation, which I don't know.

Hmm..problem is mmc controller side..it's strange.
How did you know this problem is on mmc controller side?

Well, i should be also missing something for HPI feature..but it's not relevant to mmc controller.

Ok. i will check more..

Best Regards,
Jaehoon Chung

>>> @hans, what do you think?
>>>> Kind regards
>>>> Uffe
>>>>
>>>>> This patch adds a new capability, mmc-broken-hpi, which allows us to
>>>>> mark a broken hpi implementation on the host level.
>>>>>
>>>>> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
>>>>> ---
>>>>>    drivers/mmc/core/host.c  | 2 ++
>>>>>    drivers/mmc/core/mmc.c   | 2 +-
>>>>>    include/linux/mmc/host.h | 1 +
>>>>>    3 files changed, 4 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
>>>>> index 6e4c55a..9b63b36 100644
>>>>> --- a/drivers/mmc/core/host.c
>>>>> +++ b/drivers/mmc/core/host.c
>>>>> @@ -270,6 +270,8 @@ int mmc_of_parse(struct mmc_host *host)
>>>>>                   host->caps |= MMC_CAP_HW_RESET;
>>>>>           if (of_property_read_bool(np, "cap-sdio-irq"))
>>>>>                   host->caps |= MMC_CAP_SDIO_IRQ;
>>>>> +       if (of_property_read_bool(np, "mmc-broken-hpi"))
>>>>> +               host->caps |= MMC_CAP_BROKEN_HPI;
>>>>>           if (of_property_read_bool(np, "full-pwr-cycle"))
>>>>>                   host->caps2 |= MMC_CAP2_FULL_PWR_CYCLE;
>>>>>           if (of_property_read_bool(np, "keep-power-in-suspend"))
>>>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>>>> index 4dbe3df..9a19562 100644
>>>>> --- a/drivers/mmc/core/mmc.c
>>>>> +++ b/drivers/mmc/core/mmc.c
>>>>> @@ -1592,7 +1592,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>>>>>           /*
>>>>>            * Enable HPI feature (if supported)
>>>>>            */
>>>>> -       if (card->ext_csd.hpi) {
>>>>> +       if (card->ext_csd.hpi && !(host->caps & MMC_CAP_BROKEN_HPI)) {
>>>>>                   err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>>>>>                                   EXT_CSD_HPI_MGMT, 1,
>>>>>                                   card->ext_csd.generic_cmd6_time);
>>>>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>>>>> index 8dd4d29..20f758e 100644
>>>>> --- a/include/linux/mmc/host.h
>>>>> +++ b/include/linux/mmc/host.h
>>>>> @@ -264,6 +264,7 @@ struct mmc_host {
>>>>>    #define MMC_CAP_DRIVER_TYPE_A  (1 << 23)       /* Host supports Driver Type A */
>>>>>    #define MMC_CAP_DRIVER_TYPE_C  (1 << 24)       /* Host supports Driver Type C */
>>>>>    #define MMC_CAP_DRIVER_TYPE_D  (1 << 25)       /* Host supports Driver Type D */
>>>>> +#define MMC_CAP_BROKEN_HPI     (1 << 29)       /* Host support for HPI is broken */
>>>>>    #define MMC_CAP_CMD23          (1 << 30)       /* CMD23 supported. */
>>>>>    #define MMC_CAP_HW_RESET       (1 << 31)       /* Hardware reset */
>>>>>
>>>>> -- 
>>>>> 2.8.0.rc3
>>>>>
>>>
>>>
> 
> 
> 

