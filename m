From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH RFC 04/39] mmc: core: Do not prepare a new request twice
Date: Wed, 15 Feb 2017 13:49:02 +0100
Message-ID: <CACRpkdZJ-ccYjMzdsf=z4uem6G=C9fopbV-1sUPeeEAJrJENiA@mail.gmail.com>
References: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com> <1486731352-8018-5-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:35083 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750767AbdBOMtJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2017 07:49:09 -0500
Received: by mail-it0-f48.google.com with SMTP id 203so63903390ith.0
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2017 04:49:09 -0800 (PST)
In-Reply-To: <1486731352-8018-5-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

On Fri, Feb 10, 2017 at 1:55 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> mmc_start_req() assumes it is never called with the new request already
> prepared. That is true if the queue consists of only 2 requests, but is not
> true for a longer queue. e.g. mmc_start_req() has a current and previous
> request but still exits to queue a new request if the queue size is
> greater than 2. In that case, when mmc_start_req() is called again, the
> current request will have been prepared already. Fix by flagging if the
> request has been prepared.
>
> That also means ensuring that struct mmc_async_req is always initialized
> to zero, which wasn't the case in mmc_test.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Reviewed-by: Harjani Ritesh <riteshh@codeaurora.org>

I disagree with this patch, because it makes things even more complex,
with .pre_req_done:

> +       if (areq && !areq->pre_req_done) {
> +               areq->pre_req_done = true;
(...)
> +       if (host->areq) {
> +               host->areq->pre_req_done = false;
(...)
> +       if ((status != MMC_BLK_SUCCESS || start_err) && areq) {
> +               areq->pre_req_done = false;
> @@ -168,6 +168,7 @@ struct mmc_async_req {
> +       bool pre_req_done;

We already have a crazy amount of states, which is something I try to
address in my patch set where I kill off the context and instead model
things in a different way:

Today what happens is that we call mmc_pre_req(), wait for the
previous request to complete, get the status, and if it happens
to be bad, we call mmc_post_req() and return back to the block
queue.

But why do we do that? Why are we not just leaving the request
prepared? After all it is just a cache flusg that happens in the
mmc_pre_req()... so you are addressing that in the patch, which
is nice in a way.

But in my patch set, we get rid of the whole problem, because I
just redefine things by introducing a completion in the areq.
When that completion is complete, we can always issue a new
request, because that completion is not done until all retry and
trying with single writes and error handling etc is already done.

What I don't like about this is that it takes the dataflow and states
that I'm trying to simplify by removing the NULL flushing, and
makes it even more complex with yet another state.

I haven't read all patches yet, but I feel it is better to do
command queueing on top of my patches, that is, except
for the last one that switch to using blk-mq - it's just an RFC.

Maybe I change my mind when I've read it all through, but I
generally feel I simplify the data flow, while this complicates the
data flow, but I admit that that position is a bit subjective.

Yours,
Linus Walleij
