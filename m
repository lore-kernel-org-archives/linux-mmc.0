From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 0/4] Minor MMC fixes
Date: Thu, 23 Jun 2011 13:40:25 +0300
Message-ID: <1308825629-27375-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:33950 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759157Ab1FWKlD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 23 Jun 2011 06:41:03 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

Hi

Here are 4 minor fixes:

Adrian Hunter (4):
      mmc: block: switch card to User Data Area when removing the block driver
      mmc: core: make erase timeout calculation allow for gated clock
      mmc: queue: append partition subname to queue thread name
      mmc: queue: bring discard_granularity/alignment into line with SCSI definitions

 drivers/mmc/card/block.c |    5 ++++-
 drivers/mmc/card/queue.c |   15 ++++++---------
 drivers/mmc/card/queue.h |    3 ++-
 drivers/mmc/core/core.c  |    2 +-
 4 files changed, 13 insertions(+), 12 deletions(-)

Regards
Adrian Hunter

