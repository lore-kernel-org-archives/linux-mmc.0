From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [PATCH 2/2] mmc: renesas_sdhi: Add r8a774a1 support
Date: Tue, 14 Aug 2018 13:34:34 +0100
Message-ID: <1534250074-15890-3-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1534250074-15890-1-git-send-email-fabrizio.castro@bp.renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534250074-15890-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Document RZ/G2M (R8A774A1) SoC bindings.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/mmc/tmio_mmc.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
index c434200..8315fb5 100644
--- a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
@@ -17,6 +17,7 @@ Required properties:
 		"renesas,sdhi-r8a7740" - SDHI IP on R8A7740 SoC
 		"renesas,sdhi-r8a7743" - SDHI IP on R8A7743 SoC
 		"renesas,sdhi-r8a7745" - SDHI IP on R8A7745 SoC
+		"renesas,sdhi-r8a774a1" - SDHI IP on R8A774A1 SoC
 		"renesas,sdhi-r8a7778" - SDHI IP on R8A7778 SoC
 		"renesas,sdhi-r8a7779" - SDHI IP on R8A7779 SoC
 		"renesas,sdhi-r8a7790" - SDHI IP on R8A7790 SoC
@@ -34,7 +35,8 @@ Required properties:
 		"renesas,rcar-gen1-sdhi" - a generic R-Car Gen1 SDHI controller
 		"renesas,rcar-gen2-sdhi" - a generic R-Car Gen2 or RZ/G1
 					   SDHI controller
-		"renesas,rcar-gen3-sdhi" - a generic R-Car Gen3 SDHI controller
+		"renesas,rcar-gen3-sdhi" - a generic R-Car Gen3 or RZ/G2
+					   SDHI controller
 
 
 		When compatible with the generic version, nodes must list
-- 
2.7.4
