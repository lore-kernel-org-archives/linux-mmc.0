From: Philip Rakity <prakity@marvell.com>
Subject: Re: [RFC} sdhci.c set_ios -- disable global interrupts and Question
 on Power Management
Date: Mon, 14 Feb 2011 10:34:01 -0800
Message-ID: <E5D06E6B-BE70-4446-9F56-32982C119FC0@marvell.com>
References: <7953F5A4-7BFA-4E40-8202-C682C0314F49@marvell.com>
 <AANLkTimh2cZbtnoSLQ7ddq9hFxx7ddfM-NJmaS1f=pXh@mail.gmail.com>
 <447896B1-8836-4DFE-A00D-D41C395C79FC@marvell.com>
 <B040EC60-E156-4863-A735-15876F835FA1@marvell.com>
 <AANLkTikYYo4bJxQEa3+p=gE8iKNHxxbv7JPjB6vnywrs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:42730 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751467Ab1BNSf4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Feb 2011 13:35:56 -0500
In-Reply-To: <AANLkTikYYo4bJxQEa3+p=gE8iKNHxxbv7JPjB6vnywrs@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pierre Tardy <tardyp@gmail.com>, Wolfram Sang <w.sang@pengutronix.de>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


On Feb 14, 2011, at 1:29 AM, Pierre Tardy wrote:

> On Mon, Feb 14, 2011 at 6:50 AM, Philip Rakity <prakity@marvell.com> wrote:
>> 
>> Pierre,
>> 
>> are you comfortable with this ?
> The mmc_delay() looks hackish at the first sight. Looks like Pierre
> Ossman was the author, he must have his reasons.
> 
> It looks like the mdelay are not in the fastpath, so why bother.
> 
> And, more important, you will do cond_resched while holding you
> spinlock, which is *bad*.
> What if the mmc stack will call you again from another thread? deadlock...


Assumptions -- Please Confirm 
-------------------------------------------

There is a one to one relationship
between the calls in the core layer into the SD driver.

Each thread is independent of the other.

Each thread maps into exactly one register instance for the SD driver

eg --> 2 threads cannot be active at the same time that use the same
registers in the SD driver.

Question
------------

If these assumptions are correct how can the deadlock happen ?
host->lock is held on a per thread basis.

======

> 
> 
>> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
>> -static inline void mmc_delay(unsigned int ms)
> why do you want to remove it from here ?
> It is still used by the core code.

moved to include/linux/mmc so okay for sdhci driver.  Did not want to duplicate code.

> 
> 
>> @@ -1043,7 +1043,7 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>>                        return;
>>                }
>>                timeout--;
>> -               mdelay(1);
>> +               mmc_delay(1);
> This looks like timeout code that never happen in normal condition.
> 
> 
>> @@ -1108,7 +1108,7 @@ static void sdhci_set_power(struct sdhci_host *host, unsigned short power)
>>         * can apply clock after applying power
>>         */
>>        if (host->quirks & SDHCI_QUIRK_DELAY_AFTER_POWER)
>> -               mdelay(10);
>> +               mmc_delay(10);
> Do you need this quirk in your platform?

No

> 
> 
> Pierre

