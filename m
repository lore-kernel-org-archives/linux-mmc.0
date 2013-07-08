From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH v3 5/7] mmc: SDHI: add DT compatibility strings for further SoCs
Date: Mon,  8 Jul 2013 17:54:44 +0200
Message-ID: <1373298887-9877-6-git-send-email-g.liakhovetski@gmx.de>
References: <1373298887-9877-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1373298887-9877-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

Add further OF compatibility strings to the SDHI driver to be able to
precisely control driver's behaviour on each of them.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Cc: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>
---

As explained in patch 0/7, this patch can be pushed separately via the 
mmc git-tree.

 drivers/mmc/host/sh_mobile_sdhi.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index cc4c872..b58c1a9 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -130,6 +130,9 @@ static const struct of_device_id sh_mobile_sdhi_of_match[] = {
 	{ .compatible = "renesas,shmobile-sdhi" },
 	{ .compatible = "renesas,sh7372-sdhi" },
 	{ .compatible = "renesas,r8a7740-sdhi", .data = &sh_mobile_sdhi_of_cfg[0], },
+	{ .compatible = "renesas,sh73a0-sdhi", .data = &sh_mobile_sdhi_of_cfg[0], },
+	{ .compatible = "renesas,r8a73a4-sdhi", .data = &sh_mobile_sdhi_of_cfg[0], },
+	{ .compatible = "renesas,r8a7790-sdhi", .data = &sh_mobile_sdhi_of_cfg[0], },
 	{},
 };
 MODULE_DEVICE_TABLE(of, sh_mobile_sdhi_of_match);
-- 
1.7.2.5

