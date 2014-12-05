From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [RFC PATCH 00/13] mmc: host: Add facility to support re-tuning
Date: Fri,  5 Dec 2014 19:40:58 +0200
Message-ID: <1417801271-15575-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:60352 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751479AbaLERnQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 5 Dec 2014 12:43:16 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

Hi

Here are some patches to move re-tuning support out of
sdhci and into the core, and add support for HS400
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


Adrian Hunter (13):
      mmc: core: Simplify by adding mmc_execute_tuning()
      mmc: host: Add facility to support re-tuning
      mmc: core: Disable re-tuning when card is no longer initialized
      mmc: core: Move mmc_card_removed() into mmc_start_request()
      mmc: core: Add support for re-tuning before each request
      mmc: core: Check re-tuning before retrying
      mmc: core: Hold re-tuning during switch commands
      mmc: core: Hold re-tuning during erase commands
      mmc: core: Hold re-tuning while bkops ongoing
      mmc: mmc: Comment that callers need to hold re-tuning if the card is put to sleep
      mmc: core: Add support for HS400 re-tuning
      mmc: sdhci: Always init buf_ready_int
      mmc: sdhci: Change to new way of doing re-tuning

 drivers/mmc/core/core.c    |  93 +++++++++++++++++++++++++++++++-----
 drivers/mmc/core/core.h    |   5 ++
 drivers/mmc/core/host.c    |  63 +++++++++++++++++++++++++
 drivers/mmc/core/mmc.c     |  58 ++++++++++++++++++-----
 drivers/mmc/core/mmc_ops.c |  31 ++++++++----
 drivers/mmc/core/sd.c      |  13 ++---
 drivers/mmc/core/sdio.c    |  14 ++----
 drivers/mmc/host/sdhci.c   | 115 ++++++---------------------------------------
 include/linux/mmc/host.h   |  58 +++++++++++++++++++++++
 include/linux/mmc/sdhci.h  |   3 --
 10 files changed, 296 insertions(+), 157 deletions(-)


Regards
Adrian

