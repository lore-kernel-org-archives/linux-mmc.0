From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V2 00/54] mmc: mmc: Add Software Command Queuing
Date: Thu, 30 Jun 2016 10:03:52 +0300
Message-ID: <5774C458.4090907@intel.com>
References: <1467206707-30185-1-git-send-email-adrian.hunter@intel.com>
 <e80b0201-3cd3-8c1e-8c44-7ac1db89c5b6@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:31938 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752254AbcF3HJB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 30 Jun 2016 03:09:01 -0400
In-Reply-To: <e80b0201-3cd3-8c1e-8c44-7ac1db89c5b6@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

On 29/06/16 17:24, Ritesh Harjani wrote:
> Hi Adrian,
> 
> On 6/29/2016 6:54 PM, Adrian Hunter wrote:
>> Hi
>>
>> Here is an updated version of the Software Command Queuing patches,
>> re-based on the SDHCI patches that I have.
>>
>> Ulf, there are a lot of patches now and I think it would be worth taking
>> some of them.  For example, the first 25 affect SDHCI only.  If you accept
>> the "Command during Transfer" API introduced in patch 26, then you could
>> take patches 26-30 as well.
> Are these patches affecting anything w.r.t. SW/HW CMDQ solution?

No.  There are changes to SDHCI but it should be straight forward to re-base
on top of them.

> Although not yet gone through in detail.
> But otherwise do you think it will be worthwhile to check both the solutions
> before merging any particular design to upstream?

Yes, that needs to be done.

> 
> 
> Well actually as you are aware of, HW CMDQ solution separate out itself from
> legacy w.r.t. pulling/issuing/completing of reqs.
> So mostly it should not affect much here w.r.t. SW CMDQ, but it will be good
> if we could consider, how both solution will look into upstream going forward.

Yes, they are essentially separate but with some common ground around switching.

> 
>>
>> There wasn't much comment on the RFC so there have been few changes.
>> Venu Byravarasu commented that it may be more efficient to use Software
>> Command Queuing only when there is more than 1 request queued - it isn't
>> obvious how well that would work in practice, but it could be added later
>> if it could be shown to be beneficial.
> Agree.
> 
>>
>> I haven't had a chance to go through the hardware Command Queuing patches
>> in detail yet, but otherwise these patches are ready to go.
> Request you to kindly review HW CMDQ patches as well before we plan to merge
> both of them to upstream?

Yes I will review the HW CMDQ patches.

> We do as well plan to go through SW CMDQ set of patches.

Yes please!

