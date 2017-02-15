From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH RFC 09/39] mmc: queue: Add a function to control wake-up
 on new requests
Date: Wed, 15 Feb 2017 14:07:30 +0100
Message-ID: <CACRpkdamiAJZWzMG2_zuwgcQvy02dD=tGiSD0E0d20E3YCGkag@mail.gmail.com>
References: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com> <1486731352-8018-10-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f47.google.com ([209.85.214.47]:35198 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750782AbdBONHh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2017 08:07:37 -0500
Received: by mail-it0-f47.google.com with SMTP id 203so64167354ith.0
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2017 05:07:37 -0800 (PST)
In-Reply-To: <1486731352-8018-10-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

On Fri, Feb 10, 2017 at 1:55 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> Add a function to control wake-up on new requests. This will enable
> Software Command Queuing to choose whether or not to queue new
> requests immediately or wait for the current task to complete.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

I think my patch set killed off the context and this whole thing
"just works" instead of needing more states and hacks like this.

The proliferation of states is reaching a all time high here:

+       if (cntx->is_waiting_last_req != wake_me) {
+               spin_lock_irq(q->queue_lock);
+               cntx->is_waiting_last_req = wake_me;
+               cntx->is_new_req = wake_me && mq->is_new_req;
(...)
@@ -43,6 +43,7 @@ struct mmc_queue {
(...)
+       bool                    is_new_req;

Now there is a is_new_req in the context AND an identically
named state variable in struct mmc_queue, and when reading the
code I suspect a reader would like to know the difference
between the two .is_new_req variables, one in the state
of the host and one in the state of the queue.

This is a cognitive nightmare, sorry. At least this would have to
have more specific names.

I think all these states come from the polling loop construction
and this constant spinning around and checking for errors, doing
and undoing the pre/post/bounce stuff, and compulsively flushing
the pipeline with NULL and so on. I was trying to
get rid of that stuff, but this is expanding it instead.

Hm, maybe I get a bit on the complainy side, sorry if so...

Yours,
Linus Walleij
