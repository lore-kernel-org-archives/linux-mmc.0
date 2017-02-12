From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 2/4] mmc: host: tmio: fix minor typos in a comment
Date: Sun, 12 Feb 2017 12:12:25 +0100
Message-ID: <20170212111227.1550-3-wsa+renesas@sang-engineering.com>
References: <20170212111227.1550-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:50555 "EHLO pokefinder.org"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751178AbdBLLMg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 12 Feb 2017 06:12:36 -0500
In-Reply-To: <20170212111227.1550-1-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>

Making sure we match the actual register name.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/tmio_mmc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index b20b451ad90daa..8a4e99ffe64eb1 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -54,7 +54,7 @@
 #define TMIO_STOP_STP		BIT(0)
 #define TMIO_STOP_SEC		BIT(8)
 
-/* Definitions for values the CTRL_STATUS register can take. */
+/* Definitions for values the CTL_STATUS register can take */
 #define TMIO_STAT_CMDRESPEND    BIT(0)
 #define TMIO_STAT_DATAEND       BIT(2)
 #define TMIO_STAT_CARD_REMOVE   BIT(3)
-- 
2.11.0

