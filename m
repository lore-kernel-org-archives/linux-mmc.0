From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 5/6] ARM: shmobile: ape6evm: disable MMCIF Command Completion Signal
Date: Wed, 10 Jul 2013 21:21:16 +0200
Message-ID: <1373484077-10460-6-git-send-email-g.liakhovetski@gmx.de>
References: <1373484077-10460-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1373484077-10460-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Chris Ball <cjb@laptop.org>, Nobuyuki HIRAI <nobuyuki.hirai.xe@renesas.com>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
List-Id: linux-mmc@vger.kernel.org

MMCIF on r8a73a4 doesn't support Command Completion Signal, a platform
parameter has to be added to disable it on ape6evm.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 arch/arm/mach-shmobile/board-ape6evm.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ape6evm.c b/arch/arm/mach-shmobile/board-ape6evm.c
index e9e2108e..96a6994 100644
--- a/arch/arm/mach-shmobile/board-ape6evm.c
+++ b/arch/arm/mach-shmobile/board-ape6evm.c
@@ -77,6 +77,7 @@ static struct sh_mmcif_plat_data mmcif0_pdata = {
 	.caps		= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE,
 	.slave_id_tx	= SHDMA_SLAVE_MMCIF0_TX,
 	.slave_id_rx	= SHDMA_SLAVE_MMCIF0_RX,
+	.ccs_unsupported = true,
 };
 
 static struct resource mmcif0_resources[] = {
-- 
1.7.2.5

