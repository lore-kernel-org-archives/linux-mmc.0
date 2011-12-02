From: Qiang Liu <b32616@freescale.com>
Subject: [PATCH] mmc/doc: feature description of runtime bounce buffer size adjustment
Date: Fri, 2 Dec 2011 11:17:18 +0800
Message-ID: <1322795838-17213-1-git-send-email-b32616@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:26705 "EHLO
	TX2EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756485Ab1LBDuy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Dec 2011 22:50:54 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org
Cc: leoli@freescale.com, Qiang Liu <b32616@freescale.com>, Qiang Liu <qiang.liu@freescale.com>

Add feature description about runtime bounce buffer size adjustment.

CC: Chris Ball <cjb@laptop.org>
Signed-off-by: Qiang Liu <qiang.liu@freescale.com>
---
Per Chris's request add description in mmc document.

 Documentation/mmc/mmc-dev-attrs.txt |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Documentation/mmc/mmc-dev-attrs.txt b/Documentation/mmc/mmc-dev-attrs.txt
index 8898a95..5e1f47b 100644
--- a/Documentation/mmc/mmc-dev-attrs.txt
+++ b/Documentation/mmc/mmc-dev-attrs.txt
@@ -7,6 +7,8 @@ SD or MMC device.
 The following attributes are read/write.

 	force_ro		Enforce read-only access even if write protect switch is off.
+	bouncesz		Support dynamic adjustment of bounce buffer size at runtime,
+				from 4096 to 4194304 only.

 SD and MMC Device Attributes
 ============================
--
1.6.4


