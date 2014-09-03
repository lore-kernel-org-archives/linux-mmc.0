From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH 00/13] mmc: Improve busy detection for MMC_CAP_WAIT_WHILE_BUSY
Date: Wed, 3 Sep 2014 14:51:56 +0800
Message-ID: <CAA+hA=QaCcFt8fm9xohnAhcH5T4RmASNte542jDs6v7-q-6bdw@mail.gmail.com>
References: <1391035085-2747-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:43402 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084AbaICGv5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Sep 2014 02:51:57 -0400
Received: by mail-qg0-f41.google.com with SMTP id i50so7873175qgf.28
        for <linux-mmc@vger.kernel.org>; Tue, 02 Sep 2014 23:51:57 -0700 (PDT)
In-Reply-To: <1391035085-2747-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Dong Aisheng <b29396@freescale.com>, Stephen Warren <swarren@nvidia.com>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, Adrian Hunter <adrian.hunter@intel.com>

Hi Ulf,

On Thu, Jan 30, 2014 at 6:37 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> This patchset improves the handling around busy detection in the mmc core layer
> while operating on host supporting MMC_CAP_WAIT_WHILE_BUSY.
>
> A R1B response is for an mmc command, specified as and R1 but with an optional
> busy assertion on the DAT0 line. Hosts supporting MMC_CAP_WAIT_WHILE_BUSY,
> normally has a busy detection mechanism build in it's controller HW.
>
> Using such a feature decreases the need for polling of the card's status using
> CMD13, which is the fallback method used by the mmc core for hosts that don't
> support MMC_CAP_WAIT_WHILE_BUSY.
>
> Typcial commands that expects R1B responses are CMD6 (SWITCH), CMD12 (STOP),
> CMD38 (ERASE) and CMD5 (SLEEP). This patchset adresses CMD6, CMD5 and improves
> some parts where CMD12 are used. If the implemented approach becomes accepted,
> a future patchset for CMD38 can be based on top if this patchset.
>
> Do note, the final two patches implements support for busy detection for the
> mmci host driver, since some of it's HW variants do supports busy detection.
>
> Future suggested improvements related to this patchset: (Please, feel free to
> implement any of them :-) ).
>
> a) For CMD38, select a fixed number maximum blocks to accept for
> erase/discard/trim operations. Compute the needed timeout depending on each
> card's erase information provided through it's CSD/EXT_CSD registers. Then
> follow the same principle as for sending a CMD6.
>
> b) At least for CMD38, but likely for other commands as well, we could benefit
> from doing a _periodic_ CMD13 polling to handle the busy completion. This will
> also be useful for hosts supporting MMC_CAP_WAIT_WHILE_BUSY, in particular for
> cases where the host are unable to support the needed busy timeout.
>

Do you have the plan to implement above two items?
Since currently the max_discard_sectors is still calculated based on
max_busy_timeout of host,
it is possible that for some eMMC chips, the max_discard_sectors is 1,
which then cause the erase operation terribly slow.

Regards
Dong Aisheng

> c) Handle timeouts while polling for card's status with CMD13 in cases where
> a CMD12 has been used to finalize a data DATA_WRITE transfer.
>
>
> Ulf Hansson (13):
>   mmc: core: Rename max_discard_to to max_busy_timeout
>   mmc: core: Rename cmd_timeout_ms to busy_timeout
>   mmc: core: Add ignore_crc flag to __mmc_switch
>   mmc: core: Minor simplifications to __mmc_switch
>   mmc: core: Fixup busy detection for mmc switch operations
>   mmc: core: Use generic CMD6 time while switching to eMMC HS200 mode
>   mmc: core: Respect host's max_busy_timeout when sending sleep cmd
>   mmc: block: Use R1 responses for stop cmds for read requests
>   mmc: block: Implement card_busy_detect() for busy detection
>   mmc: block: Respect hw busy detection in card_busy_detect()
>   mmc: block: Fixup busy detection while invoking stop cmd at recovery
>   mmc: mmci: Handle CMD irq before DATA irq
>   mmc: mmci: Enable support for busy detection for ux500 variant
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
>
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
