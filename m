From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFT 2/2] mmc: renesas_sdhi: document version of RZ/A1 instance
Date: Wed,  9 Aug 2017 21:14:52 +0200
Message-ID: <20170809191452.5254-3-wsa+renesas@sang-engineering.com>
References: <20170809191452.5254-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:33419 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751560AbdHITPA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 9 Aug 2017 15:15:00 -0400
In-Reply-To: <20170809191452.5254-1-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Chris Brandt <chris.brandt@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>

We don't use this new define yet, but it is helpful to document which
versions we know of.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/renesas_sdhi_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index e46504edc9fcb4..d0554088adfc41 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -40,6 +40,7 @@
 #define EXT_ACC           0xe4
 
 #define SDHI_VER_GEN2_SDR50	0x490c
+#define SDHI_VER_RZ_A1		0x820b
 /* very old datasheets said 0x490c for SDR104, too. They are wrong! */
 #define SDHI_VER_GEN2_SDR104	0xcb0d
 #define SDHI_VER_GEN3_SD	0xcc10
-- 
2.11.0

