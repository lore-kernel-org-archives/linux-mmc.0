From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH 1/4] mmc: renesas_sdhi: enable R-Car D3 (r8a77995) support
Date: Wed, 15 Nov 2017 16:25:46 +0100
Message-ID: <1510759549-30404-2-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1510759549-30404-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1510759549-30404-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, horms@verge.net.au, wsa@the-dreams.de, geert@linux-m68k.org
Cc: magnus.damm@gmail.com, linux-mmc@vger.kernel.org, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Adds compatible string and whitelists for internal DMAC implementation.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 41cbe84..f16d8f4 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -88,6 +88,7 @@ static const struct renesas_sdhi_of_data of_rcar_gen3_compatible = {
 static const struct of_device_id renesas_sdhi_internal_dmac_of_match[] = {
 	{ .compatible = "renesas,sdhi-r8a7795", .data = &of_rcar_gen3_compatible, },
 	{ .compatible = "renesas,sdhi-r8a7796", .data = &of_rcar_gen3_compatible, },
+	{ .compatible = "renesas,sdhi-r8a77995", .data = &of_rcar_gen3_compatible, },
 	{ .compatible = "renesas,rcar-gen3-sdhi", .data = &of_rcar_gen3_compatible, },
 	{},
 };
@@ -255,6 +256,7 @@ static const struct soc_device_attribute gen3_soc_whitelist[] = {
         { .soc_id = "r8a7795", .revision = "ES1.*" },
         { .soc_id = "r8a7795", .revision = "ES2.0" },
         { .soc_id = "r8a7796", .revision = "ES1.0" },
+        { .soc_id = "r8a77995", .revision = "*" },
         { /* sentinel */ }
 };
 
-- 
2.7.4
