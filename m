From: Per Forlin <per.lkml@gmail.com>
Subject: Re: [PATCH v3] mmc: support BKOPS feature for eMMC
Date: Sun, 20 Nov 2011 23:42:20 +0100
Message-ID: <CAFEEs1mA8xSm2wTY_kO4GGysq0dQizAozm_3dTaooZM5+xWOuA@mail.gmail.com>
References: <4EC45A39.5030706@samsung.com>
	<000301cca539$c3bdb350$4b3919f0$@org>
	<CAFEEs1=f+CG6g7eu84g6kG5tueqfV1rukzb3gX5-dZWmuO0s_A@mail.gmail.com>
	<b1420856d6d04502786262d58234f78c.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:44126 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754150Ab1KTWmV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 20 Nov 2011 17:42:21 -0500
Received: by vcbfk1 with SMTP id fk1so5004778vcb.19
        for <linux-mmc@vger.kernel.org>; Sun, 20 Nov 2011 14:42:20 -0800 (PST)
In-Reply-To: <b1420856d6d04502786262d58234f78c.squirrel@www.codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Konstantin Dorfman <kdorfman@codeaurora.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, svenkatr@ti.com

Hi Konstantin,

On Sun, Nov 20, 2011 at 5:12 PM, Konstantin Dorfman
<kdorfman@codeaurora.org> wrote:
> Hello Per,
>
>> On Thu, Nov 17, 2011 at 4:01 PM, Konstantin Dorfman
>> <kdorfman@codeaurora.org> wrote:
>>> Hello Jaenhoon,
>>>
>>> I have a few suggestions regarding the situation when Host starts BKOPS:
>>>
>>> 1) Host should start BKOPS (based on BKOPS_STATUS or URGENT_BKOPS event)
>>> when going to mmc_sleep, which means that the bus is in idle state (this
>>> also covers the case in mmc_queue_thread, because in this case no I/O
>>> request exists). It seems like checking the status periodically in
>>> addition
>>> to mmc_suspend is not needed. Since if the device was in idle and we
>>> performed a single BKOPS then there is no point in performing another
>>> BKOPS
>>> unless there was actually another I/O request.
>>>
>>> 2) Also this implies an answer to the question about need to interrupt
>>> BKOPS
>>> before powering off card - the answer is no.
>> By the answer no you mean there is no risk of data corruption if
>> cutting power in the middle of a BKOPS. When the card is powered up
>> next time it will verify that bkops is in a defined state, and do
>> recovery if necessary. An interesting comment I got from Sebastian is
>> if this recovery mechanism affects card boot time.
>> The question is: May the card boot up slower (due to recovery) next
>> time if BKOPS was ongoing at power off?
>> I assume this recovery time should be insignificant, but I don't know for
>> sure.
>>
> Let me explain proposed flow:
> The only trigger to start BKOPS command should be mmc_power_off() function,
> just before sending POWER_OFF_NOTIFICATION[34] and only when BKOPS is needed
> (by needed I understand situation, when URGENT_BKOPS event arrived or
> BKOPS_STATUS 0x2 or 0x3).
> The flow will wait till BKOPS successfully completed and than continue to
> powering off the card. Power off will never occur in the middle of BKOPS.
> Also do not need to start BKOPS when mmc_queue_thread() is in IDLE state
> (no requests exists), because in such case power off should be done to card.
>
I wonder how this works with suspend.
If suspend is called on the system, MMC should suspend quickly and not
wait for the BKOPS to finish.
For pm_runtime_suspend it's fine to return -EBUSY and defer
pm_runtime_suspend until BKOPS is completed.
mmc_power_on/off is too low level I think. What about adding this at
the suspend/resume level instead?

>>> 3) Based on statistical data we have (day long test) it looks like we do
>>> not
>>> need to do any preventive BKOPS caused by BKOPS_STATUS less than
>>> critical
>>> (0x3).
>> I proposed this "preventive action" but at that time I didn't have any
>> data to back it up with. I've run some day long tests and what I could
>> see is when BKOPS_LEVEL goes from 0 to 1, it goes back to 0 without
>> having to start BKOPS. Can you confirm this with your tests as well?
>> One explanation I got for this is that level of 1 only means the eMMC
>> internal cache is fragmented and not the actual memory.
> We have such data from card vendors, but I plan to do similar tests to
> confirm.
> I will update about the results.
Looking forward to see your results.

Thanks,
Per
