From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 3/3] sh: add MMCIF runtime PM support on ecovec
Date: Fri, 15 Apr 2011 20:30:55 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1104152027470.18593@axis700.grange>
References: <Pine.LNX.4.64.1104152021510.18593@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1104152021510.18593@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <damm@opensource.se>
---
 arch/sh/boards/mach-ecovec24/setup.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index bb13d0e..3a32741 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -885,6 +885,9 @@ static struct platform_device sh_mmcif_device = {
 	},
 	.num_resources	= ARRAY_SIZE(sh_mmcif_resources),
 	.resource	= sh_mmcif_resources,
+	.archdata = {
+		.hwblk_id = HWBLK_MMC,
+	},
 };
 #endif
 
-- 
1.7.2.5

