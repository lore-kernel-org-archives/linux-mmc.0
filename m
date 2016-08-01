From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 1/1] mmc: core: Add the vmmc/vmmcq regulator info
Date: Mon,  1 Aug 2016 10:22:11 +0100
Message-ID: <1470043331-5123-1-git-send-email-ben.dooks@codethink.co.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 82-70-136-246.dsl.in-addr.zen.co.uk ([82.70.136.246]:36768 "EHLO
	rainbowdash.ducie.codethink.co.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751026AbcHAJYl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Aug 2016 05:24:41 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, galak@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kernel@lists.codethink.co.uk, linux-mmc@vger.kernel.org
Cc: Ben Dooks <ben.dooks@codethink.co.uk>

The core MMC code adds two (optional) regulator properites that drivers
should use to get their supplies. This is not documented anywhere so add
information on it.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 Documentation/devicetree/bindings/mmc/mmc.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index ed23b9b..8cbcbce 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -71,6 +71,17 @@ Optional SDIO properties:
 - wakeup-source: Enables wake up of host system on SDIO IRQ assertion
 		 (Legacy property supported: "enable-sdio-wakeup")
 
+MMC power
+---------
+
+Controllers may implement power control from both the connected cards and
+the IO signaling (for example to change to high-speed 1.8V signalling). If
+the system supports this, then the following two properties should point
+to valid regulator nodes:
+
+- vqmmc-supply: supply node for IO line power
+- vmmc-supply: supply node for card's power
+
 
 MMC power sequences:
 --------------------
-- 
2.8.1

