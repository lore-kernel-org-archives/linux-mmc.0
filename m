From: Lars Persson <lars.persson@axis.com>
Subject: [PATCH v3 1/3] mmc: dt: usdhi6rol0: add optional pinctrl binding
Date: Wed, 20 Apr 2016 16:53:11 +0200
Message-ID: <a96281244b55d55e36b72a40cd061d7ffd70b88e.1461163234.git.larper@axis.com>
References: <cover.1461163234.git.larper@axis.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bes.se.axis.com ([195.60.68.10]:33174 "EHLO bes.se.axis.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932129AbcDTOx2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 20 Apr 2016 10:53:28 -0400
In-Reply-To: <cover.1461163234.git.larper@axis.com>
In-Reply-To: <cover.1461163234.git.larper@axis.com>
References: <cover.1461163234.git.larper@axis.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
Cc: g.liakhovetski@gmx.de, ulf.hansson@linaro.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, Lars Persson <larper@axis.com>

Add a pinctrl binding to specify different pin settings for high speed
modes and UHS modes.

Signed-off-by: Lars Persson <larper@axis.com>
---
 Documentation/devicetree/bindings/mmc/usdhi6rol0.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/usdhi6rol0.txt b/Documentation/devicetree/bindings/mmc/usdhi6rol0.txt
index 8babdaa..6d1b797 100644
--- a/Documentation/devicetree/bindings/mmc/usdhi6rol0.txt
+++ b/Documentation/devicetree/bindings/mmc/usdhi6rol0.txt
@@ -12,6 +12,12 @@ Optional properties:
 
 - vmmc-supply:	a phandle of a regulator, supplying Vcc to the card
 - vqmmc-supply:	a phandle of a regulator, supplying VccQ to the card
+- pinctrl-names: Can contain a "default" entry and a "state_uhs"
+                 entry. The state_uhs entry is used together with the default
+                 entry when the board requires distinct settings for UHS speeds.
+
+- pinctrl-N: One property for each name listed in pinctrl-names, see
+             ../pinctrl/pinctrl-bindings.txt.
 
 Additionally any standard mmc bindings from mmc.txt can be used.
 
-- 
2.1.4

