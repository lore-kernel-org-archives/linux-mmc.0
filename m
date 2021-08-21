Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFBCC4338F
	for <linux-mmc@archiver.kernel.org>; Sat, 21 Aug 2021 21:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88D476125F
	for <linux-mmc@archiver.kernel.org>; Sat, 21 Aug 2021 21:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhHUVR6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 21 Aug 2021 17:17:58 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:45952 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbhHUVR6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 21 Aug 2021 17:17:58 -0400
Received: from pop-os.home ([90.126.253.178])
        by mwinf5d69 with ME
        id kMHG250033riaq203MHGPS; Sat, 21 Aug 2021 23:17:17 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 21 Aug 2021 23:17:17 +0200
X-ME-IP: 90.126.253.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     maximlevitsky@gmail.com, oakad@yahoo.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] memstick: r592: Change the name of the 'pci_driver' structure to be consistent
Date:   Sat, 21 Aug 2021 23:17:15 +0200
Message-Id: <258f76acc73d5c448b9cb5dab4c39d80d517c7a9.1629580585.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This driver is all about r592.

Axe the reference to r852 in the 'pci_driver' structure name. This is
likely a copy/paste typo left as is when the driver has been created.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/memstick/host/r592.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/memstick/host/r592.c b/drivers/memstick/host/r592.c
index 7ed984360349..e79a0218c492 100644
--- a/drivers/memstick/host/r592.c
+++ b/drivers/memstick/host/r592.c
@@ -876,7 +876,7 @@ static SIMPLE_DEV_PM_OPS(r592_pm_ops, r592_suspend, r592_resume);
 
 MODULE_DEVICE_TABLE(pci, r592_pci_id_tbl);
 
-static struct pci_driver r852_pci_driver = {
+static struct pci_driver r592_pci_driver = {
 	.name		= DRV_NAME,
 	.id_table	= r592_pci_id_tbl,
 	.probe		= r592_probe,
@@ -884,7 +884,7 @@ static struct pci_driver r852_pci_driver = {
 	.driver.pm	= &r592_pm_ops,
 };
 
-module_pci_driver(r852_pci_driver);
+module_pci_driver(r592_pci_driver);
 
 module_param_named(enable_dma, r592_enable_dma, bool, S_IRUGO);
 MODULE_PARM_DESC(enable_dma, "Enable usage of the DMA (default)");
-- 
2.30.2

