From: Balaji T K <balajitk@ti.com>
Subject: [PATCH v3 0/3] mmc: omap_hsmmc: fixes for irq error handler
Date: Mon, 12 Nov 2012 18:36:41 +0530
Message-ID: <1352725604-20390-1-git-send-email-balajitk@ti.com>
References: <1352477176-6673-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41253 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752040Ab2KLNGw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 12 Nov 2012 08:06:52 -0500
In-Reply-To: <1352477176-6673-1-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: linux-omap@vger.kernel.org, svenkatr@ti.com, balbi@ti.com, Balaji T K <balajitk@ti.com>

Balaji T K (3):
  mmc: omap_hsmmc: Fix Oops in case of data errors
  mmc: omap_hsmmc: no reset of cmd state machine for DCRC
  mmc: omap_hsmmc: update error code for response_busy cmd

 drivers/mmc/host/omap_hsmmc.c |   23 +++++++++++++++--------
 1 files changed, 15 insertions(+), 8 deletions(-)

based on mmc-fixes-for-3.7-rc5 in mmc_next
Since v1: split into 3 patches
Address comments from Felipe Balbi

-- 
1.7.5.4

