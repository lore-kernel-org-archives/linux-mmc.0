From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] mmc: pxamci: fix enum type confusion
Date: Thu,  7 Mar 2019 11:09:19 +0100
Message-ID: <20190307100948.570006-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@zonque.org>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

clang points out several instances of mismatched types in this drivers,
all coming from a single declaration:

drivers/mmc/host/pxamci.c:193:15: error: implicit conversion from enumeration type 'enum dma_transfer_direction' to
      different enumeration type 'enum dma_data_direction' [-Werror,-Wenum-conversion]
                direction = DMA_DEV_TO_MEM;
                          ~ ^~~~~~~~~~~~~~
drivers/mmc/host/pxamci.c:212:62: error: implicit conversion from enumeration type 'enum dma_data_direction' to
      different enumeration type 'enum dma_transfer_direction' [-Werror,-Wenum-conversion]
        tx = dmaengine_prep_slave_sg(chan, data->sg, host->dma_len, direction,

The behavior is correct, so this must be a simply typo from
dma_data_direction and dma_transfer_direction being similarly named
types with a similar purpose.

Fixes: 6464b7140951 ("mmc: pxamci: switch over to dmaengine use")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/host/pxamci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index c907bf502a12..c1d3f0e38921 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -162,7 +162,7 @@ static void pxamci_dma_irq(void *param);
 static void pxamci_setup_data(struct pxamci_host *host, struct mmc_data *data)
 {
 	struct dma_async_tx_descriptor *tx;
-	enum dma_data_direction direction;
+	enum dma_transfer_direction direction;
 	struct dma_slave_config	config;
 	struct dma_chan *chan;
 	unsigned int nob = data->blocks;
-- 
2.20.0
