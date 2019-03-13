From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V3 04/10] dt-bindings: mmc: tegra: document Tegra194 compatible string
Date: Wed, 13 Mar 2019 14:45:46 -0700
Message-ID: <1552513552-23423-4-git-send-email-skomatineni@nvidia.com>
References: <1552513552-23423-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552513552-23423-1-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, riteshh@codeaurora.org
Cc: skomatineni@nvidia.com, thierry.reding@gmail.com, jonathanh@nvidia.com, anrao@nvidia.com, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

SDHCI controller of Tegra194 is similar to SDHCI controller in Tegra186.
This patch documents Tegra194 sdhci compatible string.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
index 2cecdc71d94c..2cf3affa1be7 100644
--- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
@@ -14,6 +14,7 @@ Required properties:
   - "nvidia,tegra124-sdhci": for Tegra124 and Tegra132
   - "nvidia,tegra210-sdhci": for Tegra210
   - "nvidia,tegra186-sdhci": for Tegra186
+  - "nvidia,tegra194-sdhci": for Tegra194
 - clocks : Must contain one entry, for the module clock.
   See ../clocks/clock-bindings.txt for details.
 - resets : Must contain an entry for each entry in reset-names.
-- 
2.7.4
