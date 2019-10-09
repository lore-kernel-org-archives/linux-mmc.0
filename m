From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] mmc: mmci: stm32: make sdmmc_idma_validate_data static
Date: Wed,  9 Oct 2019 12:54:15 +0100
Message-ID: <20191009115415.15691-1-ben.dooks@codethink.co.uk>
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Alexandre Torgue <alexandre.torgue@st.com>, linux-mmc@vger.kernel.org, Ben Dooks <ben.dooks@codethink.co.uk>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Make sdmmc_idma_validate_data to avoid the following warning
from sparse:

drivers/mmc/host/mmci_stm32_sdmmc.c:28:5: warning: symbol 'sdmmc_idma_validate_data' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: linux-mmc@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/mmc/host/mmci_stm32_sdmmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
index 8e83ae6920ae..296be8a060a6 100644
--- a/drivers/mmc/host/mmci_stm32_sdmmc.c
+++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
@@ -25,8 +25,8 @@ struct sdmmc_priv {
 	void *sg_cpu;
 };
 
-int sdmmc_idma_validate_data(struct mmci_host *host,
-			     struct mmc_data *data)
+static int sdmmc_idma_validate_data(struct mmci_host *host,
+				    struct mmc_data *data)
 {
 	struct scatterlist *sg;
 	int i;
-- 
2.23.0
