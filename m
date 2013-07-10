From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 3/6] ARM: shmobile: armadillo800eva: disable MMCIF Command Completion Signal
Date: Wed, 10 Jul 2013 21:21:14 +0200
Message-ID: <1373484077-10460-4-git-send-email-g.liakhovetski@gmx.de>
References: <1373484077-10460-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:50163 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755024Ab3GJTV0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Jul 2013 15:21:26 -0400
In-Reply-To: <1373484077-10460-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Chris Ball <cjb@laptop.org>, Nobuyuki HIRAI <nobuyuki.hirai.xe@renesas.com>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

MMCIF on r8a7740 doesn't support Command Completion Signal, a platform
parameter has to be added to disable it on armadillo800eva.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 41ff7d65..3cb006b 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -778,6 +778,7 @@ static struct sh_mmcif_plat_data sh_mmcif_plat = {
 	.caps		= MMC_CAP_4_BIT_DATA |
 			  MMC_CAP_8_BIT_DATA |
 			  MMC_CAP_NONREMOVABLE,
+	.ccs_unsupported = true,
 	.slave_id_tx	= SHDMA_SLAVE_MMCIF_TX,
 	.slave_id_rx	= SHDMA_SLAVE_MMCIF_RX,
 };
-- 
1.7.2.5

