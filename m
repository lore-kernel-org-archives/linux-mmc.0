From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V2 04/22] mmc: block: Introduce queue semantics
Date: Sat, 8 Apr 2017 19:40:07 +0200
Message-ID: <CACRpkdZagwtgb8fiMsumxdNMn8=Vb+rvfyc5gq1Toy9tkUs91A@mail.gmail.com>
References: <1489408613-26915-1-git-send-email-adrian.hunter@intel.com> <1489408613-26915-5-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:35873 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751517AbdDHRkI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 8 Apr 2017 13:40:08 -0400
Received: by mail-io0-f182.google.com with SMTP id l7so64844172ioe.3
        for <linux-mmc@vger.kernel.org>; Sat, 08 Apr 2017 10:40:08 -0700 (PDT)
In-Reply-To: <1489408613-26915-5-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Shawn Lin <shawn.lin@rock-chips.com>

On Mon, Mar 13, 2017 at 1:36 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> Change from viewing the requests in progress as 'current' and 'previous',
> to viewing them as a queue. The current request is allocated to the first
> free slot. The presence of incomplete requests is determined from the
> count (mq->qcnt) of entries in the queue. Non-read-write requests (i.e.
> discards and flushes) are not added to the queue at all and require no
> special handling. Also no special handling is needed for the
> MMC_BLK_NEW_REQUEST case.
>
> As well as allowing an arbitrarily sized queue, the queue thread function
> is significantly simpler.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
