From: Jeremy Kim <jh4u.kim@samsung.com>
Subject: [PATCH] mmc: block: Change MMC_IOC_MAX_BYTES
Date: Tue, 18 Oct 2016 19:39:27 +0900
Message-ID: <0bb501d2292b$e6a43760$b3eca620$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:49923 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759308AbcJRKja (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Oct 2016 06:39:30 -0400
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OF8005BRO9N9A80@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 18 Oct 2016 19:39:28 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: jh4u.kim@samsung.com


It is used for limitation of buffer size during IOCTL such as FFU. However,
eMMC FW size is bigger than (512L*256).
(For instance, currently, Samsung eMMC FW size is over 300KB.)
So, it needs to increase to execute FFU.


Signed-off-by: Jeonghan Kim <jh4u.kim@samsung.com>
---
 ioctl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ioctl.h b/ioctl.h
index 7e385b8..700a551 100644
--- a/ioctl.h
+++ b/ioctl.h
@@ -69,6 +69,6 @@ struct mmc_ioc_multi_cmd {
  * is enforced per ioctl call.  For larger data transfers, use the normal
  * block device operations.
  */
-#define MMC_IOC_MAX_BYTES  (512L * 256)
+#define MMC_IOC_MAX_BYTES  (512L * 1024)
 #define MMC_IOC_MAX_CMDS    255
 #endif /* LINUX_MMC_IOCTL_H */
--
1.9.1

