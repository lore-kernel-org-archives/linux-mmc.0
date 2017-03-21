From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH v12 4/9] mmc: cavium: Work-around hardware bug on cn6xxx
 and cnf7xxx
Date: Tue, 21 Mar 2017 08:19:38 -0700
Message-ID: <67481a9f-f7b5-4ec0-22cc-f6e019dc131e@caviumnetworks.com>
References: <20170310132507.32025-1-jglauber@cavium.com>
 <20170310132507.32025-5-jglauber@cavium.com>
 <CAPDyKFrbAUoYk7h8XmYdwiyr8QZXA0WTyFVw3EVFQ8UK71cwOw@mail.gmail.com>
 <6dc8a2a3-ca79-745a-c716-2188319b9378@caviumnetworks.com>
 <CAK8P3a2BX3-hbgGzYD_Oub1MR1pC9kLq73L+9gR5_gvYQyqqXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a2BX3-hbgGzYD_Oub1MR1pC9kLq73L+9gR5_gvYQyqqXA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Jan Glauber <jglauber@cavium.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Steven J . Hill" <Steven.Hill@cavium.com>, David Daney <david.daney@cavium.com>
List-Id: linux-mmc@vger.kernel.org

On 03/21/2017 01:58 AM, Arnd Bergmann wrote:
> On Mon, Mar 20, 2017 at 9:45 PM, David Daney <ddaney@caviumnetworks.com> wrote:
>> On 03/17/2017 07:13 AM, Ulf Hansson wrote:
>>> My point is really that we should avoid exporting SoC specific APIs
>>> which shall be called from drivers. This is old fashion.
>>
>>
>> Some people find it objectionable to see 1-off architecture specific in-line
>> asm in a driver file, but I agree that putting it as close to the user as
>> possible makes sense.
>
> The proper solution might be to create an architecture independent interface
> for it, what it is that the function does. Can you explain what the purpose
> of locking/unlocking the cache line for MMC is? Is this something that
> could be done more generally in the dma_map_ops implementation?

It is a 1-off erratum workaround that is only needed on fewer than five 
models/revisions of a mips64 based SoC family.  As such, creating a 
general purpose, architecture independent, framework is clearly not the 
proper approach.  This is a problem that effects only the Cavium MMC bus 
hardware block as implemented on a mips64 based SoC.  The arm64 based 
SoCs do not have this problem, and and future users of the block will 
also not contain the erratum. That is what it is.

At a high level, its purpose is to eliminate data corruption when doing 
DMA write operations to transfer data into the SD/MMC devices.  The 
specific details and RTL code for effected SoCs will not be made public. 
  It should be enough to know that the 2nd-to-last cache block of a 
transfer must be locked in the L2 cache to ensure reliable operation on 
DMA writes.  This is not some empirically derived workaround, but rather 
it is based on a well understood root cause of the failure case.

David.
