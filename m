Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FF6C4321E
	for <linux-mmc@archiver.kernel.org>; Tue, 19 Apr 2022 13:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345574AbiDSNow (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 Apr 2022 09:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbiDSNn2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Apr 2022 09:43:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5885324F;
        Tue, 19 Apr 2022 06:40:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA3C661693;
        Tue, 19 Apr 2022 13:40:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F781C385AF;
        Tue, 19 Apr 2022 13:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650375645;
        bh=LP9bbU3MqE1mo0qlsHP17AGtQ9utDR1mCwd3GRyFRr4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M/YHCSpeMYgwnnRYACPWzb5HEoTcv0Uo+NjAgUJua+1h56xSW2dsYBRjZfK1E2BdW
         ufGtCxWaK9OFsPZeVaEUcov5M3hta5Q+TJb3cdQu3RTCCHtk2DsusHYPyQF7LJHnTI
         IL8FxI+oDR/0/IzsSioLFjIlnMk2NFJMoFJ3B6APAiFOTW85BTHE0LXGnXdGVfGd13
         wCsvqkLvGaTKrsfN+TZgA0RrRTWoDmZBdsDJObGLaggZ6D5MCMY5yAp86WDvGn4KIc
         1iB23i3dMqJKuazzVP/9pqxdegdyW0H0DLYhyKg4JgYtwpC2ocseM+UbPIVSebgCgU
         9Edk9oMYpOBkA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-omap@vger.kernel.org, tony@atomide.com, aaro.koskinen@iki.fi,
        jmkrzyszt@gmail.com
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Paul Walmsley <paul@pwsan.com>,
        Kevin Hilman <khilman@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Mark Brown <broonie@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-input@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-serial@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH 25/41] ARM: omap: remove empty plat-omap directory
Date:   Tue, 19 Apr 2022 15:37:07 +0200
Message-Id: <20220419133723.1394715-26-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220419133723.1394715-1-arnd@kernel.org>
References: <20220419133723.1394715-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The last file in this directory is gone, and it can be removed as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Makefile           | 1 -
 arch/arm/plat-omap/Makefile | 9 ---------
 2 files changed, 10 deletions(-)
 delete mode 100644 arch/arm/plat-omap/Makefile

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index a2391b8de5a5..7bcf59d0d315 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -228,7 +228,6 @@ machine-$(CONFIG_PLAT_SPEAR)		+= spear
 
 # Platform directory name.  This list is sorted alphanumerically
 # by CONFIG_* macro name.
-plat-$(CONFIG_ARCH_OMAP)	+= omap
 plat-$(CONFIG_PLAT_ORION)	+= orion
 plat-$(CONFIG_PLAT_PXA)		+= pxa
 plat-$(CONFIG_PLAT_VERSATILE)	+= versatile
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
deleted file mode 100644
index fefce2e1eaf3..000000000000
--- a/arch/arm/plat-omap/Makefile
+++ /dev/null
@@ -1,9 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-#
-# Makefile for the linux kernel.
-#
-
-ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/arch/arm/plat-omap/include
-
-# Common support
-obj-y :=
-- 
2.29.2

