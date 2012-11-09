From: Balaji T K <balajitk@ti.com>
Subject: [PATCH v2 0/3] mmc: omap_hsmmc: fixes for irq error handler
Date: Fri, 9 Nov 2012 21:36:13 +0530
Message-ID: <1352477176-6673-1-git-send-email-balajitk@ti.com>
References: <20121109145218.GA10873@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37323 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752914Ab2KIQGX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 9 Nov 2012 11:06:23 -0500
In-Reply-To: <20121109145218.GA10873@arwen.pp.htv.fi>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: linux-omap@vger.kernel.org, svenkatr@ti.com, Balaji T K <balajitk@ti.com>

Balaji T K (3):
  mmc: omap_hsmmc: Fix Oops in case of data errors
  mmc: omap_hsmmc: no reset of cmd state machine for DCRC
  mmc: omap_hsmmc: update error code for response_busy cmd

 drivers/mmc/host/omap_hsmmc.c |   24 +++++++++++++++---------
 1 files changed, 15 insertions(+), 9 deletions(-)

-- 
1.7.5.4

