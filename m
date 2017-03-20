From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH v12 4/9] mmc: cavium: Work-around hardware bug on cn6xxx
 and cnf7xxx
Date: Mon, 20 Mar 2017 13:45:25 -0700
Message-ID: <6dc8a2a3-ca79-745a-c716-2188319b9378@caviumnetworks.com>
References: <20170310132507.32025-1-jglauber@cavium.com>
 <20170310132507.32025-5-jglauber@cavium.com>
 <CAPDyKFrbAUoYk7h8XmYdwiyr8QZXA0WTyFVw3EVFQ8UK71cwOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrbAUoYk7h8XmYdwiyr8QZXA0WTyFVw3EVFQ8UK71cwOw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Jan Glauber <jglauber@cavium.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Steven J . Hill" <Steven.Hill@cavium.com>, David Daney <david.daney@cavium.com>
List-Id: linux-mmc@vger.kernel.org

On 03/17/2017 07:13 AM, Ulf Hansson wrote:
> On 10 March 2017 at 14:25, Jan Glauber <jglauber@cavium.com> wrote:
>> Prevent data corruption on cn6xxx and cnf7xxx.
>> Due to an imperfection in the design of the MMC bus hardware,
>> the 2nd to last cache block of a DMA read must be locked into the L2
>> cache.
>>
[...]
>> +/**
>> + * Unlock a memory region in the L2 cache
>> + *
>> + * @start - start address to unlock
>> + * @len - length to unlock in bytes
>> + */
>> +void l2c_unlock_mem_region(u64 start, u64 len)
>> +{
>> +       u64 end;
>> +
>> +       /* Round start/end to cache line boundaries */
>> +       end = ALIGN(start + len - 1, CVMX_CACHE_LINE_SIZE);
>> +       start = ALIGN(start, CVMX_CACHE_LINE_SIZE);
>> +
>> +       while (start <= end) {
>> +               l2c_unlock_line(start);
>> +               start += CVMX_CACHE_LINE_SIZE;
>> +       }
>> +}
>> +EXPORT_SYMBOL_GPL(l2c_unlock_mem_region);
>
> It seems like we should be able to implement these functions in the
> octeon mmc driver, instead of having to export some SoC specific APIs.
> You only need to figure out how to find the correct CACHE_LINE_SIZE,
> but that should be possible to fix.

It doesn't matter which source file the code lives in.  If you are happy 
having it in drivers/mmc/host/cavium-pltfm-octeon.c (or whatever we end 
up calling the file), it could be put there.

CVMX_CACHE_LINE_SIZE == 128.  It will never change.


>
> My point is really that we should avoid exporting SoC specific APIs
> which shall be called from drivers. This is old fashion.

Some people find it objectionable to see 1-off architecture specific 
in-line asm in a driver file, but I agree that putting it as close to 
the user as possible makes sense.

David Daney
