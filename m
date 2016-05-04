From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 0/3] mmc: block: Fix tuning (by avoiding it) for RPMB
Date: Wed,  4 May 2016 14:38:10 +0300
Message-ID: <1462361893-11897-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:44068 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752560AbcEDLmF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 4 May 2016 07:42:05 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Tomas Winkler <tomas.winkler@intel.com>

Hi

The RPMB partition only allows certain commands.  In particular,
the tuning command (CMD21) is not allowed -  refer JEDEC eMMC
standard v5.1 section 6.2.2 Command restrictions.

That means commands will begin failing if re-tuning is needed
while switched to the RPMB partition.

As we discussed here:

	http://marc.info/?l=linux-mmc&m=146218765801869

this patch set takes a new approach which is:

	Re-tune before switching to the RPMB partition
	Don't allow re-tuning while switched to RPMB
	Switch back from the RPMB partition immediately

I gave it a brief test with a HS400 eMMC and using mmc utils
to access RPMB.  Despite all the partition switches and
re-tuning in between, all RPMB operations were successful.


Changes in V2:

	New approach entirely


Adrian Hunter (3):
      mmc: core: Add a facility to "pause" re-tuning
      mmc: block: Always switch back to main area after RPMB access
      mmc: block: Pause re-tuning while switched to the RPMB partition

 drivers/mmc/card/block.c | 19 ++++++++++++++++++-
 drivers/mmc/core/host.c  | 22 ++++++++++++++++++++++
 include/linux/mmc/host.h |  4 ++++
 3 files changed, 44 insertions(+), 1 deletion(-)


Regards
Adrian
