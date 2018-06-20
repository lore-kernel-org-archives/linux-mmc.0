From: Helmut Grohne <h.grohne@intenta.de>
Subject: [PATCH v3 1/2] dt-bindings: mmc: broken clock stable indicator on
 arasan controllers
Date: Wed, 20 Jun 2018 13:32:51 +0200
Message-ID: <12953dbf9af1f1a71aaf3ef77782e56a2a7ad893.1529493667.git.h.grohne@intenta.de>
References: <20180615081830.zrgx6arwn6ga27gu@laureti-dev>
 <cover.1529493667.git.h.grohne@intenta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <cover.1529493667.git.h.grohne@intenta.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Adrian Hunter <adrian.hunter@intel.com>, Michal Simek <michal.simek@xilinx.com>, =?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
Cc: Atul Garg <agarg@arasan.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Some controllers immediately report that their internal clock is stable
after activating it even when the clock is not stable. When used in
conjunction with older/slower cards, this can result in:

    mmc0: error -84 whilst initialising SD card

This flag allows documenting and thus working around such a hardware
defect.

Signed-off-by: Helmut Grohne <h.grohne@intenta.de>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
index 60481bfc3d31..28332b655d2e 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
@@ -39,6 +39,8 @@ Optional Properties:
   - xlnx,fails-without-test-cd: when present, the controller doesn't work when
     the CD line is not connected properly, and the line is not connected
     properly. Test mode can be used to force the controller to function.
+  - xlnx,int-clock-stable-broken: when present, the controller always reports
+    that the internal clock is stable even when it is not.
 
 Example:
 	sdhci@e0100000 {
-- 
2.11.0
