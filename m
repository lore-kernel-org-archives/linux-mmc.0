From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V4 08/10] mmc: cqhci: add CQHCI_SSC1 register CBC field mask
Date: Sat, 23 Mar 2019 21:45:25 -0700
Message-ID: <1553402727-23130-8-git-send-email-skomatineni@nvidia.com>
References: <1553402727-23130-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553402727-23130-1-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, riteshh@codeaurora.org
Cc: skomatineni@nvidia.com, thierry.reding@gmail.com, jonathanh@nvidia.com, anrao@nvidia.com, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

This patch adds define for CBC field mask of the register
CQHCI_SSC1.

Tested-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/mmc/host/cqhci.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
index 928ec491eecf..1e8e01d81015 100644
--- a/drivers/mmc/host/cqhci.h
+++ b/drivers/mmc/host/cqhci.h
@@ -88,6 +88,7 @@
 
 /* send status config 1 */
 #define CQHCI_SSC1			0x40
+#define CQHCI_SSC1_CBC_MASK		GENMASK(19, 16)
 
 /* send status config 2 */
 #define CQHCI_SSC2			0x44
-- 
2.7.4
