From: <wei_wang@realsil.com.cn>
Subject: [PATCH 1/7] MFD:rtsx: Fix typo in comment
Date: Mon, 24 Dec 2012 14:03:19 +0800
Message-ID: <96e414124cedf14c9783acbf6579f6ce357da2d1.1356319097.git.wei_wang@realsil.com.cn>
References: <cover.1356319097.git.wei_wang@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1356319097.git.wei_wang@realsil.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: cjb@laptop.org, sameo@linux.intel.com
Cc: devel@linuxdriverproject.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de, oakad@yahoo.com, bp@alien8.de, Wei WANG <wei_wang@realsil.com.cn>
List-Id: linux-mmc@vger.kernel.org

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
