From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] MMC: fix sdhci-dove removal
Date: Mon, 29 Oct 2012 21:43:07 +0000
Message-ID: <20121029214307.GH21164@n2100.arm.linux.org.uk>
References: <20121015094348.GP21164@n2100.arm.linux.org.uk> <20121015103725.GQ21164@n2100.arm.linux.org.uk> <20121015104456.GR21164@n2100.arm.linux.org.uk> <87txtdq90y.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33422 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933014Ab2J2VnN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Oct 2012 17:43:13 -0400
Content-Disposition: inline
In-Reply-To: <87txtdq90y.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Oct 29, 2012 at 05:10:37PM -0400, Chris Ball wrote:
> Hi Russell,
> 
> On Mon, Oct 15 2012, Russell King - ARM Linux wrote:
> > Here's an updated patch which just about fixes the sdhci-dove driver.
> > I would not be surprised given the idiotic sdhci-pltfm API if many
> > other drivers suffered the same bug.
> >
> > 8<====
> > From: Russell King <rmk+kernel@arm.linux.org.uk>
> > Subject: [PATCH] MMC: fix sdhci-dove probe/removal
> >
> > 1. Never ever publish a device in the system before it has been setup
> >    to a usable state.
> > 2. Unregister the device _BEFORE_ taking away any resources it may be
> >    using.
> > 3. Don't check clks against NULL.
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> This version of the patch doesn't apply cleanly or compile -- maybe you
> have a later revision?

Well, I'm only going to send a patch against 3.6 because that's the
kernel I'm running on the cubox - which is the platform I'm finding
these bugs on.  As it's a platform which I want to keep stable for
other work, it's not getting -rc kernels on it.

It's also been through several revisions across conflict resolutions
which is why the above errors occurred (thanks to having to fix them
up multiple times.)  And to top it off, there's additional patches
below this one too, so separating out just the fix is virtually
impossible to do safely.

Anyway, here's a replacement patch, updated against my cubox tree but
lacking the cubox gpio changes for it.  Un-tested through: (a) I can't
test this on its own on the cubox, (b) I don't have a separate dove
tree to test it against and my disk space is all but out at the moment
for yet another build tree...

It would helpful of course to have _more_ of the cubox stuff in mainline
but unfortunately it's all non-DT so wouldn't be accepted.

 drivers/mmc/host/sdhci-dove.c |   38 ++++++++++++++++++++------------------
 1 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/sdhci-dove.c b/drivers/mmc/host/sdhci-dove.c
index a6e53a1..bb3cefe 100644
--- a/drivers/mmc/host/sdhci-dove.c
+++ b/drivers/mmc/host/sdhci-dove.c
@@ -19,6 +19,7 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#include <linux/err.h>
 #include <linux/io.h>
 #include <linux/clk.h>
 #include <linux/err.h>
@@ -83,30 +84,32 @@ static int __devinit sdhci_dove_probe(struct platform_device *pdev)
 	struct sdhci_dove_priv *priv;
 	int ret;
 
-	ret = sdhci_pltfm_register(pdev, &sdhci_dove_pdata);
-	if (ret)
-		goto sdhci_dove_register_fail;
-
 	priv = devm_kzalloc(&pdev->dev, sizeof(struct sdhci_dove_priv),
 			    GFP_KERNEL);
 	if (!priv) {
 		dev_err(&pdev->dev, "unable to allocate private data");
-		ret = -ENOMEM;
-		goto sdhci_dove_allocate_fail;
+		return -ENOMEM;
 	}
 
+	priv->clk = clk_get(&pdev->dev, NULL);
+	if (!IS_ERR(priv->clk))
+		clk_prepare_enable(priv->clk);
+
+	ret = sdhci_pltfm_register(pdev, &sdhci_dove_pdata);
+	if (ret)
+		goto sdhci_dove_register_fail;
+
 	host = platform_get_drvdata(pdev);
 	pltfm_host = sdhci_priv(host);
 	pltfm_host->priv = priv;
 
-	priv->clk = clk_get(&pdev->dev, NULL);
-	if (!IS_ERR(priv->clk))
-		clk_prepare_enable(priv->clk);
 	return 0;
 
-sdhci_dove_allocate_fail:
-	sdhci_pltfm_unregister(pdev);
 sdhci_dove_register_fail:
+	if (!IS_ERR(priv->clk)) {
+		clk_disable_unprepare(priv->clk);
+		clk_put(priv->clk);
+	}
 	return ret;
 }
 
@@ -116,14 +119,13 @@ static int __devexit sdhci_dove_remove(struct platform_device *pdev)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_dove_priv *priv = pltfm_host->priv;
 
-	if (priv->clk) {
-		if (!IS_ERR(priv->clk)) {
-			clk_disable_unprepare(priv->clk);
-			clk_put(priv->clk);
-		}
-		devm_kfree(&pdev->dev, priv->clk);
+	sdhci_pltfm_unregister(pdev);
+
+	if (!IS_ERR(priv->clk)) {
+		clk_disable_unprepare(priv->clk);
+		clk_put(priv->clk);
 	}
-	return sdhci_pltfm_unregister(pdev);
+	return 0;
 }
 
 static struct platform_driver sdhci_dove_driver = {

