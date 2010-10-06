From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH 0/2] mmc: omap_hsmmc: support SDIO cards (#2)
Date: Wed, 06 Oct 2010 08:17:17 +0200
Message-ID: <4CAC146D.3040001@compulab.co.il>
References: <cover.1266847842.git.david.vrabel@csr.com>	<20100827192248.GJ20407@void.printf.net>	<4C7CC480.2040903@csr.com>	<4C7F3E0F.2080402@compulab.co.il>	<AANLkTi=RvWpuUC3FjwELkM0v57YXZbH_DBiA-4KuOwdN@mail.gmail.com>	<C903F2608D694655921F553D0D3557E3@am.dhcp.ti.com>	<AANLkTikskMMFWS+qxD+J=o6OiOa+d5H02DiT1iZ95vkz@mail.gmail.com>	<CD6B4CE9F7FA427BBD19242F669AD014@am.dhcp.ti.com> <AANLkTin-r5Svg1+YrdYq95WA6=sh7+X0Bwogk=h0V6pP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:43733 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755512Ab0JFGRa (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 6 Oct 2010 02:17:30 -0400
In-Reply-To: <AANLkTin-r5Svg1+YrdYq95WA6=sh7+X0Bwogk=h0V6pP@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: Madhusudhan <madhu.cr@ti.com>, David Vrabel <david.vrabel@csr.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Adrian Hunter <adrian.hunter@nokia.com>, Mike Rapoport <mike@compulab.co.il>

Steve Sakoman wrote:
> On Mon, Oct 4, 2010 at 10:33 AM, Madhusudhan <madhu.cr@ti.com> wrote:
>>
>>> -----Original Message-----
>>> From: Steve Sakoman [mailto:sakoman@gmail.com]
>>> Sent: Monday, October 04, 2010 11:57 AM
>>> To: Madhusudhan
>>> Cc: Mike Rapoport; David Vrabel; Chris Ball; linux-mmc@vger.kernel.org;
>>> linux-omap@vger.kernel.org
>>> Subject: Re: [PATCH 0/2] mmc: omap_hsmmc: support SDIO cards (#2)
>>>
>>> On Mon, Oct 4, 2010 at 9:45 AM, Madhusudhan <madhu.cr@ti.com> wrote:
>>>>
>>>>> -----Original Message-----
>>>>> From: Steve Sakoman [mailto:sakoman@gmail.com]
>>>>> Sent: Monday, October 04, 2010 11:32 AM
>>>>> To: Mike Rapoport
>>>>> Cc: David Vrabel; Chris Ball; linux-mmc@vger.kernel.org; linux-
>>>>> omap@vger.kernel.org; madhu.cr@ti.com
>>>>> Subject: Re: [PATCH 0/2] mmc: omap_hsmmc: support SDIO cards (#2)
>>>>>
>>>>> On Wed, Sep 1, 2010 at 11:02 PM, Mike Rapoport <mike@compulab.co.il>
>>>>> wrote:
>>>>>> David Vrabel wrote:
>>>>>>> On 27/08/2010 20:22, Chris Ball wrote:
>>>>>>>> Hi David,
>>>>>>>>
>>>>>>>> On Mon, Feb 22, 2010 at 02:24:17PM +0000, David Vrabel wrote:
>>>>>>>>> These patches add support for SDIO cards to the omap_hsmmc driver.
>>>>>>>>> Power management changes to prevent SDIO cards from being turned
>>> off
>>>>>>>>> and losing all state, and card interrupts.
>>>>>>>>>
>>>>>>>>> I've been unable to test these exact patches as I only have an
>>> N900
>>>>> for
>>>>>>>>> testing and the N900 support in mainline is incomplete.
>>>>>>>>>
>>>>>>>>> Changes since v1:
>>>>>>>>> - (hopefully) get all cards working again by removing a second
>>> call
>>>>> to
>>>>>>>>>  read MMCi_STAT in the interrupt handler.
>>>>>>>>> - flush posted writes after enabling/disabling SDIO interrupts.
>>>>>>>>> - tweak the FIXME commit on disabling FCLK to better match what
>>>>> really
>>>>>>>>>  going on (at least I think so anyway).
>>>>>>>>>
>>>>>>>>> David Vrabel (2):
>>>>>>>>>  mmc: omap_hsmmc: don't turn SDIO cards off when idle
>>>>>>>>>  mmc: omap_hsmmc: enable SDIO card interrupts
>>>>>>>> Looks like this patchset wasn't merged.  Mike Rapoport replied with
>>> a
>>>>> fix
>>>>>>>> for libertas.  Would you like to resubmit it?
>>>>>>> I thought Madhu had picked this up and was going to submit it.
>>>>>>>
>>>>>>> Regardless of whether that is the case, I think it needs to be
>>>>> submitted
>>>>>>> by someone who can run mainline kernels (I can't) and ideally
>>> someone
>>>>>>> who can test it with SDIO cards.
>>>>>> I'll try to update the patches in the next few days.
>>>>> Any update on the status of these patches?  I'm happy to help test!
>>>>>
>>>> Steve,
>>>>
>>>> I have not been able to test SDIO card interrupts. If you could help
>>> test
>>>> that it's great.
>>> Where can I grab the most recent patches?  The original set don't apply
>>> cleanly.
>>>
>> Yes. They may not apply. I can rebase them and send it to you for testing.
>> Are you using the two patches posted by David Vrabel?
> 
> Yes, I've been using the original patches on 2.6.33 and 2.6.34.  The
> SDIO interrupt patch doesn't apply on 2.6.35 or 36.
> 
> If you send a revised patch for either I would be happy to test as
> soon as I get it.

I've tried to update the patches on top of 2.6.36-rc3 and I've got stuck.
The changes Adrian has made to the interrupt synchronization  affect the way the
SDIO irq should be implemented and I haven't found a way to resolve it :-(

> Steve


-- 
Sincerely yours,
Mike.

