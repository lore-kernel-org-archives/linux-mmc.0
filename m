From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [PATCH 1/2] mmc: renesas_sdhi_internal_dmac: Whitelist r8a774a1
Date: Tue, 14 Aug 2018 13:34:33 +0100
Message-ID: <1534250074-15890-2-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1534250074-15890-1-git-send-email-fabrizio.castro@bp.renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534250074-15890-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

We need r8a774a1 to be whitelisted for SDHI to work on the RZ/G2M,
but we don't care about the revision of the SoC, so just whitelist
the generic part number.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 35cc0de..1703fdb 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -290,6 +290,7 @@ static const struct soc_device_attribute gen3_soc_whitelist[] = {
 	{ .soc_id = "r8a7796", .revision = "ES1.0",
 	  .data = (void *)BIT(SDHI_INTERNAL_DMAC_ONE_RX_ONLY) },
 	/* generic ones */
+	{ .soc_id = "r8a774a1" },
 	{ .soc_id = "r8a7795" },
 	{ .soc_id = "r8a7796" },
 	{ .soc_id = "r8a77965" },
-- 
2.7.4
