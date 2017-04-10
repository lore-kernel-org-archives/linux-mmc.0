From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V2 06/22] mmc: mmc: Add functions to enable / disable the
 Command Queue
Date: Mon, 10 Apr 2017 14:11:46 +0300
Message-ID: <31e5cbc2-91e0-9d32-003c-df6ea0a10a49@intel.com>
References: <1489408613-26915-1-git-send-email-adrian.hunter@intel.com>
 <1489408613-26915-7-git-send-email-adrian.hunter@intel.com>
 <CAPDyKFpuVWfwL-n13JKybsm56yaEzYOws7GpX-gbe-BX1O9crA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:45739 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752939AbdDJLR2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 10 Apr 2017 07:17:28 -0400
In-Reply-To: <CAPDyKFpuVWfwL-n13JKybsm56yaEzYOws7GpX-gbe-BX1O9crA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>

On 10/04/17 14:01, Ulf Hansson wrote:
> On 13 March 2017 at 13:36, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> Add helper functions to enable or disable the Command Queue.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  Documentation/mmc/mmc-dev-attrs.txt |  1 +
>>  drivers/mmc/core/mmc.c              |  2 ++
>>  drivers/mmc/core/mmc_ops.c          | 28 ++++++++++++++++++++++++++++
>>  drivers/mmc/core/mmc_ops.h          |  2 ++
>>  include/linux/mmc/card.h            |  1 +
>>  5 files changed, 34 insertions(+)
>>
>> diff --git a/Documentation/mmc/mmc-dev-attrs.txt b/Documentation/mmc/mmc-dev-attrs.txt
>> index 404a0e9e92b0..dcd1252877fb 100644
>> --- a/Documentation/mmc/mmc-dev-attrs.txt
>> +++ b/Documentation/mmc/mmc-dev-attrs.txt
>> @@ -30,6 +30,7 @@ All attributes are read-only.
>>         rel_sectors             Reliable write sector count
>>         ocr                     Operation Conditions Register
>>         dsr                     Driver Stage Register
>> +       cmdq_en                 Command Queue enabled: 1 => enabled, 0 => not enabled
>>
>>  Note on Erase Size and Preferred Erase Size:
>>
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 7fd722868875..5727a0842a59 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -790,6 +790,7 @@ static int mmc_compare_ext_csds(struct mmc_card *card, unsigned bus_width)
>>  MMC_DEV_ATTR(raw_rpmb_size_mult, "%#x\n", card->ext_csd.raw_rpmb_size_mult);
>>  MMC_DEV_ATTR(rel_sectors, "%#x\n", card->ext_csd.rel_sectors);
>>  MMC_DEV_ATTR(ocr, "%08x\n", card->ocr);
>> +MMC_DEV_ATTR(cmdq_en, "%d\n", card->ext_csd.cmdq_en);
> 
> Why do we need to be able to change this from userspace?

MMC_DEV_ATTR makes it read-only, so it is just a way for userspace to see if
command queue is enabled.

