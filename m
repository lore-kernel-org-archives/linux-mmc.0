From: Liu Qiang-B32616 <B32616@freescale.com>
Subject: RE: [PATCH V2 2/2] mmc/doc: feature description of runtime bounce
 buffer size adjustment
Date: Mon, 16 Jan 2012 13:29:17 +0000
Message-ID: <BCB48C05FCE8BC4D9E61E841ECBE6DB7014563@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1324451420-3899-1-git-send-email-b32616@freescale.com>,<1324451420-3899-2-git-send-email-b32616@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:41683
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752723Ab2APN3h convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 16 Jan 2012 08:29:37 -0500
In-Reply-To: <1324451420-3899-2-git-send-email-b32616@freescale.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Li Yang-R58472 <r58472@freescale.com>

Hi Chris,

Is the description OK? Thanks.

________________________________________
From: Liu Qiang-B32616
Sent: Wednesday, December 21, 2011 1:10 AM
To: cjb@laptop.org; linux-mmc@vger.kernel.org
Cc: Li Yang-R58472; Liu Qiang-B32616; Liu Qiang-B32616
Subject: [PATCH V2 2/2] mmc/doc: feature description of runtime bounce buffer size adjustment

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

        force_ro                Enforce read-only access even if write protect switch is off.
+       bouncesz                Support dynamic adjustment of bounce buffer size at runtime,
+                               from 4096 to 4194304, integer multiple of 512 bytes only.

 SD and MMC Device Attributes
 ============================
--
1.6.4


