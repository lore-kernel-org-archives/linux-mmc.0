From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V5 01/13] mmc: core: Add mmc_retune_hold_now()
Date: Sun, 20 Aug 2017 13:26:31 +0200
Message-ID: <CACRpkdZLyO+rEwPKtRVx+ciAg0fY0bue8rPTcxBivLUtbOSnAw@mail.gmail.com>
References: <1502366898-23691-1-git-send-email-adrian.hunter@intel.com> <1502366898-23691-2-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:34870 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752721AbdHTL0c (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 20 Aug 2017 07:26:32 -0400
Received: by mail-oi0-f41.google.com with SMTP id e124so132301779oig.2
        for <linux-mmc@vger.kernel.org>; Sun, 20 Aug 2017 04:26:32 -0700 (PDT)
In-Reply-To: <1502366898-23691-2-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Shawn Lin <shawn.lin@rock-chips.com>

On Thu, Aug 10, 2017 at 2:08 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> mmc_return_hold() / mmc_retune_release() are used around a group of
> commands to prevent re-tuning between the commands. Re-tuning can still
> happen before the first command. In some cases, re-tuning must be
> prevented entirely. Add mmc_retune_hold_now() for that purpose. It is
> added in preparation for CQE support where it will be used by CQE recovery.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

> +void mmc_retune_hold_now(struct mmc_host *host)
>  void mmc_retune_release(struct mmc_host *host)

If the only hint we have about how to use these functions is through the
commit log we are in trouble, but I would say in this case the function
name is kind of half-obvious at least.

I think what troubles me is Rusty's API maturity guideline #6
"6. The name tells you how to use it."

Yours,
Linus Walleij
