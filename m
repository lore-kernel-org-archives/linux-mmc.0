From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH] mmc: meson-gx: fix interrupt name
Date: Sat,  9 Feb 2019 01:58:50 +0100
Message-ID: <20190209005850.11457-1-martin.blumenstingl@googlemail.com>
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
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc: xademax@gmail.com, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, repk@triplefau.lt, linux-arm-kernel@lists.infradead.org, jbrunet@baylibre.com
List-Id: linux-mmc@vger.kernel.org

Commit bb364890323cca ("mmc: meson-gx: Free irq in release() callback")
changed the _probe code to use request_threaded_irq() instead of
devm_request_threaded_irq().
Unfortunately this removes a fallback for the interrupt name:
devm_request_threaded_irq() uses the device name as fallback if the
given IRQ name is NULL. request_threaded_irq() has no such fallback,
thus /proc/interrupts shows "(null)" instead.

Explicitly pass the dev_name() so we get the IRQ name shown in
/proc/interrupts again.
While here, also fix the indentation of the request_threaded_irq()
parameter list.

Fixes: bb364890323cca ("mmc: meson-gx: Free irq in release() callback")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index f19ec60bcbdc..2eba507790e4 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -1338,7 +1338,8 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	       host->regs + SD_EMMC_IRQ_EN);
 
 	ret = request_threaded_irq(host->irq, meson_mmc_irq,
-			meson_mmc_irq_thread, IRQF_SHARED, NULL, host);
+				   meson_mmc_irq_thread, IRQF_SHARED,
+				   dev_name(&pdev->dev), host);
 	if (ret)
 		goto err_init_clk;
 
-- 
2.20.1
