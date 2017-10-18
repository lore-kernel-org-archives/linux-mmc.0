From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v4 3/3] mmc: renesas_sdhi: implement R-Car Gen[123] fallback compatibility strings
Date: Wed, 18 Oct 2017 09:00:23 +0200
Message-ID: <20171018070023.3878-4-horms+renesas@verge.net.au>
References: <20171018070023.3878-1-horms+renesas@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:57269 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932290AbdJRHBG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Oct 2017 03:01:06 -0400
In-Reply-To: <20171018070023.3878-1-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>

Implement fallback compatibility strings for R-Car Gen 1, 2 and 3.

In the case of Renesas R-Car hardware we know that there are generations of
SoCs, f.e. Gen 1 and 2. But beyond that its not clear what the relationship
between IP blocks might be. For example, I believe that r8a7790 is older
than r8a7791 but that doesn't imply that the latter is a descendant of the
former or vice versa.

We can, however, by examining the documentation and behaviour of the
hardware at run-time observe that the current driver implementation appears
to be compatible with the IP blocks on SoCs within a given generation.

For the above reasons and convenience when enabling new SoCs a
per-generation fallback compatibility string scheme is being adopted for
drivers for Renesas SoCs.

Also, improve readability by listing the shmobile fallback compatibility
string after the more-specific compatibility strings they provide a
fallback for.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4
* Corrected typo in changelog
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 1 +
 drivers/mmc/host/renesas_sdhi_sys_dmac.c      | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index f905f2361d12..637c27057ac2 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -88,6 +88,7 @@ static const struct renesas_sdhi_of_data of_rcar_gen3_compatible = {
 static const struct of_device_id renesas_sdhi_internal_dmac_of_match[] = {
 	{ .compatible = "renesas,sdhi-r8a7795", .data = &of_rcar_gen3_compatible, },
 	{ .compatible = "renesas,sdhi-r8a7796", .data = &of_rcar_gen3_compatible, },
+	{ .compatible = "renesas,rcar-gen3-sdhi", .data = &of_rcar_gen3_compatible, },
 	{},
 };
 MODULE_DEVICE_TABLE(of, renesas_sdhi_internal_dmac_of_match);
diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index df4465439e13..9ab10436e4b8 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -91,7 +91,6 @@ static const struct renesas_sdhi_of_data of_rcar_gen3_compatible = {
 };
 
 static const struct of_device_id renesas_sdhi_sys_dmac_of_match[] = {
-	{ .compatible = "renesas,sdhi-shmobile" },
 	{ .compatible = "renesas,sdhi-sh73a0", .data = &of_default_cfg, },
 	{ .compatible = "renesas,sdhi-r8a73a4", .data = &of_default_cfg, },
 	{ .compatible = "renesas,sdhi-r8a7740", .data = &of_default_cfg, },
@@ -107,6 +106,10 @@ static const struct of_device_id renesas_sdhi_sys_dmac_of_match[] = {
 	{ .compatible = "renesas,sdhi-r8a7794", .data = &of_rcar_gen2_compatible, },
 	{ .compatible = "renesas,sdhi-r8a7795", .data = &of_rcar_gen3_compatible, },
 	{ .compatible = "renesas,sdhi-r8a7796", .data = &of_rcar_gen3_compatible, },
+	{ .compatible = "renesas,rcar-gen1-sdhi", .data = &of_rcar_gen1_compatible, },
+	{ .compatible = "renesas,rcar-gen2-sdhi", .data = &of_rcar_gen2_compatible, },
+	{ .compatible = "renesas,rcar-gen3-sdhi", .data = &of_rcar_gen3_compatible, },
+	{ .compatible = "renesas,sdhi-shmobile" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, renesas_sdhi_sys_dmac_of_match);
-- 
2.11.0

