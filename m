From: Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH 9/9] Documentation: document mmci STM32 DT binding
Date: Tue,  8 Nov 2016 14:43:45 +0100
Message-ID: <1478612625-23256-10-git-send-email-andrea.merello@gmail.com>
References: <1478612625-23256-1-git-send-email-andrea.merello@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36683 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752565AbcKHNoc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Nov 2016 08:44:32 -0500
Received: by mail-wm0-f68.google.com with SMTP id c17so22668825wmc.3
        for <linux-mmc@vger.kernel.org>; Tue, 08 Nov 2016 05:44:32 -0800 (PST)
In-Reply-To: <1478612625-23256-1-git-send-email-andrea.merello@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc: linux-mmc@vger.kernel.org, Andrea Merello <andrea.merello@gmail.com>

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
---
 Documentation/devicetree/bindings/mmc/mmci.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmci.txt b/Documentation/devicetree/bindings/mmc/mmci.txt
index 03796cf..d6b5127 100644
--- a/Documentation/devicetree/bindings/mmc/mmci.txt
+++ b/Documentation/devicetree/bindings/mmc/mmci.txt
@@ -8,7 +8,7 @@ by mmc.txt and the properties used by the mmci driver. Using "st" as
 the prefix for a property, indicates support by the ST Micro variant.
 
 Required properties:
-- compatible             : contains "arm,pl18x", "arm,primecell".
+- compatible             : contains "arm,pl18x", "arm,primecell" or "st,stm32f4xx-sdio"
 - vmmc-supply            : phandle to the regulator device tree node, mentioned
                            as the VCC/VDD supply in the eMMC/SD specs.
 
-- 
2.7.4

