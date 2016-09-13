From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V4 00/30] mmc: mmc: Add Software Command Queuing
Date: Tue, 13 Sep 2016 12:41:44 +0300
Message-ID: <bc910db1-db7b-6e84-7915-de9a7a8447a7@intel.com>
References: <1471344280-16663-1-git-send-email-adrian.hunter@intel.com>
 <CAPDyKFqFF2NYzRvO3XTy0m2MiX6ft2bU1jp_U1RR_XU1JLWziw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:35186 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754189AbcIMJq0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 13 Sep 2016 05:46:26 -0400
In-Reply-To: <CAPDyKFqFF2NYzRvO3XTy0m2MiX6ft2bU1jp_U1RR_XU1JLWziw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

On 12/09/16 15:36, Ulf Hansson wrote:
> On 16 August 2016 at 12:44, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> Hi
>>
>> Here is an updated version of the Software Command Queuing patches,
>> re-based on next + v4.8-rc2 + "block: Fix secure erase" patch, otherwise no
>> changes since V3.
>>
>> Ulf, as before, if you accept the "Command during Transfer" API introduced
>> in patch 1, then you could take patches 1-5 in advance of the rest.
> 
> Adrian,
> 
> I have had a busy period, apologize for taking such long time to review this!
> 
> Patch 1->5 looks good to me, so I have applied these for next. I will
> continue with the review during the week.

Thank you!

