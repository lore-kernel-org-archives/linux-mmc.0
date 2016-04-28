From: Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 1/3] Documentation: mmc: Document mmc aliases
Date: Thu, 28 Apr 2016 16:06:43 -0700
Message-ID: <1461884805-29466-2-git-send-email-dianders@chromium.org>
References: <1461884805-29466-1-git-send-email-dianders@chromium.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33094 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668AbcD1XHd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Apr 2016 19:07:33 -0400
Received: by mail-pa0-f47.google.com with SMTP id zm5so42141273pac.0
        for <linux-mmc@vger.kernel.org>; Thu, 28 Apr 2016 16:07:33 -0700 (PDT)
In-Reply-To: <1461884805-29466-1-git-send-email-dianders@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, jh80.chung@samsung.com
Cc: shawn.lin@rock-chips.com, adrian.hunter@intel.com, stefan@agner.ch, linux-mmc@vger.kernel.org, computersforpeace@gmail.com, dmitry.torokhov@gmail.com, Douglas Anderson <dianders@chromium.org>, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, chaotian.jing@mediatek.com, sudeep.holla@arm.com, lars@metafoo.de, huangtao@rock-chips.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

From: Jaehoon Chung <jh80.chung@samsung.com>

Now, index of mmc/mmcblk devices is allocated in accordance with probing
time.  If want to use the mmcblk1 for some device, it can use alias.

aliases {
	mmc0 = &mmc0;	/* mmc0/mmcblk0 for eMMC */
	mmc1 = &mmc2;	/* mmc1/mmcblk1 for SD */
	mmc2 = &mmc1;	/* mmc2/mmcblk2 for SDIO*/
};

If there are no corresponding values, it might be allocated with
existing scheme.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
[dianders: just bindings now; mention mmc not just mmcblk]
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
 Documentation/devicetree/bindings/mmc/mmc.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index a1ed9c4e7235..d225a7fb3849 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -72,6 +72,10 @@ Optional SDIO properties:
 - wakeup-source: Enables wake up of host system on SDIO IRQ assertion
 		 (Legacy property supported: "enable-sdio-wakeup")
 
+Aliases (Optional):
+- If you want to use the fixed index for devices like mmcX / mmcblkX, should
+be represented in the aliases node using following format "mmc(X)".
+(X is an unique number for the alias.)
 
 MMC power sequences:
 --------------------
@@ -146,3 +150,10 @@ mmc3: mmc@01c12000 {
 		interrupt-names = "host-wake";
 	};
 };
+
+Example with aliases nodes:
+
+aliases {
+	mmc0 = &mmc0;	/* Fixed to mmc0/mmcblk0 for &mmc0 */
+	mmc1 = &mmc2;	/* Fixed to mmc1/mmcblk1 for &mmc2 */
+};
-- 
2.8.0.rc3.226.g39d4020

