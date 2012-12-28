From: <wei_wang@realsil.com.cn>
Subject: [PATCH v3 1/8] MFD:rtsx: Fix typo in comment
Date: Fri, 28 Dec 2012 10:41:19 +0800
Message-ID: <96e414124cedf14c9783acbf6579f6ce357da2d1.1356662293.git.wei_wang@realsil.com.cn>
References: <cover.1356662293.git.wei_wang@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <cover.1356662293.git.wei_wang@realsil.com.cn>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel/>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: "devel" <devel-bounces@linuxdriverproject.org>
To: cjb@laptop.org, sameo@linux.intel.com
Cc: arnd@arndb.de, oakad@yahoo.com, gregkh@linuxfoundation.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Wei WANG <wei_wang@realsil.com.cn>, bp@alien8.de, devel@linuxdriverproject.org
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
