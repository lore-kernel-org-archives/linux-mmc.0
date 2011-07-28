From: ludovic.desroches@atmel.com
Subject: [RFC PATCH 6/9] atmel_pdc: add ATMEL_PDC_SCND_BUF_OFF
Date: Thu, 28 Jul 2011 16:29:55 +0200
Message-ID: <1311863398-31579-7-git-send-email-ludovic.desroches@atmel.com>
References: <1311863398-31579-1-git-send-email-ludovic.desroches@atmel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:34979 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755394Ab1G1NYI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Jul 2011 09:24:08 -0400
In-Reply-To: <1311863398-31579-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: patrice.vilchez@atmel.com, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, Ludovic Desroches <ludovic.desroches@atmel.com>

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Add define for the offset value between first and second buffer registers.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 include/linux/atmel_pdc.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/linux/atmel_pdc.h b/include/linux/atmel_pdc.h
index 5058a31..63499ce 100644
--- a/include/linux/atmel_pdc.h
+++ b/include/linux/atmel_pdc.h
@@ -33,4 +33,6 @@
 
 #define ATMEL_PDC_PTSR		0x124	/* Transfer Status Register */
 
+#define ATMEL_PDC_SCND_BUF_OFF	0x10	/* Offset between first and second buffer registers */
+
 #endif
-- 
1.7.0.4

