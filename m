From: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Subject: [PATCH] mmc: include linux/types.h for bool definition in atmel-mci.h
Date: Thu,  7 Aug 2014 15:14:06 +0200
Message-ID: <1407417246-29709-1-git-send-email-egtvedt@samfundet.no>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from vuizook.err.no ([178.255.151.162]:37270 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757518AbaHGNj5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 7 Aug 2014 09:39:57 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ludovic.desroches@atmel.com
Cc: Hans-Christian Egtvedt <egtvedt@samfundet.no>

This patch adds an include of linux/types.h to make sure bool is defined
before utilized in this header file.

Signed-off-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>
---
 include/linux/atmel-mci.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/atmel-mci.h b/include/linux/atmel-mci.h
index 4c7a4b2..91b77f8 100644
--- a/include/linux/atmel-mci.h
+++ b/include/linux/atmel-mci.h
@@ -1,6 +1,8 @@
 #ifndef __LINUX_ATMEL_MCI_H
 #define __LINUX_ATMEL_MCI_H
 
+#include <linux/types.h>
+
 #define ATMCI_MAX_NR_SLOTS	2
 
 /**
-- 
1.9.1

