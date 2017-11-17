From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH RFT] mmc: core: use usleep_range rather than HZ magic in
 mmc_delay()
Date: Fri, 17 Nov 2017 08:59:42 +0800
Message-ID: <8549da0b-1007-b36a-71e9-1878bb205468@rock-chips.com>
References: <20171114225520.6793-1-wsa+renesas@sang-engineering.com>
 <CAPDyKFrgO0JRatud5JRDONS=VTNef8WS+qvRAUo1AXep9wMpZg@mail.gmail.com>
 <2b56ea8c-3040-2c47-41e5-ed52f97ff75e@rock-chips.com>
 <CAPDyKFpvA2q5KwtcrXzv5ownKM54hcZTyfXKVBJhb95k2o6tyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:37847 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753861AbdKQA7n (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Nov 2017 19:59:43 -0500
In-Reply-To: <CAPDyKFpvA2q5KwtcrXzv5ownKM54hcZTyfXKVBJhb95k2o6tyw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Hi

On 2017/11/16 18:42, Ulf Hansson wrote:
> On 16 November 2017 at 08:59, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>> Hi,
>>
>> On 2017/11/16 15:47, Ulf Hansson wrote:
>>>
>>> On 14 November 2017 at 23:55, Wolfram Sang
>>> <wsa+renesas@sang-engineering.com> wrote:
>>>>
>>>> Documentation/timers/timers-howto.txt recommends to use usleep_range for
>>>> delays 1-20ms. Let's adhere to it. No need for messing with HZ and still
>>>> do busy looping these days.
>>>>
>>
>> Sorry for chime in this topic but I think for some cases, for instance,
>> mmc_host_set_uhs_voltage calls mmc_delay and it should guarantee the
>> delay is accurate, especially for the comment"Keep clock gated for at
>> least 10 ms, though spec only says 5 ms"
>>
>> But the usleep_range won't guarantee that, see
>>
>> https://patchwork.kernel.org/patch/9369963/
>>
>> It wasn't fixed at the end, so you should carefully modify
>> this fundamentally.
> 
> git tag --contains 6c5e9059692567740a4ee51530dffe51a4b9584d
> 
> It should be fixed, however, thanks for pointing to an interesting patch. :-)

Ah, I wasn't continuing tracing that topic and from the argue of v2,
I thought it wasn't fixed... So it seems fine now.

> 
> [...]
> 
> Kind regards
> Uffe
> 
> 
> 

