Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34F5C433F5
	for <linux-mmc@archiver.kernel.org>; Sun, 20 Mar 2022 12:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245078AbiCTMcF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 20 Mar 2022 08:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245060AbiCTMcD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 20 Mar 2022 08:32:03 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AB9EF0A5
        for <linux-mmc@vger.kernel.org>; Sun, 20 Mar 2022 05:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=3ILPiLcnboTMOH
        uy7FvFfWwBSSRJ9SzqY9VrCaJgArs=; b=ADp9idtrbhHnyEg00Lx8T6WVikwtco
        X0YrTc91YEBVEhz65gaatA/YBuIQ+Q6BDZgMcDcKFKI43V+XgBRzOTF8UG1xNIYS
        14eGS6lSW0j98bg3octBWavWQVWQ4zQO986emNfHAaTnTPikb2HuTmvbrL5m2ac5
        eGmYr0+cPqvCE=
Received: (qmail 461110 invoked from network); 20 Mar 2022 13:30:35 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Mar 2022 13:30:35 +0100
X-UD-Smtp-Session: l3s3148p1@pv/si6XafLkgAQnoAFbkANnMMFqLOUjD
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 1/6] mmc: renesas_sdhi: remove outdated headers
Date:   Sun, 20 Mar 2022 13:30:11 +0100
Message-Id: <20220320123016.57991-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220320123016.57991-1-wsa+renesas@sang-engineering.com>
References: <20220320123016.57991-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

We moved quirk handling out of the SDHI core to the individual drivers.
So, no need to include headers needed for soc_device_match et al.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/renesas_sdhi_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 2797a9c0f17d..fe63548d816d 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -27,7 +27,6 @@
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/slot-gpio.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/pinctrl/pinctrl-state.h>
 #include <linux/platform_device.h>
@@ -36,7 +35,6 @@
 #include <linux/reset.h>
 #include <linux/sh_dma.h>
 #include <linux/slab.h>
-#include <linux/sys_soc.h>
 
 #include "renesas_sdhi.h"
 #include "tmio_mmc.h"
-- 
2.30.2

