From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V8 05/20] mmc: queue: Factor out
 mmc_queue_alloc_bounce_sgs()
Date: Wed, 30 Nov 2016 10:46:22 +0200
Message-ID: <2ff4374a-da78-eac9-5e62-839543490e5c@intel.com>
References: <1480414167-15577-1-git-send-email-adrian.hunter@intel.com>
 <1480414167-15577-6-git-send-email-adrian.hunter@intel.com>
 <CAPDyKFoD0gKt5F0aDT7-EMUZ2j1xoYNU+0WRypPXCSfdH8WzkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:55125 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755596AbcK3Iva (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 30 Nov 2016 03:51:30 -0500
In-Reply-To: <CAPDyKFoD0gKt5F0aDT7-EMUZ2j1xoYNU+0WRypPXCSfdH8WzkQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

On 30/11/16 10:17, Ulf Hansson wrote:
> On 29 November 2016 at 11:09, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> In preparation for supporting a queue of requests, factor out
>> mmc_queue_alloc_bounce_sgs().
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>> Reviewed-by: Harjani Ritesh <riteshh@codeaurora.org>
>> ---
>>  drivers/mmc/card/queue.c | 44 ++++++++++++++++++++++++++++----------------
>>  1 file changed, 28 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
>> index 4497a218c245..3fd27c684292 100644
>> --- a/drivers/mmc/card/queue.c
>> +++ b/drivers/mmc/card/queue.c
>> @@ -211,6 +211,30 @@ static bool mmc_queue_alloc_bounce_bufs(struct mmc_queue *mq,
>>         return true;
>>  }
>>
>> +static int mmc_queue_alloc_bounce_sgs(struct mmc_queue *mq,
>> +                                     unsigned int bouncesz)
> 
> This causes a compiler warning about unused function, in case when
> CONFIG_MMC_BLOCK_BOUNCE is unset.
> No worries, I fixed it and amended the patch.

Thank you!

