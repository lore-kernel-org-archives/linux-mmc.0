From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 2/4 v3] ARM: mach-shmobile: fix SDHI IO address-range
Date: Wed, 23 Mar 2011 14:49:07 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1103231447040.6836@axis700.grange>
References: <Pine.LNX.4.64.1103231445070.6836@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:54924 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755994Ab1CWNtI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Mar 2011 09:49:08 -0400
In-Reply-To: <Pine.LNX.4.64.1103231445070.6836@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>

SDHI registers occupy only a 0x100 byte large window, not 0x200 byte.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/board-ap4evb.c   |    4 ++--
 arch/arm/mach-shmobile/board-g4evm.c    |    4 ++--
 arch/arm/mach-shmobile/board-mackerel.c |    6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 7ae9e3b..da8931d 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -312,7 +312,7 @@ static struct resource sdhi0_resources[] = {
 	[0] = {
 		.name	= "SDHI0",
 		.start  = 0xe6850000,
-		.end    = 0xe68501ff,
+		.end    = 0xe68500ff,
 		.flags  = IORESOURCE_MEM,
 	},
 	[1] = {
@@ -345,7 +345,7 @@ static struct resource sdhi1_resources[] = {
 	[0] = {
 		.name	= "SDHI1",
 		.start  = 0xe6860000,
-		.end    = 0xe68601ff,
+		.end    = 0xe68600ff,
 		.flags  = IORESOURCE_MEM,
 	},
 	[1] = {
diff --git a/arch/arm/mach-shmobile/board-g4evm.c b/arch/arm/mach-shmobile/board-g4evm.c
index cccdf2d..c87a7b7 100644
--- a/arch/arm/mach-shmobile/board-g4evm.c
+++ b/arch/arm/mach-shmobile/board-g4evm.c
@@ -205,7 +205,7 @@ static struct resource sdhi0_resources[] = {
 	[0] = {
 		.name	= "SDHI0",
 		.start  = 0xe6d50000,
-		.end    = 0xe6d501ff,
+		.end    = 0xe6d50nff,
 		.flags  = IORESOURCE_MEM,
 	},
 	[1] = {
@@ -232,7 +232,7 @@ static struct resource sdhi1_resources[] = {
 	[0] = {
 		.name	= "SDHI1",
 		.start  = 0xe6d60000,
-		.end    = 0xe6d601ff,
+		.end    = 0xe6d600ff,
 		.flags  = IORESOURCE_MEM,
 	},
 	[1] = {
diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 05fc5ac..0ae0bc6 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -670,7 +670,7 @@ static struct resource sdhi0_resources[] = {
 	[0] = {
 		.name	= "SDHI0",
 		.start	= 0xe6850000,
-		.end	= 0xe68501ff,
+		.end	= 0xe68500ff,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
@@ -705,7 +705,7 @@ static struct resource sdhi1_resources[] = {
 	[0] = {
 		.name	= "SDHI1",
 		.start	= 0xe6860000,
-		.end	= 0xe68601ff,
+		.end	= 0xe68600ff,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
@@ -748,7 +748,7 @@ static struct resource sdhi2_resources[] = {
 	[0] = {
 		.name	= "SDHI2",
 		.start	= 0xe6870000,
-		.end	= 0xe68701ff,
+		.end	= 0xe68700ff,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-- 
1.7.2.5

