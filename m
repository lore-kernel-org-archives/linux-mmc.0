From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] mmc: dw_mmc: fix 32bit little-endian access of des1 field
Date: Tue,  7 Jun 2016 14:37:19 +0100
Message-ID: <1465306639-9537-1-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@lists.codethink.co.uk
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>, Ben Dooks <ben.dooks@codethink.co.uk>, Matthew Leach <matt.leach@codethink.co.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

The IDMAC_SET_BUFFER1_SIZE() macro modifies des1, but does
not check if the value being passed is big or little endian
desptire the des1 field being marked as __le32.

Fix the issue by ensuring the values are changed from the
cpu endian to the descriptor endian by using cpu_to_le32.

Spotted whilst doing big endian conversion work on Exynos,
and stops the mmc worker thread from stalling.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Matthew Leach <matt.leach@codethink.co.uk>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/mmc/host/dw_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 2cc6123..544397e 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -92,7 +92,7 @@ struct idmac_desc {
 
 	__le32		des1;	/* Buffer sizes */
 #define IDMAC_SET_BUFFER1_SIZE(d, s) \
-	((d)->des1 = ((d)->des1 & 0x03ffe000) | ((s) & 0x1fff))
+	((d)->des1 = ((d)->des1 & cpu_to_le32(0x03ffe000)) | (cpu_to_le32((s) & 0x1fff)))
 
 	__le32		des2;	/* buffer 1 physical address */
 
-- 
2.8.1
