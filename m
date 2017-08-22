From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/8] debugfs and RPMB cleanups
Date: Tue, 22 Aug 2017 13:15:19 +0200
Message-ID: <CAPDyKFr01aKJ_OqKgMsa9fVs=cW40g_tbtSw4g=Uyze5CZ1Y-w@mail.gmail.com>
References: <20170820213913.9737-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f182.google.com ([209.85.216.182]:33206 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932573AbdHVLPU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Aug 2017 07:15:20 -0400
Received: by mail-qt0-f182.google.com with SMTP id d15so24699651qta.0
        for <linux-mmc@vger.kernel.org>; Tue, 22 Aug 2017 04:15:20 -0700 (PDT)
In-Reply-To: <20170820213913.9737-1-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 20 August 2017 at 23:39, Linus Walleij <linus.walleij@linaro.org> wrote:
> Here is a series of all the cleanup patches and RPMB rewrite
> I didn't manage to finish for the last merge window, hoping we can
> include these cleanups/refactorings for v4.14.
>
> It's OK to stop applying at any step if there is any problem.

Applied patch 1->6.

Seems like a re-spin may be need for patch7 and 8, in any case I
postpone to apply them for a little while.

>
> Linus Walleij (8):
>   mmc: block: Anonymize the drv op data pointer
>   mmc: ops: export mmc_get_status()
>   mmc: debugfs: Move block debugfs into block module
>   mmc: block: Move duplicate check
>   mmc: block: Refactor mmc_blk_part_switch()
>   mmc: block: Reparametrize mmc_blk_ioctl_[multi]_cmd()
>   mmc: block: Convert RPMB to a character device
>   mmc: block: Delete mmc_access_rpmb()
>
>  drivers/mmc/core/block.c   | 543 ++++++++++++++++++++++++++++++++++++++-------
>  drivers/mmc/core/debugfs.c |  89 --------
>  drivers/mmc/core/mmc_ops.c |   1 +
>  drivers/mmc/core/queue.c   |   2 +-
>  drivers/mmc/core/queue.h   |  10 +-
>  5 files changed, 467 insertions(+), 178 deletions(-)
>
> --
> 2.13.5
>

Kind regards
Uffe
