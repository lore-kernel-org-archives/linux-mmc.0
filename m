From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V7 02/25] mmc: queue: Factor out mmc_queue_alloc_bounce_bufs()
Date: Fri, 25 Nov 2016 15:38:47 +0100
Message-ID: <CACRpkdZZJU2LceHNYM5gRPe+S-o=fCHDkO5SjyX5f-dJnvJqHA@mail.gmail.com>
References: <1480068442-5169-1-git-send-email-adrian.hunter@intel.com> <1480068442-5169-3-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:32844 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754533AbcKYOis (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Nov 2016 09:38:48 -0500
Received: by mail-qk0-f174.google.com with SMTP id x190so80050808qkb.0
        for <linux-mmc@vger.kernel.org>; Fri, 25 Nov 2016 06:38:47 -0800 (PST)
In-Reply-To: <1480068442-5169-3-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

On Fri, Nov 25, 2016 at 11:06 AM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> In preparation for supporting a queue of requests, factor out
> mmc_queue_alloc_bounce_bufs().
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Nice refactoring.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
