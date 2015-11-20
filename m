From: Alan Cooper <alcooperx@gmail.com>
Subject: Re: [RFC 0/6] mmc: Field Firmware Update
Date: Fri, 20 Nov 2015 09:20:01 -0500
Message-ID: <CAOGqxeXyoNFS9JdSj2XtSVUVgzj32hMDepX4_FRy_fEXvyaYEA@mail.gmail.com>
References: <1447426572-11756-1-git-send-email-holgerschurig@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:34269 "EHLO
	mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759891AbbKTOUB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Nov 2015 09:20:01 -0500
In-Reply-To: <1447426572-11756-1-git-send-email-holgerschurig@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Holger Schurig <holgerschurig@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, linux-kernel@vger.kernel.org, avi.shchislowski@sandisk.com, alex.lemberg@sandisk.com

On Fri, Nov 13, 2015 at 9:56 AM, Holger Schurig <holgerschurig@gmail.com> wrote:
> There have been some attempts to add FFU (field firmware update).  The last
> AFAIK in Nov 2014, http://www.spinics.net/lists/linux-mmc/msg29324.html
>
> But it seems that the committers weren't persistent enought.
>
> I took the liberty to take Avi's patch and make it hopefully
> maintainer-review friendly.
>
> The first 5 patches just move functions out of mmc_test.c into core.c. Those
> functions will later be used by both mmc_test.c and mmc_ffu.c.  Contrary to
> Avi's patch I didn't add static helper functions to mmc_test.c, e.g.
> there's no mmc_test_prepare_mrq() that calls mmc_prepare_mrq().  It's
> simpler to call mmc_prepare_mrq() directly.  It's just one more dereference
> from *mmc_card to *mmc_test_card anyway.
>
> The patch [6/6] is http://www.spinics.net/lists/linux-mmc/msg29326.html, but
> with less checkpatch warnings.  And it doesn't use mmc_send_ext_csd()
> anymore, which has been deleted since November.
>
> I'm sending this patch as RFC now. It compiles (for me). But I get the
> firmware update file from Kingston only next Tuesday.  That means that so
> far I haven't been testing it. It won't do anything without the proper
> user-space command in mmc-utils anyway :-)
>
> Comments welcome (I intent to get this patch into the kernel)
>
> The patch is against Linux GIT (v4.3-11748-g46d862b).
>
> Holger
>
>  drivers/mmc/card/Kconfig    |  11 +
>  drivers/mmc/card/Makefile   |   1 +
>  drivers/mmc/card/block.c    |   5 +
>  drivers/mmc/card/mmc_ffu.c  | 489 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/card/mmc_test.c | 235 +++++----------------
>  drivers/mmc/core/core.c     | 134 ++++++++++++
>  drivers/mmc/core/mmc_ops.c  |   4 +-
>  include/linux/mmc/card.h    |   1 +
>  include/linux/mmc/core.h    |  41 ++++
>  include/linux/mmc/mmc.h     |   6 +
>  10 files changed, 739 insertions(+), 188 deletions(-)
>  create mode 100644 drivers/mmc/card/mmc_ffu.c

The newly added ioctl MMC_IOC_MULTI_CMD allows user space to send
multiple commands
atomically, so mmu-utils may be a better place for this functionality.

Al
