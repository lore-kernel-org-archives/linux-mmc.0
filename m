From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/3] MAINTAINERS: mmc: Remove the SDHCI-OF section
Date: Fri, 13 Mar 2015 13:51:48 +0100
Message-ID: <1426251108-10926-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-kernel@vger.kernel.org, Anton Vorontsov <anton@enomsg.org>
List-Id: linux-mmc@vger.kernel.org

Anton told me that he isn't maintaing the SDHCI-OF parts anymore, so
let's remove him from this section to avoid confusion.

Morover, since the SDHCI-OF section overlaps with the SDHCI DRIVER
section, let's just remove it completely.

Cc: Anton Vorontsov <anton@enomsg.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 78a22aa..582b4b4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8669,13 +8669,6 @@ F:	include/linux/seccomp.h
 K:	\bsecure_computing
 K:	\bTIF_SECCOMP\b
 
-SECURE DIGITAL HOST CONTROLLER INTERFACE, OPEN FIRMWARE BINDINGS (SDHCI-OF)
-M:	Anton Vorontsov <anton@enomsg.org>
-L:	linuxppc-dev@lists.ozlabs.org
-L:	linux-mmc@vger.kernel.org
-S:	Maintained
-F:	drivers/mmc/host/sdhci-pltfm.[ch]
-
 SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) SAMSUNG DRIVER
 M:	Ben Dooks <ben-linux@fluff.org>
 L:	linux-mmc@vger.kernel.org
-- 
1.9.1
