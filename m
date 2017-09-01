From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V7 00/10] mmc: Add Command Queue support
Date: Fri, 1 Sep 2017 14:58:36 +0200
Message-ID: <CAPDyKFriJLD-Q76tyUwXkAWJ8D3g=KOMt1rAtmufg97=Wh3jAQ@mail.gmail.com>
References: <1504180616-14514-1-git-send-email-adrian.hunter@intel.com> <ff9eeab1-199a-3ab3-9fa8-cc2f08d52a54@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:36327 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751888AbdIAM6h (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Sep 2017 08:58:37 -0400
Received: by mail-io0-f182.google.com with SMTP id f99so736848ioi.3
        for <linux-mmc@vger.kernel.org>; Fri, 01 Sep 2017 05:58:37 -0700 (PDT)
In-Reply-To: <ff9eeab1-199a-3ab3-9fa8-cc2f08d52a54@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>, Christoph Hellwig <hch@lst.de>

+ Christoph

On 1 September 2017 at 13:42, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 31/08/17 14:56, Adrian Hunter wrote:
>> Here is V7 of the hardware command queue patches without the software
>> command queue patches, now using blk-mq.
>>
>> HW CMDQ offers 25% - 50% better random multi-threaded I/O.  I see a slight
>> 2% drop in sequential read speed but no change to sequential write.
>
> Any comments?

A couple of overall comments, for now.

To make sure we don't overlook something when converting to mq, I
would prefer that we first convert the existing mmc block code to mq,
then we add CMDQ on top.

Regarding patch1. in the long-term solution, we should really strive
towards getting rid of the big mmc host lock, as it causes us to lose
some of the benefits on which principles mq is designed upon.

However, it may be feasible to use patch1 as an intermediate step, to
be able to convert to mq short term. Then we can continue doing the
re-factoring, to get rid of the big mmc host lock and solve other
relates issues/optimize things. What remains to be seen in this
approach, is how well mq performs, as we would still be using the big
mmc host lock. We may tolerate some minor regressions, but if too
much, there is no other way that first removing the big mmc lock.

Of course, if Linus/Christoph don't think this intermediate approach
is good enough, we will have to respect that as well.

Kind regards
Uffe
