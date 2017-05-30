From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH 1/5] MAINTAINERS: Update files for TMIO/SDHI MMC driver
Date: Tue, 30 May 2017 14:50:50 +0200
Message-ID: <1496148654-20386-2-git-send-email-horms+renesas@verge.net.au>
References: <1496148654-20386-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1496148654-20386-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

Update files for tmio/sdhi MMC driver to reflect recent filename
changes.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 053c3bdd1fe5..5b4c477573dd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12882,7 +12882,7 @@ M:	Wolfram Sang <wsa+renesas@sang-engineering.com>
 L:	linux-mmc@vger.kernel.org
 S:	Supported
 F:	drivers/mmc/host/tmio_mmc*
-F:	drivers/mmc/host/sh_mobile_sdhi.c
+F:	drivers/mmc/host/renesas_sdhi*
 F:	include/linux/mfd/tmio.h
 
 TMP401 HARDWARE MONITOR DRIVER
-- 
2.1.4
