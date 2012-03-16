From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 0/8][git pull] mmc: omap: Assorted fixes for 3.4 merge window
Date: Fri, 16 Mar 2012 19:08:56 +0530
Message-ID: <1331905144-31655-1-git-send-email-svenkatr@ti.com>
References: <y>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41738 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755805Ab2CPNjt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 16 Mar 2012 09:39:49 -0400
In-Reply-To: <y>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: cjb@laptop.org, balajitk@ti.com, balbi@ti.com, Venkatraman S <svenkatr@ti.com>

Chris,
   Here are a group of fixes posted by Felipe and Balaji for the
OMAP hsmmc driver in the past few days. 
   I've rebased them to the lastest mmc-next and posted them
here again. These have also been tested on OMAP4 development platform.

Please feel to apply directly or pull if that's convenient.

Changes since yesterday (v1):-
	Fixed formatting issues as suggested by Felipe
	Marked some patches for stable.

The following changes since commit 5f0390f10c0e9c9c504cdbf4af802252628a2490:

  mmc: omap_hsmmc: Avoid a regulator voltage change with dt (2012-03-14 11:33:20 -0400)

are available in the git repository at:

  git://github.com/svenkatr/linux.git omap-mmc-pending-for-3.4

for you to fetch changes up to 8d54766b608915035b47616ea564e4e9b4dda29c:

  mmc: omap4: hsmmc: fix module re-insertion (2012-03-16 11:38:41 +0530)

----------------------------------------------------------------
Balaji T K (5):
      mmc: omap: Enable Auto CMD12
      mmc: omap: add DDR support to omap_hsmmc
      mmc: omap: use runtime put sync in probe error patch
      mmc: omap: context save after enabling runtime pm
      mmc: omap4: hsmmc: fix module re-insertion

Felipe Balbi (3):
      mmc: host: omap_hsmmc: trivial cleanups
      mmc: host: omap_hsmmc: make it behave well as a module
      mmc: host: omap_hsmmc: convert to module_platform_driver

 drivers/mmc/host/omap_hsmmc.c |  202 ++++++++++++++++++++++------------------------
 1 file changed, 97 insertions(+), 105 deletions(-)

