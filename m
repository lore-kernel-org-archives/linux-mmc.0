From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/4] mmc: core: Clean-up and improve polling code in __mmc_switch()
Date: Fri, 21 Oct 2016 10:22:43 +0200
Message-ID: <CAPDyKFreRO0660P3JCSxB+N_bPVJnSMj-ce_dr=bJaB5wUyDiA@mail.gmail.com>
References: <CGME20161020082027epcas1p47e0913622727117286f7ad026259eb2b@epcas1p4.samsung.com>
 <1476951579-26125-1-git-send-email-ulf.hansson@linaro.org> <1ba11108-0804-950d-5410-646b53c798e8@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:35681 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754100AbcJUIWp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Oct 2016 04:22:45 -0400
Received: by mail-qk0-f170.google.com with SMTP id z190so137073142qkc.2
        for <linux-mmc@vger.kernel.org>; Fri, 21 Oct 2016 01:22:45 -0700 (PDT)
In-Reply-To: <1ba11108-0804-950d-5410-646b53c798e8@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>

On 21 October 2016 at 09:49, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> On 10/20/2016 05:19 PM, Ulf Hansson wrote:
>> The code in __mmc_switch() is rather messy and hard to follow/understand. This
>> series starts out by cleaning-up and re-factoring that code. In the final patch
>> I intend to improve the behaviour regarding the polling method, which is being
>> used to know when the card stops signal busy.
>
> Looks good to me.
>
> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
> Tested-by: Jaehoon Chung <jh80.chung@samsung.com>
>
> (Tested on Exynos Series)
>
> Best Regards,
> Jaehoon Chung

Thanks Jaehoon, I have queued them up for my next branch!

Kind regards
Uffe

>
>>
>> Ulf Hansson (4):
>>   mmc: core: Make mmc_switch_status() available for mmc core
>>   mmc: core: Clarify code which deals with polling in __mmc_switch()
>>   mmc: core: Factor out code related to polling in __mmc_switch()
>>   mmc: core: Don't use ->card_busy() and CMD13 in combination when
>>     polling
>>
>>  drivers/mmc/core/mmc.c     |  13 -----
>>  drivers/mmc/core/mmc_ops.c | 138 +++++++++++++++++++++++++--------------------
>>  drivers/mmc/core/mmc_ops.h |   2 +-
>>  3 files changed, 79 insertions(+), 74 deletions(-)
>>
>
