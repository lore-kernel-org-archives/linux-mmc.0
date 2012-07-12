From: Thomas Abraham <thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v3 2/6] mmc: dw_mmc: allow probe to succeed even if one slot is
 initialized
Date: Thu, 12 Jul 2012 18:24:24 +0530
Message-ID: <1342097668-25243-3-git-send-email-thomas.abraham@linaro.org>
References: <1342097668-25243-1-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-reply-to: <1342097668-25243-1-git-send-email-thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Instead of aborting the probe in case a slot initialization fails, allow
initialization of as many slots as possible. If there are atleast one
instance of slot that is successfully initialized, allow the driver probe
to succeed.

Signed-off-by: Thomas Abraham <thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/mmc/host/dw_mmc.c |   23 +++++++++++++----------
 1 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 948a7ac..cd58063 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1939,6 +1939,7 @@ int dw_mci_probe(struct dw_mci *host)
 {
 	int width, i, ret = 0;
 	u32 fifo_size;
+	int init_slots = 0;
 
 	if (!host->pdata || !host->pdata->init) {
 		dev_err(host->dev,
@@ -2047,10 +2048,18 @@ int dw_mci_probe(struct dw_mci *host)
 	/* We need at least one slot to succeed */
 	for (i = 0; i < host->num_slots; i++) {
 		ret = dw_mci_init_slot(host, i);
-		if (ret) {
-			ret = -ENODEV;
-			goto err_init_slot;
-		}
+		if (ret)
+			dev_dbg(host->dev, "slot %d init failed\n", i);
+		else
+			init_slots++;
+	}
+
+	if (init_slots) {
+		dev_info(host->dev, "%d slots initialized\n", init_slots);
+	} else {
+		dev_dbg(host->dev, "attempted to initialize %d slots, "
+					"but failed on all\n", host->num_slots);
+		goto err_init_slot;
 	}
 
 	/*
@@ -2085,12 +2094,6 @@ int dw_mci_probe(struct dw_mci *host)
 	return 0;
 
 err_init_slot:
-	/* De-init any initialized slots */
-	while (i > 0) {
-		if (host->slot[i])
-			dw_mci_cleanup_slot(host->slot[i], i);
-		i--;
-	}
 	free_irq(host->irq, host);
 
 err_workqueue:
-- 
1.6.6.rc2
