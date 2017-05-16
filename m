From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 1/2] dt-bindings: rockchip-dw-mshc: add optional rockchip,desired-num-phases
Date: Tue, 16 May 2017 14:28:53 +0800
Message-ID: <1494916134-68043-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:43530 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751027AbdEPGa3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 16 May 2017 02:30:29 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Ziyuan Xu <xzy.xu@rock-chips.com>, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

By default, dw_mmc-rockchip will execute tuning for each degree.
So we won't miss every point of the good sample windows. However,
probably the phases are linear inside the good sample window.
Actually we don't need to do tuning for each degree so that we could
save some time, for instance, probe the driver or resume from S3.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v2:
- rename to rockchip,desired-num-phases

 Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
index 520d61d..e5800f2 100644
--- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
@@ -31,6 +31,10 @@ Optional Properties:
   probing, low speeds or in case where all phases work at tuning time.
   If not specified 0 deg will be used.
 
+* rockchip,desired-num-phases: The desired number of times that the host
+  execute tuning when needed. If not specified, the host will do tuning
+  for 360 times, namely tuning for each degree.
+
 Example:
 
 	rkdwmmc0@12200000 {
-- 
1.9.1


