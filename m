From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 0/2] maximum discard size
Date: Tue, 28 Jun 2011 17:16:01 +0300
Message-ID: <1309270563-28817-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:20936 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758122Ab1F1OQU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 28 Jun 2011 10:16:20 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Philip Rakity <prakity@marvell.com>, Adrian Hunter <adrian.hunter@intel.com>

Hi

Here is a patch that sets a maximum discard size for host controllers
that cannot manage large timeouts.  And another patch putting it into
use for shdci.

Adrian Hunter (2):
      mmc: queue: let host controllers specify maximum discard timeout
      mmc: sdhci: specify maximum discard timeout

 drivers/mmc/card/queue.c |   33 ++++++++++++++------
 drivers/mmc/core/core.c  |   76 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c |    5 +++
 include/linux/mmc/core.h |    1 +
 include/linux/mmc/host.h |    1 +
 5 files changed, 106 insertions(+), 10 deletions(-)

Regards
Adrian Hunter
