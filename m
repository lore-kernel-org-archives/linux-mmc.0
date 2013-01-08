From: <wei_wang@realsil.com.cn>
Subject: [PATCH v4 1/8] MFD:rtsx: Fix typo in comment
Date: Tue, 8 Jan 2013 17:57:22 +0800
Message-ID: <96e414124cedf14c9783acbf6579f6ce357da2d1.1357638064.git.wei_wang@realsil.com.cn>
References: <cover.1357638064.git.wei_wang@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rtits2.realtek.com ([60.250.210.242]:45640 "EHLO
	rtits2.realtek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754574Ab3AHJ6M (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Jan 2013 04:58:12 -0500
In-Reply-To: <cover.1357638064.git.wei_wang@realsil.com.cn>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, sameo@linux.intel.com
Cc: devel@linuxdriverproject.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de, oakad@yahoo.com, bp@alien8.de, Wei WANG <wei_wang@realsil.com.cn>

From: Wei WANG <wei_wang@realsil.com.cn>

Fix a misspelling word in comment

Signed-off-by: Wei WANG <wei_wang@realsil.com.cn>
---
 include/linux/mfd/rtsx_pci.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mfd/rtsx_pci.h b/include/linux/mfd/rtsx_pci.h
index 060b721..bebe9f9 100644
--- a/include/linux/mfd/rtsx_pci.h
+++ b/include/linux/mfd/rtsx_pci.h
@@ -452,7 +452,7 @@
 #define	SD_RSP_TYPE_R6			0x01
 #define	SD_RSP_TYPE_R7			0x01
 
-/* SD_CONFIURE3 */
+/* SD_CONFIGURE3 */
 #define	SD_RSP_80CLK_TIMEOUT_EN		0x01
 
 /* Card Transfer Reset Register */
-- 
1.7.9.5

