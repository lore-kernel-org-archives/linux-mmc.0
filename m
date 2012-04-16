From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [PATCH 09/12] ARM: at91/atmel-mci: remove unused setup_dma_addr()
 macro
Date: Mon, 16 Apr 2012 11:20:53 +0200
Message-ID: <93a2e5f55b3064422a7fab75d5d9035c58152989.1334567594.git.nicolas.ferre@atmel.com>
References: <cover.1334567594.git.nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1334567594.git.nicolas.ferre@atmel.com>
In-Reply-To: <cover.1334567594.git.nicolas.ferre@atmel.com>
References: <cover.1334567594.git.nicolas.ferre@atmel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, arnd@arndb.de, olof@lixom.net
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, ludovic.desroches@atmel.com, Chris Ball <cjb@laptop.org>, plagnioj@jcrosoft.com
List-Id: linux-mmc@vger.kernel.org

This macro is not used anymove in atmel-mci driver. It has been removed
by a patch that was dealing with dw_dmac.c e2b35f3:
(dmaengine/dw_dmac: Fix dw_dmac user drivers to adapt to slave_config changes)

We are now using the dmaengine API to specify the slave DMA parameters:
dmaengine_slave_config().

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: Chris Ball <cjb@laptop.org>
Cc: <linux-mmc@vger.kernel.org>
---
 arch/arm/mach-at91/include/mach/atmel-mci.h |    7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/atmel-mci.h b/arch/arm/mach-at91/include/mach/atmel-mci.h
index 998cb0c..5d84fe3 100644
--- a/arch/arm/mach-at91/include/mach/atmel-mci.h
+++ b/arch/arm/mach-at91/include/mach/atmel-mci.h
@@ -14,11 +14,4 @@ struct mci_dma_data {
 #define	slave_data_ptr(s)	(&(s)->sdata)
 #define find_slave_dev(s)	((s)->sdata.dma_dev)
 
-#define	setup_dma_addr(s, t, r)	do {		\
-	if (s) {				\
-		(s)->sdata.tx_reg = (t);	\
-		(s)->sdata.rx_reg = (r);	\
-	}					\
-} while (0)
-
 #endif /* __MACH_ATMEL_MCI_H */
-- 
1.7.10
