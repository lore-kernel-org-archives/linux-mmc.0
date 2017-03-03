From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH RFC 22/39] mmc: block: Prepare CQE data
Date: Fri, 3 Mar 2017 14:22:14 +0200
Message-ID: <e31765ec-3453-9c40-1710-bea881cd9dec@intel.com>
References: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com>
 <1486731352-8018-23-git-send-email-adrian.hunter@intel.com>
 <CACRpkdZkTgNEUFiG5JorBM+MiXVfp6iSnNH0-k27jYb+zjgiLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:54855 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751310AbdCCOnt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 3 Mar 2017 09:43:49 -0500
In-Reply-To: <CACRpkdZkTgNEUFiG5JorBM+MiXVfp6iSnNH0-k27jYb+zjgiLw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

On 15/02/17 15:49, Linus Walleij wrote:
> On Fri, Feb 10, 2017 at 1:55 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> 
>> Enhance mmc_blk_data_prep() to support CQE requests.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> Hey:
> 
>> +#include <linux/ioprio.h>
> (...)
>> +       if (IOPRIO_PRIO_CLASS(req_get_ioprio(req)) == IOPRIO_CLASS_RT)
>> +               brq->data.flags |= MMC_DATA_PRIO;
> 
> What is this?

It is the command queue priority.

The command queue supports 2 priorities: "high" (1) and "simple" (0).  The
eMMC will give "high" priority tasks priority over "simple" priority tasks.

So here we give priority to IOPRIO_CLASS_RT which seems appropriate.

> 
> Why are we not already doing this and why is it not a separate patch?

I think adding a comment is better since it is a command queue feature.

> 
>>         /*
>>          * Data tag is used only during writing meta data to speed
>>          * up write and any subsequent read of this meta data
>>          */
> 
> Is this comment still true?

AFAIK

> 
>> -       *do_data_tag = card->ext_csd.data_tag_unit_size &&
>> -                      (req->cmd_flags & REQ_META) &&
>> -                      (rq_data_dir(req) == WRITE) &&
>> -                      ((brq->data.blocks * brq->data.blksz) >=
>> -                       card->ext_csd.data_tag_unit_size);
>> +       do_data_tag = card->ext_csd.data_tag_unit_size &&
>> +                     (req->cmd_flags & REQ_META) &&
>> +                     (rq_data_dir(req) == WRITE) &&
>> +                     ((brq->data.blocks * brq->data.blksz) >=
>> +                      card->ext_csd.data_tag_unit_size);
>> +
>> +       if (do_data_tag)
>> +               brq->data.flags |= MMC_DATA_DAT_TAG;
> 
> Because it seems to be more unconditionally used now.

The key ingredient is (req->cmd_flags & REQ_META) i.e. meta-data gets tagged.


