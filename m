From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 8/8 v3] mmc: tmio: remove a duplicated comment line
Date: Fri, 25 May 2012 17:15:33 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1205251316460.13353@axis700.grange>
References: <Pine.LNX.4.64.1205251045490.13353@axis700.grange>
 <Pine.LNX.4.64.1205251300300.13353@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:64608 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756171Ab2EYPPf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 May 2012 11:15:35 -0400
In-Reply-To: <Pine.LNX.4.64.1205251300300.13353@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/tmio_mmc_pio.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index a4f1c59..b731859 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -980,7 +980,6 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 	 *  While we increment the runtime PM counter for all scenarios when
 	 *  the mmc core activates us by calling an appropriate set_ios(), we
 	 *  must additionally ensure that in case 2) the tmio mmc hardware stays
-	 *  additionally ensure that in case 2) the tmio mmc hardware stays
 	 *  powered on during runtime for the card detection to work.
 	 */
 	if (_host->native_hotplug)
-- 
1.7.2.5

