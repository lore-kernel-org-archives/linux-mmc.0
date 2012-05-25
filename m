From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 8/8 v3] mmc: tmio: remove a duplicated comment line
Date: Fri, 25 May 2012 17:45:34 +0200
Message-ID: <1337960752-4944-20-git-send-email-g.liakhovetski@gmx.de>
References: <Pine.LNX.4.64.1205251727260.13353@axis700.grange>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1205251727260.13353@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

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

--
To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
