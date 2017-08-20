From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V5 05/13] mmc: core: Add support for handling CQE requests
Date: Sun, 20 Aug 2017 13:39:40 +0200
Message-ID: <CACRpkdYxSPx7H1P3brb36C5x816bfcQ-zmuxcDk27ZfAa7odXg@mail.gmail.com>
References: <1502366898-23691-1-git-send-email-adrian.hunter@intel.com> <1502366898-23691-6-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:34612 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752721AbdHTLjl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 20 Aug 2017 07:39:41 -0400
Received: by mail-oi0-f46.google.com with SMTP id j144so4081759oib.1
        for <linux-mmc@vger.kernel.org>; Sun, 20 Aug 2017 04:39:41 -0700 (PDT)
In-Reply-To: <1502366898-23691-6-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Shawn Lin <shawn.lin@rock-chips.com>

On Thu, Aug 10, 2017 at 2:08 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> Add core support for handling CQE requests, including starting, completing
> and recovering.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>


> +static void __mmc_cqe_request_done(struct mmc_host *host,
> +                                  struct mmc_request *mrq)

We are naming too much stuff __foo now, it gets really hard to figure
out from the function name and the surrounding code what is going on.

I guess people are using this like "do parts of what mmc_cqe_request_done()
is doing" but it'd be nice if we could be specific.

mmc_cqe_request_finalize() could work?

Yours,
Linus Walleij
