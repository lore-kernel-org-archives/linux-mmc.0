From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v12 4/9] mmc: cavium: Work-around hardware bug on cn6xxx
 and cnf7xxx
Date: Tue, 21 Mar 2017 20:49:36 +0100
Message-ID: <CAK8P3a3PBx14CpGY5g7U9YHk3zkvVV=7gJHuSh50eOVKcfVAqA@mail.gmail.com>
References: <20170310132507.32025-1-jglauber@cavium.com> <20170310132507.32025-5-jglauber@cavium.com>
 <CAPDyKFrbAUoYk7h8XmYdwiyr8QZXA0WTyFVw3EVFQ8UK71cwOw@mail.gmail.com>
 <6dc8a2a3-ca79-745a-c716-2188319b9378@caviumnetworks.com> <CAK8P3a2BX3-hbgGzYD_Oub1MR1pC9kLq73L+9gR5_gvYQyqqXA@mail.gmail.com>
 <67481a9f-f7b5-4ec0-22cc-f6e019dc131e@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ot0-f179.google.com ([74.125.82.179]:35157 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758004AbdCUTti (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Mar 2017 15:49:38 -0400
In-Reply-To: <67481a9f-f7b5-4ec0-22cc-f6e019dc131e@caviumnetworks.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Jan Glauber <jglauber@cavium.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Steven J . Hill" <Steven.Hill@cavium.com>, David Daney <david.daney@cavium.com>

On Tue, Mar 21, 2017 at 4:19 PM, David Daney <ddaney@caviumnetworks.com> wrote:
> On 03/21/2017 01:58 AM, Arnd Bergmann wrote:
>>
>> On Mon, Mar 20, 2017 at 9:45 PM, David Daney <ddaney@caviumnetworks.com>
>> wrote:
>>>
>>> On 03/17/2017 07:13 AM, Ulf Hansson wrote:
>>>>
>>>> My point is really that we should avoid exporting SoC specific APIs
>>>> which shall be called from drivers. This is old fashion.
>>>
>>>
>>>
>>> Some people find it objectionable to see 1-off architecture specific
>>> in-line
>>> asm in a driver file, but I agree that putting it as close to the user as
>>> possible makes sense.
>>
>>
>> The proper solution might be to create an architecture independent
>> interface
>> for it, what it is that the function does. Can you explain what the
>> purpose
>> of locking/unlocking the cache line for MMC is? Is this something that
>> could be done more generally in the dma_map_ops implementation?
>
>
> It is a 1-off erratum workaround that is only needed on fewer than five
> models/revisions of a mips64 based SoC family.  As such, creating a general
> purpose, architecture independent, framework is clearly not the proper
> approach.

If this is just for maintaining coherency of the DMA operation inbetween,
then there is already a generic API for that, which the driver calls.
Adding the workaround into octeon_dma_map_sg() would be a way
to abstract the platform erratum from the driver.

      Arnd
