From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v2 -next] soc: fsl: fix section mismatch build warnings
Date: Thu, 17 Nov 2016 15:11:59 +0000
Message-ID: <1479395519-20742-1-git-send-email-sudeep.holla@arm.com>
References: <1479314367-9169-2-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1479314367-9169-2-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-mmc@vger.kernel.org, Scott Wood <oss@buserror.net>, Yangbo Lu <yangbo.lu@nxp.com>, Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

We get the following warning with the driver is compiled in:

WARNING: modpost: Found 1 section mismatch(es).
To see full details build your kernel with:
'make CONFIG_DEBUG_SECTION_MISMATCH=y'

With CONFIG_DEBUG_SECTION_MISMATCH enabled, the details are reported:

WARNING: vmlinux.o(.text+0x55d014): Section mismatch in reference from the
function fsl_guts_probe() to the function
.init.text:of_flat_dt_get_machine_name()
The function fsl_guts_probe() references
the function __init of_flat_dt_get_machine_name().
This is often because fsl_guts_probe lacks a __init
annotation or the annotation of of_flat_dt_get_machine_name is wrong.

This patch fixes the issue by using the normal DT/OF API rather than
the of_flat_* one.

Cc: Scott Wood <oss@buserror.net>
Cc: Yangbo Lu <yangbo.lu@nxp.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/soc/fsl/guts.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

v1->v2:
	- As suggested by Arnd, used standard DT APIs over of_flat_* API

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index 0ac88263c2d7..6af7a11f09a5 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -132,7 +132,7 @@ EXPORT_SYMBOL(fsl_guts_get_svr);

 static int fsl_guts_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
+	struct device_node *root, *np = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
 	struct resource *res;
 	const struct fsl_soc_die_attr *soc_die;
@@ -152,7 +152,10 @@ static int fsl_guts_probe(struct platform_device *pdev)
 		return PTR_ERR(guts->regs);

 	/* Register soc device */
-	machine = of_flat_dt_get_machine_name();
+	root = of_find_node_by_path("/");
+	if (of_property_read_string(root, "model", &machine))
+		of_property_read_string_index(root, "compatible", 0, &machine);
+	of_node_put(root);
 	if (machine)
 		soc_dev_attr.machine = devm_kstrdup(dev, machine, GFP_KERNEL);

--
2.7.4
