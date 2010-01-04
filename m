From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH] MMC: Atmel host kconfig cleanup for everyone else
Date: Mon, 04 Jan 2010 16:38:32 +0000
Message-ID: <4B421988.4020508@cam.ac.uk>
References: <4B42156E.3050103@cam.ac.uk> <4B421685.8010306@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:54382 "EHLO
	ppsw-0.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753420Ab0ADQic (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Jan 2010 11:38:32 -0500
In-Reply-To: <4B421685.8010306@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-mmc@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---

 This prevents those without an Atmel chip having a line in
 menuconfig etc which says "Atmel SD/MMC Driver" without any
 options.

 drivers/mmc/host/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index e04b751..17ef22f 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -162,6 +162,7 @@ config MMC_AU1X
 
 choice
 	prompt "Atmel SD/MMC Driver"
+	depends on AVR32 || ARCH_AT91
 	default MMC_ATMELMCI if AVR32
 	help
 	  Choose which driver to use for the Atmel MCI Silicon
-- 
1.6.4.4

