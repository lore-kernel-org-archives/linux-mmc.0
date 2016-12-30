From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: use empty initializer list to zero-clear structures
Date: Fri, 30 Dec 2016 09:09:24 +0100
Message-ID: <CACRpkdZ7ovJQWkYzMJ4zxgL-OfR-3FkM71u0G0UevXD2RowLpA@mail.gmail.com>
References: <1482148278-11395-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:36855 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751587AbcL3IJZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Dec 2016 03:09:25 -0500
Received: by mail-qk0-f174.google.com with SMTP id n21so286281482qka.3
        for <linux-mmc@vger.kernel.org>; Fri, 30 Dec 2016 00:09:25 -0800 (PST)
In-Reply-To: <1482148278-11395-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Baolin Wang <baolin.wang@linaro.org>, Bojan Prtvar <prtvar.b@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Pratibhasagar V <pratibha@codeaurora.org>, Gwendal Grignou <gwendal@chromium.org>, Jens Axboe <axboe@fb.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <aisheng.dong@nxp.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Shawn Lin <shawn.lin@rock-chips.com>, Dan Carpenter <dan.carpenter@oracle.com>, Bhaktipriya Shridhar <bhaktipriya96@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>

On Mon, Dec 19, 2016 at 12:51 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> In the MMC subsystem, we see such initializers that only clears the
> first member explicitly.
>
> For example,
>
>   struct mmc_request mrq = {NULL};
>
> sets the first member (.sbc) to NULL explicitly.  However, this is
> an unstable form because we may insert a non-pointer member at the
> top of the struct mmc_request in the future. (if we do so, the
> compiler will spit warnings.)
>
> So, using a designated initializer is preferred coding style.  The
> expression above is equivalent to:
>
>   struct mmc_request mrq = { .sbc = NULL };
>
> Of course, this does not express our intention.  We want to fill
> all struct members with zeros.  Please note struct members are
> implicitly zero-cleared unless otherwise specified in the initializer.
>
> After all, the most reasonable (and stable) form is:
>
>   struct mmc_request mrq = {};
>
> Do likewise for mmc_command, mmc_data as well.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
