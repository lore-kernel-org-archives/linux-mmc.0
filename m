From: Lars Persson <lars.persson@axis.com>
Subject: [PATCH 1/3] mmc: dt: usdhi6rol0: add optional pinctrl binding
Date: Mon, 18 Apr 2016 11:38:24 +0200
Message-ID: <0376e04a938f459cee9e1f80e1447e060ba7e497.1460971625.git.larper@axis.com>
References: <cover.1460971625.git.larper@axis.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bes.se.axis.com ([195.60.68.10]:58519 "EHLO bes.se.axis.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752278AbcDRJjF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 18 Apr 2016 05:39:05 -0400
In-Reply-To: <cover.1460971625.git.larper@axis.com>
In-Reply-To: <cover.1460971625.git.larper@axis.com>
References: <cover.1460971625.git.larper@axis.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
Cc: g.liakhovetski@gmx.de, ulf.hansson@linaro.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, Lars Persson <larper@axis.com>

Add a pinctrl binding to specify different pin settings for high speed
modes and UHS modes.

Signed-off-by: Lars Persson <larper@axis.com>
---
 Documentation/devicetree/bindings/mmc/usdhi6rol0.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/usdhi6rol0.txt b/Documentation/devicetree/bindings/mmc/usdhi6rol0.txt
index 8babdaa..9dd9478 100644
--- a/Documentation/devicetree/bindings/mmc/usdhi6rol0.txt
+++ b/Documentation/devicetree/bindings/mmc/usdhi6rol0.txt
@@ -12,6 +12,10 @@ Optional properties:
 
 - vmmc-supply:	a phandle of a regulator, supplying Vcc to the card
 - vqmmc-supply:	a phandle of a regulator, supplying VccQ to the card
+- pinctrl-names: Must contain a "default" entry and optionally a "pins_uhs"
+                 entry for the UHS pin configuration.
+- pinctrl-N: One property for each name listed in pinctrl-names, see
+             ../pinctrl/pinctrl-bindings.txt.
 
 Additionally any standard mmc bindings from mmc.txt can be used.
 
-- 
2.1.4

