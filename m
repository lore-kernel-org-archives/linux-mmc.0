From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V7 01/25] mmc: queue: Fix queue thread wake-up
Date: Fri, 25 Nov 2016 15:37:44 +0100
Message-ID: <CACRpkdZB1kKxMY6jh2=1wbSta-57sctAb+fZoN8zW3G37L8wDA@mail.gmail.com>
References: <1480068442-5169-1-git-send-email-adrian.hunter@intel.com> <1480068442-5169-2-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:36407 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932240AbcKYOhq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Nov 2016 09:37:46 -0500
Received: by mail-qk0-f176.google.com with SMTP id n21so79938474qka.3
        for <linux-mmc@vger.kernel.org>; Fri, 25 Nov 2016 06:37:45 -0800 (PST)
In-Reply-To: <1480068442-5169-2-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

On Fri, Nov 25, 2016 at 11:06 AM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> The only time the driver sleeps expecting to be woken upon the arrival of
> a new request, is when the dispatch queue is empty. The only time that it
> is known whether the dispatch queue is empty is after NULL is returned
> from blk_fetch_request() while under the queue lock.
>
> Recognizing those facts, simplify the synchronization between the queue
> thread and the request function. A couple of flags tell the request
> function what to do, and the queue lock and barriers associated with
> wake-ups ensure synchronization.
>
> The result is simpler and allows the removal of the context_info lock.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Very nice patch!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
