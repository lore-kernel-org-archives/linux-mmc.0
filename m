From: Simon Horman <horms@verge.net.au>
Subject: [PATCH 4/5] ARM: mach-shmobile: ag5evm: consistently name sdhi info structures
Date: Tue, 21 Jun 2011 08:00:11 +0900
Message-ID: <1308610812-3479-5-git-send-email-horms@verge.net.au>
References: <1308610812-3479-1-git-send-email-horms@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:60666 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755994Ab1FTXAW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jun 2011 19:00:22 -0400
In-Reply-To: <1308610812-3479-1-git-send-email-horms@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Paul Mundt <lethal@linux-sh.org>, Chris Ball <cjb@laptop.org>, Simon Horman <horms@verge.net.au>

Name the SDHI1 instance sh_sdhi1_info to be consistent with sh_sdhi0_info.

Signed-off-by: Simon Horman <horms@verge.net.au>

---

Dependencies: None known
---
 arch/arm/mach-shmobile/board-ag5evm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index 1e2aba2..ce5c251 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -381,7 +381,7 @@ void ag5evm_sdhi1_set_pwr(struct platform_device *pdev, int state)
 	gpio_set_value(GPIO_PORT114, state);
 }
 
-static struct sh_mobile_sdhi_info sh_sdhi1_platdata = {
+static struct sh_mobile_sdhi_info sh_sdhi1_info = {
 	.tmio_flags	= TMIO_MMC_WRPROTECT_DISABLE,
 	.tmio_caps	= MMC_CAP_NONREMOVABLE | MMC_CAP_SDIO_IRQ,
 	.tmio_ocr_mask	= MMC_VDD_32_33 | MMC_VDD_33_34,
@@ -413,7 +413,7 @@ static struct platform_device sdhi1_device = {
 	.name		= "sh_mobile_sdhi",
 	.id		= 1,
 	.dev		= {
-		.platform_data	= &sh_sdhi1_platdata,
+		.platform_data	= &sh_sdhi1_info,
 	},
 	.num_resources	= ARRAY_SIZE(sdhi1_resources),
 	.resource	= sdhi1_resources,
-- 
1.7.4.4

