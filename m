From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH V2 3/3] MAINTAINERS: mmc: Cleanup MMC/SD/SDIO section and SDHCI driver section
Date: Fri, 13 Mar 2015 15:48:35 +0100
Message-ID: <1426258115-11801-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:41057 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753568AbbCMOsl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Mar 2015 10:48:41 -0400
Received: by lbvp9 with SMTP id p9so23281761lbv.8
        for <linux-mmc@vger.kernel.org>; Fri, 13 Mar 2015 07:48:40 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>

As Chris Ball has moved on to other assignments, he's no longer able to
help me maintain MMC. Let's remove him from the MMC sections in
MAINTAINERS and add him to CREDIT file.

This also affects the SDHCI DRIVER section, since its state now becomes
orphan.

Cc: Chris Ball <chris@printf.net>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 CREDITS     | 4 ++++
 MAINTAINERS | 6 +-----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/CREDITS b/CREDITS
index 96935df..843e176 100644
--- a/CREDITS
+++ b/CREDITS
@@ -187,6 +187,10 @@ N: Krishna Balasubramanian
 E: balasub@cis.ohio-state.edu
 D: Wrote SYS V IPC (part of standard kernel since 0.99.10)
 
+N: Chris Ball
+E: chris@printf.net
+D: Former maintainer of the MMC/SD/SDIO subsystem.
+
 N: Dario Ballabio
 E: ballabio_dario@emc.com
 E: dario.ballabio@tiscalinet.it
diff --git a/MAINTAINERS b/MAINTAINERS
index 582b4b4..50479c8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6547,10 +6547,8 @@ F:	drivers/mfd/
 F:	include/linux/mfd/
 
 MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND SDIO SUBSYSTEM
-M:	Chris Ball <chris@printf.net>
 M:	Ulf Hansson <ulf.hansson@linaro.org>
 L:	linux-mmc@vger.kernel.org
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git
 T:	git git://git.linaro.org/people/ulf.hansson/mmc.git
 S:	Maintained
 F:	drivers/mmc/
@@ -8650,10 +8648,8 @@ S:	Maintained
 F:	drivers/mmc/host/sdricoh_cs.c
 
 SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) DRIVER
-M:	Chris Ball <chris@printf.net>
 L:	linux-mmc@vger.kernel.org
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git
-S:	Maintained
+S:	Orphan
 F:	drivers/mmc/host/sdhci.*
 F:	drivers/mmc/host/sdhci-pltfm.[ch]
 
-- 
1.9.1

