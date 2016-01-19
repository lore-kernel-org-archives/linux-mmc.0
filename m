From: P L Sai Krishna <lakshmi.sai.krishna.potthuri@xilinx.com>
Subject: [LINUX PATCH 4/5] Documentation: mmc: Updated the binding doc for
 Arasan SDHCI.
Date: Tue, 19 Jan 2016 19:47:34 +0530
Message-ID: <1453213055-35563-4-git-send-email-lakshmis@xilinx.com>
References: <1453213055-35563-1-git-send-email-lakshmis@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1453213055-35563-1-git-send-email-lakshmis@xilinx.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Michal Simek <michal.simek@xilinx.com>, Soren Brinkmann <soren.brinkmann@xilinx.com>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hao <haokexin@gmail.com>, Emil Lenchak <emill@xilinx.com>, Tobias Klauser <tklauser@distanz.ch>, Sudeep Holla <Sudeep.Holla@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, Jisheng Zhang <jszhang@marvell.com>, "Ivan T.
 Ivanov" <ivan.ivanov@linaro.org>, Scott Branden <sbranden@broadcom.com>, Vincent Yang <vincent.yang.fujitsu@gmail.com>, Haibo Chen <haibo.chen@freescale.com>, Marek Vasut <marex@denx.de>, "ludovic.desroches@atmel.com" <ludovic.desroches@atmel.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar
 Gala <galak@codeaurora.org>, Suman Tripathi <stripathi@apm.com>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: devicetree@vger.kernel.org, Harini Katakam <harinik@xilinx.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, P L Sai Krishna <lakshmis@xilinx.com>, Anirudha Sarangi <anirudh@xilinx.com>, Punnaiah Choudary Kalluri <punnaia@xilinx.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

This patch adds broken-mmc-highspeed property to the binding
doc for Arasan SDHCI.

Signed-off-by: P L Sai Krishna <lakshmis@xilinx.com>
---
 Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
index 2088d9f..5884832 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
@@ -20,7 +20,8 @@ Required Properties:
 Optional Properties:
   - broken-tuning: Indicates tuning broken in Silicon 1.0 of
 			  Zynq Ultrascale+ MPSoC.
-
+  - broken-mmc-highspeed: Indicates to force
+				the controller to use in standard speed.
 Example:
 	sdhci@e0100000 {
 		compatible = "arasan,sdhci-8.9a";
-- 
2.1.2
