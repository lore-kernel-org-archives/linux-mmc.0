From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V5 05/13] mmc: core: Add support for handling CQE requests
Date: Thu, 31 Aug 2017 13:32:55 +0200
Message-ID: <CACRpkdb2z5YrJe=nNwE6FWRe=myu-hLRqZOxO86BKmWiRxrVhQ@mail.gmail.com>
References: <1502366898-23691-1-git-send-email-adrian.hunter@intel.com>
 <1502366898-23691-6-git-send-email-adrian.hunter@intel.com>
 <CACRpkdYxSPx7H1P3brb36C5x816bfcQ-zmuxcDk27ZfAa7odXg@mail.gmail.com> <9a5a19b8-2670-fcdb-5e9b-f67d0efb1cf4@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:34677 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751074AbdHaLc6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 31 Aug 2017 07:32:58 -0400
Received: by mail-oi0-f47.google.com with SMTP id w10so3150588oie.1
        for <linux-mmc@vger.kernel.org>; Thu, 31 Aug 2017 04:32:58 -0700 (PDT)
In-Reply-To: <9a5a19b8-2670-fcdb-5e9b-f67d0efb1cf4@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Shawn Lin <shawn.lin@rock-chips.com>

On Mon, Aug 21, 2017 at 11:26 AM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 20/08/17 14:39, Linus Walleij wrote:
>> On Thu, Aug 10, 2017 at 2:08 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>>> Add core support for handling CQE requests, including starting, completing
>>> and recovering.
>>>
>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>
>>
>>> +static void __mmc_cqe_request_done(struct mmc_host *host,
>>> +                                  struct mmc_request *mrq)
>>
>> We are naming too much stuff __foo now, it gets really hard to figure
>> out from the function name and the surrounding code what is going on.
>
> You have written several times that you don't like __foo() names, however it
> is a normal kernel paradigm.

Normal doesn't mean "good".

I am negative to it because it has very unclear semantics. What is the
semantic meaning of prefixing a function with __* really?

I have referred to Rusty Russell's API levels:
http://sweng.the-davies.net/Home/rustys-api-design-manifesto

This is on level 3-4 and definately not at 6.

So in my opinion, I have informed, founded in theory and
valid reasons to dislike it, and I don't think it is a matter of taste or
opinion.

>> I guess people are using this like "do parts of what mmc_cqe_request_done()
>> is doing" but it'd be nice if we could be specific.
>>
>> mmc_cqe_request_finalize() could work?
>
> It can be rolled into mmc_cqe_request_done().

OK!

Yours,
Linus Walleij
