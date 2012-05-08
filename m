From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 0/3] mmc: omap: driver registration cleanups
Date: Tue, 8 May 2012 17:05:32 +0530
Message-ID: <1336476935-16564-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34131 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753624Ab2EHL3Y (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 8 May 2012 07:29:24 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Venkatraman S <svenkatr@ti.com>

Cleanups for the legacy omap mmc driver to remove clutter and
make it well behaved as module.

Venkatraman S (3):
  mmc: omap: convert to per instance workqueue
  mmc: omap: make it behave well as module
  mmc: omap: convert to module_platform_driver

 drivers/mmc/host/omap.c |   48 +++++++++++++++-------------------------------
 1 files changed, 16 insertions(+), 32 deletions(-)

-- 
1.7.5.4

