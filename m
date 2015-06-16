From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 0/3] omap_hsmmc: Fix card enumeration failure on
Date: Tue, 16 Jun 2015 16:07:16 +0530
Message-ID: <1434451039-18195-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37129 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756521AbbFPKha (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Jun 2015 06:37:30 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Andreas Fenkart <afenkart@gmail.com>, Tony Lindgren <tony@atomide.com>, NeilBrown <neilb@suse.de>, Vignesh R <vigneshr@ti.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org


Hi,

When using omap_hsmmc driver, if sd-card repeatedly plug unplugged
multiple times quickly, card enumeration stops after few iterations.
This can be easily reproduced on DRA74X EVM which uses omap_hsmmc driver.
This patch series addresses the above problem. The first patch fixes irq
handler to report all DTOs to mmc-core. Second patch adds handling for
BADA, DEB and CEB interrupts. The last patch introduces driver specific
card detect irq handler to cleanup pending requests before card removal.

Tested on DRA74X amd DRA72X and AM437X-GP EVMs, by repeated intense
plug/unplug iterations.


Kishon Vijay Abraham I (1):
  mmc: host: omap_hsmmc: Fix DTO and DCRC handling

Vignesh R (2):
  mmc: host: omap_hsmmc: Handle BADA, DEB and CEB interrupts
  mmc: host: omap_hsmmc: Add custom card detect irq handler

 drivers/mmc/host/omap_hsmmc.c | 84 ++++++++++++++++++++++++++++++++---
 1 file changed, 78 insertions(+), 6 deletions(-)

-- 
2.4.1

