From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [RESEND PATCH v7 2/2] mmc: OCTEON: Add host driver for OCTEON
 MMC controller
Date: Fri, 22 Apr 2016 10:49:06 -0700
Message-ID: <571A6412.6070303@caviumnetworks.com>
References: <1459438013-25088-1-git-send-email-matt.redfearn@imgtec.com> <4611130.vJzBsRp8Hx@wuerfel> <CAPDyKFpsmdtsdoa4D9f-vTV-WKYAZOQ7aGae7J5Y3RVdT_kh0Q@mail.gmail.com> <3831277.QfySLsdCii@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2on0061.outbound.protection.outlook.com ([207.46.100.61]:44064
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932156AbcDVRtd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Apr 2016 13:49:33 -0400
In-Reply-To: <3831277.QfySLsdCii@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Matt Redfearn <matt.redfearn@imgtec.com>, linux-mmc <linux-mmc@vger.kernel.org>, Aleksey Makarov <aleksey.makarov@caviumnetworks.com>, Chandrakala Chavva <cchavva@caviumnetworks.com>, David Daney <david.daney@cavium.com>, Aleksey Makarov <aleksey.makarov@auriga.com>, Leonid Rosenboim <lrosenboim@caviumnetworks.com>, Peter Swain <pswain@cavium.com>, Aaron Williams <aaron.williams@cavium.com>

On 04/22/2016 09:42 AM, Arnd Bergmann wrote:
> On Friday 22 April 2016 15:54:56 Ulf Hansson wrote:
>>
>>>
>>> My suggestion with using
>>>
>>>          wait_event(host->wq, !cmpxchg(host->current_req, NULL, mrq));
>>>
>>> should sufficiently solve the problem, but the suggestion of using
>>> a kthread (even though not needed for taking a mutex) would still
>>> have some advantages and one disadvantage:
>>>
>>> + We never need to spin in the irq context (also achievable using
>>>    a threaded handler)
>>> + The request callback always returns immediately after queuing up
>>>    the request to the kthread, rather than blocking for a potentially
>>>    long time while waiting for an operation in another slot to complete
>>> + it very easily avoids the problem of serialization between
>>>    the slots, and ensures that each slot gets an equal chance to
>>>    send the next request.
>>> - you get a slightly higher latency for waking up the kthread in
>>>    oder to do a simple request (comparable amount of latency that
>>>    is introduced by an irq thread).
>>>
>>
>> Currently I can't think of anything better, so I guess something along
>> these lines is worth a try.
>>
>> No matter what, I guess we want to avoid to use a semaphore as long as
>> possible, right!?
>
> Yes, I think that would be good, to avoid curses from whoever tries
> to eliminate them the next time.
>
> I think there is some renewed interest in realtime kernels these
> days, and semaphores are known to cause problems with priority
> inversion (precisely because you don't know which thread will
> release it).

In this particular case, there can be no priority inversion, as the 
thing we are waiting for is a hardware event.  The timing of that is not 
influenced by task scheduling.  The use of wait_event instead of struct 
semaphore would be purely cosmetic.


