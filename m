From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/2] sunxi-mci: Fix hang on boot caused by irq storm
Date: Fri,  7 Feb 2014 15:00:41 +0100
Message-ID: <1391781641-7382-3-git-send-email-hdegoede@redhat.com>
References: <1391781641-7382-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBFWO2OLQKGQEKEMVUOA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1391781641-7382-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: =?UTF-8?q?David=20Lanzend=C3=B6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On power up / reboot sometimes the mmc controller will have its irq line
asserted. Getting this de-asserted requires enabling the clocks and then
resetting the mmc controller.

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/mmc/host/sunxi-mci.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mci.c b/drivers/mmc/host/sunxi-mci.c
index 0eb59be..8b47c99 100644
--- a/drivers/mmc/host/sunxi-mci.c
+++ b/drivers/mmc/host/sunxi-mci.c
@@ -737,13 +737,6 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
 	if (IS_ERR(host->reg_base))
 		return PTR_ERR(host->reg_base);
 
-	host->irq = platform_get_irq(pdev, 0);
-	ret = devm_request_irq(&pdev->dev, host->irq, sunxi_mmc_irq, 0,
-			       "sunxi-mci", host);
-	if (ret)
-		return ret;
-	disable_irq(host->irq);
-
 	host->clk_ahb = devm_clk_get(&pdev->dev, "ahb");
 	if (IS_ERR(host->clk_ahb)) {
 		dev_err(&pdev->dev, "Could not get ahb clock\n");
@@ -756,7 +749,21 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
 		return PTR_ERR(host->clk_mod);
 	}
 
-	return 0;
+	/* Make sure the controller is in a sane state before enabling irqs */
+	ret = sunxi_mmc_init_host(host->mmc);
+	if (ret)
+		return ret;
+
+	host->irq = platform_get_irq(pdev, 0);
+	ret = devm_request_irq(&pdev->dev, host->irq, sunxi_mmc_irq, 0,
+			       "sunxi-mci", host);
+	if (ret == 0)
+		disable_irq(host->irq);
+
+	/* And put it back in reset */
+	sunxi_mmc_exit_host(host);
+
+	return ret;
 }
 
 static int sunxi_mmc_probe(struct platform_device *pdev)
-- 
1.8.4.2
