From: Richard Zhu <Hong-Xing.Zhu@freescale.com>
Subject: [PATCH V6 2/4] mmc: add the abort CMDTYE bits definition
Date: Tue, 8 Mar 2011 10:55:34 +0800
Message-ID: <1299552936-17202-2-git-send-email-Hong-Xing.Zhu@freescale.com>
References: <1299552936-17202-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:29225 "EHLO
	TX2EHSOBE008.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754459Ab1CHC4K (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Mar 2011 21:56:10 -0500
In-Reply-To: <1299552936-17202-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: kernel@pengutronix.de, linux-mmc@vger.kernel.org, cjb@laptop.org, avorontsov@ru.mvista.com, eric@eukrea.com, w.sang@pengutronix.de, linuxzsc@gmail.com, richard.zhao@freescale.com, eric.miao@linaro.org, Richard Zhu <Hong-Xing.Zhu@freescale.com>

Add the abort CMDTYPE bits definition of command register (offset 0xE)

Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>
---
 drivers/mmc/host/sdhci.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 6e0969e..25e8bde 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -45,6 +45,7 @@
 #define  SDHCI_CMD_CRC		0x08
 #define  SDHCI_CMD_INDEX	0x10
 #define  SDHCI_CMD_DATA		0x20
+#define  SDHCI_CMD_ABORTCMD	0xC0
 
 #define  SDHCI_CMD_RESP_NONE	0x00
 #define  SDHCI_CMD_RESP_LONG	0x01
-- 
1.7.1


