From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 2/6] mmc: sh_mmcif: revision-specific CLK_CTRL2 handling
Date: Wed, 10 Jul 2013 21:21:13 +0200
Message-ID: <1373484077-10460-3-git-send-email-g.liakhovetski@gmx.de>
References: <1373484077-10460-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1373484077-10460-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Chris Ball <cjb@laptop.org>, Nobuyuki HIRAI <nobuyuki.hirai.xe@renesas.com>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Some newer MMCIF IP revisions contain a CE_CLK_CTRL2 register, that has to
be set for proper operation. Support for this feature is added in a way to
preserve the current behaviour by default, i.e. when it is not enabled
in platform data. Patch is based on work by Nobuyuki HIRAI.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 drivers/mmc/host/sh_mmcif.c  |    4 ++++
 include/linux/mmc/sh_mmcif.h |    2 ++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 7be20c9..dc3ce52 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -246,6 +246,7 @@ struct sh_mmcif_host {
 	bool power;
 	bool card_present;
 	bool ccs_enable;		/* Command Completion Signal support */
+	bool clk_ctrl2_enable;
 	struct mutex thread_lock;
 
 	/* DMA support */
@@ -490,6 +491,8 @@ static void sh_mmcif_sync_reset(struct sh_mmcif_host *host)
 	sh_mmcif_writel(host->addr, MMCIF_CE_VERSION, SOFT_RST_OFF);
 	if (host->ccs_enable)
 		tmp |= SCCSTO_29;
+	if (host->clk_ctrl2_enable)
+		sh_mmcif_writel(host->addr, MMCIF_CE_CLK_CTRL2, 0x0F0F0000);
 	sh_mmcif_bitset(host, MMCIF_CE_CLK_CTRL, tmp |
 		SRSPTO_256 | SRBSYTO_29 | SRWDTO_29);
 	/* byte swap on */
@@ -1390,6 +1393,7 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 	host->addr	= reg;
 	host->timeout	= msecs_to_jiffies(1000);
 	host->ccs_enable = !pd || !pd->ccs_unsupported;
+	host->clk_ctrl2_enable = pd && pd->clk_ctrl2_present;
 
 	host->pd = pdev;
 
diff --git a/include/linux/mmc/sh_mmcif.h b/include/linux/mmc/sh_mmcif.h
index b2a22b6..d4277d9 100644
--- a/include/linux/mmc/sh_mmcif.h
+++ b/include/linux/mmc/sh_mmcif.h
@@ -40,6 +40,7 @@ struct sh_mmcif_plat_data {
 	unsigned int		slave_id_rx;
 	bool			use_cd_gpio : 1;
 	bool			ccs_unsupported : 1;
+	bool			clk_ctrl2_present : 1;
 	unsigned int		cd_gpio;
 	u8			sup_pclk;	/* 1 :SH7757, 0: SH7724/SH7372 */
 	unsigned long		caps;
@@ -63,6 +64,7 @@ struct sh_mmcif_plat_data {
 #define MMCIF_CE_INT_MASK	0x00000044
 #define MMCIF_CE_HOST_STS1	0x00000048
 #define MMCIF_CE_HOST_STS2	0x0000004C
+#define MMCIF_CE_CLK_CTRL2	0x00000070
 #define MMCIF_CE_VERSION	0x0000007C
 
 /* CE_BUF_ACC */
-- 
1.7.2.5

