From: Philip Rakity <prakity@marvell.com>
Subject: Re: [RFC} sdhci.c set_ios -- disable global interrupts and Question
 on Power Management
Date: Sun, 13 Feb 2011 09:57:00 -0800
Message-ID: <447896B1-8836-4DFE-A00D-D41C395C79FC@marvell.com>
References: <7953F5A4-7BFA-4E40-8202-C682C0314F49@marvell.com>
 <AANLkTimh2cZbtnoSLQ7ddq9hFxx7ddfM-NJmaS1f=pXh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:55135 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754740Ab1BMR5E convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 13 Feb 2011 12:57:04 -0500
In-Reply-To: <AANLkTimh2cZbtnoSLQ7ddq9hFxx7ddfM-NJmaS1f=pXh@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pierre Tardy <tardyp@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


On Feb 13, 2011, at 2:25 AM, Pierre Tardy wrote:

> On Sun, Feb 13, 2011 at 6:39 AM, Philip Rakity <prakity@marvell.com> wrote:
>> 
>> Pierre,
>> 
>> I am preparing a patch to just diable to interrupt line to the SD controller so global interrupts are not locked out.
> I think I already have seen previous version of that patch earlier. It
> does not sound like a bad idea. However, disabling all interrupt is
> really cheap, and disabling only one is a bit more expensive. AFAIK,
> spin_lock and co are really meant for very short time locks.
> 
>>  This
>> will allow mdelay to work correctly in the routines the set_ios() calls.
> This sounds a little bit worse. mdelay is never good, as this is
> active wait, that is loosing tons of good cpu cycles.

do not need active waiting.  Good point.

> Do we really need those? Can we do the same thing asynchronous?

This might be possible without a restructure to separate out all the sub-calls that are
done in set_ios. Otherwise  we would require a restructure of the code in core/ to not use
set_ios but to call only the function they need via separate call in's.
(for example setting the width or power) and the associated changes in all the drivers in host.

Rather then do mdelay we could use:  (code from core.h)

static inline void mmc_delay(unsigned int ms)
{
	if (ms < 1000 / HZ) {
		cond_resched();
		mdelay(ms);
	} else {
		msleep(ms);
	}
}

Since the whole point of locking out the one interrupt line is to let everything else
work this look attractive.   -- Opintions Please --

> 
>> 
>> The pm_ calls  remove the lock before being called and restore it afterwards.  Is this just to ensure interrupts are globally
>> enabled ?
> At least on my platform, pm_ calls cannot be done in atomic context,
> and sdhci runtime_pm flow will call set_ios() back, so you will
> re-enter the function.

ok

> 
>>  If so, I can simplify my patch deleting the original spin_lock calls that surround the pm_ calls.
> No, you cannot safely remove the spin_lock calls here.

ok

