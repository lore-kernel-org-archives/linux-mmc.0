From: NeilBrown <neil@brown.name>
Subject: [PATCH 0/2] Remove mmc_host enable/disable methods.
Date: Thu, 26 Mar 2015 08:43:37 +1100
Message-ID: <20150325213419.11463.33321.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60145 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751032AbbCYVtx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 25 Mar 2015 17:49:53 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Chris Ball <chris@printf.net>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Only omap_hsmmc uses enable and disable, and this seems
to be largely for historical reasons and is no longer
necessary.

I have tested these patches with an OMAP3 with an
uSD card on mmc0 and a wifi SDIO device on mmc1.

NeilBrown


---

NeilBrown (2):
      mmc: omap_hsmmc: stop using .enable and .disable method.
      mmc: remove enable/disable methods.


 drivers/mmc/core/core.c       |    5 -----
 drivers/mmc/host/omap_hsmmc.c |   24 +++---------------------
 include/linux/mmc/host.h      |    6 ------
 3 files changed, 3 insertions(+), 32 deletions(-)

--
Signature

