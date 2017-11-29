From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH v2 1/2] mmc: renesas_sdhi: enable R-Car D3 (r8a77995) support
Date: Wed, 29 Nov 2017 17:06:45 +0100
Message-ID: <1511971606-580-2-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1511971606-580-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:42957 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933259AbdK2QGz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Nov 2017 11:06:55 -0500
In-Reply-To: <1511971606-580-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: horms@verge.net.au, geert@linux-m68k.org
Cc: linux-renesas-soc@vger.kernel.org, wsa@the-dreams.de, magnus.damm@gmail.com, linux-mmc@vger.kernel.org, marek.vasut@gmail.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Whitelists for internal DMAC implementation.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 41cbe84..396ae8a 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -255,6 +255,7 @@ static const struct soc_device_attribute gen3_soc_whitelist[] = {
         { .soc_id = "r8a7795", .revision = "ES1.*" },
         { .soc_id = "r8a7795", .revision = "ES2.0" },
         { .soc_id = "r8a7796", .revision = "ES1.0" },
+        { .soc_id = "r8a77995", .revision = "ES1.0" },
         { /* sentinel */ }
 };
 
-- 
2.7.4

