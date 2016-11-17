From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCHv3 9/9] Documentation: synopsys-dw-mshc: remove the unused
 properties
Date: Thu, 17 Nov 2016 16:40:41 +0900
Message-ID: <20161117074041.8641-10-jh80.chung@samsung.com>
References: <20161117074041.8641-1-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:53472 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752461AbcKQHlD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Nov 2016 02:41:03 -0500
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OGR0271EZZVAM70@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 17 Nov 2016 16:40:43 +0900 (KST)
In-reply-to: <20161117074041.8641-1-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, shawn.lin@rock-chips.com, adrian.hunter@intel.com, Jaehoon Chung <jh80.chung@samsung.com>

"support-highspeed" was the obsoleted property.
And "broken-cd" is not synopsys specific property.
It can be referred to mmc.txt binding Documentation.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
---
 Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
index 1279a22..7fd17c3 100644
--- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
@@ -75,11 +75,6 @@ Optional properties:
 * card-detect-delay: Delay in milli-seconds before detecting card after card
   insert event. The default value is 0.
 
-* supports-highspeed (DEPRECATED): Enables support for high speed cards (up to 50MHz)
-			   (use "cap-mmc-highspeed" or "cap-sd-highspeed" instead)
-
-* broken-cd: as documented in mmc core bindings.
-
 * vmmc-supply: The phandle to the regulator to use for vmmc.  If this is
   specified we'll defer probe until we can find this regulator.
 
-- 
2.10.1

