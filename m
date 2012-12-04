From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 1/3] mmc: add a card-event host operation
Date: Tue, 4 Dec 2012 16:51:32 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1212041647590.26918@axis700.grange>
References: <Pine.LNX.4.64.1212041633470.26918@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:53003 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751835Ab2LDPve (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Dec 2012 10:51:34 -0500
In-Reply-To: <Pine.LNX.4.64.1212041633470.26918@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Shawn Guo <shawn.guo@linaro.org>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Mike Rapoport <mike@compulab.co.il>, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>

Some hosts need to perform additional actions upon card insertion or
ejection. Add a host operation to be called from card detection handlers.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 include/linux/mmc/host.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 7abb0e1..79ead24 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -136,6 +136,7 @@ struct mmc_host_ops {
 	void	(*enable_preset_value)(struct mmc_host *host, bool enable);
 	int	(*select_drive_strength)(unsigned int max_dtr, int host_drv, int card_drv);
 	void	(*hw_reset)(struct mmc_host *host);
+	void	(*card_event)(struct mmc_host *host);
 };
 
 struct mmc_card;
-- 
1.7.2.5

