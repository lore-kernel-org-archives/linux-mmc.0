From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH/RFT 3/3] arm64: dts: salvator-common: Enable HS400 of SDHI2
Date: Tue,  5 Dec 2017 13:37:56 +0100
Message-ID: <20171205123756.18424-4-horms+renesas@verge.net.au>
References: <20171205123756.18424-1-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20171205123756.18424-1-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Takeshi Kihara <takeshi.kihara.df@renesas.com>, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

This patch adds the mmc-hs400-1_8v property to SDHI2 and enable eMMC
HS400.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v1 [Simon Horman]
* Rebase

v0 [Takeshi Kihara]
---
 arch/arm64/boot/dts/renesas/salvator-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/salvator-common.dtsi b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
index 3f9170b30b5b..66eaa23500a9 100644
--- a/arch/arm64/boot/dts/renesas/salvator-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
@@ -624,6 +624,7 @@
 	vqmmc-supply = <&reg_1p8v>;
 	bus-width = <8>;
 	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
 	non-removable;
 	status = "okay";
 };
-- 
2.11.0
