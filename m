From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V10 1/4] dt-bindings: mmc: Add supports-cqe property
Date: Tue, 22 Jan 2019 11:56:30 -0800
Message-ID: <1548186993-6229-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, mperttunen@nvidia.com, chunyan.zhang@unisoc.com, thierry.reding@gmail.com, jonathanh@nvidia.com, adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: anrao@nvidia.com, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Sowjanya Komatineni <skomatineni@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Add supports-cqe optional property for MMC hosts.

This property is used to identify the specific host controller
supporting command queue.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 [V10]: This patch version moves supports-cqe property from vendor
	specific MMC property to common MMC property.

 Documentation/devicetree/bindings/mmc/mmc.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index f5a0923b34ca..cdbcfd3a4ff2 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -62,6 +62,8 @@ Optional properties:
   be referred to mmc-pwrseq-simple.txt. But now it's reused as a tunable delay
   waiting for I/O signalling and card power supply to be stable, regardless of
   whether pwrseq-simple is used. Default to 10ms if no available.
+- supports-cqe : The presence of this property indicates that the corresponding
+  MMC host controller supports HW command queue feature.
 
 *NOTE* on CD and WP polarity. To use common for all SD/MMC host controllers line
 polarity properties, we have to fix the meaning of the "normal" and "inverted"
-- 
2.7.4
