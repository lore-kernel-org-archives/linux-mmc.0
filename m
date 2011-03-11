From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 3/4 v2] sh: fix SDHI IO address-range
Date: Fri, 11 Mar 2011 09:09:40 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1103110905210.23675@axis700.grange>
References: <Pine.LNX.4.64.1103110854050.23675@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:56658 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131Ab1CKIJn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Mar 2011 03:09:43 -0500
In-Reply-To: <Pine.LNX.4.64.1103110854050.23675@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>

SDHI registers occupy only a 0x100 byte large window, not 0x200 byte.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v2:
 
1. fix the resource size instead of adding a flag

 arch/sh/boards/mach-ap325rxa/setup.c |    4 ++--
 arch/sh/boards/mach-ecovec24/setup.c |    4 ++--
 arch/sh/boards/mach-kfr2r09/setup.c  |    2 +-
 arch/sh/boards/mach-migor/setup.c    |    2 +-
 arch/sh/boards/mach-se/7724/setup.c  |    4 ++--
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/sh/boards/mach-ap325rxa/setup.c b/arch/sh/boards/mach-ap325rxa/setup.c
index 60d109f..65bd042 100644
--- a/arch/sh/boards/mach-ap325rxa/setup.c
+++ b/arch/sh/boards/mach-ap325rxa/setup.c
@@ -417,7 +417,7 @@ static struct resource sdhi0_cn3_resources[] = {
 	[0] = {
 		.name	= "SDHI0",
 		.start	= 0x04ce0000,
-		.end	= 0x04ce01ff,
+		.end	= 0x04ce00ff,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
@@ -447,7 +447,7 @@ static struct resource sdhi1_cn7_resources[] = {
 	[0] = {
 		.name	= "SDHI1",
 		.start	= 0x04cf0000,
-		.end	= 0x04cf01ff,
+		.end	= 0x04cf00ff,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 710be27c9..fd0cb36 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -480,7 +480,7 @@ static struct resource sdhi0_resources[] = {
 	[0] = {
 		.name	= "SDHI0",
 		.start  = 0x04ce0000,
-		.end    = 0x04ce01ff,
+		.end    = 0x04ce00ff,
 		.flags  = IORESOURCE_MEM,
 	},
 	[1] = {
@@ -520,7 +520,7 @@ static struct resource sdhi1_resources[] = {
 	[0] = {
 		.name	= "SDHI1",
 		.start  = 0x04cf0000,
-		.end    = 0x04cf01ff,
+		.end    = 0x04cf00ff,
 		.flags  = IORESOURCE_MEM,
 	},
 	[1] = {
diff --git a/arch/sh/boards/mach-kfr2r09/setup.c b/arch/sh/boards/mach-kfr2r09/setup.c
index 7021b59..8b4abbb 100644
--- a/arch/sh/boards/mach-kfr2r09/setup.c
+++ b/arch/sh/boards/mach-kfr2r09/setup.c
@@ -354,7 +354,7 @@ static struct resource kfr2r09_sh_sdhi0_resources[] = {
 	[0] = {
 		.name	= "SDHI0",
 		.start  = 0x04ce0000,
-		.end    = 0x04ce01ff,
+		.end    = 0x04ce00ff,
 		.flags  = IORESOURCE_MEM,
 	},
 	[1] = {
diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
index 37e64a6..184fde1 100644
--- a/arch/sh/boards/mach-migor/setup.c
+++ b/arch/sh/boards/mach-migor/setup.c
@@ -399,7 +399,7 @@ static struct resource sdhi_cn9_resources[] = {
 	[0] = {
 		.name	= "SDHI",
 		.start	= 0x04ce0000,
-		.end	= 0x04ce01ff,
+		.end	= 0x04ce00ff,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
index 58cefd3..1235767 100644
--- a/arch/sh/boards/mach-se/7724/setup.c
+++ b/arch/sh/boards/mach-se/7724/setup.c
@@ -456,7 +456,7 @@ static struct resource sdhi0_cn7_resources[] = {
 	[0] = {
 		.name	= "SDHI0",
 		.start  = 0x04ce0000,
-		.end    = 0x04ce01ff,
+		.end    = 0x04ce00ff,
 		.flags  = IORESOURCE_MEM,
 	},
 	[1] = {
@@ -488,7 +488,7 @@ static struct resource sdhi1_cn8_resources[] = {
 	[0] = {
 		.name	= "SDHI1",
 		.start  = 0x04cf0000,
-		.end    = 0x04cf01ff,
+		.end    = 0x04cf00ff,
 		.flags  = IORESOURCE_MEM,
 	},
 	[1] = {
-- 
1.7.2.3

