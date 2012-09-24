From: Chunhe Lan <b25806@freescale.com>
Subject: Re: [PATCH v3 1/2] mmc: Move mmc_delay() to include/linux/mmc/core.h
Date: Mon, 24 Sep 2012 11:20:58 -0400
Message-ID: <50607A5A.3060103@freescale.com>
References: <1344637513-29383-1-git-send-email-Chunhe.Lan@freescale.com> <201208101327.47789.arnd@arndb.de> <505CD3A5.6080101@freescale.com> <201209211233.54545.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe005.messaging.microsoft.com ([65.55.88.15]:25132 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754883Ab2IXDSU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 23 Sep 2012 23:18:20 -0400
In-Reply-To: <201209211233.54545.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Chunhe Lan <Chunhe.Lan@freescale.com>, linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kumar.gala@freescale.com, cjb@laptop.org, Kumar Gala <galak@kernel.crashing.org>

On 09/21/2012 08:33 AM, Arnd Bergmann wrote:
> On Friday 21 September 2012, Chunhe Lan wrote:
>> On 08/10/2012 09:27 AM, Arnd Bergmann wrote:
>>> On Friday 10 August 2012, Chunhe Lan wrote:
>>>
>>>        cond_resched();
>>>        mdelay(ms);
>>>
>>> sets off alarm bells, and I would always replace that with msleep().
>>       I think that it does not replace with msleep().
>>       When the time of sleep is very short, program should not been scheduled
>>       in the context. Because it expends the more time.
>>
> A time measured in miliseconds is never "very short" for the scheduler,
> a lot of things can happen during that time span. The code I quoted
> also does not care too much about accuracy, otherwise it would adapt
> the time in the mdelay based on whether the cond_resched() actually
> schedules to another thread.
    OK. As you have mentioned, it would been modified to such:

static inline void mmc_delay(unsigned int ms)
{
         if (ms < 1000 / HZ) {
                 cond_resched();
                 msleep(ms);
         } else {
                 msleep(ms);
         }
}

OR such:

static inline void mmc_delay(unsigned int ms)
{
                 msleep(ms);
}

OR other code?

Thanks,
Chunhe
>
> 	Arnd
>



