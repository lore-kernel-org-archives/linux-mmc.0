From: Chunhe Lan <b25806@freescale.com>
Subject: Re: [v4 1/2] mmc: Move mmc_delay() to include/linux/mmc/core.h
Date: Tue, 25 Dec 2012 16:13:15 +0800
Message-ID: <50D9601B.1070503@freescale.com>
References: <1356082080-7756-1-git-send-email-Chunhe.Lan@freescale.com> <201212211939.47563.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe005.messaging.microsoft.com ([216.32.180.188]:57590
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753578Ab2LYIL1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Dec 2012 03:11:27 -0500
In-Reply-To: <201212211939.47563.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Chunhe Lan <Chunhe.Lan@freescale.com>, linux-mmc@vger.kernel.org, cjb@laptop.org, Kumar Gala <galak@kernel.crashing.org>

On 12/22/2012 03:39 AM, Arnd Bergmann wrote:
> On Friday 21 December 2012, Chunhe Lan wrote:
>> +static inline void mmc_delay(unsigned int ms)
>> +{
>> +       ktime_t end = ktime_add_us(ktime_get(), ms * 1000);
>> +
>> +       while (1) {
>> +               s64 remaining;
>> +
>> +               cond_resched();
>> +               remaining = ktime_to_us(ktime_sub(end, ktime_get()));
>> +               if (remaining < 0)
>> +                       break;
>> +
>> +               udelay(min_t(u32, remaining, 100));
>> +       }
>> +}
> The new logic is more accurate than the old one, but it still wastes
> a lot of energy and CPU cycles. Could you perhaps use an hrtimer to
> set the exact timeout and actually sleep?
     I think that does not have to use hrtimer, and it makes a fuss.
     And mmc structure has not included the hrtimer variable.

Thanks,
Chunhe
>
> 	Arnd
>



