From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 2/3] omap_hsmmc: add pm_caps field
Date: Mon, 28 Nov 2011 12:39:59 +0200
Message-ID: <4ED364FF.8000007@compulab.co.il>
References: <1321970539-7104-1-git-send-email-eliad@wizery.com>	<1321970539-7104-2-git-send-email-eliad@wizery.com>	<4ED35131.6020206@compulab.co.il>	<CAB3XZEeFSXBQZCR17bRdaG3UbhpE6JJHD_aEiq8Y2Kc3=eGRSQ@mail.gmail.com>	<4ED35BFE.9060202@compulab.co.il> <CAB3XZEeOAznyX8Z4vpb34GqD2mpr_0_Bje=-5KVkUs3q18ao_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <CAB3XZEeOAznyX8Z4vpb34GqD2mpr_0_Bje=-5KVkUs3q18ao_Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: Eliad Peller <eliad@wizery.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Chris Ball <cjb@laptop.org>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-mmc@vger.kernel.org

On 11/28/11 12:07, Eliad Peller wrote:
> On Mon, Nov 28, 2011 at 12:01 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
>> On 11/28/11 11:23, Eliad Peller wrote:
>>> hi Igor,
>>>
>>> On Mon, Nov 28, 2011 at 11:15 AM, Igor Grinberg <grinberg@compulab.co.il> wrote:
>>>> On 11/22/11 16:02, Eliad Peller wrote:
>>>>> Add pm_caps field to omap2_hsmmc_info and omap_mmc_slot_data
>>>>> structs, so we will be able to indicate mmc pm capabilities
>>>>> in the board file.
>>>>
>>>> Shouldn't this be user space runtime controllable?
>>>> Instead of being a static per board decision?
>>>>
>>> we only declare here support for the pm capabilities.
>>> the actual configuration of these capabilities is done at a later
>>> stage, and can be controlled (implicitly) by userspace (e.g. by
>>> enabling Wakeup-On-Wireless for the wl12xx chip).
>>
>> This is good to hear, because patch 1/3 makes it look like
>> the bus power does get immediately affected depending
>> on that capability, isn't it?
>>
> no.
> it checks pm_flags (configured pm features) rather than pm_caps
> (supported pm features).

I see. Thanks for the explanation.


-- 
Regards,
Igor.
