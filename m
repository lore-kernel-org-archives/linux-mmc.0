From: Qiang Liu <qiang.liu@freescale.com>
Subject: [PATCH RESEND 2/2] mmc/doc: feature description of runtime bounce buffer size adjustment
Date: Wed, 8 Aug 2012 19:06:18 +0800
Message-ID: <1344423978-2138-2-git-send-email-qiang.liu@freescale.com>
References: <1344423978-2138-1-git-send-email-qiang.liu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1344423978-2138-1-git-send-email-qiang.liu@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: leoli@freescale.com, Qiang Liu <qiang.liu@freescale.com>, Chris Ball <cjb@laptop.org>, Rob Landley <rob@landley.net>
List-Id: linux-mmc@vger.kernel.org

Add feature description of attribute bounce buffer size.

Cc: Chris Ball <cjb@laptop.org>
Cc: Rob Landley <rob@landley.net>
Signed-off-by: Qiang Liu <qiang.liu@freescale.com>
---
 Documentation/mmc/mmc-dev-attrs.txt |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Documentation/mmc/mmc-dev-attrs.txt b/Documentation/mmc/mmc-dev-attrs.txt
index 22ae844..8299433 100644
--- a/Documentation/mmc/mmc-dev-attrs.txt
+++ b/Documentation/mmc/mmc-dev-attrs.txt
@@ -7,6 +7,8 @@ SD or MMC device.
 The following attributes are read/write.

 	force_ro		Enforce read-only access even if write protect switch is off.
+	bouncesz		Support dynamic adjustment of bounce buffer size at runtime,
+				from 4K to 4M, integer multiple of 512 bytes only.

 SD and MMC Device Attributes
 ============================
--
1.7.5.1
