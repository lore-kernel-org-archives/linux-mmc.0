From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v2 3/7] mmc: mediatek: build as module
Date: Thu, 18 Jun 2015 17:47:49 +0530
Message-ID: <1434629873-11668-4-git-send-email-sudipm.mukherjee@gmail.com>
References: <1434629873-11668-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:35032 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932273AbbFRMSc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Jun 2015 08:18:32 -0400
In-Reply-To: <1434629873-11668-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Howells <dhowells@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-am33-list@redhat.com, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-usb@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

while building as module with mn10300 it failed with:

warning: data definition has no type or storage class
	module_init(__driver##_init);

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/mmc/host/mtk-sd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 7c20f28..ea6ae36 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -33,6 +33,7 @@
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/sd.h>
 #include <linux/mmc/sdio.h>
+#include <linux/module.h>
 
 #define MAX_BD_NUM          1024
 
-- 
1.8.1.2

