Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF67C46467
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Jan 2023 11:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjAPLXT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Jan 2023 06:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjAPLXS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jan 2023 06:23:18 -0500
X-Greylist: delayed 495 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 16 Jan 2023 03:23:17 PST
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [176.9.242.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474081DB9A
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jan 2023 03:23:16 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id 1E777101E6B4B;
        Mon, 16 Jan 2023 12:14:43 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id BE0C7603DB87;
        Mon, 16 Jan 2023 12:14:32 +0100 (CET)
X-Mailbox-Line: From 8bb3d7c3a36985e030ba40e853c57578de8fb303 Mon Sep 17 00:00:00 2001
Message-Id: <8bb3d7c3a36985e030ba40e853c57578de8fb303.1673866725.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Mon, 16 Jan 2023 12:14:30 +0100
Subject: [PATCH] mmc: pwrseq_sd8787: Allow being built-in irrespective of
 dependencies
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org,
        Matt Ranostay <matt@ranostay.consulting>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

pwrseq_sd8787 is forced to be built as a module if its dependencies are.

That's unnecessary, it's perfectly fine for it to be built-in even
though the wireless drivers that need it are modules.

Relax the depends definition in Kconfig accordingly.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Matt Ranostay <matt@ranostay.consulting>
Cc: Lubomir Rintel <lkundrak@v3.sk>
Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/mmc/core/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
index 6f25c34e4fec..e9e9d31b39b4 100644
--- a/drivers/mmc/core/Kconfig
+++ b/drivers/mmc/core/Kconfig
@@ -15,7 +15,7 @@ config PWRSEQ_EMMC
 
 config PWRSEQ_SD8787
 	tristate "HW reset support for SD8787 BT + Wifi module"
-	depends on OF && (MWIFIEX || BT_MRVL_SDIO || LIBERTAS_SDIO || WILC1000_SDIO)
+	depends on OF && (MWIFIEX != n || BT_MRVL_SDIO != n || LIBERTAS_SDIO != n || WILC1000_SDIO != n)
 	help
 	  This selects hardware reset support for the SD8787 BT + Wifi
 	  module. By default this option is set to n.
-- 
2.39.0

