From: ludovic.desroches@atmel.com
Subject: [PATCH v2 1/3] mmc: atmel-mci: correct data timeout computation
Date: Wed, 28 Mar 2012 12:28:33 +0200
Message-ID: <1332930513-14893-1-git-send-email-ludovic.desroches@atmel.com>
References: <1332344483-3915-2-git-send-email-ludovic.desroches@atmel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:62674 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752856Ab2C1Ia5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Mar 2012 04:30:57 -0400
In-Reply-To: <1332344483-3915-2-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: nicolas.ferre@atmel.com

From: Ludovic Desroches <ludovic.desroches@atmel.com>

The HSMCI operates at a rate of up to Master Clock divided by two.
Moreover previous calculation can cause overflows and so wrong
timeouts.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: stable <stable@vger.kernel.org>
---
 drivers/mmc/host/atmel-mci.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index e4449a5..3a57964 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -480,7 +480,14 @@ err:
 static inline unsigned int atmci_ns_to_clocks(struct atmel_mci *host,
 					unsigned int ns)
 {
-	return (ns * (host->bus_hz / 1000000) + 999) / 1000;
+	/*
+	 * It is easier here to use us instead of ns for the timeout,
+	 * it prevents from overflows during calculation.
+	 */
+	unsigned int us = DIV_ROUND_UP(ns, 1000);
+
+	/* Maximum clock frequency is host->bus_hz/2 */
+	return us * (DIV_ROUND_UP(host->bus_hz, 2000000));
 }
 
 static void atmci_set_timeout(struct atmel_mci *host,
-- 
1.7.5.4

