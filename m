From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 00/15] mmc: host: Add facility to support re-tuning
Date: Thu, 29 Jan 2015 11:00:15 +0200
Message-ID: <1422522030-17793-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:57059 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758115AbbA2JCZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 29 Jan 2015 04:02:25 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

Hi

Here is V2 of some patches to move re-tuning support
out of sdhci and into the core, and add support for HS400
re-tuning.

Currently sdhci does re-tuning transparently by
calling sdhci_execute_tuning() from its ->request()
function.

The problem with HS400 re-tuning is that it must be
done in HS200 mode. That means using switch commands
and making ios changes. That means it potentially
conflicts with other command sequences. The new
re-tuning support accomodates that, however it is
not strictly necessary because HS400 re-tuning
should only be needed after runtime suspend when
there would not be a conflict.

Nevertheless, this approach has more structure
and potentially more flexibility.

Changes in V2:

    Added support to the block driver for re-tuning
    and retrying after a CRC error. The host driver
    is left to decide when an error indicates re-tuning
    is needed. The block driver will retry a data request
    once if re-tuning is flagged as needed.

    SDIO drivers need not be aware of re-tuning because
    retrying will anyway cause re-tuning when re-tuning
    is flagged as needed. Nevertheless SDIO drivers could
    use the need_retune flag to instigate a retry when
    otherwise they might not have.

    mmc: core: Simplify by adding mmc_execute_tuning()
        Dropped because it has been applied

    mmc: host: Add facility to support re-tuning
        Renamed mmc_retune_retry() to mmc_retune_recheck()
        to better reflect what it does.

    mmc: core: Move mmc_card_removed() into mmc_start_request()
        Dropped because it has been applied

    mmc: core: Add support for re-tuning before each request
        Fixed un-balanced re-tune hold / release

    mmc: sdhci: Always init buf_ready_int
        Dropped because it has been applied

    mmc: core: Separate out the mmc_switch status check so it can be re-used
        New patch

    mmc: core: Add support for HS400 re-tuning
        It was found that that the original code was not reliable
        after a CRC error. The problem was that the CMD13 after a
        switch was faiing. So the code was changed to check the
        switch status *after* changing the I/O state to match the
        switch i.e. the new I/O state is the correct one to use
        after a switch.

    mmc: sdhci: Flag re-tuning is needed on CRC or End-Bit errors
        New patch

    mmc: block: Check re-tuning in the recovery path
        New patch

    mmc: block: Retry data requests when re-tuning is needed
        New patch

    mmc: core: Don't print reset warning if reset is not supported
        New patch


Adrian Hunter (15):
      mmc: host: Add facility to support re-tuning
      mmc: core: Disable re-tuning when card is no longer initialized
      mmc: core: Add support for re-tuning before each request
      mmc: core: Check re-tuning before retrying
      mmc: core: Hold re-tuning during switch commands
      mmc: core: Hold re-tuning during erase commands
      mmc: core: Hold re-tuning while bkops ongoing
      mmc: mmc: Comment that callers need to hold re-tuning if the card is put to sleep
      mmc: core: Separate out the mmc_switch status check so it can be re-used
      mmc: core: Add support for HS400 re-tuning
      mmc: sdhci: Change to new way of doing re-tuning
      mmc: sdhci: Flag re-tuning is needed on CRC or End-Bit errors
      mmc: block: Check re-tuning in the recovery path
      mmc: block: Retry data requests when re-tuning is needed
      mmc: core: Don't print reset warning if reset is not supported

 drivers/mmc/card/block.c   |  19 ++++++-
 drivers/mmc/card/queue.h   |   1 +
 drivers/mmc/core/core.c    |  51 ++++++++++++++++--
 drivers/mmc/core/core.h    |   2 +
 drivers/mmc/core/host.c    |  63 ++++++++++++++++++++++
 drivers/mmc/core/mmc.c     |  87 +++++++++++++++++++++++++++++++
 drivers/mmc/core/mmc_ops.c |  45 ++++++++++------
 drivers/mmc/core/mmc_ops.h |   1 +
 drivers/mmc/host/sdhci.c   | 127 ++++++++-------------------------------------
 include/linux/mmc/host.h   |  58 +++++++++++++++++++++
 include/linux/mmc/sdhci.h  |   3 --
 11 files changed, 328 insertions(+), 129 deletions(-)


Regards
Adrian

