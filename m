From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 0/2] sdio: Prevent re-tuning conflicting with custom sleep
Date: Tue, 28 Apr 2015 17:45:39 +0300
Message-ID: <1430232341-8307-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:26082 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030298AbbD1Orv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 28 Apr 2015 10:47:51 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Arend van Spriel <arend@broadcom.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi

Here are 2 patches that allow brcmfmac to awake from a
custom sleep state that conflicts with re-tuning.

The first patch adds sdio_retune_hold_now() and
sdio_retune_release(). They are used in the 2nd patch
to prevent re-tuning for the 'wake-up' command.


Adrian Hunter (2):
      mmc: core: Add functions for SDIO to hold re-tuning
      brcmfmac: Prevent re-tuning conflicting with 'wake-up'

 drivers/mmc/core/host.c                        |  6 ++++++
 drivers/mmc/core/host.h                        |  1 +
 drivers/mmc/core/sdio_io.c                     | 13 +++++++++++++
 drivers/net/wireless/brcm80211/brcmfmac/sdio.c |  6 ++++++
 include/linux/mmc/sdio_func.h                  |  3 +++
 5 files changed, 29 insertions(+)


Regards
Adrian

