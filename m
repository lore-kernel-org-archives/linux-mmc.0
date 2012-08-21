From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH] mmc: dt: Add 'broken-cd' DT binding
Date: Tue, 21 Aug 2012 16:39:31 +0530
Message-ID: <1345547371-6784-2-git-send-email-thomas.abraham@linaro.org>
References: <1345547371-6784-1-git-send-email-thomas.abraham@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:35163 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756566Ab2HUKwE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Aug 2012 06:52:04 -0400
In-reply-to: <1345547371-6784-1-git-send-email-thomas.abraham@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: linux-samsung-soc@vger.kernel.org, cjb@laptop.org, arnd@arndb.de, grant.likely@secretlab.ca, rob.herring@calxeda.com, patches@linaro.org

'broken-cd' binding lets mmc controller device node to indicate that
the card detect line is broken.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
The 'broken-cd' DT binding for MMC controllers is picked up from the OLPC
project git repo and was originally conceived by Chris Ball <cjb@laptop.org>.

 Documentation/devicetree/bindings/mmc/mmc.txt |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index 8a6811f..1aa527a 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -16,6 +16,8 @@ Optional properties:
 - wp-inverted: when present, polarity on the wp gpio line is inverted
 - non-removable: non-removable slot (like eMMC)
 - max-frequency: maximum operating clock frequency
+- broken-cd: when present, indicates that the cd-gpios line is not
+	connected to the card-detect pad of the MMC host controller.
 
 Example:
 
-- 
1.6.6.rc2

