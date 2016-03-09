From: David Lechner <david@lechnology.com>
Subject: [PATCH 1/4] mmc: davinci: remove matching string
Date: Wed,  9 Mar 2016 17:50:02 -0600
Message-ID: <1457567405-30475-2-git-send-email-david@lechnology.com>
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

The string "MMCSDCLK" is not actually used for clock lookup, so can be removed.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/mmc/host/davinci_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index ea2a2eb..469aa8c 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1280,7 +1280,7 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
 		goto out;
 
 	ret = -ENXIO;
-	host->clk = clk_get(&pdev->dev, "MMCSDCLK");
+	host->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(host->clk)) {
 		ret = PTR_ERR(host->clk);
 		goto out;
-- 
1.9.1
