From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v12 4/9] mmc: cavium: Work-around hardware bug on cn6xxx
 and cnf7xxx
Date: Tue, 21 Mar 2017 09:58:24 +0100
Message-ID: <CAK8P3a2BX3-hbgGzYD_Oub1MR1pC9kLq73L+9gR5_gvYQyqqXA@mail.gmail.com>
References: <20170310132507.32025-1-jglauber@cavium.com> <20170310132507.32025-5-jglauber@cavium.com>
 <CAPDyKFrbAUoYk7h8XmYdwiyr8QZXA0WTyFVw3EVFQ8UK71cwOw@mail.gmail.com> <6dc8a2a3-ca79-745a-c716-2188319b9378@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6dc8a2a3-ca79-745a-c716-2188319b9378@caviumnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Jan Glauber <jglauber@cavium.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Steven J . Hill" <Steven.Hill@cavium.com>, David Daney <david.daney@cavium.com>
List-Id: linux-mmc@vger.kernel.org

On Mon, Mar 20, 2017 at 9:45 PM, David Daney <ddaney@caviumnetworks.com> wrote:
> On 03/17/2017 07:13 AM, Ulf Hansson wrote:
>> My point is really that we should avoid exporting SoC specific APIs
>> which shall be called from drivers. This is old fashion.
>
>
> Some people find it objectionable to see 1-off architecture specific in-line
> asm in a driver file, but I agree that putting it as close to the user as
> possible makes sense.

The proper solution might be to create an architecture independent interface
for it, what it is that the function does. Can you explain what the purpose
of locking/unlocking the cache line for MMC is? Is this something that
could be done more generally in the dma_map_ops implementation?

     Arnd
