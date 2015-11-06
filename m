From: Al Cooper <alcooperx@gmail.com>
Subject: [PATCH V2 2/3] mmc: Add Device Tree binding supported by sdhci-pltfm.c
Date: Fri, 6 Nov 2015 13:56:03 -0500
Message-ID: <1446836164-16259-3-git-send-email-alcooperx@gmail.com>
References: <1446836164-16259-1-git-send-email-alcooperx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:31448 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753261AbbKFS4p (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Nov 2015 13:56:45 -0500
In-Reply-To: <1446836164-16259-1-git-send-email-alcooperx@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Cc: Al Cooper <alcooperx@gmail.com>

This includes both newly added and previously undocumented
properties.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 Documentation/devicetree/bindings/mmc/mmc.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index f693baf..516fdf9 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -48,6 +48,14 @@ Optional properties:
 - mmc-hs400-1_2v: eMMC HS400 mode(1.2V I/O) is supported
 - dsr: Value the card's (optional) Driver Stage Register (DSR) should be
   programmed with. Valid range: [0 .. 0xffff].
+- sdhci,auto-cmd12: the controller supports Auto-CMD12 to stop multiblock
+  transfers.
+- broken-64-bit-dma: the controller does not support 64-bit DMA even if
+  the controller claims it does.
+- broken-timeout-value: the timeout value specified by the controller is
+  incorrect and the MAX timeout will be used instead.
+- broken-sdr50: SDR50 mode is broken.
+- broken-ddr50: DDR50 mode is broken.
 
 *NOTE* on CD and WP polarity. To use common for all SD/MMC host controllers line
 polarity properties, we have to fix the meaning of the "normal" and "inverted"
-- 
1.9.0.138.g2de3478

