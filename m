From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 0/2] mmc: omap_hsmmc: checkpatch cleanup
Date: Fri, 28 Feb 2014 19:52:30 +0530
Message-ID: <1393597352-13282-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51450 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751581AbaB1OWl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 28 Feb 2014 09:22:41 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, chris@printf.net
Cc: linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>

fixes for checkpatch warnings.

Balaji T K (2):
  mmc: omap_hsmmc: fix return error code for of_get_hsmmc_pdata
  mmc: omap_hsmmc: remove redundant reset done

 drivers/mmc/host/omap_hsmmc.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

-- 
1.7.5.4

