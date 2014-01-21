From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 0/5] mmc: omap_hsmmc: add support for set block count
Date: Tue, 21 Jan 2014 19:54:37 +0530
Message-ID: <1390314282-20520-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42620 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754481AbaAUOYz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jan 2014 09:24:55 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, chris@printf.net
Cc: linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>

Balaji T K (5):
  mmc: omap_hsmmc: save clock rate to use in interrupt context
  mmc: omap_hsmmc: fix request done for sbc error case
  mmc: omap_hsmmc: split dma setup
  mmc: omap_hsmmc: add cmd23 support
  mmc: omap_hsmmc: add autocmd23 support

 drivers/mmc/host/omap_hsmmc.c |   88 ++++++++++++++++++++++++++++++++++-------
 1 files changed, 73 insertions(+), 15 deletions(-)

-- 
1.7.5.4

