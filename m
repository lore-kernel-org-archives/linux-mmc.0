From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [GIT PULL] MMC updates for mmc-next for 3.15, take 1
Date: Sun, 23 Feb 2014 16:33:31 +0100
Message-ID: <CAPDyKFrQKMMimNFr-3h+Em+W+A00tmS2mCxNUbkvyyZfom8+nA@mail.gmail.com>
References: <CAPDyKFrbLBbq8WJP3umUM4dWoRvm20AsYb9pxzMJRrnA47c6OQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:35746 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394AbaBWPdc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 23 Feb 2014 10:33:32 -0500
Received: by mail-qc0-f182.google.com with SMTP id w7so5917453qcr.27
        for <linux-mmc@vger.kernel.org>; Sun, 23 Feb 2014 07:33:32 -0800 (PST)
In-Reply-To: <CAPDyKFrbLBbq8WJP3umUM4dWoRvm20AsYb9pxzMJRrnA47c6OQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>

On 14 February 2014 12:09, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Hi Chris,
>
> I have collected some patches, all from the patchset:
>
> mmc: Improve busy detection for MMC_CAP_WAIT_WHILE_BUSY
>
> I have also included two patches for the mmci host driver, which I
> would appreciate if you could carry through your tree since there are
> a dependencies.
> I have not yet got confirmation from Russell, that he's happy with
> these, but I expect he will tell if not.

Hi Chris,

I would suggest we go ahead and merge this for 3.15, unless you have
any concerns with any of the patches of course.

Kind regards
Uffe

>
> Kind regards
> Ulf Hansson
>
>
> The following changes since commit 7536d3f83aa42ba1a3b1c6b30c2b6d94a820cbb2:
>
>   mmc: core: Enable MMC_CAP2_CACHE_CTRL as default (2014-02-13 22:58:49 -0500)
>
> are available in the git repository at:
>
>   git://git.linaro.org/people/ulfh/mmc.git mmc-next_for_chris
>
> for you to fetch changes up to 13d0f23faabc2899a289630c42088c48d10a0872:
>
>   mmc: mmci: Enable support for busy detection for ux500 variant
> (2014-02-14 09:33:16 +0100)
>
> ----------------------------------------------------------------
> Ulf Hansson (13):
>       mmc: core: Rename max_discard_to to max_busy_timeout
>       mmc: core: Rename cmd_timeout_ms to busy_timeout
>       mmc: core: Add ignore_crc flag to __mmc_switch
>       mmc: core: Minor simplifications to __mmc_switch
>       mmc: core: Fixup busy detection for mmc switch operations
>       mmc: core: Use generic CMD6 time while switching to eMMC HS200 mode
>       mmc: core: Respect host's max_busy_timeout when sending sleep cmd
>       mmc: block: Use R1 responses for stop cmds for read requests
>       mmc: block: Implement card_busy_detect() for busy detection
>       mmc: block: Respect hw busy detection in card_busy_detect()
>       mmc: block: Fixup busy detection while invoking stop cmd at recovery
>       mmc: mmci: Handle CMD irq before DATA irq
>       mmc: mmci: Enable support for busy detection for ux500 variant
>
>  drivers/mmc/card/block.c   |  178 ++++++++++++++++++++++++++++----------------
>  drivers/mmc/core/core.c    |   11 +--
>  drivers/mmc/core/mmc.c     |   34 ++++++---
>  drivers/mmc/core/mmc_ops.c |   64 ++++++++++------
>  drivers/mmc/host/mmci.c    |   54 +++++++++++---
>  drivers/mmc/host/mmci.h    |    2 +
>  drivers/mmc/host/sdhci.c   |   10 +--
>  include/linux/mmc/core.h   |    4 +-
>  include/linux/mmc/host.h   |    2 +-
>  9 files changed, 241 insertions(+), 118 deletions(-)
