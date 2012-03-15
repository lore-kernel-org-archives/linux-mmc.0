From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 0/8][git pull] mmc: omap: Assorted fixes for 3.4 merge window
Date: Thu, 15 Mar 2012 20:03:34 +0530
Message-ID: <1331822022-26714-1-git-send-email-svenkatr@ti.com>
References: <y>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <y>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: cjb@laptop.org, balajitk@ti.com, balbi@ti.com, Venkatraman S <svenkatr@ti.com>
List-Id: linux-mmc@vger.kernel.org

Chris,
   Here are a group of fixes posted by Felipe and Balaji for the
OMAP hsmmc driver in the past few days. 
   I've rebased them to the lastest mmc-next and posted them
here again. These have also been tested on OMAP4 development platform.

Please feel to apply directly or pull if that's convenient.

The following changes since commit 5f0390f10c0e9c9c504cdbf4af802252628a2490:

  mmc: omap_hsmmc: Avoid a regulator voltage change with dt (2012-03-14 11:33:20 -0400)

are available in the git repository at:

  git://github.com/svenkatr/linux.git omap-mmc-pending-for-3.4

for you to fetch changes up to a6caaa13374ab72e37f9cb2e4cebfe3d266fbaf3:

  mmc: omap4: hsmmc: fix module re-insertion (2012-03-15 19:45:49 +0530)

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

 drivers/mmc/host/omap_hsmmc.c |  203 ++++++++++++++++++++++-----------------------
 1 file changed, 98 insertions(+), 105 deletions(-)

