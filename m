From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/3] MMC cleanups
Date: Mon, 7 Nov 2016 13:43:21 +0100
Message-ID: <CAPDyKFqrBrKAWt0-ifK1nKDv=czJLAZzKOzfKq2MYtnr1cYaXg@mail.gmail.com>
References: <1478253919-2469-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37991 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751543AbcKGMnY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Nov 2016 07:43:24 -0500
Received: by mail-wm0-f47.google.com with SMTP id f82so116044755wmf.1
        for <linux-mmc@vger.kernel.org>; Mon, 07 Nov 2016 04:43:23 -0800 (PST)
In-Reply-To: <1478253919-2469-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>

On 4 November 2016 at 11:05, Linus Walleij <linus.walleij@linaro.org> wrote:
> This is a set of three cleanup patches for the MMC core/card/block
> code. I had to make them to start to understand what the code was
> doing.
>
> It would be great if we could apply these as a base for further
> refactoring of the core code, e.g. for multiqueue efforts.
>
> Linus Walleij (3):
>   mmc: block: make gen_err a bool variable
>   mmc: block: convert ecc_err to a bool
>   mmc: core: use enum mmc_blk_status properly
>
>  drivers/mmc/card/block.c    | 34 ++++++++++++++++++----------------
>  drivers/mmc/card/mmc_test.c | 44 ++++++++++++++++++++++++++++++++++----------
>  drivers/mmc/core/core.c     | 35 ++++++++++++++++++-----------------
>  include/linux/mmc/card.h    | 12 ------------
>  include/linux/mmc/core.h    | 15 ++++++++++++++-
>  include/linux/mmc/host.h    |  2 +-
>  6 files changed, 85 insertions(+), 57 deletions(-)
>
> --
> 2.7.4
>

Thanks, applied for next!

Kind regards
Uffe
