From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RESEND PATCH V3 0/4] mmc: Use runtime pm for blkdevice
Date: Wed, 24 Apr 2013 15:13:10 +0200
Message-ID: <CAPDyKFqyr=_PecZBeZ=ssg8wpY2ThHe-rQJXA5sAkMvcSqR4dw@mail.gmail.com>
References: <1366199354-4266-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f182.google.com ([209.85.220.182]:49399 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754233Ab3DXNNL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Apr 2013 09:13:11 -0400
Received: by mail-vc0-f182.google.com with SMTP id ht11so1748992vcb.27
        for <linux-mmc@vger.kernel.org>; Wed, 24 Apr 2013 06:13:10 -0700 (PDT)
In-Reply-To: <1366199354-4266-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Maya Erez <merez@codeaurora.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On 17 April 2013 13:49, Ulf Hansson <ulf.hansson@stericsson.com> wrote:
> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> SDIO has been using runtime pm for a while to handle runtime power save
> operations. This patchset is enabling the option to make the sd/mmc
> blockdevices to use runtime pm as well.
>
> The runtime pm implementation for the block device will make use of
> autosuspend to defer power save operation to after request inactivty for
> a certain time.
>
> Corresponding pm_runtime_get|put calls has been added at those places that
> do requires the card to be fully powered to communicate.
>
> Patch 4 can be considered as a proof of concept patch. It implements
> aggressive power management for (e)MMC/SD. This feature has also been
> discussed on the mmc mailing list previously.
>
> Next step would be to implement the IDLE BKOPS on top of the runtime pm
> callbacks.
>
> Changes in v3:
>         - Make sure the card device is powered from a runtime perspective
>         when needed. This is also the indirect reason to why the new patch 1
>         has been added to this patchset.
>         - Added a proof of concept patch, in patch 4.
>         - Replace acks with cc, since quite some changes has been done.
>
> Changes in v2:
>         - Removed the stated patch below from this patchset. It can be handled
>         separately. "mmc: core: Remove power_restore bus_ops for mmc and sd"
>         - Rebased patches on latest mmc-next.
>         - Added Acks.
>
> Ulf Hansson (4):
>   mmc: core: Stop bkops for eMMC only from mmc suspend
>   mmc: core: Add bus_ops for runtime pm callbacks
>   mmc: block: Enable runtime pm for mmc blkdevice
>   mmc: core: Support aggressive power management for (e)MMC/SD
>
>  drivers/mmc/card/block.c   |   32 +++++++++++++++++++++-----
>  drivers/mmc/core/bus.c     |   14 ++++++++++--
>  drivers/mmc/core/core.c    |   47 +++++++++++++++++++++------------------
>  drivers/mmc/core/core.h    |    3 +++
>  drivers/mmc/core/debugfs.c |    8 +++----
>  drivers/mmc/core/mmc.c     |   53 ++++++++++++++++++++++++++++++++++++++++++--
>  drivers/mmc/core/sd.c      |   46 ++++++++++++++++++++++++++++++++++++--
>  drivers/mmc/core/sdio.c    |   16 +++++++++++++
>  include/linux/mmc/core.h   |    3 +++
>  include/linux/mmc/host.h   |    2 +-
>  10 files changed, 185 insertions(+), 39 deletions(-)
>
> --
> 1.7.10
>

Adrian and Maya, do you think patchset is acceptable from your point?
Can we advise Chris to merge it for 3.10 or do we need another round?
:-)


Kind regards
Ulf Hansson
