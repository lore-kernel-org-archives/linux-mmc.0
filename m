From: Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH v3 9/9] Documentation: document mmci STM32 DT binding
Date: Mon, 16 Jan 2017 08:37:18 +0100
Message-ID: <1484552238-23171-10-git-send-email-andrea.merello@gmail.com>
References: <1484552238-23171-1-git-send-email-andrea.merello@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34767 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751472AbdAPHh6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jan 2017 02:37:58 -0500
Received: by mail-wm0-f68.google.com with SMTP id c85so28594982wmi.1
        for <linux-mmc@vger.kernel.org>; Sun, 15 Jan 2017 23:37:53 -0800 (PST)
In-Reply-To: <1484552238-23171-1-git-send-email-andrea.merello@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc: linux-mmc@vger.kernel.org, bruherrera@gmail.com, Andrea Merello <andrea.merello@gmail.com>

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

