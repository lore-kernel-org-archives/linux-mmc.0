From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 13/14] mmc: sh-mmcif: fix I/O errors
Date: Wed, 12 Dec 2012 15:38:17 +0100
Message-ID: <1355323098-18061-14-git-send-email-g.liakhovetski@gmx.de>
References: <1355323098-18061-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1355323098-18061-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

The INT_BUFWEN IRQ often arrives with other bits set too. If they are not
cleared, an additional IRQ can be triggered, sometimes also after the MMC
request has already been completed. This leads to block I/O errors. Earlier
Teppei Kamijou also observed these additional interrupts and proposed to
explicitly wait for them. This patch chooses an alternative approach of
clearing all active bits immediately, when processing the main interrupt.

Reported-by: Teppei Kamijou <teppei.kamijou.yb@renesas.com>
Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mmcif.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 1dd7fc0..36eee8d 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1238,7 +1238,9 @@ static irqreturn_t sh_mmcif_intr(int irq, void *dev_id)
 		sh_mmcif_writel(host->addr, MMCIF_CE_INT, ~INT_BUFREN);
 		sh_mmcif_bitclr(host, MMCIF_CE_INT_MASK, MASK_MBUFREN);
 	} else if (state & INT_BUFWEN) {
-		sh_mmcif_writel(host->addr, MMCIF_CE_INT, ~INT_BUFWEN);
+		sh_mmcif_writel(host->addr, MMCIF_CE_INT,
+				~(INT_BUFWEN | INT_DTRANE | INT_CMD12DRE |
+				  INT_CMD12RBE | INT_CMD12CRE));
 		sh_mmcif_bitclr(host, MMCIF_CE_INT_MASK, MASK_MBUFWEN);
 	} else if (state & INT_CMD12DRE) {
 		sh_mmcif_writel(host->addr, MMCIF_CE_INT,
-- 
1.7.2.5

