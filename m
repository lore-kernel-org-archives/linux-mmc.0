From: akpm@linux-foundation.org
Subject: [patch 10/20] s5pc110: SDHCI-s3c can override host capabilities
Date: Thu, 19 Aug 2010 14:13:34 -0700
Message-ID: <201008192113.o7JLDYM1008692@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58993 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751101Ab0HSVNj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Aug 2010 17:13:39 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, kyungmin.park@samsung.com, linux-mmc@vger.kernel.org

From: Kyungmin Park <kyungmin.park@samsung.com>

Each board can override the default sdhci host capabilities.
Some board has broken features by hardwares and support 8-bit bandwidth.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/arm/plat-samsung/dev-hsmmc.c  |    2 ++
 arch/arm/plat-samsung/dev-hsmmc1.c |    2 ++
 arch/arm/plat-samsung/dev-hsmmc2.c |    2 ++
 3 files changed, 6 insertions(+)

diff -puN arch/arm/plat-samsung/dev-hsmmc.c~s5pc110-sdhci-s3c-can-override-host-capabilities arch/arm/plat-samsung/dev-hsmmc.c
--- a/arch/arm/plat-samsung/dev-hsmmc.c~s5pc110-sdhci-s3c-can-override-host-capabilities
+++ a/arch/arm/plat-samsung/dev-hsmmc.c
@@ -70,4 +70,6 @@ void s3c_sdhci0_set_platdata(struct s3c_
 		set->cfg_gpio = pd->cfg_gpio;
 	if (pd->cfg_card)
 		set->cfg_card = pd->cfg_card;
+	if (pd->host_caps)
+		set->host_caps = pd->host_caps;
 }
diff -puN arch/arm/plat-samsung/dev-hsmmc1.c~s5pc110-sdhci-s3c-can-override-host-capabilities arch/arm/plat-samsung/dev-hsmmc1.c
--- a/arch/arm/plat-samsung/dev-hsmmc1.c~s5pc110-sdhci-s3c-can-override-host-capabilities
+++ a/arch/arm/plat-samsung/dev-hsmmc1.c
@@ -70,4 +70,6 @@ void s3c_sdhci1_set_platdata(struct s3c_
 		set->cfg_gpio = pd->cfg_gpio;
 	if (pd->cfg_card)
 		set->cfg_card = pd->cfg_card;
+	if (pd->host_caps)
+		set->host_caps = pd->host_caps;
 }
diff -puN arch/arm/plat-samsung/dev-hsmmc2.c~s5pc110-sdhci-s3c-can-override-host-capabilities arch/arm/plat-samsung/dev-hsmmc2.c
--- a/arch/arm/plat-samsung/dev-hsmmc2.c~s5pc110-sdhci-s3c-can-override-host-capabilities
+++ a/arch/arm/plat-samsung/dev-hsmmc2.c
@@ -71,4 +71,6 @@ void s3c_sdhci2_set_platdata(struct s3c_
 		set->cfg_gpio = pd->cfg_gpio;
 	if (pd->cfg_card)
 		set->cfg_card = pd->cfg_card;
+	if (pd->host_caps)
+		set->host_caps = pd->host_caps;
 }
_
