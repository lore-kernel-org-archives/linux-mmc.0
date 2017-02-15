From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH RFC 03/39] mmc: block: Introduce queue semantics
Date: Wed, 15 Feb 2017 13:29:22 +0100
Message-ID: <CACRpkdZwvF2ZRvki6OFvGnK0V7=9XUUx8+ZNACjjwknW5_ZUGg@mail.gmail.com>
References: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com> <1486731352-8018-4-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:35350 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751557AbdBOM3Y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2017 07:29:24 -0500
Received: by mail-io0-f175.google.com with SMTP id j18so87284209ioe.2
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2017 04:29:23 -0800 (PST)
In-Reply-To: <1486731352-8018-4-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

On Fri, Feb 10, 2017 at 1:55 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:

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

This patch appears to be doing the same thing as my patch
"mmc: queue: get/put struct mmc_queue_req"

I just happen to feel that mmc_queue_req_get() vs
mmc_queue_req_put() is a more intuitive naming. If I wanted to
be overspecific I would say "mmc_queue_req_pool_get()"
and "mmc_queue_req_pool_put()".

On top of that, this patch adds the task_id and qcount business
to see if things are complete. This is closely related to the
mechanism of a polling loop that my patch set is getting us
rid of: I stop issueing NULL requests altogether and this
way we get rid of a big chunk of the problems you are
addressing here, like this:

> -                       if (mq->mqrq_prev->req)
> +                       if (mq->qcnt)
>                                 cntx->is_waiting_last_req = true;
(...)
> -               if (req || mq->mqrq_prev->req) {
> -                       bool req_is_special = mmc_req_is_special(req);
> -
> +               if (req || mq->qcnt) {

As you will see, I take it further, the above will become just:
if (req).

Yours,
Linus Walleij
