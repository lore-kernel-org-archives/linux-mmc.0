From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V7 06/25] mmc: queue: Introduce queue depth
Date: Fri, 25 Nov 2016 19:20:36 +0200
Message-ID: <6bc17e0a-7a88-6909-f448-41c4481d491b@intel.com>
References: <1480068442-5169-1-git-send-email-adrian.hunter@intel.com>
 <1480068442-5169-7-git-send-email-adrian.hunter@intel.com>
 <CACRpkdaQL3UM5DK9nwiQEcR_R19qWqRwt+KpOJNFR1HKEQ5bkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:38197 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932124AbcKYRV3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 25 Nov 2016 12:21:29 -0500
In-Reply-To: <CACRpkdaQL3UM5DK9nwiQEcR_R19qWqRwt+KpOJNFR1HKEQ5bkA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

On 25/11/2016 4:43 p.m., Linus Walleij wrote:
> On Fri, Nov 25, 2016 at 11:07 AM, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
>> Add a mmc_queue member to record the size of the queue, which currently
>> supports 2 requests on-the-go at a time.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> (...)
>> +       /* Queue depth is only ever 2 with packed commands */
>
> That's a weird comment.
> It doesn't have anything with packed commands to do does it?

No it doesn't.  Packed commands and command queue are mutually exclusive, 
but the packed commands implementation expects there to be 2 
mmc_queue_req's.  Adding a check was just for the code to protect itself 
from oops.

> In that case it was just deleted.

Yes, I will re-base.

>
> Are you referring to the asynchronous issuing pipeline thing
> (cur & next)?

Yes.
