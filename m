From: Guodong Xu <guodong.xu@linaro.org>
Subject: [PATCH v4 1/2] Documentation: synopsys-dw-mshc: add binding for resets
Date: Wed, 10 Aug 2016 16:03:47 +0800
Message-ID: <1470816228-8874-2-git-send-email-guodong.xu@linaro.org>
References: <1470816228-8874-1-git-send-email-guodong.xu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1470816228-8874-1-git-send-email-guodong.xu@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: heiko@sntech.de, shawn.lin@rock-chips.com, jh80.chung@samsung.com, robh+dt@kernel.org, mark.rutland@arm.com, ulf.hansson@linaro.org, guodong.xu@linaro.org
Cc: devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Add resets property to synopsys-dw-mshc bindings. It is intended to
represent the hardware reset signal present internally in some host
controller IC designs.

See Documentation/devicetree/bindings/reset/reset.txt for details.

Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
index 8636f5a..4e00e85 100644
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
 
-- 
1.9.1
