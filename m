From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH 2/3] MAINTAINERS: remove atmel-mci-regs.h file
Date: Mon, 23 Nov 2015 16:27:31 +0100
Message-ID: <1448292452-5786-2-git-send-email-ludovic.desroches@atmel.com>
References: <1448292452-5786-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448292452-5786-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.ferre@atmel.com, Ludovic Desroches <ludovic.desroches@atmel.com>
List-Id: linux-mmc@vger.kernel.org

Remove atmel-mci-regs.h file since it has been merged in atmel-mci.c.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b2ab9fc..1df3df3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1904,7 +1904,6 @@ ATMEL AT91 / AT32 MCI DRIVER
 M:	Ludovic Desroches <ludovic.desroches@atmel.com>
 S:	Maintained
 F:	drivers/mmc/host/atmel-mci.c
-F:	drivers/mmc/host/atmel-mci-regs.h
 
 ATMEL AT91 / AT32 SERIAL DRIVER
 M:	Nicolas Ferre <nicolas.ferre@atmel.com>
-- 
2.5.0
