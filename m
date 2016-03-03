From: Guodong Xu <guodong.xu@linaro.org>
Subject: [PATCH 1/2] Documentation: synopsys-dw-mshc: add binding for resets
Date: Thu,  3 Mar 2016 09:33:37 +0800
Message-ID: <1456968818-22140-1-git-send-email-guodong.xu@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, jh80.chung@samsung.com, ulf.hansson@linaro.org, shawn.lin@rock-chips.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Guodong Xu <guodong.xu@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Add resets property to synopsys-dw-mshc bindings. It is intended to
represent the hardware reset signal present internally in some host
controller IC designs.

See Documentation/devicetree/bindings/reset/reset.txt for details.

Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
index 8636f5a..9b4896c 100644
--- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
@@ -39,6 +39,10 @@ Required Properties:
 
 Optional properties:
 
+* resets: phandle + reset specifier pair, intended to represent hardware
+  reset signal present internally in some host controller IC designs.
+  See Documentation/devicetree/bindings/reset/reset.txt for details.
+
 * clocks: from common clock binding: handle to biu and ciu clocks for the
   bus interface unit clock and the card interface unit clock.
 
@@ -48,7 +52,7 @@ Optional properties:
   clock-frequency.  It is an error to omit both the ciu clock and the
   clock-frequency.
 
-* clock-frequency: should be the frequency (in Hz) of the ciu clock.  If this
+* clock-frequency: should be tke frequency (in Hz) of the ciu clock.  If this
   is specified and the ciu clock is specified then we'll try to set the ciu
   clock to this at probe time.
 
-- 
1.9.1
