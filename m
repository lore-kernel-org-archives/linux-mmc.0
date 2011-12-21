From: Qiang Liu <b32616@freescale.com>
Subject: [PATCH V2 2/2] mmc/doc: feature description of runtime bounce buffer size adjustment
Date: Wed, 21 Dec 2011 15:10:20 +0800
Message-ID: <1324451420-3899-2-git-send-email-b32616@freescale.com>
References: <1324451420-3899-1-git-send-email-b32616@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe002.messaging.microsoft.com ([213.199.154.140]:54502
	"EHLO DB3EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751427Ab1LUHrX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Dec 2011 02:47:23 -0500
In-Reply-To: <1324451420-3899-1-git-send-email-b32616@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org
Cc: leoli@freescale.com, Qiang Liu <b32616@freescale.com>, Qiang Liu <qiang.liu@freescale.com>

Add feature description about runtime bounce buffer size adjustment.

CC: Chris Ball <cjb@laptop.org>
Signed-off-by: Qiang Liu <qiang.liu@freescale.com>
---
changes for V2
	add suplementary description of bouncesz limitation

 Documentation/mmc/mmc-dev-attrs.txt |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Documentation/mmc/mmc-dev-attrs.txt b/Documentation/mmc/mmc-dev-attrs.txt
index 22ae844..1314cab 100644
--- a/Documentation/mmc/mmc-dev-attrs.txt
+++ b/Documentation/mmc/mmc-dev-attrs.txt
@@ -7,6 +7,8 @@ SD or MMC device.
 The following attributes are read/write.

 	force_ro		Enforce read-only access even if write protect switch is off.
+	bouncesz		Support dynamic adjustment of bounce buffer size at runtime,
+				from 4096 to 4194304, integer multiple of 512 bytes only.

 SD and MMC Device Attributes
 ============================
--
1.6.4


