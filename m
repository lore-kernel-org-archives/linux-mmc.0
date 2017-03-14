From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 1/2] dt-bindings: mmc: tegra: Reformat compatible string list
Date: Tue, 14 Mar 2017 20:01:51 +0100
Message-ID: <20170314190152.9167-1-thierry.reding@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35762 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751014AbdCNTCH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Mar 2017 15:02:07 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The list of compatible strings is somewhat difficult to read and extend.
Reformat it into a list to make it more easily extensible.

While at it, also remove the "plus one of the above" clause because it
isn't actually valid.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt          | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
index 15b8368ee1f2..c15aa22d4570 100644
--- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
@@ -7,11 +7,12 @@ This file documents differences between the core properties described
 by mmc.txt and the properties used by the sdhci-tegra driver.
 
 Required properties:
-- compatible : For Tegra20, must contain "nvidia,tegra20-sdhci".
-  For Tegra30, must contain "nvidia,tegra30-sdhci".  For Tegra114,
-  must contain "nvidia,tegra114-sdhci".  For Tegra124, must contain
-  "nvidia,tegra124-sdhci".  Otherwise, must contain "nvidia,<chip>-sdhci",
-  plus one of the above, where <chip> is tegra132 or tegra210.
+- compatible : should be one of:
+  - "nvidia,tegra20-sdhci": for Tegra20
+  - "nvidia,tegra30-sdhci": for Tegra30
+  - "nvidia,tegra114-sdhci": for Tegra114
+  - "nvidia,tegra124-sdhci": for Tegra124 and Tegra132
+  - "nvidia,tegra210-sdhci": for Tegra210
 - clocks : Must contain one entry, for the module clock.
   See ../clocks/clock-bindings.txt for details.
 - resets : Must contain an entry for each entry in reset-names.
-- 
2.12.0

