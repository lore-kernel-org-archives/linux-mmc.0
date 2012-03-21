From: ludovic.desroches@atmel.com
Subject: [PATCH 2/3] mmc: atmel-mci: r/w proof capability only available since v2xx
Date: Wed, 21 Mar 2012 16:41:22 +0100
Message-ID: <1332344483-3915-3-git-send-email-ludovic.desroches@atmel.com>
References: <1332344483-3915-1-git-send-email-ludovic.desroches@atmel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:46445 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755708Ab2CUNmz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Mar 2012 09:42:55 -0400
In-Reply-To: <1332344483-3915-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: nicolas.ferre@atmel.com, ludovic.desroches@atmel.com, plagnioj@jcrosoft.com

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/mmc/host/atmel-mci.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index e161452..9dcb236 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2009,6 +2009,8 @@ static void __init atmci_get_cap(struct atmel_mci *host)
 	/* keep only major version number */
 	switch (version & 0xf00) {
 	case 0x100:
+		host->caps.has_pdc = 1;
+		break;
 	case 0x200:
 		host->caps.has_pdc = 1;
 		host->caps.has_rwproof = 1;
-- 
1.7.5.4

