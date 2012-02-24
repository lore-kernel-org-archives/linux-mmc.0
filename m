From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 0/4] mmc: omap: add autocmd12, DDR support and runtime fixes
Date: Fri, 24 Feb 2012 21:14:30 +0530
Message-ID: <1330098274-12048-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>
List-Id: linux-mmc@vger.kernel.org

	add Autocmd12 for multiblock read/write
	add DDR support
	minor pm runtime fixes

Balaji T K (4):
  mmc: omap: Enable Auto CMD12
  mmc: omap: add DDR support to omap_hsmmc
  mmc: omap: use runtime put sync in probe error patch
  mmc: omap: context save after enabling runtime pm

 drivers/mmc/host/omap_hsmmc.c |   29 ++++++++++++++++++++++-------
 1 files changed, 22 insertions(+), 7 deletions(-)

