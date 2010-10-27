From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH v2 2/2] [ARM] Dove: rename SDCHI devices to "sdhci-dove"
Date: Wed, 27 Oct 2010 13:21:59 +0200
Message-ID: <0991d07ee009926ba3665d3410970aaa3cbbbb22.1288178148.git.mike@compulab.co.il>
References: <cover.1288178148.git.mike@compulab.co.il>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:49743 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760874Ab0J0LWh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 27 Oct 2010 07:22:37 -0400
In-Reply-To: <cover.1288178148.git.mike@compulab.co.il>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, Saeed Bishara <saeed@marvell.com>, Mike Rapoport <mike@compulab.co.il>

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
CC: Saeed Bishara <saeed@marvell.com>
---
 arch/arm/mach-dove/common.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index f7a1258..fe627ab 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -770,7 +770,7 @@ static struct resource dove_sdio0_resources[] = {
 };
 
 static struct platform_device dove_sdio0 = {
-	.name		= "sdhci-mv",
+	.name		= "sdhci-dove",
 	.id		= 0,
 	.dev		= {
 		.dma_mask		= &sdio_dmamask,
@@ -798,7 +798,7 @@ static struct resource dove_sdio1_resources[] = {
 };
 
 static struct platform_device dove_sdio1 = {
-	.name		= "sdhci-mv",
+	.name		= "sdhci-dove",
 	.id		= 1,
 	.dev		= {
 		.dma_mask		= &sdio_dmamask,
-- 
1.7.3.1

