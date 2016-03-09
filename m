From: David Lechner <david@lechnology.com>
Subject: [PATCH 3/4] mmc: davinci: prepare clock
Date: Wed,  9 Mar 2016 17:50:04 -0600
Message-ID: <1457567405-30475-4-git-send-email-david@lechnology.com>
References: <1457567405-30475-1-git-send-email-david@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1457567405-30475-1-git-send-email-david@lechnology.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: ulf.hansson@linaro.org, k.kozlowski.k@gmail.com, linux-mmc@vger.kernel.org
Cc: khilman@deeprootsystems.com, nsekhar@ti.com, David Lechner <david@lechnology.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

When trying to use this driver with the common clock framework, enabling
the clock fails because it was not prepared. This fixes the problem by
calling clk_prepare and clk_enable in a single function.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/mmc/host/davinci_mmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index f571549..b160feb 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1283,9 +1283,9 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
 		ret = PTR_ERR(host->clk);
 		goto clk_get_fail;
 	}
-	ret = clk_enable(host->clk);
+	ret = clk_prepare_enable(host->clk);
 	if (ret)
-		goto clk_enable_fail;
+		goto clk_prepare_enable_fail;
 
 	host->mmc_input_clk = clk_get_rate(host->clk);
 
@@ -1384,7 +1384,7 @@ mmc_add_host_fail:
 cpu_freq_fail:
 	davinci_release_dma_channels(host);
 	clk_disable(host->clk);
-clk_enable_fail:
+clk_prepare_enable_fail:
 	clk_put(host->clk);
 clk_get_fail:
 	iounmap(host->base);
-- 
1.9.1
