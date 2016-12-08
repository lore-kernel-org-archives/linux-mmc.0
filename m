From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 0/2] sdio: Prevent re-tuning conflicting with custom sleep
Date: Thu,  8 Dec 2016 11:56:38 +0200
Message-ID: <1481191000-19305-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:21197 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751243AbcLHKBo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 8 Dec 2016 05:01:44 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Arend van Spriel <arend@broadcom.com>

Hi

Here are 2 patches that allow brcmfmac to awake from a
custom sleep state that conflicts with re-tuning.

The first patch adds sdio_retune_hold_now() and
sdio_retune_release(). They are used in the 2nd patch
to prevent re-tuning for the 'wake-up' command.

These patches were last posted here:

	https://marc.info/?l=linux-mmc&m=143023247221784


Changes in V2:

  brcmfmac: Prevent re-tuning conflicting with 'wake-up'
    Apply to file moved from:
        drivers/net/wireless/brcm80211/brcmfmac/sdio.c
    to:
        drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c


Adrian Hunter (2):
      mmc: core: Add functions for SDIO to hold re-tuning
      brcmfmac: Prevent re-tuning conflicting with 'wake-up'

 drivers/mmc/core/host.c                                 |  6 ++++++
 drivers/mmc/core/host.h                                 |  1 +
 drivers/mmc/core/sdio_io.c                              | 13 +++++++++++++
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c |  6 ++++++
 include/linux/mmc/sdio_func.h                           |  3 +++
 5 files changed, 29 insertions(+)


Regards
Adrian
