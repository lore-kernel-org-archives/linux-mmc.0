From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V4 09/11] mmc: block: Add CQE support
Date: Mon, 24 Jul 2017 09:44:21 +0300
Message-ID: <e7e053c9-bcf1-cc4b-5cb3-85b78837a98a@intel.com>
References: <1500630584-22852-1-git-send-email-adrian.hunter@intel.com>
 <1500630584-22852-10-git-send-email-adrian.hunter@intel.com>
 <3ab2144f-8009-ff5b-e739-6b7ed14786f7@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:42113 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751873AbdGXGun (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 24 Jul 2017 02:50:43 -0400
In-Reply-To: <3ab2144f-8009-ff5b-e739-6b7ed14786f7@rock-chips.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

On 22/07/17 12:26, Shawn Lin wrote:
> Hi Adrian,
> 
> On 2017/7/21 17:49, Adrian Hunter wrote:
>> Add CQE support to the block driver, including:
>>     - optionally using DCMD for flush requests
> 
> That doesn't seem to be fact when I was looking into
> patch 10 as it always fire DCMD with QBR whenever seeing
> !mrq->data. Do I miss something?

The function that decides how to issue a request is mmc_cqe_issue_type()
which checks mmc_cqe_can_dcmd().

<SNIP>

>> +static inline bool mmc_cqe_can_dcmd(struct mmc_host *host)
>> +{
>> +    return host->caps2 & MMC_CAP2_CQE_DCMD;
>> +}
>> +
>> +enum mmc_issue_type mmc_cqe_issue_type(struct mmc_host *host,
>> +                       struct request *req)
>> +{
>> +    switch (req_op(req)) {
>> +    case REQ_OP_DRV_IN:
>> +    case REQ_OP_DRV_OUT:
>> +    case REQ_OP_DISCARD:
>> +    case REQ_OP_SECURE_ERASE:
>> +        return MMC_ISSUE_SYNC;
>> +    case REQ_OP_FLUSH:
>> +        return mmc_cqe_can_dcmd(host) ? MMC_ISSUE_DCMD : MMC_ISSUE_SYNC;
>> +    default:
>> +        return MMC_ISSUE_ASYNC;
>> +    }
>> +}
