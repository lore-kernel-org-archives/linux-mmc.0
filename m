From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [PATCH] mmc: renesas_sdhi_internal_dmac: Whitelist r8a774c0
Date: Thu, 13 Dec 2018 20:22:27 +0000
Message-ID: <1544732547-7094-1-git-send-email-fabrizio.castro@bp.renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Biju Das <biju.das@bp.renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, Chris Paterson <Chris.Paterson2@renesas.com>, Fabrizio Castro <fabrizio.castro@bp.renesas.com>, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Biju Das <biju.das@bp.renesas.com>

We need r8a774c0 to be whitelisted for SDHI to work on the RZ/G2E,
but we don't care about the revision of the SoC, so just whitelist
the generic part number.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index b6f5410..909a5c9 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -298,6 +298,7 @@ static const struct soc_device_attribute soc_whitelist[] = {
 	  .data = (void *)BIT(SDHI_INTERNAL_DMAC_ONE_RX_ONLY) },
 	/* generic ones */
 	{ .soc_id = "r8a774a1" },
+	{ .soc_id = "r8a774c0" },
 	{ .soc_id = "r8a77470" },
 	{ .soc_id = "r8a7795" },
 	{ .soc_id = "r8a7796" },
-- 
2.7.4
