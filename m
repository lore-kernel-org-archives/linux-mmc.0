From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V5 05/13] mmc: core: Add support for handling CQE requests
Date: Mon, 21 Aug 2017 12:26:45 +0300
Message-ID: <9a5a19b8-2670-fcdb-5e9b-f67d0efb1cf4@intel.com>
References: <1502366898-23691-1-git-send-email-adrian.hunter@intel.com>
 <1502366898-23691-6-git-send-email-adrian.hunter@intel.com>
 <CACRpkdYxSPx7H1P3brb36C5x816bfcQ-zmuxcDk27ZfAa7odXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:57082 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751894AbdHUJdV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 21 Aug 2017 05:33:21 -0400
In-Reply-To: <CACRpkdYxSPx7H1P3brb36C5x816bfcQ-zmuxcDk27ZfAa7odXg@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Shawn Lin <shawn.lin@rock-chips.com>

On 20/08/17 14:39, Linus Walleij wrote:
> On Thu, Aug 10, 2017 at 2:08 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> 
>> Add core support for handling CQE requests, including starting, completing
>> and recovering.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> 
>> +static void __mmc_cqe_request_done(struct mmc_host *host,
>> +                                  struct mmc_request *mrq)
> 
> We are naming too much stuff __foo now, it gets really hard to figure
> out from the function name and the surrounding code what is going on.

You have written several times that you don't like __foo() names, however it
is a normal kernel paradigm.

> I guess people are using this like "do parts of what mmc_cqe_request_done()
> is doing" but it'd be nice if we could be specific.
> 
> mmc_cqe_request_finalize() could work?

It can be rolled into mmc_cqe_request_done().
