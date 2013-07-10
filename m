From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 6/6] ARM: shmobile: lager: disable MMCIF Command Completion Signal, add CLK_CTRL2
Date: Wed, 10 Jul 2013 21:21:17 +0200
Message-ID: <1373484077-10460-7-git-send-email-g.liakhovetski@gmx.de>
References: <1373484077-10460-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:64561 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754976Ab3GJTVW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Jul 2013 15:21:22 -0400
In-Reply-To: <1373484077-10460-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Chris Ball <cjb@laptop.org>, Nobuyuki HIRAI <nobuyuki.hirai.xe@renesas.com>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

MMCIF on r8a7790 doesn't support Command Completion Signal, but it does
implement a CE_CLK_CTRL2 register. Platform parameters have to be added to
account for these features on lager.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 arch/arm/mach-shmobile/board-lager.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index 3c67b2a..9b3085f 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -84,6 +84,8 @@ static struct regulator_consumer_supply fixed3v3_power_consumers[] =
 /* MMCIF */
 static struct sh_mmcif_plat_data mmcif1_pdata = {
 	.caps		= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE,
+	.clk_ctrl2_present = true,
+	.ccs_unsupported = true,
 };
 
 static struct resource mmcif1_resources[] = {
-- 
1.7.2.5

