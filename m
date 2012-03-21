From: ludovic.desroches@atmel.com
Subject: [PATCH 1/3] mmc: atmel-mci: correct data timeout computation
Date: Wed, 21 Mar 2012 16:41:21 +0100
Message-ID: <1332344483-3915-2-git-send-email-ludovic.desroches@atmel.com>
References: <1332344483-3915-1-git-send-email-ludovic.desroches@atmel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:39169 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754359Ab2CUNm4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Mar 2012 09:42:56 -0400
In-Reply-To: <1332344483-3915-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: nicolas.ferre@atmel.com, ludovic.desroches@atmel.com, plagnioj@jcrosoft.com

From: Ludovic Desroches <ludovic.desroches@atmel.com>

The HSMCI operates at a rate of up to Master Clock divided by two.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/mmc/host/atmel-mci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index e4449a5..e161452 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -480,7 +480,7 @@ err:
 static inline unsigned int atmci_ns_to_clocks(struct atmel_mci *host,
 					unsigned int ns)
 {
-	return (ns * (host->bus_hz / 1000000) + 999) / 1000;
+	return (ns * ((host->bus_hz/2) / 1000000) + 999) / 1000;
 }
 
 static void atmci_set_timeout(struct atmel_mci *host,
-- 
1.7.5.4

