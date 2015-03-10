From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V3 00/15] mmc: host: Add facility to support re-tuning
Date: Tue, 10 Mar 2015 14:42:55 +0200
Message-ID: <1425991390-4983-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:3552 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751708AbbCJMpJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 10 Mar 2015 08:45:09 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

Hi

Here is V3 of some patches to move re-tuning support
out of sdhci and into the core, and add support for HS400
re-tuning.

Currently sdhci does re-tuning transparently by
calling sdhci_execute_tuning() from its ->request()
function.

The problem with HS400 re-tuning is that it must be
done in HS200 mode. That means using switch commands
and making ios changes. That means it potentially
conflicts with other command sequences. The new
re-tuning support accomodates that.

Changes in V3:

    mmc: host: Add facility to support re-tuning

        Add host->retune_now flag so re-tuning can be
        started in the host drivers ->request()
        function to avoid racing with Runtime PM.

        Add host operations to let the host know when
        re-tuning is held, for eaxmple, to enable
        synchronization with runtime suspend / resume.

        Ensure functions are exported.

    mmc: core: Add support for re-tuning before each request
        Updated to reflect the change above.

    mmc: core: Check re-tuning before retrying
        Updated to reflect the change above.

    mmc: core: Hold re-tuning during switch commands
        Updated to reflect the change above.

    mmc: core: Hold re-tuning during erase commands
        Updated to reflect the change above.

    mmc: core: Hold re-tuning while bkops ongoing
        Updated to reflect the change above.

    mmc: core: Add support for HS400 re-tuning
        Updated and as already sent separately as V3:
        Remember to mmc_set_bus_speed(card) in mmc_hs400_to_hs200()

    mmc: sdhci: Change to new way of doing re-tuning
        Call mmc_retune() from ->request() function to
        avoid racing with Runtime PM. And implement
        hold_tuning / release_tuning operations to prevent
        runtime suspend while re-tuning is held.

    mmc: block: Retry errored data requests when re-tuning is needed
        Updated and as already sent separately as V3:
        Only retry when there is an error

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
      mmc: block: Retry errored data requests when re-tuning is needed
      mmc: core: Don't print reset warning if reset is not supported

 drivers/mmc/card/block.c   |  14 +++-
 drivers/mmc/card/queue.h   |   1 +
 drivers/mmc/core/core.c    |  28 ++++++--
 drivers/mmc/core/core.h    |   2 +
 drivers/mmc/core/host.c    |  95 +++++++++++++++++++++++++++
 drivers/mmc/core/mmc.c     |  89 +++++++++++++++++++++++++
 drivers/mmc/core/mmc_ops.c |  43 +++++++-----
 drivers/mmc/core/mmc_ops.h |   1 +
 drivers/mmc/host/sdhci.c   | 158 +++++++++++++++------------------------------
 include/linux/mmc/host.h   |  34 ++++++++++
 include/linux/mmc/sdhci.h  |   3 -
 11 files changed, 336 insertions(+), 132 deletions(-)


Regards
Adrian

