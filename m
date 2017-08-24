From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V5 03/13] mmc: host: Add CQE interface
Date: Thu, 24 Aug 2017 09:53:01 +0300
Message-ID: <c0f1cba4-c0a7-4936-77fd-41d3d90a4665@intel.com>
References: <1502366898-23691-1-git-send-email-adrian.hunter@intel.com>
 <1502366898-23691-4-git-send-email-adrian.hunter@intel.com>
 <CAPDyKFpemPy7ioB3=B3VrOBhDED3HoDq0CVBV=bq7gyEOQ7PkA@mail.gmail.com>
 <732e8ebc-9b81-90c4-c719-eab1ca0ac220@intel.com>
 <CAPDyKFp1YTWNfECS5720amq8zrJxhSuCJN+GUk2PEZTvdCLaXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:29374 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751124AbdHXG7e (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 24 Aug 2017 02:59:34 -0400
In-Reply-To: <CAPDyKFp1YTWNfECS5720amq8zrJxhSuCJN+GUk2PEZTvdCLaXw@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>

On 23/08/17 15:48, Ulf Hansson wrote:
> On 23 August 2017 at 08:54, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 22/08/17 14:13, Ulf Hansson wrote:
>>> On 10 August 2017 at 14:08, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>> +       void                    (*cqe_recovery_notifier)(struct mmc_host *,
>>>> +                                                        struct mmc_request *);
>>>
>>> Normally we don't put callbacks in the struct mmc_host that someone
>>> else than the host driver should assign - so this feels a bit upside
>>> down.
>>>
>>> Is there any reason to why you didn't want to add a new API? Something
>>> like mmc_cqe_recover(), which the host driver could call.
>>
>> That would make the host driver dependent on the block driver.  There needs
>> to be a function pointer, even if we wrap it in an API.
> 
> Okay, I see. I guess we could put such pointer somewhere closer to the
> mmc request queue.

Another possibility is to put in into struct mmc_request like the "done"
callback.

> 
> Anyway, I didn't find out how this pointer was being protected from
> concurrent access or perhaps that is managed via
> mmc_claim|release_host()?

It is assumed CQE is only used by the card driver so the callback can be set
/ reset in the card driver's probe / remove.

>                           Moreover, I could find it ever it being
> reset to NULL.

Yeah, doesn't look like it gets reset.
