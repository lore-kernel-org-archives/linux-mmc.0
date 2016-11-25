From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V7 16/25] mmc: block: Fix 4K native sector check
Date: Fri, 25 Nov 2016 15:51:16 +0100
Message-ID: <CACRpkdYc2uwCFA+d8CaiHrrxmXa5DCtC7d9cb_f=LZ6HtdSECA@mail.gmail.com>
References: <1480068442-5169-1-git-send-email-adrian.hunter@intel.com> <1480068442-5169-17-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f173.google.com ([209.85.216.173]:35142 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754440AbcKYOvS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Nov 2016 09:51:18 -0500
Received: by mail-qt0-f173.google.com with SMTP id c47so67739640qtc.2
        for <linux-mmc@vger.kernel.org>; Fri, 25 Nov 2016 06:51:17 -0800 (PST)
In-Reply-To: <1480068442-5169-17-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

On Fri, Nov 25, 2016 at 11:07 AM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> The 4K native sector check does not allow for the 'do' loop nor the
> variables used after the 'cmd_abort' label.
>
> 'brq' and 'req' get reassigned in the 'do' loop, so the check must not
> assume what their values are. After the 'cmd_abort' label, 'mq_rq' and
> 'req' are used, but 'rqc' must be NULL otherwise it can be started again.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Looks correct, and is clearly a sign of what we all know:
mmc_blk_issue_rw_rq() is hopelessly convoluted and needs to
be refactored into something we can read.

Shouldn't this patch just be moved to the front of the patch queue
and merged as a fix? AFAICT it's a plain bug.

Yours,
Linus Walleij
