From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V4 00/11] mmc: Add Command Queue support
Date: Tue, 8 Aug 2017 12:36:16 +0200
Message-ID: <CAPDyKFq6qj9vA+WnR7SvacsJC3nXr_mHSSi9Y2P22otFQvNJEg@mail.gmail.com>
References: <1500630584-22852-1-git-send-email-adrian.hunter@intel.com>
 <CAPDyKFpSq+nNCud=XmnQN_s5Hjfh1LVrA=5enwOw1PrN=n8-yw@mail.gmail.com> <08f77620-3efa-0532-9146-27bcae00b19a@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:38263 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751464AbdHHKgS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Aug 2017 06:36:18 -0400
Received: by mail-qk0-f177.google.com with SMTP id x191so17028380qka.5
        for <linux-mmc@vger.kernel.org>; Tue, 08 Aug 2017 03:36:18 -0700 (PDT)
In-Reply-To: <08f77620-3efa-0532-9146-27bcae00b19a@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>

On 8 August 2017 at 11:26, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 07/08/17 16:41, Ulf Hansson wrote:
>> On 21 July 2017 at 11:49, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>> Hi
>>>
>>> Here is V4 of the hardware command queue patches without the software
>>> command queue patches.
>>
>> Adrian, again apologize for the delay.
>>
>> I am reviewing the series now and my intent is to provide comments on
>> each change separately during the week.
>>
>> However, a couple of overall thoughts:
>>
>> *) Could you please post some fresh performance measurements, such we
>> can get some real proof on why CMDQ is worth to be merged? If not
>> increased throughput, perhaps we can show some decreased I/O requests
>> latency!?
>
> HW CMDQ offers 25% - 50% better random multi-threaded I/O.  I see a slight
> 2% drop in sequential read speed but no change to sequential write.

Great, that satisfies my request! Could you please fold in this
information in one of the change-logs, which adds supports for the
CQE?

>
>>
>> **) I have spoken to Linus W offlist - and he is still working on the
>> blkmq port. Although we first need to continue with the
>> re-factorization of the mmc block/core code, to minimize the bad
>> impact of our big mmc claim host lock. We should expect a
>> re-submission of his series quite soonish. However, it's also likely
>> that we need yet another round of re-factoring, before we can complete
>> the port to blkmq.
>>
>> ***) The reason for bringing up **), is of course because I think
>> deploying CMDQ support would be better done on top of the blkmq
>> interface as it's better suited for these kind of device types. My
>> goal is to reach a better maintenance situation, using more modern mmc
>> block code. We have spoken about this before, however of course I also
>> don't want to delay the CMDQ series. Anyway, let's move forward and
>> see what path we end up taking.
>
> There is no advantage to holding up HW CMDQ.

Maybe not.

I haven't completed the review yet, but I guess you understand my
concerns on the impact of the blkmq port.

If I can get some promises about yours support (testing/reviewing/etc)
of the blkmq port series when going forward, that would of course
impact my decision on what path to pick.

Does that sounds reasonable to you?

[...]

Kind regards
Uffe
