From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 0/2] mmc: fixes for eMMC v4.5 discard / sanitize operations
Date: Thu,  5 Apr 2012 14:45:46 +0300
Message-ID: <1333626348-11170-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:53497 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751400Ab2DELpt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 5 Apr 2012 07:45:49 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, "Luca Porzio (lporzio)" <lporzio@micron.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kyungmin Park <kmpark@infradead.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>

Hi

Here are patches in response to the thread
"mmc: card: move variable initialization earlier"

The patches have not been tested on eMMC v4.5
because I do not have one.  Consequently, these
patches need an ack or tested-by someone who has
one that supports discard and sanitize.


Adrian Hunter (2):
      mmc: fixes for eMMC v4.5 discard operation
      mmc: fixes for eMMC v4.5 sanitize operation

 drivers/mmc/card/block.c |   54 ++++++++++++++++++++++++++++++++-------------
 drivers/mmc/card/queue.c |    2 +-
 drivers/mmc/core/core.c  |    9 +++++--
 3 files changed, 45 insertions(+), 20 deletions(-)


Regards
Adrian
