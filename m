From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V7 04/25] mmc: queue: Factor out mmc_queue_alloc_sgs()
Date: Fri, 25 Nov 2016 15:41:10 +0100
Message-ID: <CACRpkdYa9eQaNST4KGbb+BBqz7XDnWTNTJ9tqJxZ+QtpZ7sEcw@mail.gmail.com>
References: <1480068442-5169-1-git-send-email-adrian.hunter@intel.com> <1480068442-5169-5-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f180.google.com ([209.85.216.180]:34064 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754236AbcKYOmI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Nov 2016 09:42:08 -0500
Received: by mail-qt0-f180.google.com with SMTP id n6so67582829qtd.1
        for <linux-mmc@vger.kernel.org>; Fri, 25 Nov 2016 06:41:11 -0800 (PST)
In-Reply-To: <1480068442-5169-5-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

On Fri, Nov 25, 2016 at 11:07 AM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> In preparation for supporting a queue of requests, factor out
> mmc_queue_alloc_sgs().
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Nice refactoring.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
