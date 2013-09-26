From: Grant Grundler <grundler@chromium.org>
Subject: Re: [PATCH 0/7] mmc: core: cleanup and locking patches description
Date: Thu, 26 Sep 2013 12:57:39 -0700
Message-ID: <CANEJEGvFFu-MDQX4UNcfr58Jxg6BKkw=gAMqz0Vv6jV9miixfg@mail.gmail.com>
References: <1380223380-22451-1-git-send-email-grundler@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:57253 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789Ab3IZT5k (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Sep 2013 15:57:40 -0400
Received: by mail-oa0-f49.google.com with SMTP id i4so1285472oah.22
        for <linux-mmc@vger.kernel.org>; Thu, 26 Sep 2013 12:57:39 -0700 (PDT)
In-Reply-To: <1380223380-22451-1-git-send-email-grundler@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Grundler <grundler@chromium.org>
Cc: Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Argh...too much wordsmithing...

On Thu, Sep 26, 2013 at 12:22 PM, Grant Grundler <grundler@chromium.org> wrote:
> Following 7 patches are mostly cleanup with one key patch around host->areq
> locking.  The host->areq locking problem description is here:
>         http://www.spinics.net/lists/linux-mmc/msg21644.html
>
> I do believe this preposed host->areq locking patch is a complete fix.

... is NOT a complete fix.

> But it appears to fix the problem and is better than nothing.

Still true.

cheers,
grant

>
> This patch sequence applies clean to linus' 3.12-rc2 branch and only compile
> tested in this form. This is a forward port (and cleanup) of the
> same patch I've been testing on ChromeOS-3.4 tree using Exynos5250 chipset.
>
> cheers,
> grant
>
> 0000-mmc-core-cleanups-and-locking-description (this email)
> 0001-mmc-core-rename-data-to-saved_areq.patch
> 0002-mmc-core-rename-local-var-err-to-saved_err.patch
> 0003-mmc-core-restructure-error-handling-for-start-req.patch
> 0004-mmc-core-use-common-code-path-to-return-error.patch
> 0005-mmc-core-handling-polling-more-gracefully.patch
> 0006-mmc-core-protect-references-to-host-areq-with-host-l.patch
> 0007-mmc-core-mmc_start_req-is-a-misnomer-mmc_process_are.patch
>
>
>  drivers/mmc/card/block.c    |   8 ++--
>  drivers/mmc/card/mmc_test.c |   4 +-
>  drivers/mmc/core/core.c     | 103 +++++++++++++++++++++++++-------------------
>  include/linux/mmc/core.h    |   2 +-
>  4 files changed, 66 insertions(+), 51 deletions(-)
