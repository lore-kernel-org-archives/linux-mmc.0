From: Liu Qiang-B32616 <B32616@freescale.com>
Subject: RE: [PATCH] [RFC/PATCH] SD/MMC: support adjust bounce buffer size
 dynamically in menuconfig
Date: Tue, 8 Nov 2011 02:28:54 +0000
Message-ID: <8F012AA59EAB7D4F89C0AE6C20D45709112393@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1320400467-6496-1-git-send-email-b32616@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe002.messaging.microsoft.com ([216.32.180.12]:4483 "EHLO
	VA3EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752465Ab1KHC25 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Nov 2011 21:28:57 -0500
In-Reply-To: <1320400467-6496-1-git-send-email-b32616@freescale.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "cjb@laptop.org" <cjb@laptop.org>, Li Yang-R58472 <r58472@freescale.com>, Gala Kumar-B11780 <B11780@freescale.com>

Hi all,

What about this feature? Provide a method of adjust mmc bounce size through menuconfig
or /sys/block/mmcblk0 at run-time. Which one is better?

Do you have any ideas? Thanks for your advice.

________________________________________
From: Liu Qiang-B32616
Sent: Friday, November 04, 2011 4:54 AM
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org; Li Yang-R58472; Gala Kumar-B11780; Liu Qiang-B32616; Liu Qiang-B32616
Subject: [PATCH] [RFC/PATCH] SD/MMC: support adjust bounce buffer size dynamically in menuconfig

Improve IO throughput according to different controllers.
Make it configuable in menuconfig. Of course, there is another
implement of adjust bounce buffer size at run-time. Like:
echo 262144 > /sys/block/mmcblk0/device/bouncesz
This will reinit mmc queue when bounce size is changed.
Which is better?

On powerpc platform, 256KiB will get better perfromance than 64KiB.
I used Sandisk Extreme III Class 6, 4G memory card, tested on P1022DS
with IOzone. P1022DS memory is 1GBytes. Filesystem is ext4.
By default, bounce buffer size is 64KiB,
[root@p1022ds root]# iozone -Rab result -i0 -i1 -r64 -n1g -g2g -f /mnt/ff
             KB  reclen   write rewrite    read    reread
        1048576      64   12794   13260    32330    31731
        2097152      64   12301   12382    18213    18239
use 256KiB as bounce buffer size,
[root@p1022ds root]# iozone -Rab result -i0 -i1 -r64 -n1g -g2g -f /mnt/ff
             KB  reclen   write rewrite    read    reread
        1048576      64   18533   19076    22841    23151
        2097152      64   17744   17980    18333    18342

Signed-off-by: Qiang Liu <qiang.liu@freescale.com>
---
 drivers/mmc/card/Kconfig |    9 +++++++++
 drivers/mmc/card/queue.c |    2 +-
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/card/Kconfig b/drivers/mmc/card/Kconfig
index 3b1f783..3390154 100644
--- a/drivers/mmc/card/Kconfig
+++ b/drivers/mmc/card/Kconfig
@@ -50,6 +50,15 @@ config MMC_BLOCK_BOUNCE

          If unsure, say Y here.

+config MMC_QUEUE_BOUNCESZ
+       int "MMC memory card bounce buffer size"
+       depends on MMC_BLOCK_BOUNCE
+       range 512 4194304
+       default "65536"
+       help
+         Provide a flexible method to adjust bounce buffer size to
+         improve the throughput according to different controller.
+
 config SDIO_UART
        tristate "SDIO UART/GPS class support"
        help
diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index dcad59c..590723f 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -20,7 +20,7 @@
 #include <linux/mmc/host.h>
 #include "queue.h"

-#define MMC_QUEUE_BOUNCESZ     65536
+#define MMC_QUEUE_BOUNCESZ     CONFIG_MMC_QUEUE_BOUNCESZ

 #define MMC_QUEUE_SUSPENDED    (1 << 0)

--
1.6.4


