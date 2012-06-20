From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 7/7 v4] mmc: tmio: remove a duplicated comment line
Date: Wed, 20 Jun 2012 19:10:36 +0200
Message-ID: <1340212236-647-8-git-send-email-g.liakhovetski@gmx.de>
References: <1340212236-647-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1340212236-647-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/tmio_mmc_pio.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 2050827..d68ae59 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -984,7 +984,6 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 	 *  While we increment the runtime PM counter for all scenarios when
 	 *  the mmc core activates us by calling an appropriate set_ios(), we
 	 *  must additionally ensure that in case 2) the tmio mmc hardware stays
-	 *  additionally ensure that in case 2) the tmio mmc hardware stays
 	 *  powered on during runtime for the card detection to work.
 	 */
 	if (_host->native_hotplug)
-- 
1.7.2.5

